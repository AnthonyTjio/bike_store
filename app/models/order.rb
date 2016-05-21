class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_item, dependent: :destroy

  def is_editable
  	if self.status=="Not Paid" 
  		true 
  	else 
  		false
  	end
  end

  def set_paid
  	if self.status=="Not Paid"
  		self.status = "Paid"
  		0
  	else
  		if self.status == "Paid"
  			1
  		else
  			2
  		end
  	end
  end

  def set_sent
  	if self.status == "Paid"
  		self.status = "Delivered"
  		0
  	else
  		if self.status == "Not Paid"
  			1 # The customer haven't paid
  		else
  			2 # The transaction has done
  		end
  	end
  end

end
