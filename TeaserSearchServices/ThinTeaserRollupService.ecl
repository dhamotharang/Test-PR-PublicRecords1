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
	<part name="ReturnCount"				 type="xsd:unsignedInt"/>
	<part name="StartingRecord"			 type="xsd:unsignedInt"/>	
  <separator />
	<part name="IncludeFullHistory" type="xsd:boolean"/>
	<part name="IncludeAllAddresses" type="xsd:boolean"/>
	<part name="IncludeRelativeNames" type="xsd:boolean"/>
	<part name="AlwaysReturnRecords" type="xsd:boolean"/>
  
	<part name="ForceLogging" type="xsd:boolean"/>  
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="DtcPhoneAddressTeaserMask" type="xsd:boolean"/>
  <part name="IncludePhones" type="xsd:boolean"/>
  <part name="IncludePhoneNumber" type="xsd:boolean"/>
  <part name="IncludeAddress"     type="xsd:boolean"/>
  <part name="IncludeEmailAddress" type="xsd:boolean"/>
  <part name="IncludeEducationInformation" type="xsd:boolean"/>
<part name="IncludeDtcCounts" type="xsd:boolean"/>
  <separator />
	<part name="ThinRollupPersonExtendedSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Special Thin teaser extended search (originally developed for Intelius) cloned from the ThinTeaserService.
