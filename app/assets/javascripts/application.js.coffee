#= require jquery
#= require jquery.role
#= require wiselinks

class App
  constructor: () ->
    @wiselinks = new Wiselinks($('@content'), html4: true, target_missing: 'exception')

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
      (event, $target, render, url) -> 
        console.append("<li class='loading'>>>> Wiselinks loading: #{url} to <strong>#{$target.selector}</strong> within '<strong>#{render}</strong>'</li>")
    )

    $(document).off('page:redirected').on(
      'page:redirected'
      (event, $target, render, url) -> 
        console.append("<li class='redirected'>>>> Wiselinks redirected to: #{url}</li>")        
    )

    $(document).off('page:done').on(
      'page:done'
      (event, $target, status, url, data) ->  
        console.append("<li class='status'>>>> Wiselinks status: '<strong>#{status}</strong>'</li>")
        console.scrollTop(console.find('li:last').offset().top)
    )

    $(document).off('page:fail').on(
      'page:fail'
      (event, $target, status, url, error) ->  
        console.append("<li class='status'>>>> Wiselinks status: '<strong>#{status}</strong>'</li>")
        console.scrollTop(console.find('li:last').offset().top)
    )

$(document).ready ->
  window.app = new App
  