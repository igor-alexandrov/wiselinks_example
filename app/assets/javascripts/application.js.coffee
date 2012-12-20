#= require jquery
#= require jquery.role
#= require wiselinks

class Console
  log: (message) ->
    alert(message)  

class App
  constructor: () ->
    if (!window.console)
      window.console = document.console = new Console

    @wiselinks = new Wiselinks()

    $(document).off('page:loading').on(
      'page:loading'
      (event, url, target, render) ->        
        console.log("Wiselinks loading: #{url} to #{target} within '#{render}'")
    )

    $(document).off('page:success').on(
      'page:success'
      (event, data, status) ->        
        console.log("Wiselinks status: '#{status}'")
    )

    $(document).off('page:error').on(
      'page:error'
      (event, data, status) ->        
        console.log("Wiselinks status: '#{status}'")
    )

$(document).ready ->
  window.app = new App