/*--SOAP--
<message name="profLicSearch" wuTimeout="300000">
  <part name="IndustryClass" type="xsd:string"/>
  <part name="CompanyName" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
  <part name="UnParsedFullName" 	type="xsd:string"/>	
  <part name="LastName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>
  <part name="BDID" type="xsd:string"/>
  <part name="LicenseNumber" type="xsd:string"/>
  <part name="FilingJurisdiction"	type='xsd:string'/>	
  <part name="SanctionId" type="xsd:unsignedInt"/>
  <part name="ProviderId" type="xsd:unsignedInt"/>
  <part name="SequenceId" type="xsd:unsignedInt"/>
	<part name="DOB"        type="xsd:string"/>
	<part name="TaxID"      type="xsd:string"/>
	<part name="AllowNicknames" type="xsd:boolean" />
	<part name="PhoneticMatch" type="xsd:boolean" />
	<part name="NoDeepDive" type="xsd:boolean"/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
	<part name="IncludeProfessionalLicenses" type="xsd:boolean" />
	<part name="IncludeSanctions" type="xsd:boolean" />
	<part name="IncludeProviders" type="xsd:boolean"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
 </message>
*/
/*--INFO-- This service pulls from the Ingenix and Professional licenses file.*/

import prof_licensev2_services;

Export Prof_LicenseSearchService := MACRO
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('SearchIgnoresAddressOnly',true);
	#constant('getBdidsbyExecutive',FALSE);
	#Constant('SetRepAddr',TRUE);
	#stored('SetRepAddrBit',4);
  
	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,prof_licensev2_services.profLicSearch.params,opt))
	  export boolean Include_Prof_Lic := false : stored('IncludeProfessionalLicenses');
	  export boolean Include_Sanc := false		 : stored('IncludeSanctions');
	  export boolean Include_Prov := false		 : stored('IncludeProviders');
	
	  export unsigned6 	Sanc_id := 0 						 : stored('SanctionID');
		export set of unsigned6  sanc_id_set := [] : stored('SanctionID');
		export unsigned6  ProviderId := 0      		 : stored('ProviderID');
		export unsigned6  prolic_seq_num := 0  		 : stored('SequenceID');
		shared string20	  L_Number := '' 		       : stored('LicenseNumber');
		export string20   License_Number :=  stringlib.stringtouppercase(l_number);	
		shared string11 	T_ID  := ''             : stored('TaxID');
		export string10   tax_id := Stringlib.StringFilterOut(T_ID, '-'); 
		
		// export unsigned2 pt := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(input_params,
				                                     // AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
   export boolean is_search := TRUE;
   export INTEGER5 startingRecord := 1 : STORED('starting_record');
  export INTEGER5 returnCount := 9999 : STORED('return_count');
  											
	end;
	

	recs := prof_LicenseV2_Services.ProfLicSearch.val(tempmod);
	
	maxresults_val :=  AutoStandardI.InterfaceTranslator.maxresults_val.val(project(input_params,
 									       AutoStandardI.InterfaceTranslator.maxresults_val.params));
												 
  skiprecords_val :=  AutoStandardI.InterfaceTranslator.skiprecords_val.val(project(input_params,
 									       AutoStandardI.InterfaceTranslator.skiprecords_val.params));		

  maxresultsThistime_val := AutoStandardI.InterfaceTranslator.maxresultsthistime_val.val(project(input_params,
 									       AutoStandardI.InterfaceTranslator.maxresultsthistime_val.params));											 
	
	
	// create External Key field
	Text_Search.MAC_Append_ExternalKey(recs, recs2, 
                                   MAP(l.UniqueID[1..2]='PL'=> 'L'+ INTFORMAT((UNSIGNED)(l.UniqueID[3..]),15,1),
																	     l.UniqueID[1..2]='PR'=> 'P'+ l.UniqueID[3..],
																			 'S' + l.UniqueID[3..] )
																	 );


	
	doxie.MAC_Marshall_Results(recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));

endmacro;