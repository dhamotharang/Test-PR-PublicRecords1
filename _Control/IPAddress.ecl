export IPAddress 
 :=
  module
	/*export  string  bctlpedata10    :=  'bctlpedata10.risk.regn.net';     // 10.121.149.192
	export  string  bctlpedata11    :=  'bctlpedata11.risk.regn.net';     // 10.121.149.193*/
	export  string  bctlpedata10    :=  'uspr-edata10.risk.regn.net';     // 10.121.149.192 (primary - bctlpedata10); 10.195.76.30 (secondary - alalpedata10)
 	export  string  bctlpedata11    :=  'uspr-edata11.risk.regn.net';     // 10.121.149.193 (primary - bctlpedata11); 10.195.76.31 (secondary - alalpedata11)
	export  string  bctlpedata12    :=  'bctlpedata12.risk.regn.net';     // 10.121.149.194
	export	string	edata10			    :=	'edata10-bld.br.seisint.com';			// 10.150.13.201
	export	string	edata11			    :=	'edata11-bld.br.seisint.com';			// 10.150.12.242
	export	string	edata11b		    :=	edata11;								// used to be edata11-b @ '10.173.12.242';
	export	string	edata12			    :=	'edata12-bld.br.seisint.com';			// 10.150.14.14
	export	string	edata14			    :=	'edata14-bld.br.seisint.com';			// 10.173.212.10
	export	string	edata14a		    :=	edata14;								// 10.173.212.10
	export	string	edata15			    :=	'edata15-bld.br.seisint.com';			// 10.173.14.12
	export	string	sdsmoxiedev01	  :=	'sdsmoxiedev01.seisintdecisions.com';	// 172.18.10.12, also resolves from sdskeybuild02.seisintdecisions.com and espdevonline.securint.com
	export	string	tapeload01		  :=	'tapeload01.br.seisint.com';			// 10.121.145.79
	export	string	tapeload02		  :=	'tapeload02.br.seisint.com';			// 10.121.145.80
	export	string	tapeload02b		  :=	'tapeload02b.br.seisint.com';			// 10.121.145.41
  export  string  unixland        := '10.194.72.226';
	export  string  prodlz          := '10.194.64.250';
	export	string	dataland_esp	  :=	'dataland_esp.br.seisint.com';			// 10.173.29.160
	export	string	dataland_dali	  :=	'dataland_dali.br.seisint.com';			// 10.173.28.12
	export	string	adataland_esp	  :=	'alpha_dev_thor_esp.risk.regn.net';			// 10.173.29.160
	export	string	adataland_dali	:=	'alpha_dev_thor_dali.risk.regn.net';			// 10.173.28.12	
	export	string	dataland_sasha	:=	'10.173.65.201';						// No br domain DNS entry
	
	export	string	alpharetta_poc_thor	:=	'10.194.10.5';
	export	string	aprod_thor_esp	    :=	'alpha_prod_thor_dali.risk.regn.net';				// 10.173.84.202
	export	string	aprod_thor_dali	    :=	'alpha_prod_thor_dali.risk.regn.net';				// 10.173.84.201
	export	string	prod_thor_esp	      :=	'prod_esp.br.seisint.com';				// 10.173.84.202
	export	string	prod_thor_dali	    :=	'prod_dali.br.seisint.com';				// 10.173.84.201
	export	string	prod_thor_sasha	    :=	'10.173.85.204';						// No br domain DNS entry

  // request for DNS at some point later
	export	string	prod_watch_esp      := '10.173.249.4';
	export	string	prod_watch_dali     := '10.173.249.1';
	export	string	prod_watch_dev  := '10.173.219.13';	
	// export	string	prod_watch_sasha := '';
	
	export  string NewLogTHOR_dali      := '10.241.50.45';
	export  string FCRALogTHOR_dali      := '10.173.52.1';

	export  string bair_prod_ESP       := '10.240.32.15';
	export  string bair_Dev_ESP        := '10.240.32.16';
	export  string bair_DR_ESP         := '10.240.160.19';
	export  string bair_prod_dali      := '10.240.32.211';//floating
	export  string bair_prod_dali1      := '1.1.1.74';
	export  string bair_DR_dali        := '10.240.161.32';
	export  string bair_DR_dali1        := '2.1.1.10';
	export  string bair_dataland_dali  := '1.1.1.122';
	export  string bair_LZ_VIP      := 'bair-batchlz.risk.regn.net';
	export  string bair_batchlz01      := 'bair-batchlz.risk.regn.net';//10.240.0.47
	export  string abair_batchlz01     := 'abair-batchlz.risk.regn.net';//10.240.128.41

  end
 ;