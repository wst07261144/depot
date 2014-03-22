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
//    {color:[],sort:[],image:[],size:[]}
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
    var setting = {'color':colors,'image':images,'sort':sorts,'size':sizes}
    $.ajax({
        url: '/products/pro_attr',
        type: 'POST',
        data: setting,
        success: function (data) {
//            window.location.reload()
        },
        error: function (err) {
        }
    });
}

