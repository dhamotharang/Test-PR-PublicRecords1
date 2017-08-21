	
export Layouts := module

  shared max_size := _Dataset().max_record_size;

	export CompanyMasterLayoutIn				:= record, 		maxlength(4500)
		string7   	filenumber;													//Note: filenumber and filesuffix make up the primary key
		string2   	filesuffix;
		string15  	status;
		string40  	companytype;
		string250 	consentname;
		string60  	similarname;
		string11  	expirationdate;
		string185 	mastername;
		string60  	xrefname1;
		string60  	xrefname2;
		string1100 	purpose;
		string11 		votedate;
		string11 		incorporationdate;
		string7  		term;
		string15 		limit1;
		string15 		limit2;
		string11 		limitdate;
		string10 		vote;
		string40 		locality;
		string25 		country;
		string11 		organizationdate;
		string11 		commencedate;
		string160 	partnerterms;
		string180 	registrant;
		string11  	renewaldate;
		string3   	partnermaintenance;
		string3  		initialllcmembers;	
		string70 		mailaddressline1;
		string70 		mailaddressline2;
		string70 		mailaddressline3;
		string35 		mailcity;
		string40 		maillocality;
		string15 		mailpostalcode;
		string25 		mailcountry;
		string70 		principaladdressline1;
		string70 		principaladdressline2;
		string70 		principaladdressline3;
		string35 		principalcity;
		string40 		principallocality;
		string15 		principalpostalcode;
		string25 		principalcountry;
		string185 	agentpersonname;
		string70  	agentaddressline1;
		string70  	agentaddressline2;
		string70  	agentaddressline3;
		string35  	agentcity;
		string40  	agentlocality;
		string15  	agentpostalcode;
		string25  	agentcountry;
		string4   	annualfilingyear1;
		string15  	annualfilingstatus1;
		string4   	annualfilingyear2;
		string15  	annualfilingstatus2;
		string4   	annualfilingyear3;
		string15  	annualfilingstatus3;
		string4   	licensefilingyear1;
		string36  	licensefilingstatus1;
		string4   	licensefilingyear2;
		string36  	licensefilingstatus2;
		string4   	licensefilingyear3;
		string36  	licensefilingstatus3;
	end;

	export CompanyMasterLayoutBase			:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		CompanyMasterLayoutIn;
	end;

	export CompanyOfficerLayoutIn 			:= record, 		maxlength(1000)
		string7 		filenumber;													//Note: filenumber and filesuffix make up the primary key
		string2 		filesuffix;
		string7 		personid;
		string11 		startdate;
		string7 		officertype;
		string192 	personname;
		string20 		title;
	end;

	export CompanyOfficerLayoutBase			:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		CompanyOfficerLayoutIn;
	end;

	export CompanyStockLayoutIn 				:= record, 		maxlength(100)
		string7  		filenumber;													//Note: filenumber and filesuffix make up the primary key
		string2  		filesuffix;
		string6  		stockid;
		string11 		stockdate;
		string20 		stockclass;
		string15 		sharescount;
		string12 		paidshares;
		string9  		parvalue;
		string12 		stockamount;
	end;

	export CompanyStockLayoutBase				:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		CompanyStockLayoutIn;
	end;

	export CompanyTransactionLayoutIn 	:= record,		maxlength(210)
		string7   	filenumber;													//Note: filenumber and filesuffix make up the primary key
		string2   	filesuffix;
		string8   	transid;
		string121  	transdesc;
		string11  	effectivedate;
		string121 	remarks;
	end;
	
	export CompanyTransactionLayoutBase	:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		CompanyTransactionLayoutIn;
	end;
	
	export TTSMasterLayoutIn 						:= record, 		maxlength(3500)
		string7 		filenumber;													//Note: filenumber and filesuffix make up the primary key
		string2 		filesuffix;
		string7 		certificatenumber;
		string12 		ttstradetype;
		string40 		ttscompanytype;
		string520 	ttstradename;
		string9 		ttsstatus;
		string1300 	ttspurpose;
		string11 		ttsregistrationdate;
		string11 		ttsexpirationdate;
		string11 		ttscertificationdate;
		string115 	ttsxrefname1;
		string115 	ttsxrefname2;
		string250 	ttsconsentname;
		string80 		ttssimilarname;
		string70 		ttsmailaddressline1;
		string70 		ttsmailaddressline2;
		string70 		ttsmailaddressline3;
		string35 		ttsmailcity;
		string40 		ttsmaillocality;
		string15 		ttsmailpostalcode;
		string25 		ttsmailcountry;
		string200 	ttsregistrant;
	 end;

	export TTSMasterLayoutBase					:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		TtsMasterLayoutIn;
	end;
	
	export TTSTransactionLayoutIn 			:= record, 		maxlength(240)
		string7 		filenumber;													//Note: filenumber and filesuffix make up the primary key
		string2 		filesuffix;
		string7 		certificatenumber;
		string8 		ttstransid;
		string147  	ttstransdesc;
		string11  	ttstranseffectivedate;
		string147 	ttstransremarks;
	end;

	export TTSTransactionLayoutBase			:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		TtsTransactionLayoutIn;
	end;

	//Temporary layouts
	export TempMasterRawFixedLayoutIn		:= record
		string4500	payload;
	end;

	export TempCompanyMasterLayoutIn	 	:= record
		CompanyMasterLayoutIn;
		string350 	temp_legal_name;
		string11 		temp_term_date;
		string2  		temp_term_desc;
	end;

	export TempMasterOfficerLayoutIn	 	:= record
		TempCompanyMasterLayoutIn;
		CompanyOfficerLayoutIn;
	end;

	export TempTTSMasterLayoutIn	 		 	:= record
		TTSMasterLayoutIn;
		string350		temp_legal_name;
		string8	 		temp_filing_date;
		string60  	temp_filing_desc;
		string2  		temp_name_type_cd;
		string30		temp_name_type_desc;
	end;
	
end;