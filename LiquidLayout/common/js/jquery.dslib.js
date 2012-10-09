/*
 * Dark Sky jQuery library
 * 
 * $.ds.load()
 * 
 * $.fn.dsmodal()
 * $.fn.dscenter()
 * -------$.fn.dscontext()-------
 */
(function($){
  $.ds = {}
  
  /*
  *
  * load json with loading...
  */
  $.ds.load = function(route, data, func){
    $('#loading_label').attr('loaded', '0');
    setTimeout(function(){
      if($('#loading_label').attr('loaded') == '0'){
        $('#loading_label').show();
      }
    }, 300);
    $.post(route, data,
      function(data){
        $('#loading_label').attr('loaded', '1').hide();
        func(data);
      }, "json"
    );
  };
  
  /*
   * Modal Panes plugin
   * 
   */
  $.fn.dsmodal = function(opts){
    return this.each(function(){$.ds.modal(this, opts);});
  };
  
  $.ds.modal = function(elem, opts) {
    if(typeof elem == 'object'){ elem = (elem instanceof jQuery) ? elem : $(elem); }
    if(typeof opts != 'object') opts = {};
    $.extend($.ds.modal.opts, opts);
    $.ds.modal.modals.unshift(elem);
    $.ds.modal.background
      .height($(document).height())
      .width($(document).width())
      .css({opacity:$.ds.modal.opts.opacity, zIndex:$.ds.modal.zIndex()}).show();
    elem.css({ "zIndex": $.ds.modal.zIndex()+1,"position":'absolute'}).show();
  };
  
  $.ds.modal.background = null;
  $.ds.modal.modals = new Array();
  $.ds.modal.opts = {
    'id':'ds_modal_background',
    'background':'#000000',
    'opacity': '0.3',
    'zIndex': 100
  }
  
  $.ds.modal.zIndex = function(){
    return $.ds.modal.modals.length*2+$.ds.modal.opts.zIndex;
  }
  
  $.ds.modal.close = function(){
    if($.ds.modal.modals.length == 0) { return false; } /* if no modal panes were opened */
    var modal = $.ds.modal.modals.shift();
    if($.ds.modal.modals.length){
      $.ds.modal.background.css({zIndex:$.ds.modal.zIndex()});
    }else{
      $.ds.modal.background.hide();
    }
    modal.hide();
  };
  
  jQuery.ds.modal.init = function() {
    if($.browser.msie&&($.browser.version<7)){
      $.ds.modal.background = $('<iframe>');
    }else{
      $.ds.modal.background = $('<div>');
    }
    $.ds.modal.background.attr('id',$.ds.modal.opts.id)
      .css({
        'position':'absolute',
        'left':0,
        'top':0,
        'background':$.ds.modal.opts.background
      })
      .hide()
      .appendTo('body')
      .click(function(){$.ds.modal.close();});
  }
  
  /* 
   * Center position plugin
   * 
   */
   
  jQuery.fn.dscenter = function(){
    var html = document.documentElement, body = document.body;
    if(html.clientHeight){ var clientHeight = (body.clientHeight) ? Math.min(body.clientHeight, html.clientHeight) : html.clientHeight;
      } else { var clientHeight = body.clientHeight; }
    var clientWidth = html.clientWidth ? html.clientWidth : body.clientWidth;
    var scrollTop   = html.scrollTop ? html.scrollTop : body.scrollTop;
    var scrollLeft  = html.scrollLeft ? html.scrollLeft : body.scrollLeft;
    return this.each(function() {
      var top = Math.max(parseInt(clientHeight/2 - $(this).height()/2 + scrollTop), 0) + 'px';
      var left = Math.max(parseInt(clientWidth/2 - $(this).width()/2 + scrollLeft), 0) + 'px';
      $(this).css({'position':'absolute','left':left,'top':top});
    });
  };

})(jQuery);

$(document).ready(function() {
  $.ds.modal.init();
});