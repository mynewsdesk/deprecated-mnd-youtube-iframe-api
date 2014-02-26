$.fn.extend
  youtubeIframe: (options) ->

    settings =
      videoId:            null
      width:              560
      height:             315
      playerVars:         {}
      responsiveiframe:   false
      resizeTimeout:      100
      onReady:            ->
      onError:            ->
      onPlaybackRateChange:     ->
      onPlaybackQualityChange:  ->
      onApiChange:        ->
      onUnstarted:        ->
      onEnd:              ->
      onPlaying:          ->
      onPaused:           ->
      onBuffering:        ->
      onCued:             ->

    settings = $.extend settings, options

    return @each () ->
      if not $.isEmptyObject($(@).data())
        data = $(@).data()
        data.playerVars = {}
        settings = $.extend settings, data

      containerId = "video-#{settings.videoId}"
      $(@).attr 'id', containerId
      player = new YouTubeIframePlayer(containerId, settings.videoId, settings.width, settings.height, settings.playerVars, settings.responsiveIframe, settings.resizeTimeout)

      # Pass back player specifics in callback
      player.on 'ready', ->
        settings.onReady()
      player.on 'ended', ->
        settings.onEnd()
      player.on 'playing', ->
        settings.onPlaying()
      player.on 'paused', ->
        settings.onPaused()
