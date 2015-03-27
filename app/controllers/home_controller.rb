class HomeController < ApplicationController

	def index
		@matches = Match.take(20)
	end
end