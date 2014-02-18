{YouTubeIframePlayer} = require '../src/youtube_iframe'

describe "YouTubeIframePlayer", ->
  describe "constructor", ->
    before ->
      global.YT = {} # Avoid insertApi()

    it "has default values", ->
      player = new YouTubeIframePlayer('foo', 'bar')

      expect(player.width).to.equal(560)
      expect(player.height).to.equal(315)
      expect(player.playerVars).to.be.empty
      expect(player.responsiveIframe).to.be.false
      expect(player.resizeTimeout).to.equal(100)

    it "stores values correctly", ->
      expectedWidth = 320
      expectedHeight = 160
      expectedVars = { awesome: true }
      expectedResponsive = true
      expectedResizeTimeout = 500

      player = new YouTubeIframePlayer('foo', 'bar', expectedWidth, expectedHeight, expectedVars, expectedResponsive, expectedResizeTimeout )

      expect(player.width).to.equal(expectedWidth)
      expect(player.height).to.equal(expectedHeight)
      expect(player.playerVars).to.equal(expectedVars)
      expect(player.responsiveIframe).to.be.true
      expect(player.resizeTimeout).to.equal(expectedResizeTimeout)
