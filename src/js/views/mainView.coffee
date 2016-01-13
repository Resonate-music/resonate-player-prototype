$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'

module.exports = class MainView extends Backbone.View

  el: $('body')
  template: _.template '<div id="player" class="row">
      <div class="col-sm-4">
        <h2>Res(&nbsp;)nate</h2>
        <a class="stop">Stop</a>
        |
        <a class="resume">Resume</a>
      </div>
      <div class="col-sm-8">
        <h2>Playlist</h2>
        <ul id="playlist">
          <%
          _.each(songs,function(song){
            %><li><%= song.fileName %><a href="#" class="play" data-filename="<%= song.fileName %>">Play</a></li><%
          });
          %>
        </ul>
      </div>
    </div>'

  library: null
  songPlaying: null
  currentSongName: null

  events:
    'click a.play': 'playSong'
    'click a.stop': 'stopPlaying'
    'click a.resume': 'resumePlaying'


  initialize: ->
    _.bindAll this, 'render'
    @render()


  playSong: (event)->

    @stopPlaying()
    @songPlaying = @library?.play $(event.currentTarget).data('filename')
    @currentSongName = $(event.currentTarget).data('filename')


  stopPlaying: ->

    console.dir 'Stopping '+@currentSongName
    @library?.stop()


  resumePlaying: ->

    console.log 'Resume playing '+@currentSongName
    @library?.resume()


  setLibrary: (library)->

    @library = library
    library.on 'reset', @render


  render: ->

    #console.log 'rendering'
    #console.dir @library?.toJSON()

    $(@el).html @template
      songs: @library?.toJSON()

