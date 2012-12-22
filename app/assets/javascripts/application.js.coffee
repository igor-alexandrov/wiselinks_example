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

    wiselinks = new Wiselinks($('@content'))
    wiseconsole = $(document).find('@wiseconsole')
    clear_wiseconsole = $(document).find('@clear_wiseconsole')

    clear_wiseconsole.off('click').on(
      'click'
      ->
        wiseconsole.empty()
        false
    )

    $(document).off('page:loading').on(
      'page:loading'
      (event, url, target, render) -> 
        wiseconsole.prepend("<li class='loading'>>>> Wiselinks loading: #{url} to #{target} within '#{render}'</li>")
        console.log("Wiselinks loading: #{url} to #{target} within '#{render}'")
    )

    $(document).off('page:success').on(
      'page:success'
      (event, data, status) ->  
        wiseconsole.prepend("<li class='status'>>>> Wiselinks status: '#{status}'</li>")
        console.log("Wiselinks status: '#{status}'")
    )

    $(document).off('page:error').on(
      'page:error'
      (event, data, status) ->  
        wiseconsole.prepend("<li class='status'>>>> Wiselinks status: '#{status}'</li>")
        console.log("Wiselinks status: '#{status}'")
    )

$(document).ready ->
  window.app = new App
  