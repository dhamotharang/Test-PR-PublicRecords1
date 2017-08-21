EXPORT Layouts := module

	export CorporationLayoutIn 							:= Record
			string 		corporationid;
			string 		entityid;
			string 		corporationtypeid;
			string 		corporationstatusid;
			string 		corporationnumber;
			string 		citizenship;
			string 		dateformed;
			string 		dissolvedate;
			string 		duration;
			string 		countyofincorporation;
			string 		stateofincorporation;
			string 		countryofincorporation;
			string 		purpose;
			string 		profession;
			string 		registeredagentname;
			string 		lf;
	end;
	
	export CorporationLayoutBase 						:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			CorporationLayoutIn;
	end; 

	export AddressLayoutIn 									:= Record
			string 		addressid;
			string 		corporationid;
			string 		addresstypeid;
			string 		address1;
			string 		address2;
			string 		address3;
			string 		city;
			string 		state;
			string 		zip;
			string 		county;
			string 		country;
			string 		lf;
	end;
		
	export AddressLayoutBase 								:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			AddressLayoutIn;
	end;

	export FilingLayoutIn 									:= Record
			string 		filingid;
			string 		corporationid;
			string 		documentid;
			string 		documenttypeid;
			string 		filingdate;
			string 		effectivedate;
			string 		lf;
	end;
		
	export FilingLayoutBase 								:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			FilingLayoutIn;
	end;

	export MergerLayoutIn 									:= Record
			string 		mergerid;
			string 		survivorcorporationid;
			string 		mergedcorporationid;
			string 		mergerdate;
			string 		lf;
		END;

	export MergerLayoutBase 								:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			MergerLayoutIn;
	end;
	
	export CorporationNameLayoutIn 					:= Record
			string 		mergerid;
			string 		corporationid;
			string 		corpname;
			string 		nametypeid;
			string 		title;
			string 		salutation;
			string 		prefix;
			string 		lastname;
			string 		middlename;
			string 		firstname;
			string 		suffix;
			string 		lf;
	end;
		
	export CorporationNameLayoutBase 				:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			CorporationNameLayoutIn;
	end;

	export OfficerLayoutIn 									:= Record
			string 		officerid;
			string 		corporationid;
			string 		officertitle;
			string 		salutation;
			string 		name;
			string 		address1;
			string 		address2;
			string 		address3;
			string 		city;
			string 		state;
			string 		zip;
			string 		countryname;
			string 		ownerpercentage;
			string 		transferrealestate;
			string 		foreignaddress;
			string 		lf;
	end;

	export OfficerLayoutBase 								:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			OfficerLayoutIn;
	end;
	
	export StockLayoutIn 										:= Record
			string 		stockid;
			string 		corporationid;
			string 		stockclassid;
			string 		authorizedshares;
			string 		issuedshares;
			string 		series;
			string 		npvflag;
			string 		parvalue;
			string 		lf;
	end;
	
	export StockLayoutBase 									:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			StockLayoutIn;
	end;
	
	//Lookup Tables	
	export TableLayoutIn										:= Record
			string 		tablecode;
			string 		tabledesc;
	end;
	
	export OffPartyTypeTableLayoutIn				:= Record
			string 		offpartytypeid;
			string 		offid;
			string 		partytypeid;
	end;
	
	//Temporary Layouts
	export TempCorporationLayoutIn					:= Record
		CorporationLayoutIn;
		AddressLayoutIn 				- [corporationid, lf];
		CorporationNameLayoutIn - [corporationid, lf];
		string 		corptypecode;
		string		corptypedesc;
		string 		nametypecode;
		string		nametypedesc;
		string 		statuscode;
		string		statusdesc;
		string 		survivor_mergerid;
		string 		survivor_survivorcorporationid;
		string 		survivor_mergedcorporationid;
		string 		survivor_mergerdate;
		string 		nonsurvivor_mergerid;
		string 		nonsurvivor_survivorcorporationid;
		string 		nonsurvivor_mergedcorporationid;
		string 		nonsurvivor_mergerdate;
	end;

	export TempFilingWithCorpLayoutIn				:= Record
		CorporationLayoutIn;	
		FilingLayoutIn					- [corporationid, lf];
		string 		docidcode;
		string		dociddesc;			
	end;

	export TempStockWithCorpLayoutIn				:= Record
		CorporationLayoutIn;
		StockLayoutIn 					- [corporationid, lf];
		string 		stockclasscode;
		string		stockclassdesc;			
	end;

	export TempContactsLayoutIn							:= Record
		CorporationLayoutIn;
		CorporationNameLayoutIn	- [corporationid, lf];
		OfficerLayoutIn					- [corporationid, lf];
		OffPartyTypeTableLayoutIn;
		string 		partytypecode;
		string 		partytypedesc;		
	end;

end;