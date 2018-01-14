class RsasController < ApplicationController
	before_action :set_rsa, only: [:show]

	def new
		rsa = Rsa.new()

	    if (params.has_key?(:n) && params.has_key?(:e) && params.has_key?(:d))
	    	rsa = Rsa.new({n: params[:n], e: params[:e], d: params[:d]})
	    else
	    	keys = RSA.new(0, 0, 0).new_key()
	    	rsa.n = keys[0]
			rsa.e = keys[1]
			rsa.d = keys[2]
	    end

	    respond_to do |format|
	    	if rsa.save
	        	format.json {render json: {'id' => rsa.id}}
	      	end
	    end
  	end

  	def show
	    rsa = Rsa.find_by id: params[:id]
	    respond_to do |format|
	        format.json {render json: {'n' => rsa.n , 'e' => rsa.e, 'd' => rsa.d}}
	    end
  	end

	private
	    def set_rsa
	      @rsa = Rsa.find(params[:id])
	    end

	    def rsa_params
	      params.require(:rsa).permit(:d, :e, :n)
		end
end
