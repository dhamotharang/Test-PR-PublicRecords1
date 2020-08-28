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
  <part name="ReturnCount" type="xsd:unsignedInt"/>
  <part name="StartingRecord" type="xsd:unsignedInt"/>
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
  <part name="ApplicationType" type="xsd:string"/>
  <separator />
  <part name="ThinRollupPersonSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Special Thin teaser search (originally developed for PSM).
*/

IMPORT AutoStandardI, iesp, Royalty, TeaserSearchServices;
EXPORT ThinTeaserService := MACRO

  rec_in := iesp.thinrolluppersonsearch.t_ThinRollupPersonSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('ThinRollupPersonSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  //set main search criteria:
  search_by := GLOBAL (first_row.SearchBy);
  search_options := GLOBAL (first_row.Options);
  
  user_info := GLOBAL(first_row.User);

  search_options_ex := ROW(search_options, TRANSFORM(iesp.share.t_BaseSearchOptionEx, SELF := LEFT, SELF := []));
  iesp.ECL2ESP.SetInputSearchOptions(search_options_ex);

  // this will set SSN, DID, Name and Address
  report_by := ROW (search_by, TRANSFORM (iesp.bpsreport.t_BpsReportBy, SELF := LEFT; SELF := []));

  clean_inputs := FALSE;
  iesp.ECL2ESP.SetInputReportBy (report_by, clean_inputs);

  #STORED ('ZipRadius', search_by.ZipRadius);
  #STORED ('AgeLow', search_by.AgeRange.Low);
  #STORED ('AgeHigh', search_by.AgeRange.High);

  #STORED ('RelaxedMiddleNameMatch', search_options.RelaxedMiddleNameMatch);
  BOOLEAN in_RelaxedMiddleNameMatch := FALSE : STORED('RelaxedMiddleNameMatch');
  #STORED ('PreferredUniqueId', search_options.PreferredUniqueId);
  STRING in_PreferredUniqueId := '' : STORED('PreferredUniqueId');
  #STORED ('IncludeFullHistory', search_options.IncludeFullHistory);
  BOOLEAN in_IncludeFullHistory := FALSE : STORED('IncludeFullHistory');
  #STORED ('IncludeAllAddresses', search_options.IncludeAllAddresses);
  BOOLEAN in_IncludeAllAddresses := FALSE : STORED('IncludeAllAddresses');
  #STORED ('IncludeRelativeNames', search_options.IncludeRelativeNames);
  BOOLEAN in_WidenSearchResults := FALSE : STORED('WidenSearchResults');
  #STORED ('WidenSearchResults', search_options.WidenSearchResults);
  BOOLEAN in_IncludeRelativeNames := FALSE : STORED('IncludeRelativeNames');
  #STORED ('AlwaysReturnRecords', search_options.AlwaysReturnRecords);
  BOOLEAN in_AlwaysReturnRecords := FALSE : STORED('AlwaysReturnRecords');
  #STORED ('IncludePhoneIndicator', search_options.IncludePhoneIndicator);
  BOOLEAN in_IncludePhoneIndicator := FALSE : STORED('IncludePhoneIndicator');
  #STORED ('IncludePhones', search_options.IncludePhones);
  BOOLEAN in_IncludePhones := FALSE : STORED('IncludePhones');
  
   #STORED ('SortAgeRange', search_options.SortAgeRange);
  BOOLEAN in_SortAgeRange := FALSE : STORED('SortAgeRange');

  #STORED ('ForceLogging', search_options.ForceLogging);
  BOOLEAN in_ForceLogging := FALSE : STORED('ForceLogging');
// forceLogging := random()%100000=1 or in_ForceLogging; //Log an event roughly 1 in every 100k occurances or when forced to
  forceLogging := in_ForceLogging OR search_options.ForceLogging; //above line commented due to esp team handling the random logging

  input_params := AutoStandardI.GlobalModule();
  tempmod := MODULE(PROJECT(input_params,TeaserSearchServices.Search_Records.params,OPT))
    EXPORT IncludeAllAddresses := in_IncludeAllAddresses;
    EXPORT WidenSearchResults := in_WidenSearchResults;
    EXPORT IncludeFullHistory := IF(IncludeAllAddresses, TRUE, in_IncludeFullHistory);
    EXPORT IncludeRelativeNames := in_IncludeRelativeNames;
    EXPORT IncludePhoneIndicator := in_IncludePhoneIndicator;
    EXPORT IncludePhones := in_IncludePhones;
    EXPORT RelaxedMiddleNameMatch := in_RelaxedMiddleNameMatch;
    EXPORT AlwaysReturnRecords := in_AlwaysReturnRecords;
    EXPORT applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
    EXPORT PreferredUniqueId := in_PreferredUniqueId;
    EXPORT SortAgeRange := in_SortAgeRange;
  END;

  tempresults := TeaserSearchServices.Search_Records.val(tempmod);

  lastRec:=COUNT(tempresults);
  lastID:=tempresults[lastrec].UniqueId;
  getfakeAddress := IF(forceLogging,TeaserSearchServices.Functions.getFakeAddress(tempresults[lastRec]));
  //Verify Addresses size and Addend Data
  TeaserSearchServices.Layouts.records appendFakeData(TeaserSearchServices.Layouts.records inrec, INTEGER c) := TRANSFORM
    INTEGER4 CntAddresses := COUNT(inrec.Addresses);
    newAddress:=IF(CntAddresses+1>iesp.Constants.ThinRps.MaxCountAddresses,inrec.Addresses[1..CntAddresses-1]+getfakeAddress,inrec.Addresses+getfakeAddress);
    SELF.addresses := IF(c=lastRec,newAddress,inrec.Addresses);
    SELF := inrec;
  END;
  tempresultsPlus := IF(in_ForceLogging,PROJECT(tempresults,appendFakeData(LEFT,COUNTER)),tempresults);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresultsPlus, results,
                         iesp.thinrolluppersonsearch.t_ThinRollupPersonSearchResponse, Records,
                         FALSE, RecordCount,,,iesp.Constants.ThinRps.MaxCountResponseRecords);

  OUTPUT(results, NAMED('Results'));
  // Generate Royalty Billing information if this is ForceLogging event
  Royalty.MAC_RoyaltyTeaser(getfakeAddress, royalties, lastID);
  IF(forceLogging, OUTPUT(royalties, NAMED('RoyaltySet')));


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

