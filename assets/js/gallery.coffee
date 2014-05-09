#= require 'magnific-popup'

$(document).ready ->
  $('.gallery').magnificPopup
    delegate: 'a'
    type: 'image'
    closeOnContentClick: yes
    closeBtnInside: no
    mainClass: 'mfp-with-zoom mfp-img-mobile',
    image:
      verticalFit: true
    gallery:
      enabled: true
    zoom:
      enabled: true
      duration: 300
      opener: (el) -> el.find('img')