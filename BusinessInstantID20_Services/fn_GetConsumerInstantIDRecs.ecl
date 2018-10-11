import Address, AutoStandardI, Business_Risk_BIP, Census_Data, Codes, Gateway, iesp, 
       IntlIID, Models, Risk_Indicators, Riskwise, Royalty, Seed_Files, Suppress, ut;

// The following function obtains Consumer InstantID data for the Authorized Reps passed in. 
// Logic is basically copied-n-pasted straight from Risk_Indicators.InstantID_records, but
// modified a little to handle batch records.
EXPORT fn_GetConsumerInstantIDRecs( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_CleanedInput,
	                                  Business_Risk_BIP.LIB_Business_Shell_LIBIN Options ) := 
	FUNCTION

			Risk_indicators.MAC_unparsedfullname(title_val,fname_val,mname_val,lname_val,suffix_val,'FirstName','MiddleName','LastName','NameSuffix')

			boolean FromID2                             := false : STORED('FromID2');
			boolean FromFlexID                          := false : STORED('FromFlexID');
			string20 CompanyID                          := ''    : STORED('CompanyID');
			string128 In_CustomCVIModelName             := ''    : STORED('CustomCVIModelName');
			boolean IncludeMIoverride                   := false : STORED('IncludeMIoverride');
			boolean IncludeDOBInCVI                     := false : STORED('IncludeDOBInCVI');
			boolean IncludeDriverLicenseInCVI           := false : STORED('IncludeDriverLicenseInCVI');
			boolean DisableInquiriesInCVI               := false : STORED('DisableCustomerNetworkOptionInCVI');

			// Per Product Mgmt guidance, turn off Gateway calls to Targus here in CIID.
			boolean DisallowInsurancePhoneHeaderGateway := false : STORED('DisallowInsurancePhoneHeaderGateway');	
			boolean IncludeTargus3220                   := false; // : STORED('IncludeTargusE3220Gateway');

			boolean IIDVersionOverride                  := false : STORED('IIDVersionOverride');	// back office tag that, if true, allows a version lower than the lowestAllowedVersion
			string1 IIDVersion                          := '0'   : STORED('InstantIDVersion');	// this is passed in by the customer, but doesn't really do anything since everything is Version 1 right now


			// new temporary input field for KeyBank so that we can change the OFAC version to 3 for them, currently it is defaulted to 2.
			// Remove this when CIID enhancements are finished in Aug 2013, as everyone will have version 3 at this time
			string32 LoginID        := '' : STORED('LoginID');

			string30 account_value   := '' : STORED('AccountNumber');
			string120 addr1_val      := '' : STORED('StreetAddress');
			string200 addr2_val      := '' : STORED('Addr');
			// Parsed address input
			string10 PrimRange       := AutoStandardI.GlobalModule().primrange;
			string2 PreDir           := AutoStandardI.GlobalModule().predir;
			string28 Primname        := AutoStandardI.GlobalModule().primname;
			string4 AddrSuffix       := '' : STORED('AddrSuffix');
			string2 PostDir          := AutoStandardI.GlobalModule().postdir;
			string10 UnitDesignation := '' : STORED('UnitDesignation');
			string8 SecRange         := AutoStandardI.GlobalModule().secrange;

			addr_value := map( 
													trim(addr2_val)!='' => addr2_val,
													trim(addr1_val)!='' => addr1_val,
													Address.Addr1FromComponents(PrimRange, PreDir, PrimName, AddrSuffix, PostDir, UnitDesignation, SecRange)
													);

			string25 city_val      := '' : stored('City');
			string2 state_val      := '' : stored('State');
			// string5 zip_value      := '' : stored('Zip');
			string5 zip_value      := AutoStandardI.GlobalModule().zip;
			string25 country_value := '' : stored('Country');

			// string9 ssn_value := '' : stored('ssn');
			string9 ssn_value := AutoStandardI.GlobalModule().ssn;

			string8 dob_value   := '' : stored('DateOfBirth');
			unsigned1 age_value := 0 : stored('Age');

			STRING20 dl_number_value := '' : stored('DLNumber');
			STRING2 dl_state_value   := '' : stored('DLState');

			string100 email_value := '' : stored('Email');
			STRING45 ip_value     := '' : stored('IPAddress');

			string10 phone_value  := '' : stored('HomePhone');
			STRING10 wphone_value := '' : stored('WorkPhone');

			STRING100 employe_name_value := '' : stored('EmployerName');
			STRING30 prev_lname_value    := '' : stored('FormerName');

			// EVENTUALLY disable/remove all test data code below since it is being handled
			// elsewhere in BIID 2.0.
			boolean Test_Data_Enabled     := FALSE; // : stored('TestDataEnabled');
			string20 Test_Data_Table_Name := ''; //  : stored('TestDataTableName');
			
			string DataRestriction        := Options.DataRestrictionMask; 
			string DataPermission         := Options.DataPermissionMask;
			unsigned1 DPPA_Purpose        := Options.DPPA_Purpose;
			unsigned1 GLB_Purpose         := Options.GLBA_Purpose;
			STRING5 industry_class_val    := Options.IndustryClass;
				isUtility := StringLib.StringToUpperCase(industry_class_val) = 'UTILI';

			unsigned6	_HistoryDate         := 999999 : STORED('HistoryDate'); // Reads everything from YYYYMM to YYYYMMDDTTTT

			unsigned3 history_date         := (unsigned3)(((string)_HistoryDate)[1..6]);
			string20	historyDateTimeStamp := (string)_HistoryDate;  // new for shell 5.0
			boolean IsPOBoxCompliant       := false : stored('PoBoxCompliance');
			boolean ofac_only              := true : stored('OfacOnly');
			boolean ExcludeWatchLists      := false : stored('ExcludeWatchLists');
			unsigned1 OFAC_version_temp    := Options.OFAC_Version;
				OFAC_version := if(trim(stringlib.stringtolowercase(LoginID)) in ['keyxml','keydevxml'], 4, OFAC_version_temp);	// temporary code for Key Bank
			
			boolean Include_Additional_watchlists := Options.include_additional_watchlists;
			boolean Include_Ofac                  := Options.include_ofac;
			real global_watchlist_threshold_temp  := Options.Global_Watchlist_Threshold;
				global_watchlist_threshold          := if(OFAC_version=3 and global_watchlist_threshold_temp=0, 0.85, if(global_watchlist_threshold_temp=0, 0.84, global_watchlist_threshold_temp));
			boolean use_dob_filter                := FALSE : stored('UseDobFilter');
			integer2 dob_radius                   := 2 : stored('DobRadius');
			boolean FromIIDModel                  := false : stored('FromIIDModel');
			unsigned1 RedFlag_version             := 1 : stored('RedFlag_version');
			string6 ssnmask                       := 'NONE' : stored('SSNMask');
			string6 dobmask                       := 'NONE' : stored('DOBMask');
			unsigned1 dlmask                      := 0 : stored('DLMask');

			boolean IncludeAllRC     := false : stored('IncludeAllRiskIndicators');
			unsigned1 NumReturnCodes := if(IncludeAllRC, 255, risk_indicators.iid_constants.DefaultNumCodes);
			
			boolean ExactFirstNameMatch               := false : stored('ExactFirstNameMatch');
			boolean ExactLastNameMatch                := false : stored('ExactLastNameMatch');
			boolean ExactAddrMatch                    := false : stored('ExactAddrMatch');
			boolean ExactPhoneMatch                   := false : stored('ExactPhoneMatch');
			boolean ExactSSNMatch                     := false : stored('ExactSSNMatch');
			boolean ExactDOBMatch                     := false : stored('ExactDOBMatch');
			boolean ExactDriverLicenseMatch           := false : stored('ExactDriverLicenseMatch');
			boolean ExactFirstNameMatchAllowNicknames := false : stored('ExactFirstNameMatchAllowNicknames');

			string10 CustomDataFilter := '' : stored('CustomDataFilter');

			unsigned2 EverOccupant_PastMonths := 0 : stored('EverOccupant_PastMonths');
			unsigned4 EverOccupant_StartDate  := 99999999 : stored('EverOccupant_StartDate');
			boolean   IncludeNAPData          := false : stored('IncludeNAPData');

			unsigned3 LastSeenThresholdIn_pre := 0 : stored('LastSeenThreshold');
			unsigned3 LastSeenThresholdIn := IF( LastSeenThresholdIn_pre = 0, Risk_Indicators.iid_constants.oneyear, LastSeenThresholdIn_pre );

			// they want this customizable, so instead of doing an incremental ranking, use 1 or 0 for each element
				// everything defaulted to off would be '0000000'  
				// making this a string10 in case they decide to make it even more granular
				// 8.29.16 supporting RR-10560 :: Adding a 9th bit as flag to be used to alter addrScoring to only score based on primRange & Zip5
			string10 ExactMatchLevel := if(ExactFirstNameMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
													if(ExactLastNameMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
													if(ExactAddrMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
													if(ExactPhoneMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
													if(ExactSSNMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
													if(ExactDOBMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) +
													if(ExactFirstNameMatchAllowNicknames, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) +
													if(ExactDriverLicenseMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) +
													if(In_CustomCVIModelName='CCVI1609_1', Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse);  //Flag to alter address scoring/match logic to only consider Prim_Range & Zip5

			dob_radius_use := if(use_dob_filter,dob_radius,-1);
			boolean suppressNearDups := false;
			boolean require2ele := false;
			boolean fromBiid := false;
			boolean isFCRA := false;
			boolean ln_branded := false;
			boolean fromIT1O := false;
			boolean OFAC := true;	// used in cviScore override, CIID has been hardcoded to TRUE, so I am doing that here now


			// these new fields were asked to be added for fp 2.0, but we're not using them yet other than echoing them back
			string16 Channel                     := '' : stored('Channel');
			string8 Income                       := '' : stored('Income');
			string8 OwnOrRent                    := '' : stored('OwnOrRent');
			string16 LocationIdentifier          := '' : stored('LocationIdentifier');
			string16 OtherApplicationIdentifier  := '' : stored('OtherApplicationIdentifier');
			string16 OtherApplicationIdentifier2 := '' : stored('OtherApplicationIdentifier2');
			string16 OtherApplicationIdentifier3 := '' : stored('OtherApplicationIdentifier3');
			string8 DateofApplication            := '' : stored('DateofApplication');
			string8 TimeofApplication            := '' : stored('TimeofApplication');

			boolean IncludeDPBC      := false : stored('IncludeDPBC');
			boolean EnableEmergingID := false : stored('EnableEmergingID');

			// temp := record
					// dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
			// end;

			// watchlist_options             := dataset([],temp) : stored('WatchlistsRequested', few);
			// watchlist_options             := Options.Watchlists_Requested;
			// watchlists_request            := watchlist_options[1].WatchList;
			watchlists_request            := Options.Watchlists_Requested; // [1].value;
			boolean IncludeDLverification := false : stored('IncludeDLverification');
			string44 PassportUpperLine    := '' : stored('PassportUpperLine');
			string44 PassportLowerLine    := '' : stored('PassportLowerLine');
			string6 Gender                := '' : stored('Gender');
			unsigned6 UniqueId            := 0 : stored('UniqueId');
			boolean IncludeMSoverride     := false : stored('IncludeMSoverride');
			boolean IncludeCLoverride     := false : stored('IncludeCLoverride');
			boolean SearchSicNAICSCodes   := false : STORED('SearchSicNAICSCodes');

			// DOB options
			DOBMatchOptions_in_pre := DATASET([], iesp.businessinstantid20.t_BIID20DOBMatchOptions) : STORED('DOBMatchOptions',FEW);

			DOBMatchOptions_in := 
				PROJECT(
					DOBMatchOptions_in_pre, 
					TRANSFORM( risk_indicators.layouts.Layout_DOB_Match_Options,
						SELF.DOBMatch           := LEFT.MatchType;
						SELF.DOBMatchYearRadius := LEFT.MatchYearRadius;
					)
				);

			unsigned1 lowestAllowedVersion := 1;	// lowest allowed version according to product, unless the allowinstantidversionoverride is true
			unsigned1 maxAllowedVersion := 1;	// maximum allowed version as of 1/28/2014

			// calculate the actual iidVersion that will be used.  To start, versions 0 and 1 will be supported.  0 will represent the historical iid, while version 1 will
			// represent the new logic implemented for 1/28/2014 release (new cvi, phones plus, inquiries, insurance header, reason codes etc).  A new input tag will allow the customer
			// to choose the version they want to use.  This version cannot be lower than the lowest allowed version unless the override tag is set to true, in which case
			// the customer can choose any version and if no version is passed in, it will be considered version 0.
			actualIIDVersion := map((unsigned)IIDVersion > maxAllowedVersion => 99,	// they asked for a version that doesn't exist
															IIDVersionOverride = false => min(max((unsigned)IIDversion, lowestAllowedVersion), maxAllowedVersion),	// choose the higher of the allowed or asked for because they can't override lowestAllowedVersion, however, don't let them pick a version that is higher than the highest one we currently support
															(unsigned)IIDversion); // they can override, give them whatever they asked for
			
			if(actualIIDVersion = 99, FAIL('Not an allowable InstantIDVersion.  Currently versions 0 and 1 are supported'));																			

			// NOTE: for BIID 2.0 we're not running any models here.
/*
			model_url_pre := DATASET([],iesp.businessinstantid20.t_BIID20ScoreChooser) : STORED('scores',few);
			model_url := PROJECT(model_url_pre, Models.Layout_Score_Chooser);
*/
			model_url := DATASET([], Models.Layout_Score_Chooser);

      // Allow Gateway info for Bridger XG5 gateway and ONLY the Bridger gateway. UNTIL we 
      // get clarification from Product, turn off all other Gateway calls here in CIID.
      gateways := Options.Gateways; 
			
			rec := record
				unsigned4 seq;
				end;
			d := dataset([{(unsigned)account_value}],rec);


			// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
			boolean IsInstantID := true;
			reasoncode_settings := dataset([{IsInstantID, actualIIDVersion, EnableEmergingID}],riskwise.layouts.reasoncode_settings);
			actioncode_settings := dataset([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);

			// Check to see if Red Flags or Fraud Advisor Requested
			RedFlagsReq := redflag_version > 0;
			FraudDefenderReq := EXISTS(model_url(name='Models.FraudAdvisor_Service'));

			// check to see if custom CVI requested
			customCVIparams := project(model_url(StringLib.StringToLowerCase(name)='risk_indicators.instantid'), transform(models.layout_parameters, self := left.parameters[1]));
			customCVIvalue := trim(StringLib.StringToLowercase(customCVIparams(StringLib.StringToLowerCase(name)='custom')[1].value));

			//Check to see if new custom CVI field is populated with a valid value
			Valid_CCVI := StringLib.StringToUppercase(In_CustomCVIModelName) in ['','CCVI1501_1','CCVI1609_1'];
			CustomCVIModelName := if(Valid_CCVI, StringLib.StringToUppercase(In_CustomCVIModelName), error('Invalid Custom CVI model name.'));

			customfraud_params := project(model_url(StringLib.StringToLowerCase(name) in ['models.customfa_service', 'models.fraudadvisor_service']), transform(models.layout_parameters, self := left.parameters[1]));
			customfraud_modelname := trim(StringLib.StringToUppercase(customfraud_params(StringLib.StringToLowerCase(name) in ['custom', 'version'])[1].value));

			// -----[ Project formal parameter ds_CleanedInput into input for CIID. ]-----
			layout_temp := RECORD
				UNSIGNED4 OrigSeq         :=  0;
				UNSIGNED4 Seq             :=  0;
				UNSIGNED6 HistoryDate     :=  0;
				STRING100 CompanyName     := '';
				STRING120 bus_StreetAddress1 := '';
				STRING10  bus_Prim_Range  := '';
				STRING2   bus_PreDir      := '';
				STRING28  bus_Prim_Name   := '';
				STRING4   bus_Addr_Suffix := '';
				STRING2   bus_PostDir     := '';
				STRING10  bus_Unit_Desig  := '';
				STRING8   bus_Sec_Range   := '';
				STRING25  bus_P_City_Name := '';
				STRING25  bus_V_City_Name := '';
				STRING2   bus_St          := '';
				STRING5   bus_Zip5        := '';
				STRING4   bus_Zip4        := '';
				STRING10  bus_Lat         := '';
				STRING11  bus_Long        := '';
				STRING1   bus_Addr_Type   := ''; 
				STRING4   bus_Addr_Status := '';
				STRING3   bus_County      := '';
				STRING25  bus_City        := '';
				STRING2   bus_State       := '';
				STRING5   bus_Zip         := '';
				BusinessInstantID20_Services.layouts.InputAuthRepInfoClean;
			END;
			
			layout_temp xfm_NormAuthReps(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean le, BusinessInstantID20_Services.layouts.InputAuthRepInfoClean ri) :=
				TRANSFORM
					SELF.OrigSeq            := le.Seq;
					SELF.Seq                := le.Seq * 10 + ri.Rep_WhichOne;
					SELF.HistoryDate        := le.HistoryDate;
					SELF.CompanyName        := le.CompanyName;
					SELF.bus_StreetAddress1 := le.StreetAddress1;
					SELF.bus_Prim_Range     := le.Prim_Range;
					SELF.bus_PreDir         := le.PreDir;
					SELF.bus_Prim_Name      := le.Prim_Name;
					SELF.bus_Addr_Suffix    := le.Addr_Suffix;
					SELF.bus_PostDir        := le.PostDir;
					SELF.bus_Unit_Desig     := le.Unit_Desig;
					SELF.bus_Sec_Range      := le.Sec_Range;
					SELF.bus_P_City_Name    := le.P_City_Name;
					SELF.bus_V_City_Name    := le.V_City_Name;
					SELF.bus_St             := le.St;
					SELF.bus_Zip5           := le.Zip5;
					SELF.bus_Zip4           := le.Zip4;
					SELF.bus_Lat            := le.Lat;
					SELF.bus_Long           := le.Long;
					SELF.bus_Addr_Type      := le.Addr_Type; 
					SELF.bus_Addr_Status    := le.Addr_Status;
					SELF.bus_County         := le.County;
					SELF.bus_City           := le.City;  // input
					SELF.bus_State          := le.State; // input
					SELF.bus_Zip            := le.Zip;   // input
					SELF                    := ri;
				END;
			
			// Normalize the Auth Reps out of ds_CleanedInput.
			ds_Normed := NORMALIZE( ds_CleanedInput, LEFT.AuthReps, xfm_NormAuthReps(LEFT,RIGHT) );

			// Transform for input to Consumer InstantID function.
			//   o   If the AuthRep doesn't come with an address, use the Business address.
			//   o   Assumes that the HistoryDate has been cleaned/set already
			risk_indicators.layout_input into_rep(layout_temp le) := transform
				HistoryDate := (UNSIGNED3)(((STRING)le.HistoryDate)[1..6]);
				useBusAddr := le.Prim_Name = '';
				
				self.seq			        := le.Seq;
				self.historydate      := HistoryDate;
				self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp('', HistoryDate);
				self.fname 		        := le.FirstName;
				self.mname 		        := le.MiddleName;
				self.lname 		        := le.LastName;
				self.suffix		        := le.NameSuffix;
				self.in_streetaddress := IF( useBusAddr, le.bus_StreetAddress1, le.StreetAddress1 );
				self.in_city 		      := IF( useBusAddr, le.bus_City, le.City );
				self.in_state		      := IF( useBusAddr, le.bus_State, le.State );
				self.in_zipcode 	    := IF( useBusAddr, le.bus_Zip, le.Zip );
				self.in_country	      := ''; // not supplied on input yet
				self.prim_range	      := IF( useBusAddr, le.bus_Prim_Range, le.Prim_Range );
				self.predir		        := IF( useBusAddr, le.bus_PreDir, le.PreDir );
				self.prim_name		    := IF( useBusAddr, le.bus_Prim_Name, le.Prim_Name );
				self.addr_suffix	    := IF( useBusAddr, le.bus_Addr_Suffix, le.Addr_Suffix );
				self.postdir			    := IF( useBusAddr, le.bus_PostDir, le.PostDir );
				self.unit_desig		    := IF( useBusAddr, le.bus_Unit_Desig, le.Unit_Desig );
				self.sec_range		    := IF( useBusAddr, le.bus_Sec_Range, le.Sec_Range );
				self.p_city_name	    := IF( useBusAddr, le.bus_P_City_Name, le.P_City_Name );
				self.st				    	  := IF( useBusAddr, le.bus_St, le.St );
				self.z5				    	  := IF( useBusAddr, le.bus_Zip5, le.Zip5 );
				self.zip4				    	:= IF( useBusAddr, le.bus_Zip4, le.Zip4 );
				self.lat			        := IF( useBusAddr, le.bus_Lat, le.Lat );
				self.long			        := IF( useBusAddr, le.bus_Long, le.Long );
				self.addr_type		    := IF( useBusAddr, le.bus_Addr_Type, le.Addr_Type );
				self.addr_status	    := IF( useBusAddr, le.bus_Addr_Status, le.Addr_Status );
				self.country		      := '';
				self.county           := IF( useBusAddr, le.bus_County, le.County );
				self.dob			        := le.DateOfBirth;
				self.age			        := le.Age;
				self.ssn			        := le.SSN;
				self.phone10	        := le.Phone10;
				self.dl_number		    := le.DLNumber;
				self.dl_state		      := le.DLState;
				self.email_address	  := le.Email;
				self.wphone10		      := '';
				self.ip_address	      := '';
				self.employer_name	  := ''; // We must avoid doing an OFAC/Watchlist on company name.
				self.lname_prev	      := le.FormerLastName;
			end;

			prep := project(ds_Normed, into_rep(LEFT));
			
			// Changed to default to version 2 in order to get back ADL info used in Red Flags.
			unsigned1 BSversion := 51 : stored('BSVersion');
			boolean runSSNCodes := true;
			boolean runBestAddr := true;
			boolean runChronoPhone := true;
			boolean runAreaCodeSplit := true;
			// boolean allowCellPhones := gateways(servicename='targuse3220').url <> '';	// if targuse3220 gateway is available then allow cell phone searching, NOTE: idp1/idp3 mean something a little different
			boolean allowCellPhones := false;
			unsigned1 AppendBest := 1;		// search best file
			unsigned3 LastSeenThreshold := if(actualIIDVersion=1, LastSeenThresholdIn, Risk_Indicators.iid_constants.oneyear);	// ID2 uses this and now ciid v1 does
			boolean doInquiries := ~DisableInquiriesInCVI AND dataRestriction[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue AND
															actualIIDVersion=1;
			boolean AllowInsuranceDL := true;
			unsigned8 BSOptions := 	if(doInquiries, risk_indicators.iid_constants.BSOptions.IncludeInquiries, 0) +
															if(~DisallowInsurancePhoneHeaderGateway and actualIIDVersion=1, risk_indicators.iid_constants.BSOptions.IncludeInsNAP, 0) +
															if(actualIIDVersion=1, risk_indicators.iid_constants.BSOptions.IsInstantIDv1, 0) +  // check other products to make sure it is on and off appropriately, ID2 for example, BIID for example ********************************
															if(AllowInsuranceDL, risk_indicators.iid_constants.BSOptions.AllowInsuranceDLInfo, 0) + //check to allow use of Insurance DL information
															if(uniqueid<>0 and FromID2, Risk_Indicators.iid_constants.BSOptions.RetainInputDID,0) +
															if(EnableEmergingID, Risk_Indicators.iid_constants.BSOptions.EnableEmergingID,0);
																														
			ret := risk_indicators.InstantID_Function(prep, 
					gateways, 
					DPPA_Purpose, 
					GLB_Purpose, 
					isUtility, 
					ln_branded, 
					ofac_only, 
					suppressNearDups, 
					require2ele, 
					fromBiid, 
					isFCRA, 
					ExcludeWatchLists,
					fromIT1O,
					ofac_version,
					include_ofac,
					include_additional_watchlists,
					global_watchlist_threshold,
					dob_radius_use,
					BSversion,
					runSSNCodes,
					runBestAddr,
					runChronoPhone,
					runAreaCodeSplit,
					allowCellPhones,
					ExactMatchLevel, 
					DataRestriction, 
					CustomDataFilter, 
					IncludeDLverification, 
					watchlists_request, 
					DOBMatchOptions_in, 
					EverOccupant_PastMonths, 
					EverOccupant_StartDate, 
					AppendBest, 
					BSOptions, 
					LastSeenThreshold,
					CompanyID, 
					DataPermission, 
					IncludeNAPData);

			targus := Royalty.RoyaltyTargus.GetOnlineRoyalties(UNGROUP(ret), src, TargusType, TRUE, FALSE, FALSE, TRUE);

			//Only get royalties for hitting the Insurance DL information if they are allowed to access the information
			Boolean TrackInsuranceRoyalties := Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission);
			insurance := If(TrackInsuranceRoyalties, Royalty.RoyaltyFDNDLDATA.GetWebRoyalties(UNGROUP(ret), did, insurance_dl_used, true));

			royalties4us := if(test_data_enabled, DATASET([], Royalty.Layouts.Royalty), 
				targus + insurance);	
				
			#stored('Royalties', royalties4us);	
																				
			ret_test_seed_un := risk_indicators.InstantID_Test_Function(Test_Data_Table_Name,fname_val,lname_val,ssn_value,zip_value,
																			 phone_value,Account_value, NumReturnCodes);
																															 
			ret_test_seed := project(ret_test_seed_un,transform(risk_indicators.Layout_InstantID_NuGenPlus, 
																													// strictly an inputecho of fields that are not mapped in the testseed function
																													self.mname := mname_val;
																													self.suffix := suffix_val;
																													SELF.in_streetAddress := addr_value;
																													SELF.in_city := city_val;
																													SELF.in_state := state_val;
																													SELF.in_country := country_value;
																													self.dob := dob_value;
																													SELF.dl_number := dl_number_value;
																													SELF.dl_state := dl_state_value;
																													self.PassportUpperLine := passportupperline ;
																													self.PassportLowerLine := passportlowerline ;
																													self.Gender := gender ; 
																													self.InstantIDVersion := (string)actualIIDVersion;
																													self := left));

			risk_indicators.layout_input into_test_prep(risk_indicators.Layout_InstantID_NuGenPlus l) := transform
				self.seq := l.seq;	// take seq from the ret_test_seed data as we will need it for joining to scores later.
				self.ssn := ssn_value;
				self.phone10 := phone_value;
				self.fname := stringlib.stringtouppercase(fname_val);
				self.lname := stringlib.stringtouppercase(lname_val);
				SELF.in_zipCode := zip_value;
				self := [];
			end;

			test_prep := PROJECT(ret_test_seed,into_test_prep(LEFT));																												 

			tscore(UNSIGNED1 i) := IF(i=255,0,i);


			risk_indicators.Layout_InstantID_NuGenPlus format_out(ret le) :=
			TRANSFORM
				SELF.acctNo := account_value;
				SELF.transaction_id := 0;

				self.verfirst := IF(le.combo_firstcount>0, le.combo_first, '');
				verlast := IF(le.combo_lastcount>0, le.combo_last, '');
				self.verlast := verlast;
				veraddr := IF(le.combo_addrcount>0, Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,
													le.combo_predir,le.combo_prim_name,le.combo_suffix,le.combo_postdir,le.combo_unit_desig,le.combo_sec_range),'');	
				SELF.veraddr := veraddr;	
				
				// clean the verified address to get the delivery point barcode information from the cleaner
				clean_ver_address := risk_indicators.MOD_AddressClean.clean_addr( veraddr, le.combo_city, le.combo_state, le.combo_zip ) ;
				// don't reference the clean fields unless the option to IncludeDPBC is turned on
				ver_zip5 := if(IncludeDPBC, clean_ver_address[117..121], le.combo_zip[1..5]);
				ver_zip4 := if(IncludeDPBC, clean_ver_address[122..125], le.combo_zip[6..9]);
				// delivery point barcode = zip5 + zip5 + barcode + check_digit
				ver_dpbc := ver_zip5 + ver_zip4 + clean_ver_address[136..138];  // include the 2 character code and 1 character check_digit
				
				// parsed verified address
				SELF.VerPrimRange := IF(le.combo_addrcount>0, le.combo_prim_range, '');
				SELF.VerPreDir := IF(le.combo_addrcount>0, le.combo_predir, '');
				SELF.VerPrimName := IF(le.combo_addrcount>0, le.combo_prim_name, '');
				SELF.VerAddrSuffix := IF(le.combo_addrcount>0, le.combo_suffix, '');
				SELF.VerPostDir := IF(le.combo_addrcount>0, le.combo_postdir, '');
				SELF.VerUnitDesignation := IF(le.combo_addrcount>0, le.combo_unit_desig, '');
				SELF.VerSecRange := IF(le.combo_addrcount>0, le.combo_sec_range, '');
				//
				SELF.vercity := IF(le.combo_addrcount>0, le.combo_city, '');
				SELF.verstate := IF(le.combo_addrcount>0, le.combo_state, '');
				SELF.verzip := IF(le.combo_addrcount>0, ver_zip5, '');
				SELF.verzip4 := IF(le.combo_addrcount>0, ver_zip4, '');
				self.verDPBC := if(le.combo_addrcount>0 and IncludeDPBC and ver_zip4<>'', ver_DPBC, '');
				SELF.vercounty := if(le.combo_addrcount>0, le.combo_county, '');
				SELF.verdob := IF(le.combo_dobcount>0, le.combo_dob, '');
				SELF.verssn := IF(le.combo_ssncount>0 and le.combo_ssnscore between 90 and 100, le.combo_ssn, '');// i don't think we want to output the input social for level =1
				SELF.verhphone := IF(le.combo_hphonecount>0, le.combo_hphone, '');
				
				SELF.verify_addr := IF(le.addrmultiple,'O','');
				SELF.verify_dob := IF(le.combo_dobcount>0,'Y','N');
				//new for Emerging Identities - a fake DID means we verified first, last and SSN in getDIDprepOutput so set NAS to 9
				SELF.NAS_summary := If(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, 9, le.socsverlevel); 
				SELF.NAP_summary := le.phoneverlevel;
				SELF.NAP_Type    := le.nap_type;
				SELF.NAP_Status  := le.nap_status;

				SELF.valid_ssn := IF(le.socllowissue != '', 'G', '');
					
				SELF.corrected_lname := le.correctlast;
				SELF.corrected_dob := le.correctdob;
				SELF.corrected_phone := le.correcthphone;
				SELF.corrected_ssn := le.correctssn;
				SELF.corrected_address := le.correctaddr;
				// parsed corrected address - if correctaddr is populated, it will always be the same as verified address, don't clean le.correctaddr
				haveCorrected := le.correctaddr<>'';
				SELF.CorrectedPrimRange := if(haveCorrected, le.combo_prim_range, '');
				SELF.CorrectedPreDir := if(haveCorrected, le.combo_predir, '');
				SELF.CorrectedPrimName := if(haveCorrected, le.combo_prim_name, '');
				SELF.CorrectedAddrSuffix := if(haveCorrected, le.combo_suffix, '');
				SELF.CorrectedPostDir := if(haveCorrected, le.combo_postdir, '');
				SELF.CorrectedUnitDesignation := if(haveCorrected, le.combo_unit_desig, '');
				SELF.CorrectedSecRange := if(haveCorrected, le.combo_sec_range, '');
				//
				SELF.area_code_split := if(le.areacodesplitflag='Y', le.altareacode, '');
				SELF.area_code_split_date := if(le.areacodesplitflag='Y', le.areacodesplitdate, '');
				
				SELF.additional_score1 := 0;
				SELF.additional_score2 := 0;
				
				SELF.phone_fname := le.dirsfirst;
				SELF.phone_lname := le.dirslast;
				SELF.phone_address := Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range,le.dirs_predir,le.dirs_prim_name,
														le.dirs_suffix,le.dirs_postdir,le.dirs_unit_desig,le.dirs_sec_range);
				// parsed phone address
				SELF.PhonePrimRange := le.dirs_prim_range;
				SELF.PhonePreDir := le.dirs_predir;
				SELF.PhonePrimName := le.dirs_prim_name;
				SELF.PhoneAddrSuffix := le.dirs_suffix;
				SELF.PhonePostDir := le.dirs_postdir;
				SELF.PhoneUnitDesignation := le.dirs_unit_desig;
				SELF.PhoneSecRange := le.dirs_sec_range;
				//
				SELF.phone_city := le.dirscity;
				SELF.phone_st := le.dirsstate;
				SELF.phone_zip := le.dirszip;
				
				SELF.name_addr_phone := le.name_addr_phone;
				
				SELF.ssa_date_first := le.socllowissue;
				SELF.ssa_date_last := le.soclhighissue;
				SELF.ssa_state := le.soclstate;
				SELF.ssa_state_name := Codes.GENERAL.STATE_LONG(le.soclstate);
				
				SELF.current_fname := le.verfirst;
				SELF.current_lname := le.verlast;
				
				addr1 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range, le.chronopredir, 
														 le.chronoprim_name, le.chronosuffix,
														 le.chronopostdir, le.chronounit_desig, le.chronosec_range);
				addr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2, le.chronopredir2, 
														 le.chronoprim_name2, le.chronosuffix2,
														 le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2);
				addr3 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range3, le.chronopredir3, 
														 le.chronoprim_name3, le.chronosuffix3,
														 le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3);
				
				// clean the chrono address1 to get the delivery point barcode information from the cleaner
				clean_chrono_address1 := risk_indicators.MOD_AddressClean.clean_addr( addr1, le.chronocity, le.chronostate, le.chronozip ) ;
				// don't reference the clean fields unless the option to IncludeDPBC is turned on
				chrono_zipz5_1 := if(IncludeDPBC, clean_chrono_address1[117..121], le.chronozip);
				chrono_zip4_1 := if(IncludeDPBC, clean_chrono_address1[122..125], le.chronozip4);
				// delivery point barcode = zip5 + zip5 + barcode[136..137] + check_digit[138]
				chrono1_dpbc := if(IncludeDPBC and chrono_zip4_1<>'', chrono_zipz5_1 + chrono_zip4_1 + clean_chrono_address1[136..138], '');  // include the 2 character code and 1 character check_digit
				
				
				// clean the chrono address2 to get the delivery point barcode information from the cleaner
				clean_chrono_address2 := risk_indicators.MOD_AddressClean.clean_addr( addr2, le.chronocity2, le.chronostate2, le.chronozip2 ) ;
				// don't reference the clean fields unless the option to IncludeDPBC is turned on
				chrono_zipz5_2 := if(IncludeDPBC, clean_chrono_address2[117..121], le.chronozip2);
				chrono_zip4_2 := if(IncludeDPBC, clean_chrono_address2[122..125], le.chronozip4_2);
				// delivery point barcode = zip5 + zip5 + barcode[136..137] + check_digit[138]
				chrono2_dpbc := if(IncludeDPBC and chrono_zip4_2<>'',chrono_zipz5_2 + chrono_zip4_2 + clean_chrono_address2[136..138], '');  // include the 2 character code and 1 character check_digit
				
				// clean the chrono address3 to get the delivery point barcode information from the cleaner
				clean_chrono_address3 := risk_indicators.MOD_AddressClean.clean_addr( addr3, le.chronocity3, le.chronostate3, le.chronozip3 ) ;
				// don't reference the clean fields unless the option to IncludeDPBC is turned on
				chrono_zipz5_3 := if(IncludeDPBC, clean_chrono_address3[117..121], le.chronozip3);
				chrono_zip4_3 := if(IncludeDPBC, clean_chrono_address3[122..125], le.chronozip4_3);
				// delivery point barcode = zip5 + zip5 + barcode[136..137] + check_digit[138]
				chrono3_dpbc := if(IncludeDPBC and chrono_zip4_3<>'',chrono_zipz5_3 + chrono_zip4_3 + clean_chrono_address3[136..138], '');  // include the 2 character code and 1 character check_digit
				
				
				
				Chronology := DATASET([{1, addr1, le.chronoprim_range, le.chronopredir, le.chronoprim_name, le.chronosuffix, le.chronopostdir, le.chronounit_desig, le.chronosec_range, 
													le.chronocity, le.chronostate, le.chronozip, le.chronozip4, le.chronophone, le.chronodate_first, le.chronodate_last, le.chronoaddr_isbest, if(IncludeDPBC,chrono1_dpbc,'')},
												{2, addr2, le.chronoprim_range2, le.chronopredir2, le.chronoprim_name2, le.chronosuffix2, le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2, 
														le.chronocity2, le.chronostate2, le.chronozip2, le.chronozip4_2, le.chronophone2, le.chronodate_first2, le.chronodate_last2, le.chronoaddr_isbest2, if(IncludeDPBC,chrono2_dpbc,'')},
												{3, addr3, le.chronoprim_range3, le.chronopredir3, le.chronoprim_name3, le.chronosuffix3, le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3, 
														le.chronocity3, le.chronostate3, le.chronozip3, le.chronozip4_3, le.chronophone3, le.chronodate_first3, le.chronodate_last3, le.chronoaddr_isbest3, if(IncludeDPBC,chrono3_dpbc,'')}], 
												Risk_Indicators.Layout_AddressHistory);
				self.chronology := chronology(Address<>'');
				
				Additional_Lname := if(le.socsverlevel IN risk_indicators.iid_constants.ssn_name_match, DATASET([{le.altfirst,le.altlast,le.altlast_date},
												{le.altfirst2,le.altlast2,le.altlast_date2},
												{le.altfirst3,le.altlast3,le.altlast_date3}], Risk_Indicators.Layout_LastNames), 
											dataset([], Risk_Indicators.Layout_LastNames));
				self.additional_lname := additional_lname(lname1<>'');
				
				SELF.Watchlist_Table := le.watchlist_table;
				SELF.Watchlist_Program :=le.watchlist_program;
				SELF.Watchlist_Record_Number := le.Watchlist_Record_Number;
				SELF.Watchlist_fname := le.Watchlist_fname;
				SELF.Watchlist_lname := le.Watchlist_lname;
				SELF.Watchlist_address := le.Watchlist_address;
				// parsed watchlist address
				SELF.WatchlistPrimRange := le.WatchlistPrimRange;
				SELF.WatchlistPreDir := le.WatchlistPreDir;
				SELF.WatchlistPrimName := le.WatchlistPrimName;
				SELF.WatchlistAddrSuffix := le.WatchlistAddrSuffix;
				SELF.WatchlistPostDir := le.WatchlistPostDir;
				SELF.WatchlistUnitDesignation := le.WatchlistUnitDesignation;
				SELF.WatchlistSecRange := le.WatchlistSecRange;
				//
				SELF.Watchlist_city := le.Watchlist_city;
				SELF.Watchlist_state := le.Watchlist_state;
				SELF.Watchlist_zip := le.Watchlist_zip;
				SELF.Watchlist_contry := le.Watchlist_contry;
				SELF.Watchlist_Entity_Name := le.Watchlist_Entity_Name;

				cvi_temp := IF(actualIIDVersion=0, risk_indicators.cviScore(le.phoneverlevel,le.socsverlevel,le,le.correctssn,le.correctaddr,le.correcthphone,customCVIvalue,
																																		veraddr,verlast),
																						risk_indicators.cviScoreV1(le.phoneverlevel,le.socsverlevel,le,le.correctssn,le.correctaddr,le.correcthphone,customCVIvalue,
																																				veraddr,verlast,OFAC,IncludeDOBinCVI,IncludeDriverLicenseInCVI));
				isCodeDI := risk_indicators.rcSet.isCodeDI(le.DIDdeceased) and actualIIDVersion=1;
				SELF.CVI := map(	IncludeMSoverride and risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months) and (integer)cvi_temp > 10 => '10',
										IsPOBoxCompliant AND risk_indicators.rcSet.isCodePO(le.addr_type) and (integer)cvi_temp > 10 => '10',
										IncludeCLoverride and risk_indicators.rcSet.isCodeCL(le.ssn, le.bestSSN, le.socsverlevel, le.combo_ssn) and (integer)cvi_temp > 10 => '10',
										IncludeMIoverride AND risk_indicators.rcSet.isCodeMI(le.adls_per_ssn_seen_18months) and (INTEGER)cvi_temp > 10 and actualIIDVersion=1 => '10',
										isCodeDI AND (INTEGER)cvi_temp > 10 => '10',
										cvi_temp);
				
				custom_cvi_temp := if(CustomCVIModelName <> '', risk_indicators.cviScoreV1(le.phoneverlevel,le.socsverlevel,le,le.correctssn,le.correctaddr,le.correcthphone,customCVIvalue,
																														veraddr,verlast,OFAC,IncludeDOBinCVI,IncludeDriverLicenseInCVI,CustomCVIModelName), '');
				
				SELF.cviCustomScore := map(	IncludeMSoverride and risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months) and (integer)custom_cvi_temp > 10 => '10',
										IsPOBoxCompliant AND risk_indicators.rcSet.isCodePO(le.addr_type) and (integer)custom_cvi_temp > 10 => '10',
										IncludeCLoverride and risk_indicators.rcSet.isCodeCL(le.ssn, le.bestSSN, le.socsverlevel, le.combo_ssn) and (integer)custom_cvi_temp > 10 => '10',
										IncludeMIoverride AND risk_indicators.rcSet.isCodeMI(le.adls_per_ssn_seen_18months) and (INTEGER)custom_cvi_temp > 10 and actualIIDVersion=1 => '10',
										isCodeDI AND (INTEGER)custom_cvi_temp > 10 => '10',
										custom_cvi_temp);
				
				self.SubjectSSNCount := if(risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months), (string)le.ssns_per_adl_seen_18months, '');
				self.age := if (le.age = '***','',le.age);
				
				// if DID is flagged as deceased, use that information otherwise if ssn is verified and flagged as deceased, return the information about the deceased SSN
				ssn_verified := le.socsverlevel IN risk_indicators.iid_constants.ssn_name_match;
				isCode02 := risk_indicators.rcSet.isCode02(le.decsflag);
				self.deceasedDate := MAP(	ssn_verified and isCode02 => if(le.deceasedDate=0, '', (string)le.deceasedDate),
																	isCodeDI => if(le.DIDdeceasedDate=0, '', (STRING)le.DIDdeceasedDate),
																	'');
				self.deceasedDOB := MAP(ssn_verified and isCode02 => if(le.deceasedDOB=0, '', (string)le.deceasedDOB),
																isCodeDI => if(le.DIDdeceasedDOB=0, '', (STRING)le.DIDdeceasedDOB),
																'');
				self.deceasedFirst := MAP(ssn_verified and isCode02 => le.deceasedFirst,
																	isCodeDI => le.DIDdeceasedFirst,
																	'');
				self.deceasedLast := MAP(	ssn_verified and isCode02 => le.deceasedLast,
																	isCodeDI => le.DIDdeceasedLast,
																	'');
				
				risk_indicators.mac_add_sequence(le.watchlists, watchlists_with_seq);
				self.watchlists := watchlists_with_seq;

				// add a sequence number to the reason codes for sorting in XML
				risk_indicators.mac_add_sequence(risk_indicators.reasonCodes(le, NumReturnCodes, reasoncode_settings), reasons_with_seq);
				empty_reasons := dataset([], risk_indicators.Layout_Desc);
				risk_indicators.mac_add_sequence(empty_reasons, empty_reasons_with_seq);
				self.ri := reasons_with_seq(hri<>'');
				SELF.fua := risk_indicators.getActionCodes(le, 4, SELF.NAS_summary, SELF.NAP_summary, ac_settings := actioncode_settings);
				
				self.cviCustomScore_name := if(Valid_CCVI, CustomCVIModelName, '');
				self.cviCustomScore_ri  := if(CustomCVIModelName <> '', reasons_with_seq(hri<>''), empty_reasons_with_seq);
				SELF.cviCustomScore_fua := if(CustomCVIModelName <> '', risk_indicators.getActionCodes(le, 4, SELF.NAS_summary, SELF.NAP_summary, ac_settings := actioncode_settings), empty_reasons);
					
				self.verdl := le.verified_dl;
				
				passportline := PassportUpperLine + PassportLowerLine;

				self.passportValidated := if(IntlIID.ValidationFunctions().passportValidation(passportline, le.dob[3..8], gender), 'Y','N');
				
				// strictly an inputecho
				self.PassportUpperLine := passportupperline ;
				self.PassportLowerLine := passportlowerline ;
				self.Gender := gender ;	
				self.dobmatchlevel := le.dobmatchlevel;
				
				// DL field (for IID Model)
				self.DLValid :=  if(IncludeDLVerification, if(le.drlcvalflag = '0' and le.dl_state in Risk_Indicators.iid_constants.SetDLValidationStates, '1', '0'), '');
				
				// SSN deceased field for IID Model
				self.SSNDeceased := le.decsflag='1';

				// FlexID needs city, state and zip match exactly, also needs to know if ssn was found
				self.combo_prim_name := le.combo_prim_name;
				self.combo_prim_range := le.combo_prim_range;
				self.combo_sec_range := le.combo_sec_range;
				self.combo_city := le.combo_city;
				self.combo_state := le.combo_state;
				self.combo_zip := le.combo_zip[1..5];
				self.combo_ssn := le.combo_ssn;
				self.addressPOBox := (Risk_Indicators.rcSet.isCode12(le.addr_type) or Risk_Indicators.rcSet.isCodePO(le.zipclass)) and (actualIIDVersion=1 or FromFlexID);
				self.addressCMRA := (le.hrisksic in risk_indicators.iid_constants.setCRMA or le.ADVODropIndicator='C') and (actualIIDVersion=1 or FromFlexID);
					
				self.SSNFoundForLexID := le.bestssn<>'' and actualIIDVersion=1;
				
				self.ADVODoNotDeliver := le.ADVODoNotDeliver;
				self.ADVODropIndicator := le.ADVODropIndicator;
				self.ADVOAddressVacancyIndicator := le.ADVOAddressVacancyIndicator;
				self.ADVOResidentialOrBusinessInd := le.ADVOResidentialOrBusinessInd;
				self.USPISHotList := le.USPISHotList;
				
				self.InstantIDVersion := (string)actualIIDVersion;

				//new for Emerging Identities
				isEmergingID := Risk_Indicators.rcSet.isCodeEI(le.DID, le.socsverlevel, le.socsvalid) AND EnableEmergingID;
				self.EmergingID := if(isEmergingID, true, false);  //a fake DID indicates an Emerging Identity	
				isReasonCodeSR	:= exists(reasons_with_seq(hri='SR')); //check if reason code 'SR' is set
				self.AddressSecondaryRangeMismatch := map(le.sec_range = '' and isReasonCodeSR															=> 'D',	 //no input sec range, but our data has one
																									le.sec_range <> '' and ~isReasonCodeSR and self.versecrange = ''	=> 'I',	 //input sec range, but our data does not have one
																									le.sec_range <> '' and isReasonCodeSR															=> 'M',	 //input sec range, but our data shows different sec range
																									le.sec_range = '' and ~isReasonCodeSR															=> 'N',	 //no input sec range and our data does not have one
																																																											 'V'); //input sec range matches our data
				self.StandardizedAddress := if(le.addr_status[1] in ['E',''], false, true); //check address status to see if it standardized successfully
				self.StreetAddress1 := address.Addr1FromComponents(le.prim_range,le.predir,le.prim_name,le.addr_suffix,le.postdir,le.unit_desig,le.sec_range);
				self.StreetAddress2 := address.Addr2FromComponents(le.p_city_name,le.st,le.z5);
				self.DID := if(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, 0, le.DID); //if DID is fake, zero it out
				
				SELF := le;
				SELF := [];  // default models and red flags datasets to empty
			END;

			ret_temp2 := UNGROUP(PROJECT(ret, format_out(LEFT)));

			//for Emerging Identities, return standardized county name
			ret_temp := join(ret_temp2, census_data.Key_Fips2County, 
				keyed(left.st=right.state_code) and
				keyed(left.county=right.county_fips),
				transform(risk_indicators.Layout_InstantID_NuGenPlus, 
					self.CountyName := right.county_name,
					self := left),
					left outer, KEEP(1), ATMOST(500));


			// Adapted from Business_Risk.InstantID_Function
			with_SIC := JOIN(ret_temp, Risk_Indicators.Key_HRI_Address_To_SIC,
							left.z5 != '' and 
							left.prim_range != '' and
							keyed(left.z5=right.z5) and 
							keyed(left.prim_name=right.prim_name) and 
							keyed(left.addr_suffix=right.suffix) and 
							keyed(left.predir=right.predir) and 
							keyed(left.postdir=right.postdir) and 
							keyed(left.prim_range=right.prim_range) and
							keyed(left.sec_range=right.sec_range),
							transform(Risk_Indicators.Layout_InstantID_NuGenPlus,
													self.Sic_Code := right.sic_code;
													self := left),
							left outer, atmost(riskwise.max_atmost), keep(1));

			ret_formatted := IF(SearchSicNAICSCodes, with_SIC, ret_temp);


			risk_indicators.Layout_InstantID_NuGenPlus intoEmpty(d le) := transform
				self.acctNo := account_value;
				self := [];
			END;
			formed := if(fromIIDModel and EXISTS(model_url), project(d, intoEmpty(LEFT)), ret_formatted);	// don't do IID portion if from IID model and a model is requested
			// for testing only   formed contains the hri desc  under ri and under fua it already contains the codes
			// output(formed,named('formed'));

			// this is not ideal to index into the datasets by position number, as the position can change,
			// but I can't figure out how to reference the row in the parameters dataset that is named 'isstudent'
			student_params := project(model_url(StringLib.StringToLowerCase(name)='models.studentadvisor_service'), transform(models.layout_parameters, self := left.parameters[1]));
			student_boolean := student_params[1].value='1';

			ModelRequests1 := project(dataset([{1}], {unsigned a}), 
				transform(models.layouts.Layout_Model_Request_In, 
					self.ModelName := 'customfa_service',
					self.ModelOptions := project(model_url[1].parameters, transform(Models.Layouts.Layout_Model_Options,
												self.optionname := left.Name;
												self.optionvalue := left.Value;));
						));
			//With the FraudPoint 3.0 changes, a second address/identity was added to the input into FraudAdvisor_Service so that custom models
			//could be built using this second set of elements. It is a requirement to also pass in these fields through InstantID and FlexID.
			//The decision was made to pass them in via the custom fields within the model request section, therefore there are no real changes
			//needed here until a model is created that actually needs these fields. This is just a note/reminder that if/when these fields are
			//needed by a custom model and that model is requestable via InstantID or FlexID, the model name needs to be added to this set below, 
			//which will then automatically pass the custom model request section along from either InstantID or FlexID to FraudAdvisor_Service. 
			//FraudAdvisor_Service will then need to change at that time to look for these new custom fields.
			set_custom_models_requiring_custom_params := ['FP31310_2', 'AIN801_1', 'FP1407_1', 'FP1407_2', 'FP1509_2'];			
			modelRequests := if(customfraud_modelname in set_custom_models_requiring_custom_params, 
				modelRequests1, 
				dataset([], models.layouts.Layout_Model_Request_In));
				
			fa_params := model_url(StringLib.StringToLowerCase(name)='models.fraudadvisor_service')[1].parameters;
			model_version := trim(StringLib.StringToUppercase(fa_params(StringLib.StringToLowerCase(name)='version')[1].value));
			custom_modelname := trim(StringLib.StringToUppercase(fa_params(StringLib.StringToLowerCase(name)='custom')[1].value));
			modelname := if(model_version='', custom_modelname, model_version);
			includeRiskIndices := fa_params(StringLib.StringToLowerCase(name)='includeriskindices')[1].value='1';

			//Check to see if the FP model requested requires a valid GLB 
			FP3_models_requiring_GLB	:= ['FP31505_0', 'FP3FDN1505_0', 'FP31505_9', 'FP3FDN1505_9']; //these models require valid GLB, else fail
			glb_ok 	:= Risk_Indicators.iid_constants.glb_ok(GLB_Purpose, isFCRA);
			InvalidFP3GLBRequest := modelname in FP3_models_requiring_GLB and ~glb_ok; 
