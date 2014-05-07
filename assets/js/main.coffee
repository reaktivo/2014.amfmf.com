#= require 'jquery.smooth-scroll'
#= require 'jquery.transit-0.9.9'
#= require 'page'
#= require 'underscore'

_.extend $.embedly.defaults,
  key: '1484765558d14f12a55ec72aaf21b758'
  query: { autoplay: yes }

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
    $(document).on 'click', 'a.listen', @loadMusic
    $(document).on 'click', 'a.bio', @showBio

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

  loadMusic: (e) =>
    e.preventDefault()
    url = e.currentTarget.href;
    $detail = $('#detail')
    if $('.listen-content', $detail).is(':empty')
      $.embedly.oembed(url).progress (data) =>
        $('.listen-content', $detail).html(data.html)
        @showMusic(e)
    else
      @showMusic(e)

  showMusic: (e) =>
    e.preventDefault()
    $detail = $('#detail')
    $('.bio-content', $detail).hide()
    $('.listen-content', $detail).show()
    $('a.bio', $detail).show()
    $('a.listen', $detail).hide()

  showBio: (e) =>
    e.preventDefault()
    $detail = $('#detail')
    $('.bio-content', $detail).show()
    $('.listen-content', $detail).hide()
    $('a.bio', $detail).hide()
    $('a.listen', $detail).show()

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