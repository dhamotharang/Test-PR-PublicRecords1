/*--SOAP--
<message name="BLJSearchService">
  <part name="IncludeBankruptcies"  type="xsd:boolean"/>
  <part name="IncludeLiensJudgments" type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
  <part name="IncludeAttorneyTrustee" type="xsd:boolean"/>
  <part name="DID" 					type="xsd:string"/>
  <part name="BDID" 				type="xsd:string"/>
  <part name="SSN"					type="xsd:string"/>
  <part name="PartyType"			type="xsd:string"/>
  <part name="CompanyName" 			type="xsd:string"/>
  <part name="UnParsedFullName" 	type="xsd:string"/>
  <part name="FirstName"   			type="xsd:string"/>
  <part name="MiddleName"  			type="xsd:string"/>
  <part name="LastName"    			type="xsd:string"/>
  <part name="AllowNickNames" 		type="xsd:boolean"/>
  <part name="PhoneticMatch"  		type="xsd:boolean"/>
  <part name="Addr"	       			type="xsd:string"/>
  <part name="City"        			type="xsd:string"/>
  <part name="State"       			type="xsd:string"/>
  <part name="Zip"         			type="xsd:string"/>
  <part name="County"           	type="xsd:string"/>
  <part name="FilingJurisdiction"	type="xsd:string"/>	
  <part name="TMSID" 				type="xsd:string"/>
  <part name="FEIN"		  			type="xsd:string"/>
  <part name="ZipRadius"  			type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" 			type="xsd:byte"/>
  <part name="GLBPurpose" 			type="xsd:byte"/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
  <part name="MaxResults" 			type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" 	type="xsd:unsignedInt"/>
  <part name="SkipRecords" 			type="xsd:unsignedInt"/>
  <part name="NoDeepDive" 			type="xsd:boolean"/>    
  <part name="SSNMask"				type="xsd:string"/>
  <part name="ReturnHashes" 		type="xsd:boolean"/>
  <part name="srch_hashvals" 		type="tns:XmlDataSet" cols="70" rows="3"/>
  <part name="StrictMatch"			type="xsd:boolean"/>
  <part name="EvictionsOnly" 		type="xsd:boolean"/> 
        <!-- Liens Only -->
  <part name="RMSID" 				type="xsd:string"/>
  <part name="ExactOnly"   			type="xsd:boolean"/>
  <part name="FilingNumber"			type="xsd:string"/>
  <part name="IRSSerialNumber"		type="xsd:string"/>
  <part name="CertificateNumber" 	type="xsd:string"/>
  <part name="Phone"	  			type="xsd:string"/>
  <part name="LienCaseNumber"		type="xsd:string"/>
	<!-- Bankrupcty Only -->
  <part name="CaseNumber"       	type="xsd:string"/>
  <part name="UltID" type="xsd:string"/>
	<part name="OrgID" type="xsd:string"/>
  <part name="SeleID" type="xsd:string"/>
	<part name="ProxID" type="xsd:string"/>  
	<part name="PowID" type="xsd:string"/>
	<part name="EmpID" type="xsd:string"/>
	<part name="DotID" type="xsd:string"/>
  <part name="BusinessIDFetchLevel" type="xsd:string"/>
  <!-- Business Bankrupcty Only -->
  <part name="ChapterChoice" type="xsd:unsignedInt"/>
  <part name="BusinessOnly" 		type="xsd:boolean"/> 

</message>
*/
/*--INFO-- This service searches the Bankruptcyv2 and Lienv2 files.*/

import doxie, liensv2_services, Text_Search, bankruptcyv2_Services;

