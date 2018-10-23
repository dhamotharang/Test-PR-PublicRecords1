/*--SOAP--
<message name="UCCSearchService">
  
	<!-- Indexed Directly -->
  <part name="TMSID" 							type="xsd:string"/>
  <part name="RMSID" 							type="xsd:string"/>
  <part name="DID" 								type="xsd:string"/>
  <part name="BDID" 							type="xsd:string"/>
  <part name="FilingNumber"				type='xsd:string'/>
  <part name="FilingJurisdiction"	type='xsd:string'/>
  <part name="FilingDateBegin"		type='xsd:string'/>
  <part name="FilingDateEnd"			type='xsd:string'/>

	<!-- Indexed by Autokey -->
  <part name="CompanyName" 				type="xsd:string"/>
  <part name='SSN'								type='xsd:string'/>
  <part name="SSNMask"						type="xsd:string"/>
	<part name="UnParsedFullName" 	type="xsd:string"/>
  <part name="FirstName"   				type="xsd:string"/>
  <part name="MiddleName"  				type="xsd:string"/>
  <part name="LastName"    				type="xsd:string"/>
  <part name="Addr"	       				type="xsd:string"/>
  <part name="City"        				type="xsd:string"/>
  <part name="State"       				type="xsd:string"/>
  <part name="Zip"         				type="xsd:string"/>
  <part name="County"             type="xsd:string"/>
  <part name="FEIN"		  					type="xsd:string"/>

	<part name="PartyType"							type="xsd:string"/>
  <part name="IncludeMultipleSecured"	type="xsd:boolean"/>
  <part name="ReturnRolledDebtors"		type="xsd:boolean"/>
	<part name="SearchOrigFilingOnly"		type="xsd:boolean"/>
  <part name="PenaltThreshold"				type="xsd:unsignedInt"/>
	
  <part name="DPPAPurpose" 				type="xsd:byte"/>
  <part name="GLBPurpose" 				type="xsd:byte"/>
	<part name="ApplicationType" 		type="xsd:string"/>
	
  <part name="AllowNickNames" 		type="xsd:boolean"/>
  <part name="PhoneticMatch"  		type="xsd:boolean"/>
  <part name="StrictMatch"				type="xsd:boolean"/>
  <part name="ExactOnly"   				type="xsd:boolean"/>
  <part name="NoDeepDive" 				type="xsd:boolean"/>
  <part name="ZipRadius"  				type="xsd:unsignedInt"/>
  <part name="MaxResults"  				type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" 				type="xsd:unsignedInt"/>
  <part name="ReturnHashes" 			type="xsd:boolean"/>
	<part name="UltID"							type="xsd:unsignedInt"/>
	<part name="OrgID"							type="xsd:unsignedInt"/>
	<part name="SeleID"							type="xsd:unsignedInt"/>
	<part name="ProxID"							type="xsd:unsignedInt"/>
	<part name="DotID"							type="xsd:unsignedInt"/>
	<part name="EmpID"							type="xsd:unsignedInt"/>
	<part name="PowID"							type="xsd:unsignedInt"/>
  <part name="BusinessIdFetchLevel" 	type="xsd:string"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
</message>
*/
/*--INFO-- This service searches the UCCv2 files.*/

export UCCSearchService() := macro
import Text_Search,doxie;

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('getBdidsbyExecutive',FALSE);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#stored('ScoreThreshold',10);
	#stored('PenaltThreshold',10);
	#constant('DisplayMatchedParty',true);
	
	// output(UCCv2_Services.UCCSearchService_records, named('Results'));
	
  bid_params := module(project(AutoStandardI.GlobalModule(), TopBusiness_Services.iParam.BIDParams,opt))
  end;
    
  in_bids := TopBusiness_Services.Functions.create_business_ids_dataset(bid_params);

	recs := UCCv2_Services.UCCSearchService_records(in_bids, 
																									bid_params.BusinessIDFetchLevel).records;

  // create External Key field
  orec := record 
     RECORDOF(recs);
     Text_Search.Layout_ExternalKey;
  END;
  orec addExt ( recs l) := transform
    self := l;
  	self.ExternalKey := l.TMSID;
  end;
  recs2 := project(recs, addext(left));

	doxie.MAC_Header_Field_Declare()
	doxie.MAC_Marshall_Results(recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));

endmacro;
