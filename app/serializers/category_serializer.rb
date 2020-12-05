class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :products
  
  def products
    object.products.first(10).map do |product|
      ::ProductSerializer.new(product).attributes
    end
  end
end
