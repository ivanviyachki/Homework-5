class MessagesController < ApplicationController
	before_action :set_message, only: [:show]
	def new
		rsa = Rsa.find_by id: params[:id]
		new_rsa = RSA.new(rsa.n, rsa.e, rsa.d)

		crypted_mess = new_rsa.encrypt(params[:message])
	    message = Message.new({messid: rsa.id, mess: crypted_mess})
	    
	    respond_to do |format|
			if message.save
				format.json {render json: {'id' => message.id}}
			end
	    end
	end

	def show
		crypted_mess = Message.find_by messid: params[:id], id: params[:id2]

		respond_to do |format|
			if crypted_mess.save
				format.json {render json: {'message' => crypted_mess.mess}}
			end
	    end
	end

	def decrypt_message
	    rsa = Rsa.find_by id: params[:id]
	    
	    new_rsa = RSA.new(rsa.n, rsa.e, rsa.d)
	    decrypted_mess = new_rsa.decrypt(params[:message])

	    respond_to do |format|
	    	format.json {render json: {'message' => decrypted_mess}}
	    end
  	end

	private
		def set_message
			@message = Message.find(params[:id])
		end

		def message_params
			params.require(:message).permit(:content)
		end
end
