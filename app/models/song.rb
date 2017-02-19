class Song < ActiveRecord::Base
  S3_BUCKET_NAME = "wilson-notes"

  belongs_to :user
  belongs_to :competition

  validates_presence_of :name
  validates_presence_of :artist

  before_destroy :delete_amazon_objects, if: :amazon_object_exists?
  before_update :delete_amazon_objects, if: :amazon_object_exists?

  def amazon_object_exists?
    return false if self.new_record?

    (self.file_name_changed? ? self.file_name_was : self.file_name).present?
  end

  def delete_amazon_objects
    bucket = AWS::S3.new.buckets[S3_BUCKET_NAME]

    file_name = self.file_name_changed? ? self.file_name_was : self.file_name
    extension = self.extension_changed? ? self.extension_was : self.extension

    bucket.objects["uploads/#{file_name}#{extension}"].delete
    bucket.objects.with_prefix("t/#{file_name}/").delete_all
  end

  # http://wilson-notes.s3.amazonaws.com/uploads/41r7d8qz.m4a
  def upload(uploaded_io)
    return nil unless uploaded_io

    original_extension = File.extname(uploaded_io.original_filename)
    file_name = rand(2821109907456).to_s(36).rjust(8, '0') # create a random 8 character file name

    key = "uploads/#{file_name}#{original_extension}"

    AWS::S3.new.buckets[S3_BUCKET_NAME].objects[key].write(uploaded_io)

    # transcode the audio file to mp3 & hls
    transcoder = AWS::ElasticTranscoder::Client.new

    # http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/ElasticTranscoder/Client.html#create_job-instance_method
    response = transcoder.create_job(
      pipeline_id: '1390029519400-paneaz',
      input: {
        key: key,
        container: 'auto' # auto-detect the existing file's container (eg. mp3, ogg, etc)
      },
      outputs: [
        {
          key: "segment.ts",
          preset_id: "1351620000001-200050", # HLS 400k
          segment_duration: '30' # Create 30 second segments
        },
        {
          key: "song.mp3",
          preset_id: "1351620000001-300040" # MP3 - 128k
        }
      ],
      output_key_prefix: "t/#{file_name}/", # each output key will have this prefix
      playlists: [
        name: "playlist", # the extension m3u8 is automatically added for us
        format: "HLSv3", # the only format currently supported
        output_keys: [
          "segment.ts" # create a play list for the segment.ts output
        ]
      ]
    )

    self.file_name = file_name
    self.extension = original_extension
  end

  def hls_url
    "http://#{S3_BUCKET_NAME}.s3.amazonaws.com/t/#{self.file_name}/playlist.m3u8"
  end

  def mp3_url
    "http://#{S3_BUCKET_NAME}.s3.amazonaws.com/t/#{self.file_name}/song.mp3"
  end

end
