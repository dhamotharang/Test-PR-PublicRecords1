/*--SOAP--
<message name="PersonRollupService" wuTimeout="300000">
 	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName"        type="xsd:string"/>
	<part name="MiddleName"       type="xsd:string"/>
	<part name="LastName"         type="xsd:string"/>
	<part name="NameSuffix"				type="xsd:string"/>
  <part name="allowNicknames" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="CheckNameVariants" type="xsd:boolean"/>
  <separator />
	<part name="prim_range" type="xsd:string"/>
	<part name="prim_name" type="xsd:string"/>
  <part name="predir" type="xsd:string"/>
  <part name="postdir" type="xsd:string"/>
	<part name="suffix"  type="xsd:string"/>
  <part name="sec_range" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="StateCityZip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="DLNumber" type="xsd:string"/>
	<part name="DLState" type="xsd:string"/>
  <separator />
  <part name="DID" type="xsd:string" required="1" />
  <part name="SSN" type="xsd:string"/>
  <part name="SSNLast4" type="xsd:string"/>
  <part name="SSNFirst5" type="xsd:string"/>
	<part name="SSNMask" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <separator />	
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
  <part name="DataPermissionMask" type="xsd:string" default="00000000000"/>
  <part name="DoNotFillBlanks" type="xsd:boolean"/>	
  <part name="IncludeBankruptcies" type="xsd:boolean"/>	
  <part name="IncludeSourceDocCounts" type="xsd:boolean"/>
  <part name="IncludeAlsoFound" type="xsd:boolean"/>	
  <part name="IncludePhonesFeedback" type="xsd:boolean"/>
	<part name="IncludeAddressFeedback" type="xsd:boolean"/>
	<part name="IncludeDLInfo" type="xsd:boolean"/>
	<part name="IncludeNonDMVSources"	type="xsd:boolean"/>
	<part name="StrictMatch" type="xsd:boolean"/>
	<part name="UsePartialSSNMatch" type="xsd:boolean"/>
  <part name="MaxWaitSeconds" type="xsd:integer"/>	
	<part name="IncludePhonesPlus" type="xsd:boolean"/>
	<part name="IncludeAlternatePhonesCount" type="xsd:boolean"/>
	<part name="ExcludeDMVPII" type="xsd:boolean"/>

	<!-- FDN only option/fields -->
	<part name="IncludeFraudDefenseNetwork" type="xsd:boolean"/>
	<part name="GlobalCompanyId"				    type="xsd:unsignedInt"/>
	<part name="IndustryType"	    			    type="xsd:unsignedInt"/>
	<part name="ProductCode"		  		      type="xsd:unsignedInt"/>

  <separator />
	<part name="ReturnCount"				 type="xsd:unsignedInt"/>
	<part name="StartingRecord"			 type="xsd:unsignedInt"/>	
  <separator />
  <part name="RollupBpsSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Replacement for Moxie personsearch (bpssearch with address rollup) */
