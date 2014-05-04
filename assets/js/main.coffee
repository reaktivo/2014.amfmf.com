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

  loadDetail: (ctx, cb) =>
    $detail = $('#detail')
    if $detail.length and not $detail.is(':empty')
      @container.addClass 'transition'
      delay = 500
    callback = =>
      el = $("<div>")
        .append($.parseHTML(ctx.state.data))
        .find('#detail')
      cb el
    if ctx.state.data
      setTimeout callback, delay or 1
    else
      $.get ctx.pathname, (data) =>
        ctx.state.data = data
        ctx.save()
        setTimeout callback, delay or 1

  showDetail: (ctx, next) =>
    return do next unless @isValid ctx.params.slug
    @loadDetail ctx, ($detail) =>
      $('#detail').replaceWith $detail
      @container.fadeIn()
      @layout()
      @container.removeClass 'transition'

  hideDetail: (ctx, next) =>
    @container.fadeOut =>
      $('#detail').empty()

  layout: (e) =>
    h = @viewport().height
    # deg = Math.floor(12 * Math.random()) - 6
    # $('#detail img').css(rotate: "#{deg}deg")
    $('.controls span', @detail).css width: h

  isValid: (slug) =>
    path = "/#{slug}"
    @lineup.is ->
      @href.indexOf(path) is @href.length - path.length;

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
  page '/:slug', app.showDetail
  page.start(dispatch: off)