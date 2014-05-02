class AMFVideo

  constructor: ->
    do @setup

  setup: =>
    @video = $ '#video'
    @player = $f @video[0]
    @player.addEvent 'ready', @videoReady

  videoReady: =>
    @player.addEvent 'finish', @videoFinish

  videoFinish: =>
    @video.fadeOut()