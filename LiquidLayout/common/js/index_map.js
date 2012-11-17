/********************************* Uses to highlight object ***********/
function pick_out_ad(prefecture, obj_id) {
    var show_item = document.getElementById(obj_id);
    var width = show_item.offsetWidth;
    show_item.style.backgroundPosition = '-' + (prefecture) * width + 'px' + ' 1px';
    return true;
}

/************************* Uses to back to main map *****/
function back_to_admap(obj_id) {
    var show_item = document.getElementById(obj_id);
    var width = show_item.offsetWidth;	
    show_item.style.backgroundPosition = width + 'px' ;
    return true;
}