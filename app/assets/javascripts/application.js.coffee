#= require jquery
#= require jquery.role
#= require wiselinks

class App
  constructor: () ->
    @wiselinks = new Wiselinks($('@content'))
    console = $(document).find('@console')
    clear_console = $(document).find('@clear_console')

    clear_console.off('click').on(
      'click'
      ->
        console.empty()
        false
    )

    $(document).off('page:loading').on(
      'page:loading'
      (event, url, target, render) -> 
        console.append("<li class='loading'>>>> Wiselinks loading: #{url} to <strong>#{target}</strong> within '<strong>#{render}</strong>'</li>")
    )

    $(document).off('page:success').on(
      'page:success'
      (event, data, status) ->  
        console.append("<li class='status'>>>> Wiselinks status: '<strong>#{status}</strong>'</li>")
        console.scrollTop(console.find('li:last').offset().top)
    )

    $(document).off('page:error').on(
      'page:error'
      (event, data, status) ->  
        console.append("<li class='status'>>>> Wiselinks status: '<strong>#{status}</strong>'</li>")
        console.scrollTop(console.find('li:last').offset().top)
    )

$(document).ready ->
  window.app = new App
  