export BLJSearchService() := macro
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    doxie.MAC_Header_Field_Declare(false);
	#constant('getBdidsbyExecutive',FALSE);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#constant('DisplayMatchedParty',true);
	#constant('isFCRA', false);
	#stored('ScoreThreshold',10);
	#stored('PenaltThreshold',10);
		
	boolean Include_Bankruptcies := false : stored('IncludeBankruptcies');
  boolean Include_LiensJudgments := false : stored('IncludeLiensJudgments');
  boolean Include_CriminalIndicators := false : stored('IncludeCriminalIndicators');
  boolean Include_AttorneyTrustee := false : stored('IncludeAttorneyTrustee');
	unsigned ChapterChoice := 0 : stored('ChapterChoice');
	boolean BusinessOnly := false : stored('BusinessOnly');
	

	  //get lien records
	  boolean evictions_only := false : stored('EvictionsOnly');
		gm := AutoStandardI.GlobalModule();
		liens_params := module(project(gm, LiensV2_Services.IParam.search_params, opt))
			export unsigned2 pt := 10 			: stored('PenaltThreshold');
			export string CertificateNumber := '' : stored('CertificateNumber');
			export unsigned8 maxresults := maxresults_val;
			export string1 partyType := party_type;
			export string50 liencasenumber := liencasenumber_value;
			export string50 filingnumber := filingnumber_value;
			export string20 filingjurisdiction := filingjurisdiction_value;
			export string25 irsserialnumber := irsserialnumber_value;
			export string6 ssn_mask := ssn_mask_value;
			export string32 ApplicationType := application_type_value;
			export string101 rmsid := rmsid_value;
			export string50 tmsid := tmsid_value;
      export boolean includeCriminalIndicators := Include_CriminalIndicators;
      // Reassigning the values to zero and not to read from stored since we don't want to search liens with the business ids
      export unsigned6 UltID := 0;
      export unsigned6 OrgID := 0;
      export unsigned6 SELEID := 0;
      export unsigned6 ProxID := 0;
      export unsigned6 POWID := 0;
      export unsigned6 EmpID := 0;
      export unsigned6 DotID := 0;
		END;
		
		lienrecs := LiensV2_Services.LiensSearchService_records(liens_params).records;

      lienorec := record 
        liensv2_services.layout_lien_rollup;
        Text_Search.Layout_ExternalKey;
      END;
      lienorec addLienExt ( lienrecs l) := transform
        self := l;
  	    self.ExternalKey := l.TMSID;
      end;
      lienrecs_w_key := project(lienrecs, addLienext(left));
      eviction_recs := lienrecs_w_key(eviction = 'Y');
      lienorecs := if(evictions_only, eviction_recs, lienrecs_w_key);
    
	
    //get bankruptcy records
    bid_params := module(project(AutoStandardI.GlobalModule(),TopBusiness_Services.iParam.BIDParams,opt))
    end;
    
    in_bids := TopBusiness_Services.Functions.create_business_ids_dataset(bid_params);
    
	  bankrecs := bankruptcyv2_Services.bankruptcy_raw().search_view(in_ssn_mask := ssn_mask_value,
                                                                   in_party_type := Party_Type, 
                                                                   in_filing_jurisdiction := FilingJurisdiction_value,
                                                                   in_includeCriminalIndicators := Include_CriminalIndicators,
                                                                   in_Include_AttorneyTrustee := Include_AttorneyTrustee,
                                                                   in_bids := in_bids,
                                                                   bid_fetch_level := bid_params.BusinessIDFetchLevel);
	
  // If needed filter out chapters
 	 bankrecs_chp :=  map( 
                        ChapterChoice = 1  => bankrecs(Chapter = '11'),
													 ChapterChoice = 2 => bankrecs(Chapter = '7'),
													 ChapterChoice = 3 => bankrecs(Chapter in ['11','7']),
													 ChapterChoice not in [1,2,3] and   BusinessOnly  => bankrecs(Chapter in ['11','7']),
														                     bankrecs);
																						
	 // Classify the Bankruptcy record
	 bankrecs_classified :=  BLJ_V2_Services.fnSupressPeople(bankrecs_chp);			 
	 bankrecs_unclassified := project(bankrecs_chp,
	                           transform(recordof(bankrecs_classified), 
														     self.BKRecordType := 3, // no classification
																  self := left));
																	
	 bankrecs_final := if(BusinessOnly,bankrecs_classified(BKRecordType <> 0),bankrecs_unclassified);
	 
	  bankorec := record 
        bankruptcyv2_services.layouts.layout_rollup;
        Text_Search.Layout_ExternalKey;
				 boolean DebtorsSuppressed;
      END;
			
      bankorec addExt ( bankrecs_final l) := transform
				self.ExternalKey := l.TMSID;        
				Self.DebtorsSuppressed := l.BKRecordType = 2;
				self := l;
				
      end;
			 
   bankorecs :=  project(bankrecs_final, addext(left));
    
	
	//combined records 
	CombinedLayout := RECORD
	  boolean isDeepDive;
	  STRING1 recordType;
	  Unsigned penalt;
	  lienorec lienRec;
	  bankorec bankruptcyRec;
	END;
	CombinedLayout  loadbankruptcy(bankorecs L) := transform
	  self.recordType := BLJ_V2_Services.Constants.recordType.bankruptcyRec;
	  self.isDeepDive := L.isDeepDive;
	  self.penalt := L.penalt;
	  self.bankruptcyRec := L;  
	  self := [];
	end;
	CombinedLayout  loadlien(lienorecs L) := transform
	  self.recordType := BLJ_V2_Services.Constants.recordType.lienRec;
	  self.isDeepDive := L.isDeepDive;
	  self.penalt := L.penalt;
	  self.lienRec := L; 
	  self := [];
	end;

	CRecs1 := project(bankorecs,loadbankruptcy(left));
	CRecs2 := project(lienorecs,loadlien(left));
	
	//Sort by Penalty then Bankruptcy/Lien
	MRecs := SORT((CRecs1 + CRecs2),if(isDeepDive, 1, 0),penalt, recordType, record); 
		
	//determine which records to return 
	boolean searchBankruptcyOnly := Include_Bankruptcies and not Include_LiensJudgments;
	boolean searchLienOnly := Include_LiensJudgments and not Include_Bankruptcies ;
	finalOutputRecs := MAP(searchBankruptcyOnly => CRecs1,
                         searchLienOnly => CRecs2,
                         MRecs); //if both or neither are specified

	doxie.MAC_Marshall_Results(finalOutputRecs, outputBLJ);
	
	OUTPUT(outputBLJ,NAMED('Results'));	
endmacro;
//BLJSearchService();
	
	