/*--USES-- ut.input_xslt */
IMPORT iesp,AutoStandardI;
EXPORT PersonRollupService () := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	//The following macro defines the field sequence on WsECL page of query. 
	WSInput.MAC_PersonSearch_Services_PersonRollupService();

	#constant('IncludeHRI', true);
	#constant('BpsLeadingNameMatch', true);
	#constant('UseSSNFallBack', true);
	#constant('AllowFuzzyDOBMatch', false);
	#constant('FuzzySecRange', 1);
	#constant('IncludeZeroDIDRefs', true);  // allow for matches from the daily fetches that don't have a DID

  rec_in := iesp.rollupbpssearch.t_RollupBpsSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('RollupBpsSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
	search_by := global (first_row.SearchBy);
	search_options := global (first_row.Options);

  // Added for the FDN project, to handle 3 FDN only required input fields
	fdn_user := global (first_row.FDNUser);
	#stored ('GlobalCompanyId', fdn_user.GlobalCompanyId);
	#stored ('IndustryType',  fdn_user.IndustryType);
	#stored ('ProductCode', fdn_user.ProductCode);

  // this will set SSN, DID, Name and Address
  report_by := ROW (search_by, transform (iesp.bpsreport.t_BpsReportBy, Self := Left; Self := []));
	
	clean_inputs := true;
  iesp.ECL2ESP.SetInputReportBy (report_by, clean_inputs);

	#stored ('ZipRadius', search_by.Radius);
	#stored ('AgeLow', search_by.AgeRange.Low);
	#stored ('AgeHigh', search_by.AgeRange.High);	
  #stored ('allownicknames', search_options.UseNicknames);
  #stored ('phoneticmatch', search_options.UsePhonetics);
  #stored ('StrictMatch', search_options.StrictMatch);
  #stored ('IncludeBankruptcies', search_options.IncludeBankruptcy);
  #stored ('IncludeSourceDocCounts', search_options.IncludeSourceDocCounts);
	#stored ('CheckNameVariants', search_options.CheckNameVariants);
  #stored ('IncludeAlsoFound', search_options.IncludeAlsoFound);
	#stored ('IncludePhonesPlus', search_options.IncludePhonesPlus or search_options.IncludeAlternatePhonesCount);  
	#stored ('IncludeAlternatePhonesCount', search_options.IncludeAlternatePhonesCount);
	#stored ('IncludePhonesFeedback', search_options.IncludePhonesFeedback);
	#stored ('IncludeAddressFeedback', search_options.IncludeAddressFeedback);
	
	boolean in_includeAlsoFound := false : stored('IncludeAlsoFound');
	boolean in_IncludeAlternatePhonesCount := false : stored('IncludeAlternatePhonesCount');
	boolean in_IncludePhonesFeedback := false : stored('IncludePhonesFeedback');
	boolean in_IncludeAddressFeedback := false : stored('IncludeAddressFeedback');
	set of string in_IncludeSourceList := SET(search_options.IncludeSourceList, value);
		
	// not currently in the search options 
  // boolean BlanksFilledIn := search_options.BlanksFilledIn;
  // #stored ('DoNotFillBlanks', ~BlanksFilledIn);

	// default Addr HRI to true, others to false
  boolean in_includeSSNHri := false : stored('IncludeSSNHri');	
  boolean in_includeAddrHri := true : stored('IncludeAddrHri');	
  boolean in_includePhoneHri := false : stored('IncludePhoneHri');	

	#stored ('UsePartialSSNMatch', search_options.UsePartialSSNMatch);
	boolean in_PartialSSNMatch := false : stored('UsePartialSSNMatch');	
	boolean in_allowEditDist := false : stored('CheckNameVariants');
	String24 inDLNum := search_by.DLNumber : stored('DLNumber');
	in_DL_Num := stringlib.stringtouppercase(inDLNum);
	#stored('dl_number',in_DL_Num);
	string xml_in_DL_State := stringlib.stringtouppercase(search_by.DLState);
	#stored('DLState',xml_in_DL_State);
	boolean xml_in_includeDLInfo := search_options.includeDLInfo;
	#stored ('IncludeDLInfo', xml_in_includeDLInfo);
	boolean xml_in_includeNonDMVSources := search_options.IncludeNonDMVSources;
	#stored ('IncludeNonDMVSources', xml_in_includeNonDMVSources);
	string in_DL_State := '' :stored('DLState'); 
	boolean in_includeDLInfo :=  false : stored('IncludeDLInfo');

  // Added for the FDN project, 1 new input option & 3 required input fields
	#stored ('IncludeFraudDefenseNetwork', search_options.IncludeFraudDefenseNetwork);
  boolean in_IncludeFraudDefenseNetwork := false : stored('IncludeFraudDefenseNetwork');
	unsigned6 in_FDN_gcid     := 0 : stored('GlobalCompanyId');
	unsigned2 in_FDN_indtype  := 0 : stored('IndustryType');
	unsigned6 in_FDN_prodcode := 0 : stored('ProductCode');

	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,PersonSearch_Services.Rollup_Records.params,opt));
		export includeAlsoFound := in_includeAlsoFound;
		export includeSSNHri := in_includeSSNHri;
		export includeAddrHri := in_includeAddrHri;
		export includePhoneHri := in_includePhoneHri;
		export IncludeAlternatePhonesCount := in_IncludeAlternatePhonesCount;
		export allowPartialSSNMatch := in_PartialSSNMatch;
		export allowEditDist := in_allowEditDist; 
		export includeDLInfo := in_includeDLInfo;
		export dlState_value := stringlib.stringtouppercase(in_DL_State);
		export DLNumber_Value := in_DL_Num;
		export boolean IncludePhonesFeedback := in_IncludePhonesFeedback;
		export boolean IncludeAddressFeedback := in_IncludeAddressFeedback;		
		export unsigned SourceDocFilter := doxie.SourceDocFilter.GetBitmask(in_IncludeSourceList);				
    // Added for the FDN project, 1 new input option & 3 required input fields
		export IncludeFraudDefenseNetwork  := in_IncludeFraudDefenseNetwork;
	  export unsigned6 FDNinput_gcid     := in_FDN_gcid;
	  export unsigned2 FDNinput_indtype  := in_FDN_indtype;
	  export unsigned6 FDNinput_prodcode := in_FDN_prodcode;

	end;

	tempresults   := PersonSearch_Services.Rollup_Records.val(tempmod);
	FDN_check     := tempresults(FDNResultsFound = true);
  FDN_Royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(FDN_check);
  royalties     := if(tempmod.IncludeFraudDefenseNetwork, FDN_Royalties);

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, results, 
                         iesp.rollupbpssearch.t_RollupBpsSearchResponse, Records, false, SubjectTotalCount);

  output(royalties,named('RoyaltySet'));
  output(results,named('Results'));

ENDMACRO;
// PersonRollupService()
/*
<RollupBpsSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
	<DataRestrictionMask>000000000000000000000000</DataRestrictionMask>
	<DataPermissionMask>00000000001</DataPermissionMask>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>	
<FDNUser>
  <GlobalCompanyId></GlobalCompanyId>
  <IndustryType></IndustryType>
  <ProductCode></ProductCode>
</FDNUser>
<SearchBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
  <UniqueID></UniqueID>
  <SSN></SSN>
  <SSNLast4></SSNLast4>
  <SSNFirst5></SSNFirst5>
  <Phone10></Phone10>
	<Radius></Radius>
  <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DOB>	
  <DateFirstSeen>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DateFirstSeen>	
  <DateLastSeen>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DateLastSeen>	
  <AgeRange>
    <Low></Low>
    <High></High>
  </AgeRange>	
</SearchBy>
<Options>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <UseNicknames>1</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
  <UsePartialSSNMatch>0</UsePartialSSNMatch>
  <IncludeSourceDocCounts>0</IncludeSourceDocCounts>
  <IncludeSourceList><Item>DECEASED</Item><Item>LOCATOR</Item><Item>UTILITY</Item></IncludeSourceList>
	<IncludePhonesPlus></IncludePhonesPlus>
	<IncludeAlternatePhonesCount></IncludeAlternatePhonesCount>
	<IncludeFraudDefenseNetwork>0</IncludeFraudDefenseNetwork>
</Options>
</row>
</RollupBpsSearchRequest>
*/
