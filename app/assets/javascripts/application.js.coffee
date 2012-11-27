#= require jquery
#= require jquery.role
#= require wiselinks

class App
  constructor: () ->
    @wiselinks = new Wiselinks()

$(document).ready ->
  window.app = new App