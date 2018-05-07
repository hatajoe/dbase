# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

repositories = null

if repositories == null
  fetch '/repositories.json', { credentials: 'same-origin' }
    .then (response) -> response.json()
    .then (json) -> repositories = json

document.addEventListener 'turbolinks:load', () ->
  repository_form = document.getElementById 'product_repository_name'
  if repository_form != null
    repository_data_list = document.getElementById 'repositories'
    repository_form.onfocus = () ->
      if repositories != null && repository_data_list.getElementsByTagName('option').length == 0
        repository_data_list.innerHTML = repositories.map (repo) ->
          '<option value="' + repo.full_name + '"></option>'
        -> join '\n'

    repository_form.onsubmit = (e) ->
