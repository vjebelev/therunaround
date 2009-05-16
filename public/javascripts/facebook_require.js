FB_RequireFeatures(["XFBML"], function()
{
    FB.Facebook.init(window.api_key, window.xd_receiver_location);
    FB.Facebook.get_sessionState().waitUntilReady(function() { } );
});
