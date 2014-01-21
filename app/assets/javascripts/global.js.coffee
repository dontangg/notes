
$ ->
  speed = 150

  $('#menu-btn').click ->
    $('body')
      .css
        position: 'absolute'
        width: $('body').innerWidth()
      .animate { left: 260 }, speed

    $('#menu')
      .show()
      .animate { left: 0 }, speed

  $('#hide-menu-btn').click ->
    $('body').animate { left: 0 }, speed, ->
      $(this).css { position: '', width: ''}

    $('#menu').animate { left: -260 }, speed, ->
      $(this).hide()



