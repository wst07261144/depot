function generate_order(){
    var name1 =  $("#name").val().trim()
    var phone1 = $("#phone").val().trim()
    var address1 = $("#address").val().trim()
    if(localStorage.getItem('order_info') != null){
        data = JSON.parse(localStorage.getItem('order_info'))
        data['name'] = name1; data['phone'] = phone1; data['address'] = address1
        $.ajax({
            url: '/products/order/direct',
            type: 'POST',
            data: {orders: JSON.stringify(data)},
            success:success_callback,
            error:function(){}
        })

    }
    if(localStorage.getItem('product_id_at_cart') != null){
        var data = {name: name1, phone: phone1, address: address1, shopping_cart_id: localStorage.getItem('product_id_at_cart')}
        $.ajax({
            url: '/products/order',
            type: 'POST',
            data: {orders: JSON.stringify(data)},
            success:success_callback,
            error:function(){}
        })
    }
    if(localStorage.getItem('cart_ids') != null){
        var data = {name: name1, phone: phone1, address: address1, cart_ids: localStorage.getItem('cart_ids')}
        $.ajax({
            url:'/products/order/many',
            type: 'POST',
            data:{orders :JSON.stringify(data)},
            success:success_callback,
            error:function(){}
        })

    }
    function success_callback(){
        localStorage.removeItem('product_id_at_cart')
        localStorage.removeItem('order_info')
        localStorage.removeItem('cart_ids')
        window.location.href = '/products/order_index'
    }
}

function save_the_product_order(product_id){
    localStorage.setItem('product_id_at_cart', product_id )
}

function check_save_button_for_order(){
    $('#confirm_buy').attr('disabled', !check_status_of_save_button_for_order());
}


function check_status_of_save_button_for_order(){
    var count = 0;
    var phone = /^\d+$/
    $("#modal-buy .add-on input").each(function(index,el){
        if($(el).attr('name')!= 'phone'){
            if($(el).val().trim() != ''){
                count += 1
            }
        }else{
            if(phone.test($(el).val().trim()) && $(el).val ().trim().length == 11){
                count += 1
            }
        }
    })
    return count == 3
}

function add_to_order(id,name,image){
    var color = $('input[name="color"]:checked').val()
    var size = $('input[name="size"]:checked').val()
    var num = $('#select_num input').val()
    var price=$('#price').text().trim().substring(7).trim()
    var data = {'color': color, 'size': size, 'num': num, 'price': price,'product_id': id, 'title': name, 'image':image}
    localStorage.setItem('order_info', JSON.stringify(data))
}
