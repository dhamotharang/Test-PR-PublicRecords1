#workunit('name','2x42 Process');

layout:= record
	string	AccountNumber	;
	string	CompanyName	;
	string	AlternateCompanyName	;
	string	addr	;
	string	city	;
	string	state	;
	string	zip	;
	string	BusinessPhone	;
	string	TaxIdNumber	;
	string	BusinessIPAddress ;
	string	RepresentativeFirstName	;
	string	RepresentativeMiddleName ;
	string	RepresentativeLastName	;
	string	RepresentativeNameSuffix  ;
	string	RepresentativeAddr	;
	string	RepresentativeCity	;
	string	RepresentativeState	;
	string	RepresentativeZip	;
	string	RepresentativeSSN	;
	string	RepresentativeDOB	;
	string  RepresentativeAge   ;
	string	RepresentativeDLNumber	;
	string	RepresentativeDLState	;
	string	RepresentativeHomePhone	;
	string	RepresentativeEmailAddress	;
	string  RepresentativeFormerLastName ;
	integer	HistoryDateYYYYMM;
end;

// f := dataset('~tfuerstenberg::in::chase_2530_bus_rep1_file1_in', Layout, csv(QUOTE('"')));
f := choosen(dataset('~tfuerstenberg::in::chase_2530_bus_rep1_file1_in', Layout, csv(QUOTE('"'))),5);
output(f);

roxieIP :='http://roxiethorvip.hpcc.risk.regn.net:9856';  // roxiebatch

Layout_BIID_Soapcall := record
	string	AccountNumber;
	string	BDID;
	string	CompanyName;
	string	AlternateCompanyName;
	string	Addr;
	string	City;
	string	State;
	string	Zip;
	string	BusinessPhone;
	string	TaxIdNumber;
	string	BusinessIPAddress;
	string	RepresentativeFirstName;
	string	RepresentativeMiddleName;
	string	RepresentativeLastName;
	string	RepresentativeNameSuffix;
	string	RepresentativeAddr;
	string	RepresentativeCity;
	string	RepresentativeState;
	string	RepresentativeZip;
	string	RepresentativeSSN;
	string	RepresentativeDOB;
	string	RepresentativeAge;
	string	RepresentativeDLNumber;
	string	RepresentativeDLState;
	string	RepresentativeHomePhone;
	string	RepresentativeEmailAddress;
	string 	RepresentativeFormerLastName;
	integer	HistoryDateYYYYMM;
	unsigned1	DPPAPurpose;
	unsigned1	GLBPurpose;
	string tribcode;
	string DataRestrictionMask;
end;

Layout_BIID_Soapcall into_bus_input(f le) := transform
	self.bdid := '';
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.tribcode := '2x42';
	self.datarestrictionmask := '000001000100';  // restricts experian and transunion from use
	self := le;
end;

indata := project(f,into_bus_input(LEFT));
output(indata, named('biid_in'));

errx := record
	string errorcode := '';
	business_risk.Layout_Final_Denorm - score - RepSSNValid;  // requested to take the score field out of the layout during testprocessing because batch customers don't see it
	DATASET(Models.Layout_Model) models;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.company_name := L.companyname;
	self.addr1 := L.addr;
	self.p_city_name := L.city;
	self.st := L.state;
	self.z5 := L.zip;
	self.phone10 := L.businessphone;
	self := L;
	self := [];
end;

results := soapcall(indata, roxieIP,
				'Business_Risk.InstantID_Service', {indata},
				dataset(errx),  
				RETRY(2), TIMEOUT(500),
				literal,
				XPATH('Business_Risk.InstantID_ServiceResponse/Results/Result/Dataset[@name=\'Result 1\']/Row'),
				PARALLEL(30), onFail(err_out(LEFT)));	

