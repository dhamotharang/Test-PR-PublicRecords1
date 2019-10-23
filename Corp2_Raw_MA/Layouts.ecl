EXPORT Layouts := module

	export CorpDataExportLayoutIn 					:= record
	  string 			dataid;
	  string 			fein;
	  string 			tempfein;
	  string 			entityname;
	  string 			entitytypedescriptor;
	  string		  addr1;
	  string		  addr2;
	  string 			city;
	  string 			state;
	  string 			postalcode;
	  string 			countrycode;
	  string 			agentname;
	  string 			agentaddr1;
	  string 			agentaddr2;
	  string 			agentcity;
	  string 			agentstate;
	  string 			agentpostalcode;
	  string 			doingbusinessas;
	  string 			foreignname;
	  string 			jurisdictionstate;
	  string 			jurisdictioncountry;
	  string 			jurisdictiondate;
	  string 			dateoforganization;
	  string 			activeflag;
	  string 			inactivedate;
	  string 			inactivetype;
	  string 			revivaldate;
	  string 			lastdatecertain;
	  string 			fiscalmonth;
	  string 			fiscalday;
	  string 			mergerallowedflag;
	  string 			annualrptreqflag;
	  string 			corppublicflag;
	  string 			profitflag;
	  string 			consentflag;
	  string 			partnershipflag;
	  string 			manufacturerflag;
	  string 			residentagentflag;
	  string 			oldfein;
	  string 			oldfiscalmonth;
	  string 			oldfiscalday;
	  string250 	corp_name_comment := ''; 
	end;
	
	export CorpDataExportLayoutBase   			:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpDataExportLayoutIn;
	end;	
	
	export CorpIndividualExportLayoutIn 		:= record, maxlength(10000)
	  string			dataid;
	  string 			individualtitle;
	  string 			individualtypeflag;
	  string 			firstname;
	  string 			lastname;
	  string 			middlename;
	  string 			suffix;
	  string 			termexpiration;
	  string 			busaddr1;
	  string			buscity;
	  string			busstate;
	  string 			buscountrycode;
	  string 			buspostalcode;
	  string 			resaddr1;
	  string 			rescity;
	  string 			resstate;
	  string 			rescountrycode;
	  string 			respostalcode;
	end;	

	export CorpIndividualExportLayoutBase   := record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpIndividualExportLayoutIn;
	end;
	
	export CorpStockExportLayoutIn 					:= record, maxlength(10000)
	  string 			dataid;
	  string			stockclass;
	  string 			authorizednumber;
	  string 			parvaluepershare;
	  string 			restrictionindicator;
	  string 			totalissuedoutstanding;
	end;

	export CorpStockExportLayoutBase   			:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpStockExportLayoutIn;
	end;
	
	export CorpDetailExportLayoutIn 				:= record
	  string	 		detailid;
	  string 			dataid;
	  string 			filingcode;
	  string 			submitdate;
	  string 			approvaldate;
	  string 			effectivedate;
	  string 			fileyear;
	  string 			filingnum;
	  string 			comments;
	  string 			insertdate;
	  string			modifydate;
	end;

	export CorpDetailExportLayoutBase   		:= record
	  string1			action_flag;
	  unsigned4		dt_first_received;
	  unsigned4		dt_last_received;		
	  CorpDetailExportLayoutIn;
	end;
	
	export CorpMergerLayoutIn 							:= record
		string 			mergerid;
	  string 			dataid;
	  string 			mergeddataid;
	  string 			mergedfein;
	  string 			mergertype;
	  string 			mergerdate;
	  string 			mergerentityname;
  end;
	
	export CorpMergerLayoutBase   					:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpMergerLayoutIn;
	end;
	
	export CorpNameChangeLayoutIn 					:= record
	  string 			namechgid;
	  string 			dataid; 
	  string 			oldentityname;
	  string 			namechgdate;
	  string 			unknown;
	  string 			oldentitynamesoundex;
	end;
	
	export CorpNameChangeLayoutBase					:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpNameChangeLayoutIn;
	end;
	
	export Temp_CorpDataExportMerger				:= record
		CorpDataExportLayoutIn;	
		CorpMergerLayoutIn - dataid;
		string 			mergerindicator;
		string 			mergerfein;
		string			inactivedesc;
		string			statusdate;
		string 			statusdesc;
	end;
	
	export Temp_CorpDataNameChange					:= record
		CorpDataExportLayoutIn;	
		CorpNameChangeLayoutIn - dataid;
	end;
	
	export Temp_NormalizedIndividualExport	:= record
		CorpIndividualExportLayoutIn;
	  string		  c_address1;
	  string 			c_city;
	  string 			c_state;
	  string 			c_zip;
	  string 			c_country;
	  string 			c_addrtype;
	  string 			c_addrdesc;			
	end;
	
	export Temp_CorpDataIndividualExport		:= record
		CorpDataExportLayoutIn;
		Temp_NormalizedIndividualExport - dataid;
	end;

	export Temp_CorpDataDetailExport				:= record
		CorpDataExportLayoutIn;
		CorpDetailExportLayoutIn - dataid;
	end;

	export Temp_CorpDataStockExport					:= record
		CorpDataExportLayoutIn;	
		CorpStockExportLayoutIn - dataid;
	end;

end;