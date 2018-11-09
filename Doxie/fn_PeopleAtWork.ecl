IMPORT doxie,iesp,doxie_crs,PAW_Services,AutoStandardI;

EXPORT fn_PeopleAtWork(DATASET(doxie.Layout_Rollup.KeyRec) inKeyRecs) := FUNCTION

  // Bug: 45732 - Original Doxie.paw code code PAW_V1
	// Keeping both child datasets in the output so that the esp and 
	// applicaiton layers can update their code without breaking the app
	raw_paw := doxie_crs.Layout_employment;
	paw_out := iesp.peopleatwork.t_PeopleAtWorkRecord;
	
	INTEGER SetConfidence (STRING3 score) := 
	   FUNCTION
		    int_score := (INTEGER) score;
				RETURN MAP(int_score <= 10  => 3,
				           int_score <= 100 => 2,
									 /* default */       1);
		 END; // SetConfidence function

   paw_out iespPAW (raw_paw L) :=
	    TRANSFORM	
			   SELF.ConfidenceLevel := (STRING) SetConfidence (L.Score);
				 SELF.Verified        := L.verified;
				 SELF.Name            := iesp.ECL2ESP.SetNameFields (L.fname, 
				                         L.mname, L.Lname,'',L.name_suffix,L.title);
				 SELF.UniqueId        := INTFORMAT((INTEGER)L.did,12,1);
    		 SELF.Title           := L.company_title;
    		 SELF.SSN             := L.ssn;
    		 SELF.EMail           := L.email_address;
    		 SELF.Phone10         := L.company_phone; 
    		 SELF.Gender          := '';
    		 SELF.TimeZone        := L.timezone;
    		 SELF.CompanyTimeZone := L.company_timezone;   
    		 SELF.CompanyName     := L.company_name;
    		 SELF.Department      := l.company_department;
    		 SELF.FEIN            := L.company_fein;
    		 SELF.BusinessId      := L.bdid;
    		 SELF.Address         := iesp.ECL2ESP.setAddressFields
				                         (L.company_prim_name,
																  L.company_prim_range,
																  L.company_predir,
																  L.company_postdir,
																  L.company_addr_suffix,
																  L.company_unit_desig,
																  L.company_sec_range,'',
																  L.company_city,'',
																  L.company_state,L.company_zip,'','',
																  L.company_zip);
    		 SELF.DateFirstSeen := iesp.ECL2ESP.toDatestring8 (L.dt_first_seen);
    		 SELF.DateLastSeen  := iesp.ECL2ESP.toDatestring8 (L.dt_last_seen);
				 self := []; //BusinessIds
      END; // iespPAW transform

   doxie.Layout_Rollup.KeyRec pawTrans(doxie.Layout_Rollup.KeyRec L, doxie_crs.Layout_employment R) := 
	    TRANSFORM
	       SELF.paw := CHOOSEN(L.paw + PROJECT(R,iespPAW(LEFT)), iesp.Constants.BR.MaxPeopleAtWork);  //limit per DID
	       SELF := L;
      END; // pawTrans transform
   
   //add iesp (PAW V1) version of paw records 
   setofdids := dedup (project (inKeyRecs, transform (doxie.layout_references, Self.did := (unsigned6) Left.did)), did, all);
   // this is to replace doxie\Get_Dids call, which won't return any candidates for, say, search by DL number.

   outKeyRecsV1 := DENORMALIZE (inKeyRecs,doxie.employment_records (setofdids),LEFT.did=RIGHT.did,pawTrans(LEFT,RIGHT));   

// END PAW - V1 /// Starting PAW - V2	
// Bug: 45732 Request to have the PAW section of the doxie.HeaderFileRollupService
//      Match the output/rollup from the PAW service.  PAW_v2 changes the doxie.HFRS
//      to call the PAW service so that the output/rollup is identical.  
//      The doxie code is used to get the IDs which are passed to the PAW which 
//      gets the records and rolls up the child dataset
			
   setofcids := PAW_Services.PAW_Raw.getContactIDs.byDIDs(setofdids);

   tempmod := MODULE(PROJECT(AutoStandardI.GlobalModule(),PAW_Services.PAWSearchService_Records.params,opt))
	   EXPORT UNSIGNED2 REQ_PHONES_PER_ADDR := PAW_Services.Constants.MAX_PHONES_PER_ADDR : STORED('ReqPhonesPerAddr');
	   EXPORT UNSIGNED2 REQ_DATES_PER_POSITION := PAW_Services.Constants.MAX_DATES_PER_POSITION : STORED('ReqDatesPerPosition');
	   EXPORT UNSIGNED2 REQ_DATES_PER_EMPLOYER := PAW_Services.Constants.MAX_DATES_PER_EMPLOYER : STORED('ReqDatesPerEmployer');
	   EXPORT UNSIGNED2 REQ_FEINS_PER_EMPLOYER := PAW_Services.Constants.MAX_FEINS_PER_EMPLOYER : STORED('ReqFeinsPerEmployer');
	   EXPORT UNSIGNED2 REQ_COMPANY_NAMES_PER_EMPLOYER := PAW_Services.Constants.MAX_COMPANY_NAMES_PER_EMPLOYER : STORED('ReqCompanyNamesPerEmployer');
	   EXPORT UNSIGNED2 REQ_ADDRS_PER_EMPLOYER := PAW_Services.Constants.MAX_ADDRS_PER_EMPLOYER : STORED('ReqAddrsPerEmployer');
	   EXPORT UNSIGNED2 REQ_POSITIONS_PER_EMPLOYER := PAW_Services.Constants.MAX_POSITIONS_PER_EMPLOYER : STORED('ReqPositionsPerEmployer');
	   EXPORT UNSIGNED2 REQ_SSNS_PER_PERSON := PAW_Services.Constants.MAX_SSNS_PER_PERSON : STORED('ReqSsnsPerPerson');
	   EXPORT UNSIGNED2 REQ_NAMES_PER_PERSON := PAW_Services.Constants.MAX_NAMES_PER_PERSON : STORED('ReqNamesPerPerson');
	   EXPORT UNSIGNED2 REQ_EMPLOYERS_PER_PERSON := PAW_Services.Constants.MAX_EMPLOYERS_PER_PERSON : STORED('ReqEmployersPerPerson');
	   EXPORT PenaltThreshold := 10 : STORED('PenaltThreshold');
	   EXPORT BOOLEAN IncludeCriminalIndicators := FALSE : STORED('IncludeCriminalIndicators');
   END;

   searchservice_records := PAW_Services.PAWSearchService_Records.val(setofcids,tempmod);

   doxie.Layout_Rollup.KeyRec pawTrans_V2(doxie.Layout_Rollup.KeyRec L, paw_services.PAW_OutRecsLayout R) := 
     TRANSFORM
	     SELF.paw_V2 := R;
	     SELF := L;
     END;
	
   //add paw_V2 version of records
   outKeyRecs := JOIN(outKeyRecsV1,searchservice_records,
                     (UNSIGNED6)LEFT.did=RIGHT.did,
                      pawTrans_V2(LEFT,RIGHT), Left outer);

	 RETURN outKeyRecs;

END;

