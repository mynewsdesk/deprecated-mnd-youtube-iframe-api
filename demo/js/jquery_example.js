$(function() {
  $('.video-example').youtubeIframe({
    onPlaying: function() {
      console.log("Player 1 is playing");
    },
    onEnd: function() {
      console.log("Finished playing");
    }
  });

  $('.video-example2').youtubeIframe({
    videoId: 'CLNZg8tVZaY',
    responsiveIframe: false,
    onPlaying: function() {
      console.log("Player 2 is playing");
    },
    onEnd: function() {
      console.log("Finished playing");
    }
  });
});
