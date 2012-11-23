#= require zepto
#= require wiselinks

class App
  constructor: () ->
    @wiselinks = new Wiselinks()

$(document).ready ->
  window.app = new App      

  $(document).on('wiselinks:loading', -> console.log('wiselinks:loading'))  
  $(document).on('wiselinks:success', -> console.log('wiselinks:success'))
  $(document).on('wiselinks:error', -> console.log('wiselinks:error'))