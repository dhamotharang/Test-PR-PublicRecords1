/*--SOAP--
<message name="PersonSearchService" wuTimeout="300000">
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
  <part name="IncludePriorAddresses" type="xsd:boolean"/>	
  <part name="IncludeSourceDocCounts" type="xsd:boolean"/>	
  <part name="IncludeAddressFeedback" type="xsd:boolean"/>
	<part name="IncludePhonesFeedback" type="xsd:boolean"/>	
	<part name="IncludePhonesPlus" type="xsd:boolean"/>
  <part name="ReturnAlsoFound" type="xsd:boolean"/>	
 	<part name="StrictMatch" type="xsd:boolean"/>
	<part name="UsePartialSSNMatch" type="xsd:boolean"/>
  <part name="MaxWaitSeconds" type="xsd:integer"/>	
	<part name="ExcludeDMVPII" type="xsd:boolean"/>
  <separator />
	<part name="ReturnCount"				 type="xsd:unsignedInt"/>
	<part name="StartingRecord"			 type="xsd:unsignedInt"/>	
  <separator />
  <part name="includealldidrecords" type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
  <part name="EnhancedSort" type="xsd:boolean"/>

	<!-- FDN only option/fields -->
	<part name="IncludeFraudDefenseNetwork" type="xsd:boolean"/>
	<part name="GlobalCompanyId"				    type="xsd:unsignedInt"/>
	<part name="IndustryType"	    			    type="xsd:unsignedInt"/>
	<part name="ProductCode"		  		      type="xsd:unsignedInt"/>

  <part name="BpsSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Replacement for Moxie bpssearch */
/*--USES-- ut.input_xslt */

