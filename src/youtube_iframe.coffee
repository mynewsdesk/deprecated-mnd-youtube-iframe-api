###
# ----------------------------------------------
# Authors:
#   Emil Löfquist (emil.lofquist@mynewsdesk.com)
#   Zoee Silcock (zoee.silcock@mynewsdesk.com)
#
# API docs:
#   https://developers.google.com/youtube/iframe_api_reference
# ----------------------------------------------
###
root = exports ? this

class Mixin
  @addTo: (obj)->
    for name, method of @
      obj[name] = method

class Observable extends Mixin
  eventListeners = []
  @on: (to, onNewEvent) ->
    eventListeners.push item: to, callback: onNewEvent
  @notifyNewEvent = (item, data = {}) ->
    subscriber.callback(item, data) for subscriber in eventListeners when subscriber.item is item

class YouTubeIframePlayer

  player:         null
  isPlaying:      false

  constructor: (playerContainerId, videoId, width = 560, height = 315, playerVars = {}, responsiveIframe = false, resizeTimeout = 100) ->
    unless YT? then insertApi()
    Observable.addTo @

    @playerContainerId  = playerContainerId
    @videoId            = videoId
    @width              = width
    @height             = height
    @playerVars         = playerVars
    @responsiveIframe   = responsiveIframe
    @resizeTimeout      = resizeTimeout

  insertPlayer: ->
    @player = new YT.Player(@playerContainerId,
      width: @width
      height: @height
      videoId: @videoId
      playerVars: @playerVars
      events:
        onReady: =>
          @notifyNewEvent 'ready'
          if @responsiveIframe then @respondToResize()
        onError: (e) =>
          switch e.data
            when 2 then message       = "Incorrect parameter value."
            when 5 then message       = "Content cannot be played in a HTML5 player or a HTML5 player related error has occured."
            when 100 then message     = "The video requested cannot be found."
            when 101,150 then message = "The owner of the requested video does not allow it to be played in embedded players."
          @notifyNewEvent 'error', { code: e.data, message: message }
        onPlaybackRateChange: (e) =>
          @notifyNewEvent 'playbackRateChange', e.data
        onPlaybackQualityChange: (e) =>
          @notifyNewEvent 'playbackQualityChange', e.data
        onApiChange: (e) =>
          @notifyNewEvent 'apiChange', e.data
        onStateChange: (e) =>
          switch e.data
            when YT.PlayerState.UNSTARTED then @notifyNewEvent 'unstarted', e.data
            when YT.PlayerState.ENDED then @notifyNewEvent 'ended', e.data
            when YT.PlayerState.PLAYING
              if @isPlaying
                @notifyNewEvent 'seeking', e.data
              else
                @isPlaying = true
                @notifyNewEvent 'playing', e.data
            when YT.PlayerState.PAUSED then @notifyNewEvent 'paused', e.data
            when YT.PlayerState.BUFFERING then @notifyNewEvent 'buffering', e.data
            when YT.PlayerState.CUED then @notifyNewEvent 'cued', e.data
    )

  insertApi = ->
    script          = document.createElement 'script'
    script.src      = 'https://www.youtube.com/iframe_api'
    firstScriptTag  = document.getElementsByTagName('script')[0]
    firstScriptTag.parentNode.insertBefore(script, firstScriptTag)

  getNewHeight = (originalWidth, originalHeight, newWidth) ->
    Math.round originalHeight / originalWidth * newWidth

  isZeroOrEmpty = (val) -> val is "0" or val is ""

  resizeIframe = (iframe) ->
    width         = iframe.width
    height        = iframe.height
    parent        = iframe.parentNode
    parentWidth   = parent.offsetWidth
    newHeight     = getNewHeight(width, height, parentWidth)

    # Do not resize parent if the iframe is supposed to be hidden
    unless isZeroOrEmpty(parent.style.opacity) or isZeroOrEmpty(parent.style.height)
      parent.style.height = "#{newHeight}px"

    iframe.style.width  = "#{parentWidth}px"
    iframe.style.height = "#{newHeight}px"

  respondToResize: =>
    iframe = @player.getIframe()
    resizeIframe(iframe)
    timer = null
    window.onresize = =>
      clearTimeout timer
      timer = setTimeout =>
        resizeIframe(iframe)
      , @resizeTimeout

root.Observable = Observable if Testing?
root.YouTubeIframePlayer = YouTubeIframePlayer
