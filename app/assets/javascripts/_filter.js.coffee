class Filter
  constructor: (@$container) ->
    self = this

    @$include_blank_url_params = self._find('@include_blank_url_params')
    @$optimize_url_params = self._find('@optimize_url_params')

    @$form = self._find('@form')

    self.initialize_events()

    @$include_blank_url_params.trigger('change')
    @$optimize_url_params.trigger('change')

  initialize_events: ->
    self = this

    @$include_blank_url_params.off('change').on('change'
      ->
        self.$form.data('include-blank-url-params', $(this).is(':checked'))
    )

    @$optimize_url_params.off('change').on('change'
      ->
        self.$form.data('optimize-url-params', $(this).is(':checked'))
    )

  _find: (selector) ->
    return this.$container.find(selector)

window.Filter = Filter