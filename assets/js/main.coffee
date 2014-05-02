#= require 'jquery.smooth-scroll'
#= require 'jquery.transit-0.9.9'
#= require 'page'

class Main

  body: $('body')
  window: $(window)
  lineup: $('#lineup a')
  container: $('#detail-container')

  constructor: ->
    @window.resize @layout
    do @setup
    do @layout

  setup: =>
    @lineup.addClass 'buzz'

  loadDetail: (ctx, next) =>
    $detail = $('#detail')
    if $detail.length and not $detail.is(':empty')
      debugger
      @container.addClass 'transition'
      delay = 500
    if ctx.state.data
      debugger
      setTimeout next, delay or 1
    else
      debugger
      $.get ctx.pathname, (data) =>
        debugger
        ctx.state.data = data
        ctx.save()
        setTimeout next, delay or 1

  parseData: (data) =>
    $("<div>").append($.parseHTML(data)).find('#detail')

  showDetail: (ctx, next) =>
    $detail = @parseData ctx.state.data
    $('#detail').replaceWith $detail
    @container.fadeIn()
    @layout()
    @container.removeClass 'transition'

  hideDetail: (ctx, next) =>
    @container.fadeOut()

  layout: (e) =>
    h = @viewport().height
    # deg = Math.floor(12 * Math.random()) - 6
    # $('#detail img').css(rotate: "#{deg}deg")
    $('.controls span', @detail).css width: h

  isValid: (slug) =>
    @lineup.is ->
      @href.indexOf(slug) is @href.length - slug.length;

  viewport: ->
    if typeof window.innerWidth is 'undefined'
      width: document.documentElement.clientWidth
      height: document.documentElement.clientHeight
    else
      width: window.innerWidth
      height: window.innerHeight

# window.onbeforeunload = -> 'Testing...'
$(document).ready ->
  window.app = new Main
  page '/', app.hideDetail
  page '/:slug', app.loadDetail, app.showDetail
  page.start(dispatch: off)