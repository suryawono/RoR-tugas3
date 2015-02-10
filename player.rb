class Player
	attr_accessor :nama, :blood, :manna
	def initialize()
		puts "Masukkan nama player :"
		@nama=gets.chomp
		@blood=100
		@manna=40
	end
	
	def is_die
		return (@blood<=0 || @manna <=0)
	end
	
	def attack
		@manna-=20
	end
	
	def defend
		@blood-=20
	end
	
	def status
		puts "#{@nama} : manna = #{@manna}, blood = #{@blood}"
	end
end	

class MainMenu
	def initialize
		
	end
	
	def start_menu(players_size)
		self.header_menu
		puts "Description:"
		puts "1. ketik \"new\" untuk membuat karakter"
		puts "2. ketik \"start\" untuk memulai pertarungan"
		puts "---------------------------------------"
		puts "Current player : #{players_size}"
	end
	
	def battle_menu
		players_move={}
		self.header_menu
		puts "Battle start:"
		puts "siapa yang akan menyerang : "
		players_move["penyerang"]=gets.chomp
		puts "siapa yang akan diserang : "
		players_move["terserang"]=gets.chomp
		return players_move
	end
	
	def get_command
		command=gets.chomp
		return command
	end
	
	def header_menu
		puts "======================================="
		puts "       Welcome to Battle Arena         "
		puts "---------------------------------------"
	end
end

class Game
	attr_accessor :menu, :players
	def initialize
		@menu=MainMenu.new
		@players=Array.new
	end
	
	def start
		menu.start_menu(players.size)
		while (command=@menu.get_command)!="start" do
			if (command=="new")
				@players.push(Player.new)
				menu.start_menu(players.size)
			else
				puts "Invalid command"
			end
		end
		while !(self.is_gameover)
			self.battle(@menu.battle_menu)
			self.show_players_status
		end
		puts "--Game Over--"
	end
	
	def is_gameover
		status=false
		@players.each do |player|
			status=status || player.is_die
		end
		return status
	end
	
	def battle(players_move)
		@players.each do |player|
			if (player.nama==players_move['penyerang'])
				player.attack
			end
			if (player.nama==players_move['terserang'])
				player.defend
			end
		end
	end
	
	def show_players_status
		@players.each do |player|
			player.status
		end
	end
end

game=Game.new
game.start