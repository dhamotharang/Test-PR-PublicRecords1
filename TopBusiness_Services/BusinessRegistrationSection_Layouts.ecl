import iesp;

EXPORT BusinessRegistrationSection_Layouts := module

export rec_input := record
		string25 acctno;
	  iesp.share.t_BusinessIdentity;
end;	

export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
	end;	
	
export rec_business_registration_recordWLinkids := record

   iesp.share.t_businessIdentity;
	 iesp.topbusinessREport.t_TopBusinessBusinessRegistrationRecord;
	 
	 // iesp.share.t_date  recordDate;
	
	// STRING50 COMPANYNAME;
	
	 // STRING59 DESCRIPT;
	
	 // STRING2  CORPCODE;
	 // STRING4  SOS_CODE;
	 // STRING4  FILING_COD;
	 // STRING2  STATE_CODE;
	 // STRING2  STATUS;
	// STRING20 FilingNum;
	 // STRING12 FileDATE;
	// STRING8  ExpDATE;
	// STRING8  ProcDATE;
	// iesp.share.t_address address;
	
	// STRING10 companyPhone10;
	
	// string50 corpcodeDecode;
	// string50 sosCodeDecode;
	// string10 filingCodDecode;
	// string15 statusDecode;
	// string8 fileDateDecode;
	// string8 procDateDecode
end;	

export rec_linkids_plus_BusRegRecord := record
	string30 acctno;
  iesp.share.t_businessIdentity;
   iesp.TopbusinessReport.t_TopBusinessBusinessRegistrationSection;
end;

export rec_final := record
 string25 acctno;
   iesp.topbusinessREport.t_TopBusinessBusinessRegistrationSection;
end;
end; // module