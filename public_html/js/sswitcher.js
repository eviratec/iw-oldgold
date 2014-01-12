/*
//  Services Switcher
//  Written by Callan Milne
//  Copyright (c) 2010 Integrated Web Services
*/

    var swapBannerEvery = 5; // How often should the banner swap (in seconds)
    var itemSelectedImg = "/img/iw2/sswitcher/ss.tick.gif";
    var itemNotSelectedImg = "/img/iw2/sswitcher/ss.tick.clear.gif";
    
    var timer;
    var timerActive = 0;
    var timerCount = 0;
    var preload = ['','','','',''];
    
    var currentBanner = 0;
    var currentItem = 0;
    
    var sswitcherItems = ["ecommerce","webui","social","appdev","marketing"];
    var sswitcherLinks = ["services/ecommerce/premium","services/web-design","services/social-media","services/application-development","services/online-marketing"];
    
    function sswitcher(act) {
      // Check if we are starting or stopping
      if (act == 'START') {
        // Action was start, start the timer (provided it's not already active)
        if (!timerActive) {
          timerActive = 1;
          loopSswitcher(0);
        }
      }
      else if (act == 'SOFT-START') {
        // Action was soft-start, start, but don't swap initial image for 1.5 times as long
        if (!timerActive) {
          timerActive = 1;
          loopSswitcher(1);
        }
      }
      else if (act == 'STOP') {
        // Action was stop, stop the timer
        timerActive = 0;
        clearTimeout(timer);
      }
    }
    
    function loopSswitcher(soft) {
      // Swap carousel banner periodically
      if (!soft) {
        // Normal start, swap image immediately and start timer
        nextSswitcherBanner();
        timer = setTimeout("loopSswitcher(0)",(swapBannerEvery*1000));
      }
      else {
        // Soft start, don't swap image immediately, extend initial timer
        timer = setTimeout("loopSswitcher(0)",(swapBannerEvery*1500));
      }
    }
    
    function nextSswitcherBanner() {
      
      var sswitcherImage = document.getElementById('sswitcherImage').src;
      var re = /([a-zA-Z0-9-._]+)\.png$/i;
      
      if (sswitcherImage.match(re)) {
        
        currentItem = RegExp.$1;
        
        // See which banner is currently selected
        for (i = 0; i < sswitcherItems.length; i++) {
          if (sswitcherItems[i] == currentItem) {
            currentBanner = i;
          }
        }
        
        // Swap to next banner in rotation
        if (currentBanner > 3) {
          swapSswitcherBanner(0);
        }
        else {
          var nextBanner = currentBanner+1;
          swapSswitcherBanner(nextBanner);
        }
        
      }
      else {
        // This should never happen
        alert("No services switcher match! "+currentItem);
      }
    }
    
    function swapSswitcherBanner(banner) {
      
      // Define some new stuff, and change some existing definitions
      var lastBanner = currentBanner;
      currentBanner = banner;
      
      // Get some element ID's
      var banner = document.getElementById('sswitcherImage');
      var bannerLink = document.getElementById('sswitcherLink');
      var lastArrow = document.getElementById('sswitcherSelected'+lastBanner);
      var currArrow = document.getElementById('sswitcherSelected'+currentBanner);
      
      // Change some image sources, opacities and href's
      banner.style.opacity = '0';
      lastArrow.src = itemNotSelectedImg;
      currArrow.src = itemSelectedImg;
      bannerLink.href = sswitcherLinks[currentBanner];
      banner.src = "/img/iw2/sswitcher/ss.banner."+sswitcherItems[currentBanner]+".png";
      
      // Make the next banner fade in!
      Effect.Appear(banner, { duration: 0.5, from: 0, to: 1 });
      
    }
    
    function loadSswitcher() {
      // Compact call to start switcher for body onload
      for (i = 0; i < sswitcherItems.length; i++) {
        // Preload required images
        preload[i] = new Image();
        preload[i].src = "/img/iw2/sswitcher/ss.banner."+sswitcherItems[i]+".png";
      }
      sswitcher('SOFT-START');
    }