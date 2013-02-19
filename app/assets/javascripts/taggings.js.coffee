# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.Gist = {
  getTagsForGist: (callback) ->
    $.get("/gists/#{Gist.gist_id}/taggings", (tags) ->
      Gist.gistTags = tags.map((tag) -> tag.name)
      if (callback)
        callback(tags)
    )

  buildTagList: (tags) ->
    tag_list = $('<ul></ul>')
    tags.forEach((tag) ->
      tag_list.append("<li>#{tag.name}</li>")
    )
    $("#tags").append(tag_list)

  tagClickListen: () ->
    that = this
    $('#tag-list').off('click', 'li')
    test = (e) ->
      that.saveTag($(e.target).text(), () ->
        $('input#tag-box').val('')
      )
    $('#tag-list').on('click', 'li', test)

  saveTag: (tag_name, callback) ->
    $.post(
      "/gists/#{Gist.gist_id}/taggings",
      {tag_name: tag_name},
      (resp) ->
        if (resp.message)
        else
          $('#tags ul').append('<li>' + resp.name + '</li>')
          $('#tag-list').remove()
          if (Gist.allTags.indexOf(resp.name) == -1)
            Gist.allTags.push(resp.name)
          if (Gist.gistTags.indexOf(resp.name) == -1)
            Gist.gistTags.push(resp.name)
          if(callback)
            callback(resp)
    )

  buildTagDropdown: () ->
    availableTags = this.filterTagNames(Gist.allTags, Gist.gistTags)
    this.renderTagDropdown(availableTags)
    this.filterTagDropdown(availableTags)
    this.tagClickListen()

  tagBoxHandler: (e) ->
    if (e.which == 13)
      tag_name = $('input#tag-box').val()
      $('input#tag-box').val('')
      this.saveTag(tag_name)
    else
      this.buildTagDropdown()


  filterTagNames: (collection, filterOut) ->
    collection.filter((el) ->
      (filterOut.indexOf(el) == -1)
    )

  hideDropdown: (e) ->
    $('#tag-list').hide()

  showDropdown: (e) ->
    if ($('#tag-list').length)
      $('#tag-list').toggle()
    else
      this.buildTagDropdown()

  renderTagDropdown: (tagNames) ->
    if ($('#tag-list').length)
      dropdown = $('#tag-list ul')
    else
      dropdown = $('<div id="tag-list"></div>')
      $("#new-tag-form").append($(dropdown))
      $("#tag-list").append("<ul></ul>")
    $('#tag-list li').remove()

  filterTagDropdown: (tagNames) ->
    input = $('input#tag-box').val()
    tagNames.forEach((name) ->
      regexp = new RegExp('^' + input)
      if (name.match(regexp))
        $('#tag-list ul').append($("<li>#{name}</li>"))
    )
}