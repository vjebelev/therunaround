function populate_date(month, day, year) {
  ge('date_month').value = month;
  ge('date_day').value = day;
  ge('date_year').value = year;
}

function ge(elem) {
  return document.getElementById(elem);
}

/*
 * Ensure Facebook app is initialized and call callback afterward
 *
 */
function ensure_init(callback) {
  if(!window.api_key) {
    window.alert("api_key is not set");
  }

  if(window.is_initialized) {
    callback();
  } else {
    FB_RequireFeatures(["XFBML", "CanvasUtil"], function() {
        FB.FBDebug.logLevel = 4;
        FB.FBDebug.isEnabled = true;
        // xd_receiver.php is a relative path here, because The Run Around
        // could be installed in a subdirectory
        // you should prefer an absolute URL (like "/xd_receiver.php") for more accuracy
        FB.Facebook.init(window.api_key, window.xd_receiver_location);

        window.is_initialized = true;
        callback();
      });
  }
}

/*
 * "Session Ready" handler. This is called when the facebook
 * session becomes ready after the user clicks the "Facebook login" button.
 * In a more complex app, this could be used to do some in-page
 * replacements and avoid a full page refresh. For now, just
 * notify the server the user is logged in, and redirect to home.
 *
 * @param link_to_current_user  if the facebook session should be
 *                              linked to a currently logged in user, or used
 *                              to create a new account anyway
 */
function facebook_button_onclick() {

  ensure_init(function() {
      FB.Facebook.get_sessionState().waitUntilReady(function() {
          var user = FB.Facebook.apiClient.get_session() ?
            FB.Facebook.apiClient.get_session().uid :
            null;

          // probably should give some indication of failure to the user
          if (!user) {
            return;
          }

          // The Facebook Session has been set in the cookies,
          // which will be picked up by the server on the next page load
          // so refresh the page, and let all the account linking be
          // handled on the server side

          // This could be done a myriad of ways; for a page with more content,
          // you could do an ajax call for the account linking, and then
          // just replace content inline without a full page refresh.
          //refresh_page();
          window.location = window.facebook_authenticate_location;
        });
    });
}

/*
 * Do a page refresh after login state changes.
 * This is the easiest but not the only way to pick up changes.
 * If you have a small amount of Facebook-specific content on a large page,
 * then you could change it in Javascript without refresh.
 */
function refresh_page() {
  window.location = '/';
}

function logout() {
  window.location = '/login/logout';
}

