/*--SOAP--
<message name="BankruptcySearchService">
	<!-- Indexed Directly -->
  <part name="TMSID" 							type="xsd:string"/>
  <part name="BDID" 							type="xsd:string"/>
  <part name="DID" 								type="xsd:string"/>

	<!-- Indexed by Autokey -->
	<part name="PartyType"          type="xsd:string"/>
  <part name="CompanyName" 				type="xsd:string"/>
	<part name="UnParsedFullName" 	type="xsd:string"/>
  <part name="FirstName"   				type="xsd:string"/>
  <part name="MiddleName"  				type="xsd:string"/>
  <part name="LastName"    				type="xsd:string"/>
  <part name="Addr"	       				type="xsd:string"/>
  <part name="City"        				type="xsd:string"/>
  <part name="State"       				type="xsd:string"/>
  <part name="Zip"         				type="xsd:string"/>
  <part name="County"           	type="xsd:string"/>
  <part name='SSN'								type='xsd:string'/>
  <part name="FEIN"		  					type="xsd:string"/>
	
	<!-- CaseNumber -->
	<part name="CaseNumber"         type="xsd:string"/>
	
  <part name="FilingJurisdiction"	type='xsd:string'/>	
	
  <part name="PenaltThreshold"		type="xsd:unsignedInt"/>
	
  <part name="DPPAPurpose" 				type="xsd:byte"/>
  <part name="GLBPurpose" 				type="xsd:byte"/>
  <part name="SSNMask"						type="xsd:string"/>
	<part name="ApplicationType"   	type="xsd:string"/>
	
  <part name="AllowNickNames" 		type="xsd:boolean"/>
  <part name="PhoneticMatch"  		type="xsd:boolean"/>
  <part name="NoDeepDive" 				type="xsd:boolean"/>
  <part name="ZipRadius"  				type="xsd:unsignedInt"/>
  <part name="MaxResults"  				type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" 				type="xsd:unsignedInt"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
	<part name="StrictMatch"		type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>

 <!-- Business Bankrupcty Only -->
  <part name="ChapterChoice" type="xsd:unsignedInt"/>
  <part name="BusinessOnly" 		type="xsd:boolean"/> 


</message>
*/
/*--INFO-- This service searches the Bankruptcyv2 files.*/

import doxie,Text_Search;

export BankruptcySearchService(
	) :=
		macro
		#CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
		//The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_BankruptcyV2_Services_SearchService();
		
    doxie.MAC_Selection_Declare()
		doxie.MAC_Header_Field_Declare()
		
		unsigned ChapterChoice := 0 : stored('ChapterChoice');
		boolean BusinessOnly := false : stored('BusinessOnly');
 
		#constant('SearchIgnoresAddressOnly',true);
		#stored('ScoreThreshold',10);
		#stored('PenaltThreshold',10);
		#constant('DisplayMatchedParty',true);
		#constant('isFCRA', false);

		recs	 := bankruptcyv2_Services.bankruptcy_raw().search_view(in_ssn_mask := ssn_mask_value,
																														 in_party_type := Party_Type, 
																														 in_filing_jurisdiction := FilingJurisdiction_value,
                                                             in_includeCriminalIndicators := IncludeCriminalIndicators);

    
		 // If needed filter out chapters
 	 bankrecs_chp :=  map( 
                        ChapterChoice = 1  =>    recs(Chapter = '11'),
													 ChapterChoice = 2 => recs(Chapter = '7'),
													 ChapterChoice = 3 => recs(Chapter in ['11','7']),
													 ChapterChoice not in [1,2,3] and   BusinessOnly  => recs(Chapter in ['11','7']),
														                     recs);
																						
	 // Classify the Bankruptcy record
	 bankrecs_classified :=  BLJ_V2_Services.fnSupressPeople(bankrecs_chp);			 
	 bankrecs_unclassified := project(bankrecs_chp,
	                           transform(recordof(bankrecs_classified), 
														     self.BKRecordType := 3, // no classification
														     self := left));
																	
	 bankrecs_final := if(BusinessOnly,bankrecs_classified(BKRecordType <> 0),bankrecs_unclassified);
																														 
		
		orec := record 
				RECORDOF(recs);
				Text_Search.Layout_ExternalKey;
			// added
				boolean DebtorsSuppressed;
    END;
		
     orec addExt(bankrecs_final l) := transform
			Self.ExternalKey := l.TMSID;
			Self.DebtorsSuppressed := l.BKRecordType = 2; // added
			self := l;
    end;
		
    recs2 := project(bankrecs_final, addext(left));
		
		doxie.MAC_Marshall_Results(recs2, recs_marshalled);
          //output(recs, named('recs'));
		OUTPUT(recs_marshalled, NAMED('Results'));			
		endmacro;