*/
import iesp, AutoStandardI, ut, doxie, Royalty;
export ThinTeaserRollupService := MACRO
	
  rec_in := iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRequest;
	ds_in := DATASET ([], rec_in) : STORED ('ThinRollupPersonExtendedSearchRequest', FEW);
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
	// this sets DID by 'uniqueID' input
  iesp.ECL2ESP.SetInputReportBy (report_by, clean_inputs);

	#stored ('ZipRadius', search_by.ZipRadius);
	#stored ('AgeLow', search_by.AgeRange.Low);
	#stored ('AgeHigh', search_by.AgeRange.High);
	#stored ('RelaxedMiddleNameMatch', search_options.RelaxedMiddleNameMatch);
	boolean in_RelaxedMiddleNameMatch := false : stored('RelaxedMiddleNameMatch');		
  #stored ('IncludeFullHistory', search_options.IncludeFullHistory);
  boolean in_IncludeFullHistory := false : stored('IncludeFullHistory');	
	#stored ('IncludeAllAddresses', search_options.IncludeAllAddresses);
  boolean in_IncludeAllAddresses := false : stored('IncludeAllAddresses');
  #stored ('IncludeRelativeNames', search_options.IncludeRelativeNames);
  boolean in_IncludeRelativeNames := false : stored('IncludeRelativeNames');
  #stored ('AlwaysReturnRecords', search_options.AlwaysReturnRecords);
  boolean in_AlwaysReturnRecords := false : stored('AlwaysReturnRecords');	
  #stored ('IncludePhones', search_options.IncludePhones);
  boolean in_IncludePhones := false : stored('IncludePhones');	
	
	// new option all mask or non mask
	#stored ('IncludePhoneNumber', search_options.IncludePhoneNumber);
  boolean in_IncludePhoneNumber := false : stored('IncludePhoneNumber');	
	// new option for includingAddress possibly Masked or not include AddressMasked
	#stored ('IncludeAddress', search_options.IncludeAddress);
  boolean in_IncludeAddress := false : stored('IncludeAddress');	
	
		// new option for includingEmailAddress possibly Masked or not.
	#stored ('IncludeEmailAddress', search_options.IncludeEmailAddress);
  boolean in_IncludeEmailAddress := false : stored('IncludeEmailAddress');
	
	#stored ('IncludeEducationInformation', search_options.IncludeEducationInformation);
  boolean in_IncludeEducationInformation := false : stored('IncludeEducationInformation');	
 	// end new additions.
	
	#stored ('IncludeDtcCounts', search_options.IncludeDtcCounts);
  integer in_IncludeDtcCounts := 1 : stored('IncludeDtcCounts');	
 	// end new additions.
	
	#stored ('ForceLogging', search_options.ForceLogging);
  boolean in_ForceLogging := false : stored('ForceLogging');	
	// forceLogging := random()%100000=1 or in_ForceLogging; //Log an event roughly 1 in every 100k occurances or when forced to
	forceLogging := in_ForceLogging or search_options.ForceLogging; //above line commented due to esp team handling the random logging
	
	// new option for includingPhone possibly Masked or not include PhoneNumberMasked
	// or include addressMasked  Defaults to FALSE in MBS (master billing system)
	#stored ('DtcPhoneAddressTeaserMask', Search_options.DtcPhoneAddressTeaserMask);	
	// in MBS the DctPhoneAddressTeaserMask is set as follows
	// value of 0 or non existence means to Mask and value of 1 means not to mask
	// so thus below logic in next 2 lines is coded to flip the value of this boolean
	// IF its passed in from ESP to roxie.  Defaults to False which means to Mask in roxie output
	boolean InFROMESP_DtcPhoneAddressTeaserMask := false : stored('DtcPhoneAddressTeaserMask');
  boolean In_DtcPhoneAddressTeaserMask := NOT(InFROMESP_DtcPhoneAddressTeaserMask);
	input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (input_params);
	tempmod := module(project(input_params,TeaserSearchServices.Search_Records.params,opt))
		export IncludeAllAddresses := in_IncludeAllAddresses;
		export IncludeFullHistory := IF(IncludeAllAddresses, true, in_IncludeFullHistory);
		export IncludeRelativeNames := in_IncludeRelativeNames;		
		export IncludePhoneIndicator := in_IncludePhones;
		export DtcPhoneAddressTeaserMask := In_DtcPhoneAddressTeaserMask;
		export IncludePhoneNumber := in_IncludePhoneNumber;
		export IncludeAddress := in_IncludeAddress;		
		export IncludeEmailAddress := in_IncludeEmailAddress;		
		export IncludeEducationInformation := in_IncludeEducationInformation;
		export IncludeDtcCounts               := in_IncludeDtcCounts;
		export RelaxedMiddleNameMatch := in_RelaxedMiddleNameMatch;
		export AlwaysReturnRecords := in_AlwaysReturnRecords;
		export applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;
	
	tempresults := TeaserSearchServices.Search_Records.val(tempmod);
	// get Additional data
	w_additional_data := TeaserSearchServices.Functions.GetAdditionalData(tempresults, 
																																				tempmod.IncludeAllAddresses, 
																																				tempmod.IncludeFullHistory, 
																																				in_IncludePhones,
																																				tempmod.DtcPhoneAddressTeaserMask,		
																																				tempmod.IncludePhoneNumber,
																																				tempmod.IncludeAddress,
																																				tempmod.IncludeEmailAddress,		
																																				tempmod.IncludeEducationInformation,
																																				tempmod.ApplicationType);
  w_additional_data_Counts := TeaserSearchServices.Functions.GetCounts(w_additional_data,
	                                                                   tempmod.IncludeDtcCounts,
																																		 tempmod.ApplicationType);
	
	lastRec:=count(tempresults);
	lastID:=tempresults[lastrec].UniqueId;
	getExtendedFakeAddress := if(forceLogging,TeaserSearchServices.Functions.getExtendedFakeAddress(w_additional_data_Counts[lastRec]));
	//Verify Addresses size and Addend Data for extended version
	iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord appendExtendedFakeData(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord inrec, integer c) := transform
		integer4 CntAddresses := count(inrec.Addresses);
		newAddress:=if(CntAddresses+1> iesp.Constants.ThinRpsExt.MaxAddresses,inrec.Addresses[1..CntAddresses-1]+getExtendedFakeAddress,inrec.Addresses+getExtendedFakeAddress);
		self.addresses := if(c=lastRec,newAddress,inrec.Addresses);
		self := inrec;
	end;
	w_additional_dataPlus := if(in_ForceLogging,project(w_additional_data_Counts,appendExtendedFakeData(left,counter)), w_additional_data_Counts);	
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(w_additional_dataPlus, results, 
                         iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchResponse, Records, 
												 false, RecordCount,,,iesp.Constants.ThinRpsExt.MaxRespRecords);
  // output(InFROMESP_DtcPhoneAddressTeaserMask, named('InFROMESP_DtcPhoneAddressTeaserMask'));												 
	//output(In_DtcPhoneAddressTeaserMask, named('In_DtcPhoneAddressTeaserMask'));
	// output(w_additional_data, named('w_additional_data'));
	// output(w_addition_data_counts, named('w_addition_data_counts'));
	//output(dtcCounts, named('dtcCounts'));
	output(results, named('Results'));
	IF (exists(results), doxie.compliance.logSoldToTransaction(mod_access));
	// Generate Royalty Billing information if this is ForceLogging event
	Royalty.MAC_RoyaltyTeaser(getExtendedFakeAddress, royalties, lastID);
	if(forceLogging, output(royalties, named('RoyaltySet')));
	
endmacro;
	
// TeaserSearchServices.ThinTeaserRollupService()