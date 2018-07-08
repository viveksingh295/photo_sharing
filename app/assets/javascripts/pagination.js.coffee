$(document).on 'turbolinks:load', ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_url = $('.pagination .next_page a').attr('href')
      if more_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
          $('.pagination').html('<img src="" alt="Loading..." title="Loading..." />')
          $.getScript more_url
      return
    return