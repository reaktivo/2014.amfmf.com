#= require 'jquery.smooth-scroll'

class Main

  body: $('body')
  window: $(window)

  constructor: ->
    do @setup

  setup: =>
    setInterval (=> @window.resize()), 100

  viewport: ->
    if typeof window.innerWidth is 'undefined'
      width: document.documentElement.clientWidth
      height: document.documentElement.clientHeight
    else
      width: window.innerWidth
      height: window.innerHeight


$(document).ready -> new Main