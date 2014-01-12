/************************************
 * IntegratedWeb Drop Menu v1
 * Copyright (c) 2010 Callan Milne
 ************************************/

var menuTimeout = 200;
var menuDelay = 200;
var menuCloseTimer = 0;
var menuOpenTimer = 0;
var menuItem = 0;
var menuButton = 0;

function menuShow(id) {
  menuCancelCloseTime();
  menuClose();
  
  menuItem = document.getElementById(id+'Menu');
  menuButton = document.getElementById(id+'Button');
  var menuHeight = document.getElementById('topMenu').offsetHeight;
  var menuPosY = (menuButton.offsetTop+menuHeight+2);
  var menuPosX = menuButton.offsetLeft;
  menuItem.style.top = menuPosY+'px';
  menuItem.style.left = menuPosX+'px';
  menuOpenTimer = window.setTimeout('Effect.SlideDown(menuItem, { duration: 0.3 })', menuDelay);
  /*menuItem.style.display = 'block';*/
  
  menuButton.className = 'over';
}

function menuClose() {
  window.clearTimeout(menuOpenTimer);
  menuOpenTimer = null;
  if (menuItem) {
    menuItem.style.display = 'none';
    menuButton.className = '';
  }
}

function menuCloseTime() {
  menuCloseTimer = window.setTimeout(menuClose, menuTimeout);
}

function menuCancelCloseTime() {
  if(menuCloseTimer) {
    window.clearTimeout(menuCloseTimer);
    menuCloseTimer = null;
  }
}

document.onclick = menuClose;