//			if(InvalidFP3GLBRequest, FAIL('Valid Gramm-Leach-Bliley Act (GLBA) purpose required'));

			risk_indicators.Layout_Interactive_In scoredata(rec le) :=
			TRANSFORM
				SELF.AccountNumber := account_value;
				SELF.SSN := ssn_value;
				SELF.FirstName := fname_val;
				SELF.MiddleName := mname_val;
				SELF.LastName := lname_val;
				SELF.NameSuffix := suffix_val;

				SELF.DateOfBirth := dob_value;
				
				SELF.StreetAddress := addr_value;
				SELF.City := city_val;
				SELF.State := state_val;
				SELF.Zip := zip_value;
				
				SELF.Age := age_value;
				SELF.DLNumber := dl_number_value;
				SELF.DLState := dl_state_value;
				
				SELF.HomePhone := phone_value;
				SELF.WorkPhone := wphone_value;
				
				SELF.DPPAPurpose := DPPA_Purpose;
				SELF.GLBPurpose := GLB_Purpose;
				SELF.IndustryClass := industry_class_val;
				SELF.LnBranded := ln_branded;
				SELF.HistoryDateYYYYMM := history_date;
				SELF.HistoryDateTimeStamp := historyDateTimeStamp;
				SELF.OfacOnly := ofac_only;
				self.isStudent := student_boolean;

				self.gateways := gateways;
				
				self.IncludeAdditionalWatchlists := Include_Additional_Watchlists;

				self.OFACVersion := OFAC_version;
				
				self.IncludeOFAC := Include_Ofac;
				self.GlobalWatchListThreshold := global_watchlist_threshold;
				self.UseDOBFilter := use_dob_filter;
				self.DOBRadius    := dob_Radius;
				self.customFraudModel := customfraud_modelname;
				
				self.ipaddress := ip_value;
				self.email := email_value;
				self.model := modelname;
				self.testdataenabled := Test_Data_Enabled;
				self.TestDataTableName := Test_Data_Table_Name;
				self.DataRestrictionMask := DataRestriction;
				self.DataPermissionMask := DataPermission;
				
				self.IncludeRiskIndices	:= includeRiskIndices;
				self.Channel := Channel;
				self.Income := Income;
				self.OwnOrRent := OwnOrRent;
				self.LocationIdentifier := LocationIdentifier;
				self.OtherApplicationIdentifier := OtherApplicationIdentifier;
				self.OtherApplicationIdentifier2 := OtherApplicationIdentifier2;
				self.OtherApplicationIdentifier3 := OtherApplicationIdentifier3;
				self.DateofApplication := DateofApplication;
				self.TimeofApplication := TimeofApplication;
				
				self.ModelRequests := ModelRequests;

				self := [];
			END;

			scores_out := IF(count(model_url(url<>''))>0,riskwise.ScoreController(model_url(url<>''),PROJECT(ungroup(d),scoredata(LEFT))));


			models.layouts.Layout_Score_IID_wFP limit_scores( models.layouts.Layout_Score_FP le ) := TRANSFORM
				num_reasons := if( modelname in ['FP1109_0','FP1109_9', 'FP1310_1', 'FP1401_1', 'FP1307_1', 'FP31310_2', 'FP1307_2', 'FP1404_1', 'FP1407_1', 'FP1407_2', 'FP1403_2', 'FP31505_0', 'FP3FDN1505_0', 'FP31505_9', 'FP3FDN1505_9', 'FP1509_2', 'FP1510_2'], 6, 4); // FP version 2 and forward will get 6 reason codes, otherwise 4 like they used to
				self.reason_codes := choosen( le.reason_codes, num_reasons ); 
				self.risk_indices := if(includeRiskIndices or modelname in ['FP31310_2'], 
																dataset([{'StolenIdentityIndex', le.StolenIdentityIndex},
																				 {'SyntheticIdentityIndex', le.SyntheticIdentityIndex},
																				 {'ManipulatedIdentityIndex', le.ManipulatedIdentityIndex},
																				 {'VulnerableVictimIndex', le.VulnerableVictimIndex},
																				 {'FriendlyFraudIndex', le.FriendlyFraudIndex},
																				 {'SuspiciousActivityIndex', le.SuspiciousActivityIndex}], models.layouts.layout_risk_indices),
																dataset([],models.layouts.layout_risk_indices)
																);
				self := le;
			END;



			models.Layouts.Layout_Model_IID limit_model( models.Layouts.FP_Layout_Model le ) := TRANSFORM
				self.scores := project( le.scores, limit_scores(LEFT) );
				self := le;
			END;

			outer_layout := RECORD
				STRING30 AccountNumber;
				DATASET(models.Layouts.Layout_Model_IID) models;
			END;

			outer_layout limit_scores_out( scores_out le ) := transform
				self.models := project( le.models, limit_model(left) );
				self.AccountNumber := le.AccountNumber;
			end;

			// FP3710_9 is a call to Flagship FP3710_0 except with Criminal Risk Codes returned
			scores :=	project(scores_out, limit_scores_out(left) );

			iid := if(Test_Data_Enabled, ret_test_seed, formed);	// choose either test results or real results

			risk_indicators.Layout_InstantID_NuGenPlus combo(risk_indicators.Layout_InstantID_NuGenPlus le, scores ri) :=
			TRANSFORM
				SELF.models := ri.models;
				// self.ssn := ssn_value;	// replace the entered social
				// self.dob := dob_value;	// replace the input dob, it could have been blanked out for bad format
				self.recordcount := count(iid);	// add recordcount for logging by ESP
				SELF := le;
			END;

			scores_added := JOIN(iid, scores, 
													LEFT.AcctNo=RIGHT.AccountNumber, combo(LEFT,RIGHT), LEFT OUTER, PARALLEL);

			red_flags := if(Test_Data_Enabled, seed_files.GetRedFlags(test_prep, Test_Data_Table_Name), risk_indicators.Red_Flags_Function(ret, reasoncode_settings));

			with_red_flags := join(scores_added, red_flags, left.seq=right.seq, 
														transform(risk_indicators.Layout_InstantID_NuGenPlus,
																			self.Red_Flags := right, self := left), left outer);

			// If red flags option is selected, then return result with red flags added. Otherwise, return data without red flags.
			pick_transaction := if(RedFlagsReq, with_red_flags, scores_added);

			dl_mask_value := dlmask=1;
			Suppress.MAC_Mask(pick_transaction, post_ssn_mask1, verssn, '', true, false, false, false, '', ssnmask);
			Suppress.MAC_Mask(post_ssn_mask1, post_ssn_mask2, corrected_ssn, verdl, true, true, false, false, '', ssnmask);

			unsigned1 dob_mask_value := Suppress.date_mask_math.MaskIndicator (dobmask);
			risk_indicators.Layout_InstantID_NuGenPlus mask_dobs(risk_indicators.Layout_InstantID_NuGenPlus le) := transform
				self.verdob := risk_indicators.iid_constants.mask_dob(le.verdob, dob_mask_value);
				self.corrected_dob := risk_indicators.iid_constants.mask_dob(le.corrected_dob, dob_mask_value);
				self.deceasedDate := risk_indicators.iid_constants.mask_dob(le.deceaseddate, dob_mask_value);
				self.deceasedDOB := risk_indicators.iid_constants.mask_dob(le.deceaseddob, dob_mask_value);
				self := le;
			end;

			post_dob_masking := project(post_ssn_mask2,mask_dobs(left));
			
			InstantID_records_pre :=
				JOIN(
					ds_Normed, post_dob_masking,
					LEFT.Seq = RIGHT.seq,
					TRANSFORM( { risk_indicators.Layout_InstantID_NuGenPlus, UNSIGNED4 OrigSeq },
						SELF.OrigSeq := LEFT.OrigSeq,
            SELF.seq := LEFT.seq,
						SELF := RIGHT,
						SELF := []
					),
					INNER
				);

      // Sort explicity to ensure Auth Reps (identified by "seq") are still in the same 
      // order as were input.
      InstantID_records_srtd := SORT( InstantID_records_pre, OrigSeq, seq );

			// Convert seq back to original sequence number; there will therefore be 1-5 records
			// having the same seq #. Preserve the sequence number ("Rep_WhichOne") for each AR.
      InstantID_records :=
        PROJECT(
          InstantID_records_srtd,
          TRANSFORM( BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout, 
            SELF.seq := LEFT.OrigSeq,
            SELF.Rep_WhichOne := (STRING)(LEFT.seq % 10);
						SELF := LEFT,
          )
        );
      
			// OUTPUT( ds_Normed, NAMED('ds_Normed') );
			// OUTPUT( prep, NAMED('prep') );
			// OUTPUT( post_dob_masking, NAMED('post_dob_masking') );
      // OUTPUT( InstantID_records_pre, NAMED('InstantID_records_pre') );
      // OUTPUT( InstantID_records_srtd, NAMED('InstantID_records_srtd') );

		RETURN InstantID_records;
	END;