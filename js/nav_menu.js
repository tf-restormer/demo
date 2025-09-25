function move_to_start() {
    window.scrollTo(0, 0);
}

window.onscroll = function() {show_button()};

// Get the navbar
var nav_button = document.getElementById("nav_button");

// Get the offset position of the navbar
var sticky = nav_button.offsetTop;

// Add the sticky class to the navbar when you reach its scroll position. Remove "sticky" when you leave the scroll position
function show_button() {
  if (window.scrollY >= sticky) {
    nav_button.style.visibility = "visible";
  } else {
    nav_button.style.visibility = "hidden";
  }
}