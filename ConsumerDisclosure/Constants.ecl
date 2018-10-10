IMPORT AutoKeyI;

EXPORT Constants :=
MODULE

	// below limits are defined here due to requirement of this FCRA service to return ALL payload records for subject
  EXPORT Limits :=
  MODULE
		EXPORT UNSIGNED2 MaxATFPerDID 		 	 := 200; // atf_services.constants.MAX_RECS_PER_ATF_ID  -- as of 11/10/2017 maxcnt=43
		EXPORT UNSIGNED2 MaxAircraftsPerDID  := 1000; // ut.limits.AIRCRAFTS_PER_DID   -- as of 11/10/2017 maxcnt=975
		EXPORT UNSIGNED2 MaxAirmenPerDID 		 := 200; // ut.limits.AIRMAN_PER_DID       -- as of 11/10/2017 maxcnt=66
		EXPORT UNSIGNED2 MaxAirmanCertificates := 100; // ut.limits.AIRMAN_CERTIFICATES_MAX  -- as of 11/10/2017 maxcnt=32
    EXPORT UNSIGNED2 MaxAdvoPerAddress   := 1000; // -- as of 11/9/2017 maxcnt=1919, drops below 1K except 109 rec
    EXPORT UNSIGNED2 MaxAVMPerAddress    := 100; // -- as of 11/9/2017 maxcnt=9
    EXPORT UNSIGNED2 MaxBKParties        := 200;  // -- as of 11/9/2017 maxcnt=411 (single rec), followed by cnt=192
    EXPORT UNSIGNED1 MaxBankruptcyPerDID := 10000; // -- maxcnt=60334 as of 11/9/2017,  drops below 10K after 282 recs
    EXPORT UNSIGNED2 MaxCCWPerDID     	 := 50;   // ut.limits.CCW_PER_DID
    EXPORT UNSIGNED2 MaxCrimOffendersPerDID := 10000;  // -- maxcnt=689440 as of 11/9/2017, drops below 10K except 173 recs => maxcnt=2183 unique ofender_key per Lexid (= 2240099868)
    EXPORT UNSIGNED2 MaxCrimOffendersPerOFK := 4000;   // -- maxcnt=3925 as of 11/9/2017,  with 461 recs above 1K
    EXPORT UNSIGNED2 MaxCrimOffenses     := 750;   // -- maxcnt=704 as of 11/9/2017, 4 recs have above 500 offenses 
    EXPORT UNSIGNED2 MaxCrimPunishments  := 150;   // -- as of 11/9/2017 maxcnt=104
    EXPORT UNSIGNED2 MaxCrimCourtOffenses := 900;   // -- as of 11/9/2017 maxcnt=850
    EXPORT UNSIGNED2 MaxDeathPerDID 		 := 100;  // -- as of 11/9/2017 maxcnt=14
		EXPORT UNSIGNED2 MaxEmailPerDID      := 1000;   // -- maxcnt=5490 as of 11/10/2017, drops below 1K after 44 recs
    EXPORT UNSIGNED2 MaxGongPerDID 		 	 := 1000;   // -- maxcnt=7033 as of 11/10/2017, drops below 1K after 37 recs
    EXPORT UNSIGNED2 MaxHeaderPerDID     := 1000;  // ut.limits.HEADER_PER_DID
    EXPORT UNSIGNED2 MaxHuntersPerDID    := 700;  // ut.limits.HUNTERS_PER_DID --maxcnt=652 as of 11/10/2017, 4 recs above 350
		EXPORT UNSIGNED2 MaxInfutorPerDID    := 1000; // -- maxcnt=60369 as of 11/10/2017, drops below 1K after 5 recs
		EXPORT UNSIGNED2 MaxInquiriesPerDID  := 5000; // -- as of 11/9/2017 maxcnt=325049, drops below 10K except 7 recs, below 5K except 20 recs
    EXPORT UNSIGNED1 MaxLiensPerDID      := 1000; // -- as of 11/14/2017 maxcnt=3001, drops below 1K except 4 recs
    EXPORT UNSIGNED2 MaxLiens            := 1500; // -- as of 11/14/2017 maxcnt=1270 for parties, 
    EXPORT UNSIGNED2 MaxMDPerDID         := 150;  //ut.limits.MARRIAGEDIVORCE_PER_DID=100  -- maxcnt=116 as of 11/14/2017
    EXPORT UNSIGNED2 MaxMDParties        := 4;    //ut.limits.MARRIAGEDIVORCE_PARTY_PER_RECORD  -- maxcnt=3 as of 11/14/2017
    EXPORT UNSIGNED2 MaxOverrides        := 100;
    EXPORT UNSIGNED2 MaxOptOutPerDID     := 100; //-- maxcnt=31 as of 11/14/2017
    EXPORT UNSIGNED2 MaxPAWPerDID        := 5000;  // -- maxcnt=18867 as of 11/14/2017, drops below 10K except 7 recs, below 5K except 19 recs
    EXPORT UNSIGNED2 MaxProfLicensePerDID:= 2000; // -- maxcnt=1862 as of 11/14/2017, drop below 1K except 18 recs
    EXPORT UNSIGNED2 MaxPropPerDID       := 10000;  // -- maxcnt=106156 as of 11/14/2017, 99 LexIds have above 10K ffids, with 7 lexids above 40K ffids
    EXPORT UNSIGNED2 MaxPropPerAddress   := 1000;
    EXPORT UNSIGNED2 MaxPropPerFID       := 100;  //-- maxcnt=1 as of 11/14/2017
    EXPORT UNSIGNED2 MaxPropPartiesPerFID := 700; //-- maxcnt=605 as of 11/15/2017
		EXPORT UNSIGNED2 MaxStudentPerDID    := 100; //-- maxcnt=55 as of 11/14/2017
		EXPORT UNSIGNED2 MaxSOffenderPerDID  := 100; //SexOffender_Services.Constants.MAX_RECS_PERDID -- maxcnt=7 as of 11/14/2017
		EXPORT UNSIGNED2 MaxSOPerSSPK        := 200; //-- maxcnt=99 as of 11/14/2017
		EXPORT UNSIGNED2 MaxSSN			         := 100; // -- maxcnt=5 as of 11/14/2017
    EXPORT UNSIGNED2 MaxThrivePerDID     := 250; // -- maxcnt=195 as of 11/10/2017,
    EXPORT UNSIGNED2 MaxUCCPerDID        := 10000; // -- maxcnt=35849 as of 11/14/2017, drops below !0K except 8 recs,below 2K after 88 recs, below 1K after 188 recs
    EXPORT UNSIGNED2 MaxUCCPerTmsid      := 2500; // -- maxcnt=608429 as of 11/14/2017, drops below 2500 except 2 recs
    EXPORT UNSIGNED2 MaxWatercraftPerDID := 1000;  // ut.limits.WATERCRAFT_PER_DID=50 -- maxcnt=930 as of 11/9/2017
    EXPORT UNSIGNED2 MaxWatercraftOwners := 900;  // ut.limits.OWNERS_PER_WATERCRAFT -- maxcnt=886 as of 11/9/2017, drops below 100 except 26 recs
    EXPORT UNSIGNED2 MaxWatercraftCoastGuards := 50;  // ut.limits.MAX_COASTGUARD_PER_WATERCRAFT -- maxcnt=19 as of 11/9/2017
    EXPORT UNSIGNED2 MaxWatercraftDetails := 200;  // ut.limits.MAX_DETAILS_PER_WATERCRAFT -- maxcnt=185 as of 11/9/2017, drops below 50 except 4 recs
  END;
 
  EXPORT StatusCodes := MODULE
    EXPORT  ResultsFound     := 0;      
    EXPORT  NoResultsFound   := AutoKeyI.errorcodes._codes.NO_RECORDS;       
	  EXPORT  SOAPError        := AutoKeyI.errorcodes._codes.SOAP_ERR;
  END;    
    
  EXPORT GetStatusMessage(INTEGER __code) := AutoKeyI.errorcodes._msgs(__code);

END;