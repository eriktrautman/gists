# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Gists = () ->
  that = this

  this.autosave = () ->
    clearTimeout(that.autosaveTimer)
    that.autosaveTimer = setTimeout(
      () ->
        that.submitGistForm()
        that.displaySaveSuccess()
      , 3000)

  this.submitGistForm = () ->
    $('form.edit_gist input[name="commit"]').click()

  this.displaySaveSuccess = () ->
    $('p.saved').remove()
    $('body').prepend($('<p class="saved">Saved</p>'))

  this

window.gistsController = new Gists