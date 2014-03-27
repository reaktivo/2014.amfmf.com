{ random } = require 'underscore'

module.exports = (app) ->

  app.get '/', (req, res) ->
    res.render 'index',
      title: 'All My Friends Music Festival — 14 de Junio 2014'
      video: "/video/amfmf#{random(1,7)}.mp4"