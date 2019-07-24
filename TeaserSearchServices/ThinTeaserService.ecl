/*--SOAP--
<message name="ThinTeaserService">	
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
	<part name="RelaxedMiddleNameMatch" type="xsd:boolean"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <separator />
	<part name="ReturnCount"				 type="xsd:unsignedInt"/>
	<part name="StartingRecord"			 type="xsd:unsignedInt"/>	
  <separator />
	<part name="PreferredUniqueId" type="xsd:string"/>
	<part name="IncludeFullHistory" type="xsd:boolean"/>
	<part name="IncludeAllAddresses" type="xsd:boolean"/>
	<part name="WidenSearchResults" type="xsd:boolean"/>
	<part name="IncludeRelativeNames" type="xsd:boolean"/>
	<part name="AlwaysReturnRecords" type="xsd:boolean"/>
	<part name="IncludePhoneIndicator" type="xsd:boolean"/>
	<part name="IncludePhones" type="xsd:boolean"/>
	<part name="ForceLogging" type="xsd:boolean"/>  
     <part name="SortAgeRange" type="xsd:boolean"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <separator />
	<part name="ThinRollupPersonSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Special Thin teaser search (originally developed for PSM).
*/

IMPORT AutoStandardI, iesp, Royalty, TeaserSearchServices;
export ThinTeaserService := MACRO

  rec_in := iesp.thinrolluppersonsearch.t_ThinRollupPersonSearchRequest;
	ds_in := DATASET ([], rec_in) : STORED ('ThinRollupPersonSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
	search_by := global (first_row.SearchBy);
	search_options := global (first_row.Options);
	
	user_info := global(first_row.User);

	search_options_ex := ROW(search_options, transform(iesp.share.t_BaseSearchOptionEx, self := left, self := []));
	iesp.ECL2ESP.SetInputSearchOptions(search_options_ex);

  // this will set SSN, DID, Name and Address
  report_by := ROW (search_by, transform (iesp.bpsreport.t_BpsReportBy, Self := Left; Self := []));

	clean_inputs := false;
  iesp.ECL2ESP.SetInputReportBy (report_by, clean_inputs);

	#stored ('ZipRadius', search_by.ZipRadius);
	#stored ('AgeLow', search_by.AgeRange.Low);
	#stored ('AgeHigh', search_by.AgeRange.High);

	#stored ('RelaxedMiddleNameMatch', search_options.RelaxedMiddleNameMatch);
	boolean in_RelaxedMiddleNameMatch := false : stored('RelaxedMiddleNameMatch');		
  #stored ('PreferredUniqueId', search_options.PreferredUniqueId);
  string in_PreferredUniqueId := '' : stored('PreferredUniqueId');	
  #stored ('IncludeFullHistory', search_options.IncludeFullHistory);
  boolean in_IncludeFullHistory := false : stored('IncludeFullHistory');	
	#stored ('IncludeAllAddresses', search_options.IncludeAllAddresses);
  boolean in_IncludeAllAddresses := false : stored('IncludeAllAddresses');
  #stored ('IncludeRelativeNames', search_options.IncludeRelativeNames);
  boolean in_WidenSearchResults := false : stored('WidenSearchResults');
  #stored ('WidenSearchResults', search_options.WidenSearchResults);	
  boolean in_IncludeRelativeNames := false : stored('IncludeRelativeNames');
  #stored ('AlwaysReturnRecords', search_options.AlwaysReturnRecords);
  boolean in_AlwaysReturnRecords := false : stored('AlwaysReturnRecords');	
  #stored ('IncludePhoneIndicator', search_options.IncludePhoneIndicator);
  boolean in_IncludePhoneIndicator := false : stored('IncludePhoneIndicator');	
  #stored ('IncludePhones', search_options.IncludePhones);
  boolean in_IncludePhones := false : stored('IncludePhones');	
	
	 #stored ('SortAgeRange', search_options.SortAgeRange);
  boolean in_SortAgeRange := false : stored('SortAgeRange');

	#stored ('ForceLogging', search_options.ForceLogging);
  boolean in_ForceLogging := false : stored('ForceLogging');	
//	forceLogging := random()%100000=1 or in_ForceLogging; //Log an event roughly 1 in every 100k occurances or when forced to
	forceLogging := in_ForceLogging or search_options.ForceLogging; //above line commented due to esp team handling the random logging

	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,TeaserSearchServices.Search_Records.params,opt))
		export IncludeAllAddresses := in_IncludeAllAddresses;
		export WidenSearchResults := in_WidenSearchResults;
		export IncludeFullHistory := IF(IncludeAllAddresses, true, in_IncludeFullHistory);
		export IncludeRelativeNames := in_IncludeRelativeNames;		
		export IncludePhoneIndicator := in_IncludePhoneIndicator;
		export IncludePhones := in_IncludePhones;
		export RelaxedMiddleNameMatch := in_RelaxedMiddleNameMatch;
		export AlwaysReturnRecords := in_AlwaysReturnRecords;
		export applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		export PreferredUniqueId := in_PreferredUniqueId;
		export SortAgeRange :=  in_SortAgeRange;
	end;

	tempresults := TeaserSearchServices.Search_Records.val(tempmod);

	lastRec:=count(tempresults);
	lastID:=tempresults[lastrec].UniqueId;
	getfakeAddress := if(forceLogging,TeaserSearchServices.Functions.getFakeAddress(tempresults[lastRec]));
	//Verify Addresses size and Addend Data
	TeaserSearchServices.Layouts.records appendFakeData(TeaserSearchServices.Layouts.records inrec, integer c) := transform
		integer4 CntAddresses := count(inrec.Addresses);
		newAddress:=if(CntAddresses+1>iesp.Constants.ThinRps.MaxCountAddresses,inrec.Addresses[1..CntAddresses-1]+getfakeAddress,inrec.Addresses+getfakeAddress);
		self.addresses := if(c=lastRec,newAddress,inrec.Addresses);
		self := inrec;
	end;
	tempresultsPlus := if(in_ForceLogging,project(tempresults,appendFakeData(left,counter)),tempresults);


	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresultsPlus, results, 
                         iesp.thinrolluppersonsearch.t_ThinRollupPersonSearchResponse, Records, 
												 false, RecordCount,,,iesp.Constants.ThinRps.MaxCountResponseRecords);

	output(results, NAMED('Results'));
	// Generate Royalty Billing information if this is ForceLogging event
	Royalty.MAC_RoyaltyTeaser(getfakeAddress, royalties, lastID);	
	if(forceLogging, output(royalties, named('RoyaltySet')));


ENDMACRO;
// ThinTeaserService();


/*
<ThinRollupPersonSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>	
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
  <Phone10></Phone10>
	<ZipRadius></ZipRadius>
  <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DOB>	
  <AgeRange>
    <Low></Low>
    <High></High>
  </AgeRange>	
</SearchBy>
<Options>
	<PreferredUniqueId></PreferredUniqueId>
  <WidenSearchResults>0</WidenSearchResults>
	<IncludePhoneIndicator>0</IncludePhoneIndicator>
	<IncludePhones>0</IncludePhones>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <UseNicknames>1</UseNicknames>
  <UsePhonetics>0</UsePhonetics>
  <IncludeFullHistory>1</IncludeFullHistory>
  <IncludeRelativeNames>1</IncludeRelativeNames>
  <AlwaysReturnRecords>0</AlwaysReturnRecords>
<SortAgeRange>0</SortAgeRange>
</Options>
</row>
</ThinRollupPersonSearchRequest>
*/