IMPORT iesp,AutoStandardI, doxie, Royalty;
EXPORT PersonSearchService () := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	//The following macro defines the field sequence on WsECL page of query. 
	WSInput.MAC_PersonSearch_Services_PersonSearchService();
	
	#constant('IncludeHRI', true);
	#constant('BpsLeadingNameMatch', true);
	#constant('UseSSNFallBack', true);
	#constant('AllowFuzzyDOBMatch', false);
	#constant('FuzzySecRange', 1);
	#constant('IncludeZeroDIDRefs', true);  // allow for matches from the daily fetches that don't have a DID


  rec_in := iesp.bpssearch.t_BpsSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('BpsSearchRequest', FEW);
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
  #stored ('IncludePriorAddresses', search_options.IncludePriorAddresses);
  #stored ('IncludeSourceDocCounts', search_options.IncludeSourceDocCounts);
  #stored ('ReturnAlsoFound', search_options.ReturnAlsoFound);
	#stored ('IncludePhonesPlus', search_options.IncludePhonesPlus or search_options.IncludeAlternatePhonesCount);
	#stored ('IncludeAlternatePhonesCount', search_options.IncludeAlternatePhonesCount);
	#stored ('includealldidrecords', search_options.IncludeAllUniqueIdRecords);
	#stored ('IncludeCriminalIndicators', search_options.IncludeCriminalIndicators);
	#stored ('EnhancedSort', search_options.EnhancedSort);
	#stored ('IncludePhonesFeedback', search_options.IncludePhonesFeedback);
	#stored ('IncludeAddressFeedback', search_options.IncludeAddressFeedback);
	boolean in_IncludeAlternatePhonesCount := false : stored('IncludeAlternatePhonesCount');
	boolean in_IncludePhonesPlus := search_options.IncludePhonesPlus;
  boolean in_returnAlsoFound := false : stored('ReturnAlsoFound');
	
	#stored ('CheckNameVariants', search_options.CheckNameVariants);
  boolean BlanksFilledIn := search_options.BlanksFilledIn;
  #stored ('DoNotFillBlanks', ~BlanksFilledIn);
	
	// default Addr HRI to true, others to false
  boolean in_includeSSNHri := false : stored('IncludeSSNHri');	
  boolean in_includeAddrHri := true : stored('IncludeAddrHri');	
  boolean in_includePhoneHri := false : stored('IncludePhoneHri');	

	#stored ('UsePartialSSNMatch', search_options.UsePartialSSNMatch);
	boolean in_PartialSSNMatch := false : stored('UsePartialSSNMatch');	
	boolean in_allowEditDist := false : stored('CheckNameVariants');
	boolean in_IncludeCriminalIndicators := false : stored('IncludeCriminalIndicators');
	boolean in_EnhancedSort := false : stored('EnhancedSort');
	boolean in_IncludePhonesFeedback := false : STORED('IncludePhonesFeedback');
	boolean in_IncludeAddressFeedback := false : STORED('IncludeAddressFeedback');
	set of string in_IncludeSourceList := SET(search_options.IncludeSourceList, value);

  // Added for the FDN project, 1 new input option & 3 required input fields
	#stored ('IncludeFraudDefenseNetwork', search_options.IncludeFraudDefenseNetwork);
  boolean in_IncludeFraudDefenseNetwork := false : stored('IncludeFraudDefenseNetwork');
	unsigned6 in_FDN_gcid     := 0 : stored('GlobalCompanyId');
	unsigned2 in_FDN_indtype  := 0 : stored('IndustryType');
	unsigned6 in_FDN_prodcode := 0 : stored('ProductCode');

	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,PersonSearch_Services.Search_Records.params,opt))
		export returnAlsoFound := in_returnAlsoFound;
		export includeSSNHri := in_includeSSNHri;
		export includeAddrHri := in_includeAddrHri;
		export includePhoneHri := in_includePhoneHri;
		export allowPartialSSNMatch := in_PartialSSNMatch;
		export allowEditDist := in_allowEditDist; 
		export IncludeAlternatePhonesCount := in_IncludeAlternatePhonesCount;
		export includePhonesPlus := in_IncludePhonesPlus;
    export IncludeCriminalIndicators := in_IncludeCriminalIndicators;
		export EnhancedSort := in_EnhancedSort;
		export IncludePhonesFeedback := in_IncludePhonesFeedback;
		export IncludeAddressFeedback := in_IncludeAddressFeedback;
		export unsigned SourceDocFilter := doxie.SourceDocFilter.GetBitmask(in_IncludeSourceList);				
    // Added for the FDN project, 1 new input option & 3 required input fields
		export IncludeFraudDefenseNetwork  := in_IncludeFraudDefenseNetwork;
	  export unsigned6 FDNinput_gcid     := in_FDN_gcid;
	  export unsigned2 FDNinput_indtype  := in_FDN_indtype;
	  export unsigned6 FDNinput_prodcode := in_FDN_prodcode;
	end;

	tempresults := PersonSearch_Services.Search_Records.val(tempmod);
	FDN_check     := tempresults(FDNResultsFound=true);
  FDN_Royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(FDN_check);
  royalties     := if(tempmod.IncludeFraudDefenseNetwork, FDN_Royalties);
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, results, 
                         iesp.bpssearch.t_BpsSearchResponse, Records, false, SubjectTotalCount);

  output(royalties,named('RoyaltySet'));
  output(results,named('Results'));

ENDMACRO;
//PersonSearchService();
/*
<BpsSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
	<DataRestrictionMask>0000000000000000000000000</DataRestrictionMask>
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
<Options>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <UseNicknames>1</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
  <UsePartialSSNMatch>0</UsePartialSSNMatch>
  <IncludeSourceDocCounts>0</IncludeSourceDocCounts>
	<IncludeSourceList/>
  <IncludePriorAddresses>0</IncludePriorAddresses>
  <IncludeBankruptcy>0</IncludeBankruptcy>
  <IncludeAllUniqueIdRecords>0</IncludeAllUniqueIdRecords>
	<IncludeFraudDefenseNetwork>0</IncludeFraudDefenseNetwork>
</Options>
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
</row>
</BpsSearchRequest>
*/