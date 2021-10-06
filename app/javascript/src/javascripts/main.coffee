window.PRACTICE =
  init: ->
    console.log 'make with love'
    # PRACTICE.misc.selectizeByScope('body')
    return
  tasks:
    index:
      setup: ->
        console.log 'index page'
    # form:
      # setup: ->
        # $('.participants').on 'cocoon:before-insert', (e, insertedItem, originalEvent) ->
          # PRACTICE.misc.selectizeByScope insertedItem
        # return
  misc:
    selectizeByScope: (selector) ->
      $(selector).find('.selectize').each (i, el) ->
        $(el).selectize();
      return

$(document).on 'turbolinks:load', ->
  PRACTICE.init()