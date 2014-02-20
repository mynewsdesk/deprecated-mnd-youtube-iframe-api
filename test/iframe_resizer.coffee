describe "IframeResizer", ->
  before ->
    @resizer = new IframeResizer()

  describe "calculateNewHeight", ->
    it "calculates the new height based on the new width", ->
      width = 640
      height = 320

      expect(@resizer.calculateNewHeight(width, height, 320)).to.equal(160)

  describe "resizeIframe", ->
    beforeEach ->
      @iframe = sinon.stub()
      @iframe.width = 640
      @iframe.height = 320
      @iframe.style = sinon.stub()

      @iframe.parentNode = sinon.stub()
      @iframe.parentNode.offsetWidth = 320
      @iframe.parentNode.style = sinon.stub()

    it "resizes the iframe", ->
      @resizer.resizeIframe(@iframe)

      expect(@iframe.style.width).to.equal("320px")
      expect(@iframe.style.height).to.equal("160px")
