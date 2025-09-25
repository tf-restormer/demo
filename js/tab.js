function openPage(pageName, elmnt) {
    // Hide all elements with class="tabcontent" by default */
    var i, tabcontent, active_tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");

    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
    }
  
    // Remove the background color of all tablinks/buttons
    active_tablinks = document.getElementsByClassName("tablink_active");
    for (i = 0; i < active_tablinks.length; i++) {
        active_tablinks[i].className = active_tablinks[i].className.replace("_active", "");
      }

    // Show the specific tab content
    document.getElementById(pageName).style.display = "block";
    elmnt.className += "_active";
  
    // Add the specific color to the button used to open the tab content
  }
  
  // Get the element with id="defaultOpen" and click on it
  document.getElementById("defaultOpen").click();