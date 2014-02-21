describe "PlayerQueue", ->
  it "adds player to queue", ->
    player = new YouTubeIframePlayer("123", "456")
    expect(PlayerQueue.get().queue).to.have.length(1)
