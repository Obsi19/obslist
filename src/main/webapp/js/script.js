let menu = document.querySelector('#menu-btn');
let navbar = document.querySelector('.hearder .navbar');

menu.onclick = () => {
    menu.classList.toggle('fa-times');
    navbar.classList.toggle('active');
};


document.addEventListener("DOMContentLoaded", () => {
    const menu = document.querySelector("#menu-btn");
    const navbar = document.querySelector(".navbar");

    window.onscroll = () => {
        menu.classList.remove("fa-times");
        navbar.classList.remove("active");
    };
});



var swiper = new Swiper(".home-slider", {
    loop:true,
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
});



let loadMoreBtn = document.querySelector('.packages .load-more .btn');
let currentItem = 3;

loadMoreBtn.onclick = () =>{
    let boxes = [...document.querySelectorAll('.packages .box-container .box')];
    for(var i = currentItem; i < currentItem + 3; i++){
        boxes[i].style.display = 'inline-block';

    };
 
    currentItem += 3;
    if(currentItem >= boxes.length){
        loadMoreBtn.style.display = 'none';

    }

}


function myFunction() {
  var x = document.getElementById("myInput");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}


