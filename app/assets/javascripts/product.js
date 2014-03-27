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
    $('#image input').each(function(){
        if($(this).val().trim()){
            images.push($(this).val().trim())
        }
    })
    var setting = {'color':colors,'image':images,'sort':sorts,'size':sizes,'id':window.location.pathname.substring(20)}
    $.ajax({
        url: '/products/pro_attr',
        type: 'POST',
        data: setting,
        success: function (data) {
            window.location.href = '/products/index'
        },
        error: function (err) {
        }
    });
}

function turn_css(el){
    var id = $(el).parent().attr('id')
    console.log(id)
    console.log(window.location.pathname)
    $('.multilevel-nav li').each(function(index,el){

        if($(el).hasClass('active') && $(this).attr('id')!= id ){
            $(this).removeClass('active')
        }
        if($(el).attr('id') == id){
            $(this).addClass('active')
        }

    })
}
$(function(){
    if (window.location.pathname.substring(20)!=''){
       var product_id = window.location.pathname.substring(20);
       var data = JSON.parse( $('#data').text())
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
        $.each(data.image_url,function(index,img){
            var new_input = $("#image .none").clone().removeClass('none')
            new_input.children('input').val(img)
            $('#image .none').before(new_input)
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


