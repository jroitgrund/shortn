'use strict';

(function () {


function postJSON(url, formData, callback, errorCallback) {
  var request = new XMLHttpRequest();
  request.open('POST', url, true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
  var token = document.querySelector("meta[name='csrf-token']").content;
  request.setRequestHeader("X-CSRF-Token", token);
  request.timeout = 4000;

  request.onload = function() {
    if (request.status >= 200 && request.status < 400) {
      var response = JSON.parse(request.responseText);
      callback(response);
    } else {
      errorCallback();
    }
  };

  request.onerror = errorCallback;

  var params = Object.keys(formData).map(function (key) {
    return encodeURIComponent(key) + '=' + encodeURIComponent(formData[key]);
  }).join('&');

  request.send(params);
}

function getFullUrlFromKey(key) {
  return window.location.origin + '/' + key;
}

function addProtocolToUrl(url) {
  if (url.toLowerCase().substr(0, 7) === 'http://') {
    return url;
  } else {
    return 'http://' + url;
  }
}

function showError() {
  document.getElementById('status').innerHTML = 'Server unreachable. Try again later';
}

function showShortenedUrl(response) {
  var url = getFullUrlFromKey(response.key);
  document.getElementById('status').innerHTML =
    'URL shortened to<br><a href="' + url + '">' + url + '</a>';
}

function shorten() {
  postJSON(
    '/shortn',
    { url: addProtocolToUrl(document.getElementById('url-input').value) }, 
    showShortenedUrl,
    showError);
}

function main() {
  document.getElementById('shorten-button').addEventListener('click', shorten);
}

document.addEventListener('DOMContentLoaded', main);


})();
