/**
 * Created by fabiomadeira on 25/02/15.
 */
// jQuery for page scrolling feature
jQuery(document).ready(function(e) {
    e(".scroll").click(function(t) {
        t.preventDefault();
        e("html,body").animate({
            scrollTop: e(this.hash).offset().top
        }, 1e3)
    })
});


function toggledisplay(elementID){
       (
         function(style) {
           style.display = style.display === 'block'? 'none' : 'block';
       })(document.getElementById(elementID).style);
}