layout_2x42 := record
  string12 		bdid := '';
	string30	 	account;
	
	// verification fields
	STRING120 	vercmpy 			:= '';
	STRING50 		veraddr 			:= '';
	STRING30 		vercity 			:= '';
	STRING2 		verstate 			:= '';
	STRING9 		verzip 			:= '';  // add verzip4
	STRING10 		verphone 			:= '';
	STRING9 		verfein 			:= '';
	
	// BNAP (score 0-8) -- Name/Addr/Phone score
	string1		BNAP_Indicator		:= '';
	// BNAT (score 0-8) -- Name/Addr/Fein score
	string1		BNAT_Indicator 	:= '';
	// BNAS (score 0-3) -- Name/Addr/SSN score
	string1		BNAS_Indicator 	:= '';
	// BVI (score 0-50) -- Business Verification Index
	string2		BVI				:= '';

	string4	PRI_1;
	string4	PRI_2;
	string4	PRI_3;
	string4	PRI_4;
	string4	PRI_5;
	string4	PRI_6;
	string4	PRI_7;
	string4	PRI_8;

	// just 3 digit score and 4 reason codes
	string3 fd_score1;
	string4	fd_Reason1;
	string4	fd_Reason2;
	string4	fd_Reason3;
	string4	fd_Reason4;
	
	//Best Info
	string120		bestCompanyName	:= '';
	string50		bestAddr			:= '';
	string30		bestCity			:= '';
	string2		bestState			:= '';
	string9		bestZip			:= '';  // add bestzip4 to the end of this field
	string9		bestFEIN			:= '';
	string10		bestPhone			:= '';
	
	// AR2BI (score 00 - 50) -- Authd Rep Rel to Bus Indicator
	string2		AR2BI			:= '';

	string20		RepFNameVerify		:= '';
	string20		RepLNameVerify		:= '';
	string50		RepAddrVerify		:= '';
	string25		RepCityVerify		:= '';
	string2		RepStateVerify		:= '';
	string9		RepZipVerify		:= '';  // add zip4
	// string4		RepZip4Verify		:= '';
	string10		RepPhoneVerify		:= '';
	string9		RepSSNVerify		:= '';
	string8		RepDOBVerify		:= ''; 
	string2		RepNAS_Score		:= ''; // Name_Addr_SSN
	string2		RepNAP_Score		:= ''; // Name_Addr_Phone
	string2		RepCVI			:= ''; // comp. verification index	
	
	string4	Rep_PRI_1;
	string4	Rep_PRI_2;
	string4	Rep_PRI_3;
	string4	Rep_PRI_4;
	string4	Rep_PRI_5;
	string4	Rep_PRI_6;

	// filler fields	
	string3 future1;
	string2 future2;
	string2 future3;
	string2 future4;
	string2 future5;	
	
	// Rep Best Info
	string20		RepBestFname		:= '';
	string20		RepBestLname		:= '';
	string50		RepBestAddr1		:= '';
	string30		RepBestCity		:= '';
	string2		RepBestState		:= '';
	string9		RepBestZip		:= '';  // add zip4 to this field
	// string4		RepBestZip4		:= '';
	string8		RepBestDOB		:= '';
	string9		RepBestSSN		:= '';
	string10		RepBestPhone		:= '';
	
	string200 errorcode := '';
end;


layout_2x42 final_tf(results L) := transform
	self.fd_score1 := (string)(integer)L.Models[1].scores[1].i;
	self.fd_Reason1 := L.Models[1].scores[1].reason_codes[1].reason_code;
	self.fd_Reason2 := L.Models[1].scores[1].reason_codes[2].reason_code;
	self.fd_Reason3 := L.Models[1].scores[1].reason_codes[3].reason_code;
	self.fd_Reason4 := L.Models[1].scores[1].reason_codes[4].reason_code;
	
	self.verzip := l.verzip; // + l.verzip4;
	self.bestzip := l.bestzip + l.bestzip4;
	self.RepZipVerify := l.RepZipVerify + l.RepZip4Verify;
	self.RepBestZip := l.RepBestZip + l.RepBestZip4;
	// filler fields
	self.future1 := '';
	self.future2 := '';
	self.future3 := '';
	self.future4 := '';
	self.future5 := '';
	self :=L;
	
end;

j_f := project(results,final_tf(LEFT));
output(j_f,named('output'));
output(j_f,,'~tfuerstenberg::out::greendot_2780_ciid_fp_rf_out',CSV(heading(single), quote('"')), overwrite);
