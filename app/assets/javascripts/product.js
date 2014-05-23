$(window).ready(function () {
    $("#upload_excel_submit").click(function () {
        var form_value = $("#upload_file_user_info_file").val();
        if (!(form_value === '' || form_value.indexOf('xls') == -1)) {
            $("#upload_excel_submit").val("上传中，请勿打断！");
            setTimeout(function() {
                $("#upload_excel_submit").attr("disabled", 'disabled');
            },100);
            $("#upload_excel_close").hide();
        }
    });
});

$(document).ready(function(){
    init_scroll();
    if(window.location.pathname.indexOf('/products/orders/')!= -1) {
        var order = localStorage.order_condition
        if(order){
            $('.btn-group.btn-group-0 a').each(function(index,el){
                $(el).text().trim() == order ? $(el).addClass('active') : $(el).removeClass('active')
            })
        }
    }
})

$(function(){
    var path = window.location.pathname
    if (path.substring(20)!='' && path.substring(0,20) == '/products/next_step/'){
        var product_id = window.location.pathname.substring(20);
        var data = JSON.parse( $('#data').text())
        console.log(data)
        $.each(data.color,function(index,col){
            if(col == '白色' || col == '黑色' || col == '黄色'||col=='红色' ||col== '粉色'){
                $('#color a').each(function(index,el){
                    if($(el).text().trim() == col ){
                        $(el).removeClass('label-blank').addClass('btn').addClass('btn-primary')
                    }
                })
            }else{
                var new_input = $("#color .none").clone().removeClass('none')
                new_input.children('input').val(col)
                $('#color .none').before(new_input)

            }
        })
        $.each(data.size,function(index,size){
            if(size == 'S' || size == 'L' || size == 'XL'||size=='XXL' ||size== 'XXXL'){
                $('#size a').each(function(index ,el){
                    if($(el).text().trim() == size ){
                        $(el).removeClass('label-blank').addClass('btn').addClass('btn-primary')
                    }
                })
            }else{
                var new_input = $("#size .none").clone().removeClass('none')
                new_input.children('input').val(col)
                $('#size .none').before(new_input)

            }
        })

        if(data.sort == '男士上装' || data.sort == '男士裤装' || data.sort == '女士上装'||data.sort=='女士裤装、裙装' ){
            $('#sort a').each(function(index ,el){
                if($(el).text().trim() == data.sort ){
                    $(el).removeClass('label-blank').addClass('btn').addClass('btn-primary')
                }
            })
        }

    }
})

function init_scroll() {
    if($('#scroll').height() > $(window).height() - $('#scroll').offset().top) {
        $('#scroll').css('height',$(window).height() - $('#scroll').offset().top +'px');
    }

    $(window).resize(function(){
        $('#scroll').css('height',$(window).height() - $('#scroll').offset().top +'px');
    })
}

function change_order_for_index(el) {
    if(!$(el).hasClass('active')) {
         localStorage.order_condition = $(el).text().trim()
         window.location.href = '/products/orders/' + $(el).text().trim();
    }
}

function add_color_input(){
    var new_input = $("#color .none").clone().removeClass('none')
    $('#color .none').before(new_input)
}

function add_size_input(){
    var new_input = $("#size .none").clone().removeClass('none')
    $('#size .none').before(new_input)
}

function add_image_input(){
    var new_input = $("#image .none").clone().removeClass('none')
    $('#image .none').before(new_input)
}

function select_color(el){
    if($(el).hasClass('label-blank')){
        $(el).removeClass('label-blank').addClass('btn').addClass('btn-primary')
    }else{
        $(el).removeClass('btn').removeClass('btn-primary').addClass('label-blank')
    }
}

function save_settings(){
    var colors=[],sorts=[],images=[],sizes=[];
    $('#color .label.btn').each(function(index, el){
       colors.push($(el).text().trim())
    })
    $('#color input').each(function(){
        if($(this).val().trim()){
            colors.push($(this).val().trim())
        }
    })
    $('#size .label.btn').each(function(index, el){
        sizes.push($(el).text().trim())
    })
    $('#size input').each(function(){
        if($(this).val().trim()){
            sizes.push($(this).val().trim())
        }
    })
    $('#sort .label.btn').each(function(index, el){
        sorts.push($(el).text().trim())
    })
    var setting = {'color':colors,'image':images,'sort':sorts,'size':sizes,'id':window.location.pathname.substring(20)}
    var setting = {'color':colors,'sort':sorts,'size':sizes,'id':window.location.pathname.substring(20)}
    $.ajax({
        url: '/products/pro_attr',
        type: 'POST',
        data: setting,
        success: function (data) {
              $('#save_setting').parent().addClass('none')
              $('#add_img').removeClass('none')
        },
        error: function (err) {
        }
    });
}

$(document).on("page:load", function () {
    change_service_header_style_to_active();

});

function change_service_header_style_to_active() {
    var url_and_id_mapping={
    '/products/index': 'all',
    '/products/girl/tops': 'girl_tops',
    '/products/girl/bottoms': 'girl_bottoms',
    '/products/boy/tops': 'boy_tops',
    '/products/boy/bottoms': 'boy_bottoms'
    }
    $.each(['/products/index','/products/girl/tops','/products/girl/bottoms','/products/boy/tops','/products/boy/bottoms'],function(index,item){
        if(window.location.pathname == item){
           $('#' + url_and_id_mapping[window.location.pathname]).addClass('active')
           init_scroll();
        }
        if(window.location.pathname != item && $("#" + url_and_id_mapping[item]).hasClass('active')){
           $('#' + url_and_id_mapping[item]).removeClass('active')
        }
    })
}

function judge_button_can_click(){
    var color = $('input[name="color"]:checked').val()
    var size = $('input[name="size"]:checked').val()
    var num = $('#select_num input').val()
    var item_null = (color != undefined && size != undefined && num != '' )
    $('#shopping_cart').attr('disabled', !item_null)
    $('#buy_now').attr('disabled', !item_null)
}

function add_to_shopping_cart(){
    var color = $('input[name="color"]:checked').val()
    var size = $('input[name="size"]:checked').val()
    var num = $('#select_num input').val()
    var price=$('#price').text().trim().substring(7).trim()
    var data = {'color': color, 'size': size, 'num': num, 'price': price}
    $.ajax({
        url: '/products/shopping_cart/' + window.location.pathname.substring(10),
        type: 'POST',
        data:data,
        success:function(){
           window.location.href = 'http://localhost:3001/products/shopping_cart'
        },
        error:function(){}
    })
}

function check_file() {
    var file_component = document.getElementById("upload_file_user_info_file")
    var file_value = file_component.value;
    if (file_value === '') {
        alert("请选择图片")
        return false;
    }
    return true;
}

function delete_img_when_edit(img_name, index){
    $.ajax({
        url: '/products/image/' + img_name,
        type: 'DELETE',
        success:function(){
            $('[index=' + index +']').remove()
        },
        error:function(){}
    })
}

function delete_orders(order_or_product_id, admin) {
    console.log('123')
    if(admin == 'user'){
        $.ajax({
            url: '/products/order/' + order_or_product_id,
            type: 'DELETE',
            success:function(){
                $('#order_' + order_or_product_id).remove()
            },
            error:function(){}
        })
    } else {
        $.ajax({
            url: '/products/orders/' + order_or_product_id,
            type: 'DELETE',
            success:function(){
                $('#product_' + order_or_product_id).remove()
            },
            error:function(){}
        })
    }

}



