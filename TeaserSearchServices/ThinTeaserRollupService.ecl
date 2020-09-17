/*--SOAP--
<message name="ThinTeaserRollupService">
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
  <part name="UniqueId" type="xsd:unsignedInt"/>
  <separator />
  <part name="ReturnCount" type="xsd:unsignedInt"/>
  <part name="StartingRecord" type="xsd:unsignedInt"/>
  <separator />
  <part name="IncludeFullHistory" type="xsd:boolean"/>
  <part name="IncludeAllAddresses" type="xsd:boolean"/>
  <part name="IncludeRelativeNames" type="xsd:boolean"/>
  <part name="AlwaysReturnRecords" type="xsd:boolean"/>
  
  <part name="ForceLogging" type="xsd:boolean"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="DtcPhoneAddressTeaserMask" type="xsd:boolean"/>
  <part name="IncludePhones" type="xsd:boolean"/>
  <part name="IncludePhoneNumber" type="xsd:boolean"/>
  <part name="IncludeAddress" type="xsd:boolean"/>
  <part name="IncludeEmailAddress" type="xsd:boolean"/>
  <part name="IncludeEducationInformation" type="xsd:boolean"/>
<part name="IncludeDtcCounts" type="xsd:boolean"/>
  <separator />
  <part name="ThinRollupPersonExtendedSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Special Thin teaser extended search (originally developed for Intelius) cloned from the ThinTeaserService.
*/
IMPORT iesp, AutoStandardI, doxie, Royalty;
EXPORT ThinTeaserRollupService := MACRO
  
  rec_in := iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('ThinRollupPersonExtendedSearchRequest', FEW);
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
  // this sets DID by 'uniqueID' input
  iesp.ECL2ESP.SetInputReportBy (report_by, clean_inputs);

  #STORED ('ZipRadius', search_by.ZipRadius);
  #STORED ('AgeLow', search_by.AgeRange.Low);
  #STORED ('AgeHigh', search_by.AgeRange.High);
  #STORED ('RelaxedMiddleNameMatch', search_options.RelaxedMiddleNameMatch);
  BOOLEAN in_RelaxedMiddleNameMatch := FALSE : STORED('RelaxedMiddleNameMatch');
  #STORED ('IncludeFullHistory', search_options.IncludeFullHistory);
  BOOLEAN in_IncludeFullHistory := FALSE : STORED('IncludeFullHistory');
  #STORED ('IncludeAllAddresses', search_options.IncludeAllAddresses);
  BOOLEAN in_IncludeAllAddresses := FALSE : STORED('IncludeAllAddresses');
  #STORED ('IncludeRelativeNames', search_options.IncludeRelativeNames);
  BOOLEAN in_IncludeRelativeNames := FALSE : STORED('IncludeRelativeNames');
  #STORED ('AlwaysReturnRecords', search_options.AlwaysReturnRecords);
  BOOLEAN in_AlwaysReturnRecords := FALSE : STORED('AlwaysReturnRecords');
  #STORED ('IncludePhones', search_options.IncludePhones);
  BOOLEAN in_IncludePhones := FALSE : STORED('IncludePhones');
  
  // new option all mask or non mask
  #STORED ('IncludePhoneNumber', search_options.IncludePhoneNumber);
  BOOLEAN in_IncludePhoneNumber := FALSE : STORED('IncludePhoneNumber');
  // new option for includingAddress possibly Masked or not include AddressMasked
  #STORED ('IncludeAddress', search_options.IncludeAddress);
  BOOLEAN in_IncludeAddress := FALSE : STORED('IncludeAddress');
  
    // new option for includingEmailAddress possibly Masked or not.
  #STORED ('IncludeEmailAddress', search_options.IncludeEmailAddress);
  BOOLEAN in_IncludeEmailAddress := FALSE : STORED('IncludeEmailAddress');
  
  #STORED ('IncludeEducationInformation', search_options.IncludeEducationInformation);
  BOOLEAN in_IncludeEducationInformation := FALSE : STORED('IncludeEducationInformation');
   // end new additions.
  
  #STORED ('IncludeDtcCounts', search_options.IncludeDtcCounts);
  INTEGER in_IncludeDtcCounts := 1 : STORED('IncludeDtcCounts');
   // end new additions.
  
  #STORED ('ForceLogging', search_options.ForceLogging);
  BOOLEAN in_ForceLogging := FALSE : STORED('ForceLogging');
  // forceLogging := random()%100000=1 or in_ForceLogging; //Log an event roughly 1 in every 100k occurances or when forced to
  forceLogging := in_ForceLogging OR search_options.ForceLogging; //above line commented due to esp team handling the random logging
  
  // new option for includingPhone possibly Masked or not include PhoneNumberMasked
  // or include addressMasked Defaults to FALSE in MBS (master billing system)
  #STORED ('DtcPhoneAddressTeaserMask', Search_options.DtcPhoneAddressTeaserMask);
  // in MBS the DctPhoneAddressTeaserMask is set as follows
  // value of 0 or non existence means to Mask and value of 1 means not to mask
  // so thus below logic in next 2 lines is coded to flip the value of this boolean
  // IF its passed in from ESP to roxie. Defaults to False which means to Mask in roxie output
  BOOLEAN InFROMESP_DtcPhoneAddressTeaserMask := FALSE : STORED('DtcPhoneAddressTeaserMask');
     BOOLEAN In_DtcPhoneAddressTeaserMask := NOT(InFROMESP_DtcPhoneAddressTeaserMask);
  
  #STORED ('SortAgeRange', search_options.SortAgeRange);
  BOOLEAN in_SortAgeRange := FALSE : STORED('SortAgeRange');
  
  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (input_params);
  tempmod := MODULE(PROJECT(input_params,TeaserSearchServices.Search_Records.params,OPT))
    EXPORT IncludeAllAddresses := in_IncludeAllAddresses;
    EXPORT IncludeFullHistory := IF(IncludeAllAddresses, TRUE, in_IncludeFullHistory);
    EXPORT IncludeRelativeNames := in_IncludeRelativeNames;
    EXPORT IncludePhoneIndicator := in_IncludePhones;
    EXPORT DtcPhoneAddressTeaserMask := In_DtcPhoneAddressTeaserMask;
    EXPORT IncludePhoneNumber := in_IncludePhoneNumber;
    EXPORT IncludeAddress := in_IncludeAddress;
    EXPORT IncludeEmailAddress := in_IncludeEmailAddress;
    EXPORT IncludeEducationInformation := in_IncludeEducationInformation;
    EXPORT IncludeDtcCounts := in_IncludeDtcCounts;
    EXPORT RelaxedMiddleNameMatch := in_RelaxedMiddleNameMatch;
    EXPORT AlwaysReturnRecords := in_AlwaysReturnRecords;
    EXPORT applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
    EXPORT SortAgeRange := in_SortAgeRange;
  END;
  
  tempresults := TeaserSearchServices.Search_Records.val(tempmod);
  // get Additional data
  w_additional_data := TeaserSearchServices.Functions.GetAdditionalData(
    tempresults,
    tempmod.IncludeAllAddresses,
    tempmod.IncludeFullHistory,
    in_IncludePhones,
    tempmod.DtcPhoneAddressTeaserMask,
    tempmod.IncludePhoneNumber,
    tempmod.IncludeAddress,
    tempmod.IncludeEmailAddress,
    tempmod.IncludeEducationInformation,
    tempmod.ApplicationType);
  w_additional_data_Counts := TeaserSearchServices.Functions.GetCounts(
    w_additional_data,
    tempmod.IncludeDtcCounts,
    tempmod.ApplicationType);
  
  lastRec:=COUNT(tempresults);
  lastID:=tempresults[lastrec].UniqueId;
  getExtendedFakeAddress := IF(forceLogging,TeaserSearchServices.Functions.getExtendedFakeAddress(w_additional_data_Counts[lastRec]));
  //Verify Addresses size and Addend Data for extended version
  iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord appendExtendedFakeData(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord inrec, INTEGER c) := TRANSFORM
    INTEGER4 CntAddresses := COUNT(inrec.Addresses);
    newAddress:=IF(CntAddresses+1> iesp.Constants.ThinRpsExt.MaxAddresses,inrec.Addresses[1..CntAddresses-1]+getExtendedFakeAddress,inrec.Addresses+getExtendedFakeAddress);
    SELF.addresses := IF(c=lastRec,newAddress,inrec.Addresses);
    SELF := inrec;
  END;
  w_additional_dataPlus := IF(in_ForceLogging,PROJECT(w_additional_data_Counts,appendExtendedFakeData(LEFT,COUNTER)), w_additional_data_Counts);
  
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(w_additional_dataPlus, results,
    iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchResponse, Records,
    FALSE, RecordCount,,,iesp.Constants.ThinRpsExt.MaxRespRecords);
  
  OUTPUT(results, NAMED('Results'));
  // Generate Royalty Billing information if this is ForceLogging event
  Royalty.MAC_RoyaltyTeaser(getExtendedFakeAddress, royalties, lastID);
  IF(forceLogging, OUTPUT(royalties, NAMED('RoyaltySet')));
  
ENDMACRO;
  
// TeaserSearchServices.ThinTeaserRollupService()
