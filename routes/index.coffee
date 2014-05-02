
{ findWhere, first, last } = require 'underscore'

lineup = require '../public/media/lineup'

module.exports = (app) ->

  findDetail = (slug) ->
    detail = findWhere lineup, { slug }
    return unless detail
    index = lineup.indexOf(detail)
    prev = lineup[index - 1]
    prev = last lineup if prev is undefined
    next = lineup[index + 1]
    next = first lineup if next is undefined
    title = detail.name + " — " + app.locals.title
    bodyId = detail.slug
    { detail, index, prev, next, title, bodyId }

  app.locals.title = 'All My Friends Music Festival'
  app.locals.lineup = lineup

  app.get '/', (req, res) ->
    res.render 'index'

  app.get '/:slug', (req, res, next) ->
    result = findDetail(req.params.slug)
    return next() unless result
    res.render 'detail', result