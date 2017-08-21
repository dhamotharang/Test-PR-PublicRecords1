EXPORT Layouts := module

	export CorpMstrLayoutIn   					:= Record
		string 	entityid;
		string 	entityname;
		string 	prinaddr1;
		string 	prinaddr2;
		string 	princity;
		string 	prinstate;
		string 	prinzip;
		string 	princountry;
		string 	mailaddr1;
		string 	mailaddr2;
		string 	mailcity;
		string 	mailstate;
		string 	mailzip;
		string 	mailcountry;			
		string 	entitystatus;
		string 	jurisdiction;
		string 	perpetualflag;
		string 	termdate;
		string 	entitytype;
		string 	agentfirstname;
		string 	agentmiddlename;
		string 	agentlastname;
		string 	agentsuffix;
		string 	agentorgname;
		string 	agentprinaddr1;
		string 	agentprinaddr2;
		string 	agentprincity;
		string 	agentprinstate;
		string 	agentprinzip;
		string 	agentprincountry;
		string 	agentmailaddr1;
		string 	agentmailaddr2;
		string 	agentmailcity;
		string 	agentmailstate;
		string 	agentmailzip;
		string 	agentmailcountry;			
		string 	entityformdate;
	end;
	
	export CorpMstrLayoutBase   				:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpMstrLayoutIn;
	end;
	
	export CorpTrdnmLayoutIn 						:= Record
		string 	tradenameid;
		string 	tradename;
		string 	tradenameform;
		string 	effdate;
		string 	firstname;
		string 	middlename;
		string 	lastname;
		string 	suffix;
		string 	regorg;
		string 	prinaddr1;
		string 	prinaddr2;
		string 	princity;
		string 	prinstate;
		string 	prinzip;			
		string 	princountry;
		string 	mailaddr1;
		string 	mailaddr2;
		string 	mailcity;
		string 	mailstate;
		string 	mailzip;
		string 	mailcountry;			
		string 	adddate;
	end;

	export CorpTrdnmLayoutBase    			:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpTrdnmLayoutIn;
	end;
	
	export CorpHistLayoutIn    					:= Record
		string 	histentityid;
		string 	tranid;
		string 	histdesc;
		string 	comment;
		string 	recdate;
		string 	effdate;
		string 	name;
	end;

	export CorpHistLayoutBase    				:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpHistLayoutIn;
	end;
		
	export TradeMarkLayoutIn   					:= Record		
		string  trademarkid;
		string  trdmkdscr;
		string  ownerfname;
		string  ownermname;
		string  ownerlname;
		string  ownersuffix;
		string  ownerorg;
		string  busphyaddr1;
		string  busphyaddr2;			
		string  busphycity;
		string  busphystate;
		string  busphycountry;
		string  busphyzip;
		string  busmailaddr1;
		string  busmailaddr2;
		string  busmailcity;
		string  busmailst;
		string  busmailcountry;
		string  busmailzip;
		string  agentfname;
		string  agentmname;
		string  agentlname;
		string  agentsufx;
		string  agentorg;
		string  agentphyaddr1;
		string  agentphyaddr2;
		string  agentphycity;
		string  agentphyst;
		string  agentphycountry;
		string  agentphyzip;
		string  agentmailaddress1;
		string  agentmailaddress2;
		string  agentmailcitytm;
		string  agentmailst;
		string  agentmailcountrytm;
		string  agentmailziptm;
		string  spaddr1;
		string  spaddr2;
		string  spcity;
		string  spstate;
		string  spcountry;
		string  spzip;
		string  gsclasscd;
		string  gsdesc;
		string  status;
		string  frstusedco;
		string  effectdte;
		string  expirdte;
		string  tmtype;
		string  specdesc;
		string  tradeform;
		string  entityform;
		string  jurisform;
		string  fileddate;
		string  docid;
		string  gsdeleteflag;
		string  comments;
	end;					

	export TradeMarkLayoutBase 					:= Record	
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		TradeMarkLayoutIn;
	end;

	export Temp_NormalizedMstr  				:= Record			
		CorpMstrLayoutIn;
		string 	norm_address1;
		string 	norm_address2;
		string 	norm_city;
		string 	norm_state;
		string 	norm_zip;
		string 	norm_country;
		string	norm_addrtype;
		string  norm_addrdesc;
		string  norm_agentname;
		string  norm_agentfirstname;
		string  norm_agentmiddlename;
		string  norm_agentlastname;
		string  norm_agentsuffix;
	end;

	export Temp_NormalizedTrdnm  				:= Record
		CorpTrdnmLayoutIn;
		string 	norm_address1;
		string 	norm_address2;
		string 	norm_city;
		string 	norm_state;
		string 	norm_zip;
		string 	norm_country;
		string	norm_addrtype;
		string  norm_addrdesc;
		string  norm_trdnmname;
		string  norm_trdnmfirstname;
		string  norm_trdnmmiddlename;
		string  norm_trdnmlastname;
		string  norm_trdnmsuffix;
	end;

	export Temp_NormalizedTradeMark  		:= Record
		string 	histentityid;
		string 	tranid;
		TradeMarkLayoutIn;
		string 	norm_address1;
		string 	norm_address2;
		string 	norm_city;
		string 	norm_state;
		string 	norm_zip;
		string 	norm_country;
		string	norm_addrtype;
		string  norm_addrdesc;
		string  norm_ownername;
		string  norm_ownerfirstname;
		string  norm_ownermiddlename;
		string  norm_ownerlastname;
		string  norm_ownersuffix;
		string  norm_agentname;
		string  norm_agentfname;
		string  norm_agentmname;
		string  norm_agentlname;
		string  norm_agentsuffix;		
	end;

end;