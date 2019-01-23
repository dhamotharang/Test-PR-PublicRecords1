/*--SOAP--
<message name="LiensSearchService">
  
  <part name="DID" 					type="xsd:string"/>
  <part name="BDID" 				type="xsd:string"/>
  <part name="PartyType"			type="xsd:string"/>
  <part name="CompanyName" 			type="xsd:string"/>
  <part name="ExactOnly"   			type="xsd:boolean"/>
  <part name='SSN'					type='xsd:string'/>
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
  <part name="County"           type="xsd:string"/>
  <part name="LienCaseNumber"		type='xsd:string'/>
  <part name="FilingNumber"			type='xsd:string'/>
  <part name="IRSSerialNumber"	type='xsd:string'/>
  <part name="FilingJurisdiction"	type='xsd:string'/>	
  <part name="TMSID" 				type="xsd:string"/>
  <part name="RMSID" 				type="xsd:string"/>
  <part name="FEIN"		  			type="xsd:string"/>
	<part name="CertificateNumber" type="xsd:string"/>
  <part name="Phone"	  			type="xsd:string"/>
  <part name="ZipRadius"  			type="xsd:unsignedInt"/>
  <part name="SkipRecords" 			type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" 			type="xsd:byte"/>
  <part name="GLBPurpose" 			type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="ScoreThreshold" 		type="xsd:unsignedInt"/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
  <part name="MaxResults" 			type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" 	type="xsd:unsignedInt"/>
  <part name="SkipRecords" 			type="xsd:unsignedInt"/>
  <part name="NoDeepDive" 				type="xsd:boolean"/>    
  <part name="SSNMask"					type="xsd:string"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
	<part name="StrictMatch"		type="xsd:boolean"/>
  <part name="EvictionsOnly" 				type="xsd:boolean"/> 
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
  <part name="UltID" type="xsd:string"/>
	<part name="OrgID" type="xsd:string"/>
  <part name="SeleID" type="xsd:string"/>
	<part name="ProxID" type="xsd:string"/>  
	<part name="PowID" type="xsd:string"/>
	<part name="EmpID" type="xsd:string"/>
	<part name="DotID" type="xsd:string"/>
  <part name="BusinessIDFetchLevel" type="xsd:string"/>
</message>
*/
/*--INFO-- This service searches the LiensV2 files.  
           Please Note: The *Filing Jurisdiction*                  
					 field is not used in the standalone liens searches which originate from accurint.com
				   but is used in the find a person/business statewide searches from lexis.com.
					 Therefore the field : *Filing Jurisdiction* below should be left blank 
					 when running a liens only roxie search using the fields below */


export LiensSearchService() := macro
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #CONSTANT ('SaltLeadThreshold', 15); // lead threshold set here according to Linking Team's recommendation.
	#constant('getBdidsbyExecutive',FALSE);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#stored('ScoreThreshold',10);
	#stored('PenaltThreshold',10);
	#constant('DisplayMatchedParty',true);

	boolean evictions_only := false : stored('EvictionsOnly');
	boolean include_criminalIndicators := false : stored('IncludeCriminalIndicators');
  
	doxie.MAC_Header_Field_Declare();
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
		export boolean includeCriminalIndicators := include_criminalIndicators;
	END;
  
	recs := LiensV2_Services.LiensSearchService_records(liens_params).records;
	
	
  orec := record 
     RECORDOF(recs);
     Text_Search.Layout_ExternalKey;
  END;
  orec addExt ( recs l) := transform
    self := l;
  	self.ExternalKey := l.TMSID;
  end;
  recs2 := project(recs, addext(left));
	
	eviction_recs := recs2(eviction = 'Y');
	out_recs := if(evictions_only, eviction_recs, recs2);
	
	out_recs2 := if(party_type = '', out_recs, out_recs(matched_party.party_type = party_type));
	
	doxie.MAC_Marshall_Results(out_recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));

endmacro;