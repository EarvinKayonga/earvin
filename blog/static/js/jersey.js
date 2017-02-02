// Hide the fake styles, and grab the real styles
var realStyle = document.getElementsByTagName('jenn')[0];
realStyle.style.display = 'none';


// Grab the data
var toApply = [];
realStyle.innerHTML.split("<br>").forEach(function (line) {


  var match = line.trim().match('(.+?){(.+?)}');
  if (match) {

    var things = match[2].split(';').map(function (s) { return s.trim(); });
    things.slice(0, -1).forEach(function (t) {
      var pieces = t.split(':');

      // handle dem commas
      match[1].split(',').forEach(function (selector) {

        selector = selector.trim();

        var elems;
        if (selector[0] === '#') {
          // IDs
          elems = [document.getElementById(selector.slice(1))];
        } else if (selector.indexOf(' ') !== -1) {
          // Nested
          var tags = selector.split(' ');
          elems = [];
          var es = document.getElementsByTagName(tags[0]);
          for (var i = 0; i < es.length; i++) {
            var cn = es[i].childNodes;
            for (var j = 0; j < cn.length; j++) {
              if (cn[j].tagName === tags[1].toUpperCase()) {
                elems.push(cn[j]);
              }
            }
          }
        } else {
          // Bare tags
          elems = document.getElementsByTagName(selector);
        }
        var elem;
        for (var m = 0; m < elems.length; m++) {
          elem = elems[m];
          toApply.push([elem, pieces[0], pieces[1].trim()]);
        }

      });

    });

  }
});


var applyNext = function () {
  var app = toApply.shift();
  if (app && app[0]) {
    app[1] = app[1].replace(/\-(\w)/, function(i,m) { return m.toUpperCase(); });
    app[0].style[app[1]] = app[2];
  }
};

// And apply it
var interval = setInterval(function () {
  applyNext();
  if (!toApply.length) {
    clearInterval(interval);
    document.getElementsByClassName("panel")[0].className = "";
    document.getElementsByClassName("container")[0].style.maxWidth = 'none'
    var pre = document.getElementsByTagName('pre');
    for (var i = 0; i < pre.length; i++) {
      pre[i].style.padding = 'none';
      pre[i].style.margin = 'none';
      pre[i].style.fontSize = '13px';
      pre[i].style.lineHeight = '13px';
      pre[i].style.borderRadius = '0px';
      pre[i].style.border = 'none';
      pre[i].style.wordBreak = 'none';
      pre[i].style.wordWrap = 'none';
      pre[i].style.backgroundColor = 'transparent';
    }
  }
}, 50);



// Undeprecate <blink>
(function() {
  window.blinks = document.getElementsByTagName('blink');

  window.blinker = function(el) {
    setTimeout(function() {
      if (el.style.visibility == 'hidden')
        el.style.visibility = 'visible';
      else
        el.style.visibility = 'hidden';

      window.blinker(el);
    }, el.attributes.type ? el.attributes.type.nodeValue : 182);
  };

  for (var i = 0; i < window.blinks.length; i++) {
    // death to tyrants
    window.blinker(window.blinks[i]);
  }
})();

// a splash of color for better accessibility and growth hackitude

var randomNumber = function(max){
  return (Math.random() * max).toFixed(0);
};
