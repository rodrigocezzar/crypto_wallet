# Use o rails dev:setup (lib/tasks/dev.rake)

spinner = TTY::Spinner.new("[:spinner] cadastrando moedas")
spinner.auto_spin

coins = [   
		  { 
		  	description: "Bitcoin",
		    acronym: "BTC", 	
		    url_image: "https://img2.gratispng.com/20171220/bhe/bitcoin-png-5a3a2702388611.73714972151376051423153857.jpg"
		  },
		  { 
		  	description: "Ethereum",
		    acronym: "ETH",
		    url_image: "https://p.kindpng.com/picc/s/124-1245766_ethereum-png-transparent-png.png"
		  },
		  { 
		  	description: "Dash",
		    acronym: "DASH",
		    url_image: "https://cryptologos.cc/logos/dash-dash-logo.png"
		  }
		]

coins.each do |coin|
  Coin.find_or_create_by!(coin)
end

spinner.success("(concluido)")