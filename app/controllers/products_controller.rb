class ProductsController < ApplicationController
  before_action :is_admin

  def index

    @subject = '商品列表'
    @name = User.find_by(id:session[:user_id]).name
    products = Product.all.order(created_at: :desc)
    @products = generate_products_for_page(products)
  end

  def index_order
    order = params['order']
    ids = params['ids']
    if order == '按销量'
      ids = generate_product_by_sell_num(params['ids'])
      products = []
      ids.each do |id|
        products.push(Product.find_by(id: id))
      end
    elsif order == '按价格'
      products = Product.where(id: ids).order(price: :asc)
    else
      products = Product.where(id: ids).order(created_at: :desc)
    end
    @products = generate_products_for_page(products)
    render partial:'clothing_list'
  end

  def new
    @subject = '创建新商品'
    @product = Product.new
    @name = User.find(session[:user_id]).name
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      session[:product_id] = @product.id
      redirect_to '/products/next_step'
    else
      render 'new'
    end
  end

  def update
    product =  Product.find(params[:id])
    session[:product_id] = params[:id]
    product.update_attributes(params[:product].permit!)
    redirect_to '/products/next_step/'+ (params[:id])
  end

  def color_size_image
    @name = User.find(session[:user_id]).name
    @subject = '设置商品属性'
  end

  def edit_color_size_image
    @name = User.find(session[:user_id]).name
    @subject = '编辑商品属性'
    @data = Product.fetch_edit_data(params[:id])
  end

  def save_product_attr
    if params['color'].blank? || params['size'].blank? || params['sort'].blank?
      render :text=>'error'
    else
      Product.save_product_attrs(session[:product_id]||params[:id], params)
      render :text=>'ok'
    end
  end

  def show
    @subject = '商品详情'
    @name = User.find(session[:user_id]).name
    @product = Product.find params[:format]
    @color = @product.product_colors.pluck(:color)
    @size = @product.product_sizes.pluck(:size)
    @image = @product.product_images.pluck(:image_url)
    @images = @product.product_images.pluck(:image_url) - [@product.product_images.pluck(:image_url)[0]]
    @addresses = CustomerAddress.where(user_id: session[:user_id])
  end

  def edit
    @subject = '编辑商品'
    @name= User.find(session[:user_id]).name
    @product =  Product.find(params[:id])
  end

  def girl_tops
    @subject = '商品列表'
    @name = User.find_by(id:session[:user_id]).name
    products = Product.where(sort: '女士上装')
    @products = generate_products_for_page(products)
  end

  def girl_tops_order
    order = params['order']
    ids = params['ids']
    if order == '按销量'
      ids = generate_product_by_sell_num(params['ids'])
      products = []
      ids.each do |id|
        products.push(Product.find_by(id: id))
      end
    elsif order == '按价格'
      products = Product.where(id: ids).order(price: :asc)
    else
      products = Product.where(id: ids).order(created_at: :desc)
    end
    @products = generate_products_for_page(products)
    render partial:'clothing_list'
  end

  def boy_tops
    @subject = '商品列表'
    @name = User.find_by(id:session[:user_id]).name
    products = Product.where( sort: '男士上装')
    @products = generate_products_for_page(products)
  end

  def boy_tops_order
    order = params['order']
    ids = params['ids']
    if order == '按销量'
      ids = generate_product_by_sell_num(params['ids'])
      products = []
      ids.each do |id|
        products.push(Product.find_by(id: id))
      end
    elsif order == '按价格'
      products = Product.where(id: ids).order(price: :asc)
    else
      products = Product.where(id: ids).order(created_at: :desc)
    end
    @products = generate_products_for_page(products)
    render partial:'clothing_list'
  end

  def girl_bottoms
    @subject = '商品列表'
    @name = User.find_by(id:session[:user_id]).name
    products = Product.where(sort: '女士下装')
    @products = generate_products_for_page(products)
  end

  def girl_bottoms_order
    order = params['order']
    ids = params['ids']
    if order == '按销量'
      products = []
      ids.each do |id|
        products.push(Product.find_by(id: id))
      end
    elsif order == '按价格'
      products = Product.where(id: ids).order(price: :asc)
    else
      products = Product.where(id: ids).order(created_at: :desc)
    end
    @products = generate_products_for_page(products)
    render partial:'clothing_list'
  end

  def boy_bottoms
    @subject = '商品列表'
    @name = User.find_by(id:session[:user_id]).name
    products = Product.where(sort: '男士裤装')
    @products = generate_products_for_page(products)
  end

  def boy_bottoms_order
    order = params['order']
    ids = params['ids']
    if order == '按销量'
      ids = generate_product_by_sell_num(params['ids'])
      products = []
      ids.each do |id|
        products.push(Product.find_by(id: id))
      end
    elsif order == '按价格'
      products = Product.where(id: ids).order(price: :asc)
    else
      products = Product.where(id: ids).order(created_at: :desc)
    end
    @products = generate_products_for_page(products)
    render partial:'clothing_list'
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to '/products/index'
  end

  def add_shopping_cart
    product = ShoppingCart.find_by(color: params[:color], size: params[:size],price: params[:price],
                              user_id: session[:user_id],product_id: params[:product_id])
    if product.nil?
      pro = Product.find(params[:product_id])
      @shopping_cart = ShoppingCart.create(color: params[:color], size: params[:size], num: params[:num],
                    price: params[:price], user_id: session[:user_id],product_id: params[:product_id],
                    name: pro.title, img: pro.product_images.first.image_url)
      render text: 'ok'
    else
      product.update_attribute(:num, product.num + params[:num].to_i)
      render text: 'ok'
    end
  end

  def shopping_cart_index
    @subject = '我的购物车'
    @name = User.find(session[:user_id]).name
    @products = ShoppingCart.where(user_id: session[:user_id]).order(created_at: :desc)
    @addresses = CustomerAddress.where(user_id: session[:user_id])
  end

  def destroy_from_shopping_cart
    ShoppingCart.find(params[:id]).destroy
    render :text=> 'ok'
  end

  def handle_img
    require 'fileutils'
    xls_tmp = params[:upload_file][:user_info_file]
    xls_tmp.each_with_index do|img,index|
      a = rand(100000).to_s
      xls_position = File.join('app/assets/images', session[:user_id].to_s + '_' + a  + '_upload.png')
      FileUtils.cp img.path, xls_position
      ProductImage.create(product_id: session[:product_id], image_url: session[:user_id].to_s + '_' + a  + '_upload.png' )
    end

    redirect_to '/products/index'
  end

  def delete_img
    ProductImage.find_by(product_id: session[:product_id], image_url: params[:img_name]+'.png').destroy
    render text: 'ok'
  end

  def save_orders
    order = JSON.parse(params[:orders])
    address = CustomerAddress.find_or_create_by(user_id: session[:user_id], name: order['name'], phone: order['phone'],
                           address: order['address'])
    shopping_cart = ShoppingCart.find_by(id: order['shopping_cart_id'].to_i)

    address.orders.create(user_id: session[:user_id], product_id: shopping_cart.product_id,name: shopping_cart.name,
                          color: shopping_cart.color, num: shopping_cart.num, size: shopping_cart.size,
                          price: shopping_cart.price, total_price: shopping_cart.num * shopping_cart.price,
                          img: shopping_cart.img)
    render :text=>'ok'
  end

  def save_ordes_many
    orders = JSON.parse(params[:orders])
    address = CustomerAddress.find_or_create_by(user_id: session[:user_id], name: orders['name'], phone: orders['phone'],
                                     address: orders['address'])
    JSON.parse(orders['cart_ids']).each do |id|
      shopping_cart = ShoppingCart.find_by(id: id.to_i)

      address.orders.create(user_id: session[:user_id], product_id: shopping_cart.product_id,name: shopping_cart.name,
                            color: shopping_cart.color, num: shopping_cart.num, size: shopping_cart.size,
                            price: shopping_cart.price, total_price: shopping_cart.num * shopping_cart.price,
                            img: shopping_cart.img)
    end
    render :text=>'ok'
  end

  def save_order_direct
    order = JSON.parse(params[:orders])
    address = CustomerAddress.find_or_create_by(user_id: session[:user_id], name: order['name'], phone: order['phone'],
                                     address: order['address'])
    address.orders.create(user_id: session[:user_id], product_id: order['product_id'],name: order['title'],
                          color: order['color'], num: order['num'], size: order['size'],
                          price: order['price'], total_price: order['price'].to_i * order['num'].to_i,
                          img: order['image'])
    render :text=>'ok'
  end

  def order_index
    products = []
    @subject = '我的订单'
    @name = User.find_by(id:session[:user_id]).name
    if (!@is_admin && User.find(session[:user_id]).admin != 'super')
       Order.where(user_id: session[:user_id],user_delete: nil).each do |order|
         products.push(generate_order_items(order))
       end
      @products = products
    end
    if (is_admin || User.find(session[:user_id]).admin == 'super')
      my_orders = Order.where(admin_delete: nil).group_by{|order| order.product_id}
      @products = generate_order_admin1(my_orders)
    end
  end

  def delete_order
    Order.find_by(id: params[:order_id]).update(user_delete: 'true')
    render text: 'ok'
  end

  def delete_orders
    Order.where(product_id: params[:product_id]).each do |product|
      product.update_attribute(:admin_delete, true)
    end
    render text: 'ok'
  end

  def is_admin
    @is_admin = User.find(session[:user_id]).admin == 'admin'
  end

  private

  def generate_order_admin1(my_orders)
    products = []
    my_orders.keys.each_with_index do |order1,index|
      orders = {}
      order = Product.find_by(id: order1)
      orders.merge!({name: order.title})
      orders.merge!({img: order.product_images[0].image_url})
      orders.merge!({product_id: order1})
      orders.merge!({info: generate_order_admin2(my_orders,index)})
      products.push(orders)
    end
    products
  end

  def generate_order_admin2(my_orders,index)
    array=[]
    my_orders.values[index].each do |item|
      items = {}
      address = CustomerAddress.find_by(id: item.customer_address_id)
      items.merge!({receive: address.name})
      items.merge!({phone: address.phone})
      items.merge!({address: address.address})
      items.merge!({color: item.color})
      items.merge!({order_id: item.id})
      items.merge!({num: item.num})
      items.merge!({size: item.size})
      items.merge!({price: item.price})
      items.merge!({total_price: item.total_price})
      array.push(items)
    end
    array
  end

  def generate_order_items(order)
    orders = {}
    address = CustomerAddress.find_by(id: order.customer_address_id)
    orders.merge!({receive: address.name})
    orders.merge!({phone: address.phone})
    orders.merge!({address: address.address})
    orders.merge!({color: order.color})
    orders.merge!({name: order.name})
    orders.merge!({num: order.num})
    orders.merge!({img: order.img})
    orders.merge!({product_id: order.product_id})
    orders.merge!({size: order.size})
    orders.merge!({price: order.price})
    orders.merge!({order_id: order.id})
    orders.merge!({total_price: order.total_price})
    orders
  end

  def product_params
    params.require(:product).permit(:title, :mian_liao, :logo, :pic_source, :season, :style, :hou_bao, :huo_hao, :price, :user_id)
  end

  def generate_products_for_page(products)
    display = []
    products.each do |product|
      color = product.product_colors.pluck(:color)
      size = product.product_sizes.pluck(:size)
      img = product.product_images.pluck(:image_url)
      num = Order.where(product_id: product.id).count
      display.push({id: product.id, price: product.price, sell_num: num , title:product.title, logo:product.logo, size: size.join(' '),color: color.join(' '), image_url: img[0]})
    end
    display
  end

  def generate_product_by_sell_num(ids)
    order = Hash[Order.all.group('product_id').count.sort_by{|k, v| v}.reverse]

    order_ids = order.keys
    array_after_sort = []
    order_ids.each do |id|
      array_after_sort.push(id) if ids.map{|t| t.to_i}.include?(id)
    end
    ids.each do |id|
      array_after_sort.push(id.to_i) if !array_after_sort.include?(id.to_i)
    end
    array_after_sort
  end
end