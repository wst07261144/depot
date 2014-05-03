$(document).ready(function(){
    if(window.location.pathname == "/products/shopping_cart"){
        $('#select_all input').click()
    }
})
function select_all(){
    if($('#select_all input[type=checkbox]:checked').length == 1){
        var select_cloth = $("#shopping_products input[type=checkbox][name=checkbox]")
        select_cloth.each(function(index,item){
            $(item).prop("checked", true);
        });
        $("#select_all :contains('合计')").text('合计：' + statistics_select_cloth_price_and_num()[0] + '元  合计物品：'+ statistics_select_cloth_price_and_num()[1] + '件')
    } else {
        $("#shopping_products input[type=checkbox][name=checkbox]").each(function(index,item){
            $(item).prop("checked", false);
        });
    }
    check_submit_order_button_status()
}

function statistics_select_cloth_price_and_num(){
    var all_price = 0,all_num = 0;
    $('#shopping_products input[type=checkbox]:checked').each(function(index,el){
       all_price += parseFloat($(el).val().split("+")[0]) * parseFloat($(el).val().split("+")[1])
        all_num += parseInt($(el).val().split("+")[1])
    })
    return [all_price,all_num]
}

function select_one(){
    var all_price = 0, all_num = 0, count = 0;
    var selected_cloth = $('#shopping_products input[type=checkbox]:checked')
    selected_cloth.each(function(index,el){
        all_price += parseFloat($(el).val().split("+")[0]) * parseFloat($(el).val().split("+")[1])
        all_num += parseInt($(el).val().split("+")[1])
        count += 1
    })
    $("#select_all :contains('合计')").text('合计：' + all_price + '元   合计物品：'+ all_num + '件')
    count == $('#shopping_products input[type=checkbox]').length ? $('#select_all input').prop("checked", true) : $('#select_all input').prop("checked", false)
    check_submit_order_button_status()
}

function destroy_cloth_from_shopping_cart(id){
    $.ajax({
        url:'/products/shopping_cart/'+id,
        type: 'DELETE',
        success:function(){ window.location.reload()},
        error:function(){}
    })
}

function jump_to_shopping_cart(){
    window.location.href = 'http://localhost:3001/products/shopping_cart'
}

function submit_orders(){
    var shopping_cart_ids = []
    $('#shopping_products input[type=checkbox]:checked').each(function(index,el){
        shopping_cart_ids.push($(el).next().children().text().trim())
    })
    localStorage.cart_ids  = JSON.stringify(shopping_cart_ids)
}

function check_submit_order_button_status(){
    $('#submit_order').attr('disabled',$('#shopping_products input[type=checkbox]:checked').length == 0)
}