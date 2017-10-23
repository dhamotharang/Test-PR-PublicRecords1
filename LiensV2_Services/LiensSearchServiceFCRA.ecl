/*--SOAP--
<message name="LiensSearchServiceFCRA">
  
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
  <part name="LiensOnly" 				type="xsd:boolean"/> 
  <part name="JudgmentsOnly" 				type="xsd:boolean"/> 	
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="NonSubjectSuppression" type="xsd:unsignedInt" default="2"/> <!-- [1,2,3] -->
  <part name="ApplyNonsubjectRestrictions" type="xsd:boolean"/> 
	<part name="FFDOptionsMask" type="xsd:string"/>
 
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
</message>
*/
/*--INFO-- This service searches the FCRA LiensV2 files.*/

import liensv2_services, STD, FCRA, FFD, WSInput;

export LiensSearchServiceFCRA() := macro

	WSInput.MAC_LiensV2_LiensSearchServiceFCRA();

	#constant('getBdidsbyExecutive',FALSE);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#stored('ScoreThreshold',10);
	#stored('PenaltThreshold',10);
	#constant('DisplayMatchedParty',true);
	#constant('isFCRA', true);
	#constant('NoDeepDive', true);
	boolean isFCRA := true;
	boolean evictions_only := false : stored('EvictionsOnly');
	boolean liens_only := false : stored('LiensOnly');
	boolean judgments_only := false : stored('JudgmentsOnly');	
	doxie.MAC_Header_Field_Declare(isFCRA);

	//------------------------------------------------------------------------------------	
	//soap call for remote DIDs for Collections
  fcra_subj_only := false : stored ('ApplyNonsubjectRestrictions');
	boolean isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
	boolean returnByDidOnly := fcra_subj_only OR isCollections;
	//------------------------------------------------------------------------------------
	gateways := Gateway.Configuration.Get();
	picklist_res := FCRA.PickListSoapcall.non_esdl(gateways, true, returnByDidOnly and (did_value='')); //call gateway only when returnByDidOnly is true
	//------------------------------------------------------------------------------------

	string14 rdid := if(returnByDidOnly and did_value='', picklist_res[1].Records[1].UniqueId, did_value);

	// for FCRA version, set isFCRA boolean to true
	nss_default := if(fcra_subj_only or isCollections, Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription, Suppress.Constants.NonSubjectSuppression.doNothing);
	nss := ut.GetNonSubjectSuppression(nss_default);
	gm := AutoStandardI.GlobalModule(isFCRA);
	liens_params := module(project(gm, LiensV2_Services.IParam.search_params, opt))
		export string14 DID := rdid;
		export unsigned2 pt := 10 : stored('PenaltThreshold');
		export string CertificateNumber := '' : stored('CertificateNumber');
		export unsigned8 maxresults := maxresults_val;
		export string1 partyType := party_type;
		export string50 liencasenumber := liencasenumber_value;
		export string50 filingnumber := filingnumber_value;
		export string20 filingjurisdiction := filingjurisdiction_value;
		export string25 irsserialnumber := irsserialnumber_value;
		export string6 ssn_mask := ssn_mask_value;
		export integer1 non_subject_suppression := nss;
		export string32 ApplicationType := application_type_value;
		export string101 rmsid := rmsid_value;
		export string50 tmsid := tmsid_value;
		export boolean subject_only := returnByDidOnly;
		export integer8 FFDOptionsMask := FFD.FFDMask.Get();		 
	  export integer FCRAPurpose := FCRA.FCRAPurpose.Get();
	END;
	all_recs_and_statements := LiensV2_Services.LiensSearchService_records(liens_params, isFCRA);
	all_recs := all_recs_and_statements.records;
	statements := all_recs_and_statements.statements;
	
	// returns filtered results if filter is specifed
	recs_filt := all_recs((evictions_only and eviction = 'Y') 
													or (liens_only 
														and (STD.Str.ToUpperCase(STD.Str.CleanSpaces(filings[1].filing_type_desc)) in liensv2.filing_type_desc.LIEN)) 
													or (judgments_only 
														and (STD.Str.ToUpperCase(STD.Str.CleanSpaces(filings[1].filing_type_desc)) in liensv2.filing_type_desc.JUDGMENT)));

	need_filter := evictions_only or liens_only or judgments_only;

	out_recs := if(need_filter, recs_filt, all_recs);
	
	doxie.MAC_Marshall_Results(out_recs, recs_marshalled);
	OUTPUT(recs_marshalled, NAMED('Results'));
	OUTPUT(statements,NAMED('ConsumerStatements'));

endmacro;
