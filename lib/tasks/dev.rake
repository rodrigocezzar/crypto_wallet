namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
  	if Rails.env.development?
  	  show_spinner("apagando bd...") { %x(rails db:drop) }
  	  show_spinner("criando bd...") { %x(rails db:create)}
  	  show_spinner("migrando bd...") { %x(rails db:migrate) }
  	  %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)  	  
    else 

  	end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
  	show_spinner("cadastrando moedas...")do
		coins = [   
				  { 
				  	description: "Bitcoin",
				    acronym: "BTC", 	
				    url_image: "https://img2.gratispng.com/20171220/bhe/bitcoin-png-5a3a2702388611.73714972151376051423153857.jpg",
            mining_type: MiningType.find_by(acronym: 'PoW')
				  },
				  { 
				  	description: "Ethereum",
				    acronym: "ETH",
				    url_image: "https://p.kindpng.com/picc/s/124-1245766_ethereum-png-transparent-png.png",
            mining_type: MiningType.all.sample
				  },
				  { 
				  	description: "Dash",
				    acronym: "DASH",
				    url_image: "https://cryptologos.cc/logos/dash-dash-logo.png",
            mining_type: MiningType.all.sample
				  }
				]

		  coins.each do |coin|
		    Coin.find_or_create_by!(coin)
		  end
	   end	  
	end

    desc "Cadastra os tipos de mineração"
    task add_mining_types: :environment do
  	  show_spinner("cadastrando tipos de mineração") do
      mining_types = [
        {description: "Proff of Work", acronym: "PoW"},
        {description: "Proff of Stake", acronym: "PoS"}
      ]

      mining_types.each do |mining_type|
	    MiningType.find_or_create_by!(mining_type)
	  end
    end
  end

 private

    def show_spinner(msg_start, msg_end = "concluido")
  	  spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
  	  spinner.auto_spin
  	  yield
  	  spinner.success("(#{msg_end})")
    end
  end
