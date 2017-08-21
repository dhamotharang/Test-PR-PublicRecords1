export Layouts := module

	export CorporationLayoutIn 		:= Record

		string 	corpid;
		string 	entityid ;    
		string 	corp_typeid;                  
		string 	corp_status;                
		string 	corp_num;                   
		string 	citizenship;           
		string 	date_formed;           
		string 	dissolve_date;         
		string 	duration;              
		string 	county_of_inc;         
		string 	state_of_inc;          
		string 	country_of_inc;        
		string 	purpose;               
		string 	profession;            
		string 	agent_name;

	end;

	export CorporationLayoutBase		:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		CorporationLayoutIn;

	end;

	export AddressLayoutIn 				:= Record

		string 	addr_id;  
		string 	corpid;                
		string 	addr_type_id;                  
		string 	addr_line_1;              
		string 	addr_line_2;              
		string 	addr_line_3;              
		string 	addr_city;                
		string 	addr_state;               
		string 	addr_zip;                 
		string 	addr_county;              
		string 	addr_country;	

	end;

	export AddressLayoutBase					:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		AddressLayoutIn;

	end;	

	export FilingLayoutIn 						:= Record

		string 	filingid; 
		string 	corpid ;                 
		string 	documentid;                
		string 	documenttypeid;              
		string 	filing_date;           
		string 	effective_date;

	end;

	export FilingLayoutBase						:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		FilingLayoutIn;

	end;

	export MergerLayoutIn 						:= Record

		string 	merg_id;
		string 	survivorcorpid;
		string 	mergedcorpid;               
		string 	merg_date;

	end;

	export MergerLayoutBase						:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		MergerLayoutIn;

	end;

	export NamesLayoutIn 							:= Record

		string 	name_id;    
		string 	corpid;                
		string 	name;                  
		string 	name_type;                  
		string 	name_title;                 
		string 	name_salutation;            
		string 	name_prefix;                
		string 	name_last_name;             
		string 	name_middle_name;           
		string 	name_first_name;            
		string 	name_suffix;

	end;

	export NamesLayoutBase							:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		NamesLayoutIn;

	end;
	
	export OfficerLayoutIn 						:= Record

		string 	officerpartyid; 				
		string 	corpid; 			
		string 	title;
		string 	salutation;
		string 	contname;
		string 	address1;
		string 	address2;
		string 	address3;
		string 	city;
		string 	state;
		string 	zip; 
		string 	countryname;
		string 	ownerprecentage;
		string 	transferrealestate;
		string 	foreignaddress;

	end;

	export OfficerLayoutBase					:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		OfficerLayoutIn;

	end;

	export StockLayoutIn 							:= Record

		string 	stockid; 				
		string 	corpid;
		string 	stockclassid;
		string 	authorizedshares;
		string 	issuedshares;
		string 	series;
		string 	npvflag;
		string 	parvalue;

	end;

	export StockLayoutBase						:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		StockLayoutIn;

	end;
	
	export DocTypeTable 			:= Record

		string 	typeCode;
		string 	typeDesc;

	end;

	export OfficerTypeTable 	:= Record 

		string 	officerpartytype_id; 
		string 	officerid;
		string 	partytypeid;

	end;
		
	//Temporary layouts
	export TempCorpName	:= Record

		CorporationLayoutIn;
		NamesLayoutIn;

	end;

	export TempCorpNameAddr	:= Record

		TempCorpName;
		AddressLayoutIn;

	end;

	export TempCorpSurvivor	:= Record
	
		tempcorpnameaddr;
		string 	temp_survivor_name;
		string 	temp_survivor_id;
		string 	mergedcorpid;               
		string 	merg_date;		
	end;
	
	export TempCorpMerger	:= Record
	
		TempCorpSurvivor-temp_survivor_name-temp_survivor_id;
		string 	survivorcorpid;		
		string 	survivor_name;
		string 	merged_name;
		string1 merger_indicator;
		
	end;

	export TempCorpFiling:= Record

		CorporationLayoutIn;
		FilingLayoutIn;

	end;

	export TempCorpFiling_Merger:= Record

		TempCorpFiling;            
		string 	merg_date;
		string 	Merged_name;
		string 	survivor_name;

	end;
	
	export Temp_corporationStock   := record

		corporationlayoutin.corpid;
		corporationlayoutin.entityid;
		corporationlayoutin.corp_num;
		StockLayoutIn;

	end;
	
	export Temp_DocTypeTable 			:= Record

		DocTypeTable;
		integer len;

	end;

end;