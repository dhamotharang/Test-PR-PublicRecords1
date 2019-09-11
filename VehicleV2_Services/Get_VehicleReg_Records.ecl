IMPORT Vehiclev2_services, doxie, suppress, vehicle_wildcard, ut,  
       NID, drivers, doxie_Raw, doxie_build, iesp;

EXPORT Get_VehicleReg_Records(Vehiclev2_services.IParam.searchParams aInput,
                              BOOLEAN returnIesp,
															BOOLEAN RawRecs = FALSE) := MODULE //TODO: make a function
 	
	SHARED getVehRecs := VehicleV2_Services.Get_Vehicle_Records(aInput, returnIesp);
	
    mod_access := PROJECT(aInput, doxie.IDataAccess);
    
		// BEGIN ADDITION OF WILDCARD INPUT ENTRIES 
		unsigned zipRadius_val            := 1 : STORED('Radius');
		string30 vin_val                  := '' : STORED('VinWild');
		string20 tag_val                  := '' : STORED('TagWild');
						
    string30 county_value             := aInput.County;				
		STRING30 fname_val                := aInput.FirstName;
		string30 mname_val								:= aInput.MiddleName;		
		string30 lname_val								:= aInput.LastName;
		string30 city_val								  := aInput.city;		
		string2	 state_value							:= aInput.state;		 
		unsigned8 Maxresults_val          := if (aInput.maxresultsVal > 1000, 1000, 
		                                         aInput.maxresultsVal); // could lower this constant if needed.		                                    		 	
		unsigned8 maxResultsThisTime_val := if (aInput.MaxResultsVal > 1000,1000,																					
																					aInput.MaxResultsVal);
		unsigned8	SkipRecords_val					:= 0			: stored('SkipRecords');		
	
		BOOLEAN IncludeCriminalIndicators := aInput.includeCriminalIndicators;		
		BOOLEAN IncludeNonRegulatedVehicleSources := aInput.IncludeNonRegulatedSources;		
		// TODO ******* DOUBLECHECK MAY NEED SPECIAL CASE HERE TO KEEP DEFAULT SETTING
     
		vin_value := stringlib.stringtouppercase(vin_val);		
		tag_value := stringlib.stringtouppercase(tag_val);	
		city_value := stringlib.stringtouppercase(city_val);		
		ssn_mask_value := mod_access.ssn_mask;
		dl_mask_value := mod_access.dl_mask = 1;

		modelIndex := vehicle_wildcard.Key_ModelIndex;
		bodyIndex  := Vehicle_Wildcard.Key_BodyStyle;

		boolean containsSearch_use := false : stored('containsSearch');
		
		set of string5 zips_in :=  if (aInput.zip != '',[aInput.zip], []);		
		string5					zip5_value			:= if (AInput.zip != '', aInput.zip, '');				
		unsigned2       zipradius_value := (unsigned2) if (zipRadius_val = 0, 1, zipRadius_val);		  
		string5         city_zip_value  := ziplib.CityToZip5(state_value,city_value);

		// Are we using wildcards in the Tag, VIN, or Zip fields?
		doWild := LENGTH(StringLib.StringFilter(tag_value,'*?')) > 0; 
		doWildVIN := LENGTH(StringLib.StringFilter(vin_value,'*?')) > 0; 
		doWildZip := LENGTH(StringLib.StringFilter(zip5_value,'*?')) > 0; 
   
		// Determine allowable zip codes based on Zip5, ZipRadius, Zip, County, City and State inputs
		set of integer4 zipr_set := ut.fn_GetZipSet(,,zip5_value,,,zipradius_value);
		set of integer4 zipcity_set := ut.fn_GetZipSet(,,city_zip_value,,,zipradius_value);
		set of integer4 zipcnty_set := ut.fn_GetZipSet(,state_value,,county_value);
		zipr_ds  := project(dataset(zipr_set,{integer4 zip}),transform({string5 zip},self.zip := intformat(left.zip,5,1)));
		zipcnty_ds  := project(dataset(zipcnty_set,{integer4 zip}),transform({string5 zip},self.zip := intformat(left.zip,5,1)));
		zipcity_ds  := project(dataset(zipcity_set,{integer4 zip}),transform({string5 zip},self.zip := intformat(left.zip,5,1)));
		set of string5 zips := map(
			doWildZip				=> [],								// Zip wildcards override everythig else			
			exists(zipr_ds) => set(zipr_ds,zip),	// zip radius is preferred (Zip5+ZipRadius)
			exists(zipcity_ds) => set(zipcity_ds,zip),	// zip radius of city (cityZip+ZipRadius)
			exists(zips_in) => zips_in,						// a list of zips is next-best (Zip)
			exists(zipcnty_ds) => set(zipcnty_ds,zip),	// zips derived from county are better than nothing (County+State)
			[]);
		zip_dataset := dataset(zips, {string5 zip});
		zip_use := set(zip_dataset, (unsigned3)zip); // : STORED('zip_use');
		// NOTE: One might argue that wildcard is supposed to behave more like a filter than a search, and
		//       therefore we should really be taking the union of the three different ways of entering zip
		//       codes.  That seems pretty reasonable, but I don't believe anyone in product has asked for
		//       it.  Thus, for now at least, it makes the most sense to make the minimal change to existing
		//       behavior here and just continue using an order of preference among the three methods.

		string2 _state := aInput.state;
		zipCd:={string5 zip,unsigned1 code};
		zipCdRec := dataset([{city_zip_value,ut.St2Code(ziplib.ZipToState2(city_zip_value))}],zipCd);
		zipCdRecs := project(zip_dataset,transform(zipCd,
			self.zip:=left.zip,
			self.code:=ut.St2Code(ziplib.ZipToState2(left.zip))
			));
		set of unsigned1 state_use := set(dedup(sort(zipCdRec(code!=0)+zipCdRecs,code),code),code);
					
		
		string2 regState := '' : stored('registerState');	// can possibly revert to dropping stored after jira HPCC-13417
		                                                  // is fixed. regState currently not used in query
		unsigned1 regState_use := IF (regState = '', -1,		                             
																	ut.st2Code(stringlib.stringtouppercase(regState)));
		
		string tmpMake := ''  : stored('Make');	
		string tmpMake2 := '' : stored('Make2');
		string tmpMake3 := '' : stored('Make3');
		string tmpMake4 := '' : stored('Make4');
	
		 set of string4 _make := if (tmpMake != '' AND tmpmake2 != '' and	tmpMake3 != '' AND tmpmake4 != '',
		                            [tmpMake,tmpMake2,tmpMake3,tmpMake4],
																if (tmpmake != '' AND tmpMake2 != '' and tmpMake3 != '', 
																         [tmpMake,tmpMake2,tmpMake3],
																     if (tmpmake != '' AND tmpMake2 != '',
																        [tmpMake,tmpMake2],
																				 if (tmpMake != '', [tmpMake],[])
																		 )
																		)
																	);		
		make_use := if (exists(_make), vehicle_wildcard.Make2Code(_make),[]);
		                     	
		string colorTmp := '' : stored('Color');
		string ColorTmp2 := '' : stored('Color2');
		string ColorTmp3 := '' : stored('Color3');
		string ColorTmp4 := '' : stored('Color4');
				
		set of string3 _majorColor := if (ColorTmp != '' AND ColorTmp2 != '' and	ColorTmp3 != '' AND ColorTmp4 != '',
		                            [ColorTmp,ColorTmp2,ColorTmp3,ColorTmp4],
																if (ColorTmp != '' AND ColorTmp2 != '' and 
		                             ColorTmp3 != '', [ColorTmp,ColorTmp2,ColorTmp3],
																     if (ColorTmp != '' AND ColorTmp2 != '',
																        [ColorTmp,ColorTmp2],
																				 if (ColorTmp != '', [ColorTmp],[])
																		 )
																		)
																	);
		vehicle_wildcard.MAC_SetConvert(_majorColor, vehicle_wildcard.Color2Code, 
										majorColor_use, 'majorColor_use')
		
		string MinorcolorTmp := '' : stored('MinorColor');
		string MinorColorTmp2 := '' : stored('MinorColor2');
		string MinorColorTmp3 := '' : stored('MinorColor3');
		string MinorColorTmp4 := '' : stored('MinorColor4');

		set of string3 _MinorColor :=  if (MinorColorTmp != '' AND MinorColorTmp2 != '' and								
		                             MinorColorTmp3 != '' AND MinorColorTmp4 != '',
		                            [MinorColorTmp,MinorColorTmp2,MinorColorTmp3,MinorColorTmp4],
																if (MinorColorTmp != '' AND MinorColorTmp2 != '' and 
		                             MinorColorTmp3 != '', [MinorColorTmp,MinorColorTmp2,MinorColorTmp3],
																     if (MinorColorTmp != '' AND MinorColorTmp2 != '',
																        [MinorColorTmp,MinorColorTmp2],
																				 if (MinorColorTmp != '', [MinorColorTmp],[])
																		 )
																		)
																	);		
		vehicle_wildcard.MAC_SetConvert(_minorColor, vehicle_wildcard.Color2Code, 
										minorColor_use, 'minorColor_use')
        
		string tmpModel := '' : stored('Model');
		string tmpModel2 := '' : stored('Model2');
		string tmpModel3 := '' : stored('Model3');
		string tmpModel4 := '' : stored('Model4');
		
		set of string36 _model := if (tmpModel != '' AND tmpModel2 != '' and								
		                             tmpModel3 != '' AND tmpModel4 != '',
		                            [tmpModel,tmpModel2,tmpModel3,tmpModel4],
																if (tmpModel != '' AND tmpModel2 != '' and 
		                             tmpModel3 != '', [tmpModel,tmpModel2,tmpModel3],
																     if (tmpModel != '' AND tmpModel2 != '',
																        [tmpModel,tmpModel2],
																				 if (tmpModel != '', [tmpModel],[])
																		 )
																		)
																	);				
    model_dataset := dataset(_model, {string36 m});		
		model_convert := JOIN(dedup (model_dataset, m, all), modelIndex,
                      keyed((QSTRING36)LEFT.m = RIGHT.str[1..LENGTH(TRIM(Left.m))]),
                      KEEP (100));
		model_use := set(model_convert, i);
	
		set of string36 _body := [] : stored('body');
		body_dataset := dataset(_body, {string36 b});
		body_convert := JOIN(dedup (body_dataset, b, all), bodyIndex,
                      keyed(Stringlib.StringToUpperCase(LEFT.b) = RIGHT.body_style),
                      KEEP (100));
		body_use := set(body_convert, i) : stored('body_use');

    INTEGER _modelYearStart_use := 0 : STORED('YearMake');
		INTEGER modelYearStart_use := (INTEGER)_modelYearStart_use;
		
		INTEGER _modelYearEnd_use := 0 : STORED('YearMakeMax');
		INTEGER modelYearEnd_use := if (_modelYearStart_use <> 0 and _modelYearEnd_use = 0,
                                        modelYearStart_use, _modelYearEnd_use);
																				
		INTEGER _ageRangeStart := 0 : STORED('Age');
		INTEGER ageRangeStart_ := IF (LENGTH(TRIM((STRING) _ageRangeStart)) < 4, 
								(INTEGER)_ageRangeStart,
								ut.Age(_ageRangeStart)
								);

		INTEGER _ageRangeEnd := 0 : STORED('AgeMax');
		INTEGER ageRangeEnd_ := IF(LENGTH(TRIM((STRING) _ageRangeEnd)) < 4,
							  if ( (INTEGER)_ageRangeEnd = 0 AND _ageRangeStart <> 0, (INTEGER)_ageRangeStart, (INTEGER)_ageRangeEnd),
							  ut.Age(_ageRangeEnd)
								);

		INTEGER ageRangeStart_use := IF(ageRangeStart_ < ageRangeEnd_, ageRangeStart_, ageRangeEnd_);
		INTEGER ageRangeEnd_use := IF(ageRangeStart_ < ageRangeEnd_, ageRangeEnd_, ageRangeStart_);
		
		
		STRING1 _sex := '' : stored('Gender');		
		STRING8 sex_use := stringlib.stringtouppercase(_sex);
		
    UNSIGNED8 pre_MaxResultsThisTime_val := IF (aInput.MaxResultsthistimeVal = 0, 2000, aInput.MaxResultsthistimeVal );

		// allows to choose between record timeline statuses
		historyConstant := VehicleV2_services.Constant.HISTORY;
		unsigned1 USE_RECENT				:= 0; // CURRENT+EXPIRED
		unsigned1 USE_CURRENT				:= 1;
		unsigned1 USE_EXPIRED				:= 2;
		unsigned1 USE_HISTORICAL		:= 3;
		unsigned1 USE_ALL						:= 4;
		boolean		incDetailedReg		:= false : stored('IncludeDetailedRegistrationType');
		string    _tline_temp1      := '' : stored('RegistrationStatus');
		
		unsigned1 tline_temp1 := MAP (stringlib.stringtouppercase(_tline_temp1) = 'ALL' => USE_ALL,
		                    stringlib.stringtouppercase(_tline_temp1) = 'CURRENT' => USE_CURRENT,
												stringlib.stringtouppercase(_tline_temp1) = 'EXPIRED' => USE_EXPIRED,
											  USE_ALL);
		                 
		//unsigned1 tline_temp1				:= if (_tline_temp1 = '', USE_RECENT, (unsigned1) _tline_temp1);// : stored ('RegistrationType');
		unsigned1 tline_temp2				:= USE_ALL : stored ('RecordStatus'); // no longer the preferred input value
		unsigned1 tline_use					:= map(
																tline_temp1>USE_RECENT AND tline_temp1<=USE_ALL => tline_temp1,
																tline_temp1=USE_RECENT AND tline_temp2<=USE_ALL => tline_temp2,
																USE_RECENT);
		// NOTE: logic of EXPIRED records found to be different between wildcard and vehicle party:
		// Wildcard Expired logic: "An Expired Registration is defined as a registration that has an expiration date in the past at the time of the build, but no more than twelve months in the past"
		// Vehicle Party Expired logic: "An Expired flag will be set when no current record for same vehicle_key and iteration key and registration latest effective date within 12 months at the time of build"
		// as a result expired records in wild file pulls flag from party record that could be either 'E' or 'H'
		// So, we expect wildfile to contain only CURRENT('') or EXPIRED('E','H') records
		set of string1 tline_allow	:= case(
			tline_use,
			USE_CURRENT			=> historyConstant.CURRENT,
			USE_EXPIRED			=> historyConstant.EXPIRED,
			//USE_HISTORICAL	=> historyConstant.HISTORICAL, //commented out not used from input
			USE_ALL					=> historyConstant.INCLUDEALL,
			historyConstant.INCLUDEALL);
		// NOTE: Between 2007 and mid-2012, a change was in place that added EXPIRED records to the
		//       Wildfile and made them selectable in the query -- however, the query code erroneously
		//       referred to them as HISTORICAL records.  This proved to be a point of significant
		//       confusion when a requirement to add HISTORICAL records was raised.  Anyway, from
		//       this point forward we're calling them what they are: CURRENT, EXPIRED, or HISTORICAL.
		//       For backward compatibility, though, the incDetailedReg flag will indicate whether to
		//       use the corrected terminology in the history_name output field.
 
	 wildfile := vehicle_wildcard.file_veh_hole;

	WILDFILE_READ_LIMIT := 50000; // to avoid excessive reading before postfiltering

	// simplify wild inputs where possible, and detect excessive complexity
	string wild_tag := ut.mod_WildSimplify.do(tag_value);
	string wild_vin := ut.mod_WildSimplify.do(vin_value);
	string wild_zip := ut.mod_WildSimplify.do(zip5_value);
	boolean	wild_bad := (doWild and ut.mod_WildSimplify.isBad(wild_tag)) or (doWildVIN and ut.mod_WildSimplify.isBad(wild_vin)) or (doWildZip and ut.mod_WildSimplify.isBad(wild_zip));

	// matching the plate #
	boolean UseTagBlur := false : stored('UseTagBlur');
	string tag_blur := ut.blur(tag_value);
	platematch := 
		MAP(tag_value='' or tag_value=wildfile.wd_plate_number => true,
			UseTagBlur					=> StringLib.StringFind(ut.blur(wildfile.wd_plate_number), tag_blur, 1) > 0,
														// blur is too loose for contains or wild; so we'll search for a substring instead and do so all the time
			containsSearch_use	=> StringLib.StringContains(wildfile.wd_plate_number, tag_value, TRUE),
			doWild							=> stringlib.StringWildMatch(wildfile.wd_plate_number, wild_tag, true),
			false);

// matching the VIN
	vinmatch := MAP(vin_value = '' => TRUE,
			// NOTE: We don't do a "contains" search in VIN, to aid in efficiency
			doWildVIN => stringlib.StringWildMatch(wildfile.wd_VIN, wild_vin, true),  // true here ignore case of string value
			vin_value = wildfile.wd_VIN);

	// Zip5 wildcard matching
	WildZipMatch := MAP(
		doWildZip => stringlib.StringWildMatch((string5)wildfile.wd_zip, wild_zip, true), // true here ignore case of string value
		true);

// matching the age range
CurrentYear := (INTEGER)(stringlib.GetDateYYYYMMDD()[1..4]);
AgeFrom1900 := CurrentYear - (1900 + wildfile.wd_years_since_1900);
agematch := ageRangeStart_use = 0 OR ageRangeEnd_use = 0 OR
				(ageRangeStart_use-1 <= AgeFrom1900 AND
				 ageRangeEnd_use+1 >= AgeFrom1900);
//////////////////////////////////////////////////////////				 
// *** next 2 attrs used to filter regular MVR search
//
// used by to filter regular MVR search later.
STRING ageStart := (STRING) ( currentYear - ageRangeEND_ -1)
                              + stringlib.GetDateYYYYMMDD()[5..6]
															+ stringlib.GetDateYYYYMMDD()[7..8];
																 // used the ageRangeEn_ in case user enters just a value for ageStart.
// used by to filter regular MVR search later.														 
STRING ageEnd :=   (STRING) ( CurrentYear - ageRangeStart_ )
                                    + stringlib.GetDateYYYYMMDD()[5..6]
																    + stringlib.GetDateYYYYMMDD()[7..8];	
/////////////////////////////////////////////////////////////////////////
// matching the car year range
yearMatch := modelYearStart_use = 0 OR modelYearEnd_use = 0 OR 
				(modelYearStart_use <= wildfile.wd_YEAR_MAKE AND
				 modelYearEnd_use >= wildfile.wd_YEAR_MAKE);

genderMatch := sex_use NOT IN ['M', 'F'] OR sex_use = wildfile.wd_gender;

county_bad := if(
	county_value<>'' and state_value='',
	error(301, doxie.ErrorCodes(301) + ' - State required to search by County'),
	false);

unacceptable_inputs := doxie.fn_wildcard_badinput(_state,regState, make_use,
zip_use,model_use,MajorColor_use,ageRangeStart_use,ageRangeEnd_use,modelYearStart_use,
modelYearEnd_use,sex_use,tag_value,vin_value) or wild_bad or county_bad;

// OSS LIMIT CMD DOESN"T WORK in OSS like it did in 702 platform build
// SO THIS 'CHOOSEN (DS, LIMITVALUE +1)' IS TO GET AROUND THAT.

wildfileAttr := CHOOSEN(wildfile (
  keyed(state_use = []		OR		wd_state IN state_use),
  keyed(regState = ''		OR		wd_orig_state = regState_use),
  keyed(_make = []				OR		wd_make_code IN make_use),  
  keyed(zip_use = []			OR		wd_zip IN zip_use),
  keyed(_model = []			OR		wd_model_description IN model_use),
  keyed(_body = []			  OR		wd_body_code IN body_use),
  keyed(majorColor_use = [] 	OR		wd_major_color_code IN majorColor_use),
  agematch,
  yearmatch,
  gendermatch,
  platematch,
  vinmatch,
  WildZipMatch,
  mod_access.isValidDppa(),
  TRUE), WILDFILE_READ_LIMIT+1);
// 
// Combine matches
pre_filtered := LIMIT (wildfileAttr, WILDFILE_READ_LIMIT, SKIP);
 // THIS WAS THE ORGINAL LINE in QUERY ATTEMPT to make it fail gracefully i..e w pre_filtered hopefully set to 0.
 
 
// ORIGINAL LINE BUT WE DON"T WANT FAIL QUERY because regular MVR search has to run so just return empty set.
// the check if count< WILDFILE_READ_LIMIT ensures we don't run a 
// Fn_Find call if input is over the threshold : WILDFILE_READ_LIMIT

filtered := if( ((~unacceptable_inputs) and (count(wildfileAttr) < WILDFILE_READ_LIMIT)), pre_filtered);
badSearch := unacceptable_inputs OR (count(wildfileAttr) > WILDFILE_READ_LIMIT);
pre_Filtered_wseq := project(filtered,transform(recordof(filtered),
		self.wd_veh_id := counter,self:=left));//:persist('doxie_wildcardsearch_local3');		

// It's tempting to narrow down to MaxResults_val records early for efficiency,
// but we can't do so until we're done with all filtering of the results.
unsigned2 UPPER_LIMIT := 2000;
unsigned2 REAL_LIMIT := ut.Min2(MaxResults_val,UPPER_LIMIT);

dup_pre_filtered_wseq := dedup(sort(pre_Filtered_wseq,vehicle_key,iteration_key,sequence_key),
		vehicle_key,iteration_key,sequence_key);
		
unsigned1	dppa_purpose := mod_access.dppa;
Vehiclev2_services.Mac_DppaCheck(dup_pre_filtered_wseq,dup_pre_filtered_wdppa)

no_postfiltering := fname_val='' and mname_val='' and lname_val='' and tline_use=USE_ALL and county_value='';
filtered_wseq := group(if(no_postfiltering,choosen(dup_pre_filtered_wdppa,UPPER_LIMIT*5), dup_pre_filtered_wdppa),
	vehicle_key,iteration_key,sequence_key);

fname_pref := NID.PreferredFirstNew (stringlib.stringtouppercase(fname_val));
mname_pref := NID.PreferredFirstNew (stringlib.stringtouppercase(mname_val));

F := project(filtered_wseq,transform(doxie_Raw.Layout_VehRawBatchInput.input_w_keys,
  self := left,self.input.seq := left.wd_veh_id, self :=[]));

FT := if (Count(F) > 0,
         Vehiclev2_services.Fn_Find(F,TRUE,,TRUE,IncludeCriminalIndicators,IncludeNonRegulatedVehicleSources).v1_ret);
				 
doxie.Layout_VehicleSearch getRaw(Filtered_wseq L,FT R) :=
TRANSFORM
	//SELF.pick := L.wd_person_source;
	SELF.source := doxie_build.buildstate;
	SELF := R;
END;

boolean FullNameMatched (FT R, string f_name, string m_name, string l_name) := FUNCTION
  return ((f_name = '' OR f_name = R.own_1_fname) AND
          (m_name = '' OR m_name = R.own_1_mname) AND
          (l_name = '' OR l_name = R.own_1_lname)) OR
         ((f_name = '' OR f_name = R.own_2_fname) AND
          (m_name = '' OR m_name = R.own_2_mname) AND
          (l_name = '' OR l_name = R.own_2_lname)) OR
         ((f_name = '' OR f_name = R.reg_1_fname) AND
          (m_name = '' OR m_name = R.reg_1_mname) AND
          (l_name = '' OR l_name = R.reg_1_lname)) OR
         ((f_name = '' OR f_name = R.reg_2_fname) AND
          (m_name = '' OR m_name = R.reg_2_mname) AND
          (l_name = '' OR l_name = R.reg_2_lname));
END;

boolean NameMatched (FT R) := FUNCTION
  return FullNameMatched (R, fname_val, mname_val, lname_val) OR
         FullNameMatched (R, fname_pref, mname_pref, lname_val);
END;

//check if user requests historical, expired, or current records
timelineMatch (string1 hist) := hist in tline_allow;

// NOTE: logic of EXPIRED records found to be different between wildcard and vehicle party:
// Wildcard Expired logic: "An Expired Registration is defined as a registration that has an expiration date in the past at the time of the build, but no more than twelve months in the past"
// Vehicle Party Expired logic: "An Expired flag will be set when no current record for same vehicle_key and iteration key and registration latest effective date within 12 months at the time of build"
// as a result expired records in wild file pulls flag from party record that could be either 'E' or 'H'
// So, we expect wildfile to contain only CURRENT('') or EXPIRED('E','H') records
FT hname(FT L) := transform
	historyConstant := VehicleV2_services.Constant.HISTORY;	
	self.history := if(L.history not in historyConstant.CURRENT,'E',L.history);
	self.history_name := if(L.history not in historyConstant.CURRENT,'EXPIRED',L.history_name);
	self := L;
end;

toOut := project(FT(
	NameMatched(FT) and 
	mod_access.isValidDppaState(orig_state, , source_code) and
	timelineMatch(history) and
	state_value in [reg_1_state,''] and
	county_value in [reg_1_county_name,'']
), hname(left));

// there could be duplicates in the output (say, upto 4 different "people" per vehicle);
// from another side we have to ensure MaxResults_val records returned, so here we have some
// overhead, but it allows to remove duplicates and enforce MaxResults_val returned.

results_out := SORT(CHOOSEN (toOut, REAL_LIMIT),seq);
	 		                         	 
	 // inputfile, outputfile, ssnfield, DLfield, maskSSN, maskDL
	 // now mask the SSN and the DL numbers
suppress.MAC_Mask(results_out, outf_c, own_1_ssn, OWN_1_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_c, outf_d, own_2_ssn, OWN_2_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_d, outf_e, reg_1_ssn, REG_1_DRIVER_LICENSE_NUMBER, true, true);
suppress.MAC_Mask(outf_e, results_cleaned, reg_2_ssn, REG_2_DRIVER_LICENSE_NUMBER, true, true);

result_return := results_cleaned;
	 
// Sort Filtered by TAG, id, and name to create unique ordering
outfile := SORT(result_return, make_code, -model_description, LICENSE_PLATE_NUMBERxBG4, VID, own_1_lname, own_1_fname, own_1_mname, pick);

doxie.MAC_Marshall_Results(outfile,outf);

// NOTE: A lot of the above code in this attr is from the doxie.* files related to the MVR wildcard search
// There are some additions because VehicleV2_Services.VehicleRegSearchService needed to read
// in sets of values in some cases e.g. makes/models yet still maintain the input functionality 
// that is currently working and needed for the MVR search query e.g. just 1 value input for make/model
// all recs from regular MVR search query 
// returned using this call: EXPORT getVehRecs := VehicleV2_Services/Get_Vehicle_Records
// which is at top of this attribute.
// NOTE: regstate input from doxie.wildcard_search  is not used in this query
/////////////////////////////////////////////////////////////////////////////////////////////////
 wildCardRecsTmp := outf;

 string restrictedCONSTANT := 'RESTRICTED'; // same as what
 // Polk_Code_Translations.ErrorCodes('520') returns.
// this is a ref to what gateway returns
 // when DPPA/glb is not good enough eg dppa=8/glb=1.  Thus needed this constant to filter out
 // the 'RESTRICTED' rec that is returned from experian gateway to remove rec from final output
 //  This comes as a result of noFail being passed in by VehicleV2_Services.VehicleRegSearchService
 // as a constant to VehicleV2_Services.IParam.getSearchModule in order to bypass the
 // experian gateway error code so that wildcard search above here can be preformed.
 
	 VehicleV2_Services.Layouts.layout_MVRRegistrationExtra toOutRecord (recordof(wildCardRecsTmp) L) := TRANSFORM
		SELF.DataSource := L.Source;
		//SELF.ExternalKey := //(String)l.Vehicle_Key+l.Iteration_Key+l.Sequence_Key;
		//SELF.AlsoFound := L.is_deep_dive;
		SELF.NonDMVSource := L.NonDMVSource;
		SELF.DateLastSeen.Year := (INTEGER) ((string) L.dt_last_seen)[1..4];
		SELF.DateLastSeen.Month := (INTEGER) ((string) L.dt_last_seen)[5..6];
		SELF.DateLastSeen.DAY := (INTEGER) 0;		
		SELF.VehicleInfo := PROJECT(L, TRANSFORM(iesp.motorvehicle.t_MotorVehicleSearchVehicleInfo,
			SELF.VehicleRecordId := LEFT.VID; 			
			SELF.VIN := LEFT.orig_vin;
			SELF.YearMake := (INTEGER4) LEFT.year_make;
			SELF.Make := LEFT.make_description;
			SELF.Model := LEFT.model_description;
			//SELF.Series := LEFT.vina_vp_series;
			SELF.Series := LEFT.series_description;
			SELF.MajorColor := LEFT.major_color_code;
			SELF.MinorColor := LEFT.minor_color_code;
			//SELF._Type := LEFT.vehicle_type_description;
			SELF.Style := LEFT.body_style_description;
			SELF.StateOfOrigin := LEFT.orig_state;			
			//SELF.MatchCode := LEFT.matchCode;			
			SELF := [];
		));
				
     Registrant1 := PROJECT(L, TRANSFORM(iesp.motorvehicle.t_MotorVehicleSearchRegistrant, 																	
		                  SELF.RegistrantInfo.HasCriminalConviction := LEFT.reg_1_hascriminalconviction;
											SELF.RegistrantInfo.IsSexualOffender := LEFT.reg_1_hascriminalconviction;
											SELF.RegistrantInfo.UniqueId := (STRING) LEFT.reg_1_did;                  																									 
											SELF.RegistrantInfo.SSN := (STRING) LEFT.reg_1_ssn;		
											SELF.RegistrantInfo.DOB.Year := (INTEGER) LEFT.reg_1_dob[1..4];
											SELF.RegistrantInfo.DOB.Month := (INTEGER) LEFT.reg_1_dob[5..6];
											SELF.RegistrantInfo.DOB.DAY := (INTEGER) LEFT.reg_1_dob[7..8];
											SELF.RegistrantInfo.Gender := CASE(LEFT.reg_1_sex,
                                                          'F' => 'Female',
																													'M' => 'Male',
																													''); // VALUES of M, F, U;
											SELF.RegistrantInfo.DriverLicenseNumber := LEFT.Reg_1_driver_license_number;	
											SELF.RegistrantInfo.BusinessName := LEFT.reg_1_company_name;
                     
											SELF.RegistrantInfo.Name := iesp.ecl2esp.setName(LEFT.reg_1_fname,
																																					LEFT.reg_1_mname,
																																					LEFT.reg_1_lname,
																																					LEFT.reg_1_name_suffix,
																																					LEFT.reg_1_title,
																																					'');
		 		               // probably don't want to call Address cleaner for every rec from wildcard search
				
											SELF.RegistrantInfo.Address := iesp.ECL2ESP.SetAddress(
																	//left.prim_name,left.prim_range,left.predir,left.postdir,
																	'','','','',
																	//left.suffix,left.unit_desig,left.sec_range,
																	'','',LEFT.reg_1_APARTMENT_NUMBER,
																	//left.v_city_name,
																	LEFT.reg_1_city,
																	// '',''
																	LEFT.reg_1_state,L.reg_1_zip5,
																	//left.zip4,
																	'',
																	LEFT.reg_1_county_name,'',LEFT.reg_1_street_address,'','');         
												SELF.RegistrationInfo.TrueLicensePlate := LEFT.license_plate_numberxbg4;
												SELF.RegistrationInfo.LicenseState := LEFT.orig_state;												
												SELF := [];
												));
      Registrant2 := PROJECT(L, TRANSFORM(iesp.motorvehicle.t_MotorVehicleSearchRegistrant, 	
			
		                  SELF.RegistrantInfo.HasCriminalConviction := LEFT.reg_2_hascriminalconviction;
											SELF.RegistrantInfo.IsSexualOffender := LEFT.reg_2_hascriminalconviction;
											SELF.RegistrantInfo.UniqueId := (STRING) LEFT.reg_2_did;
											SELF.RegistrantInfo.SSN := (STRING) LEFT.reg_2_ssn;		
											SELF.RegistrantInfo.DOB.Year := (INTEGER) LEFT.reg_2_dob[1..4];
											SELF.RegistrantInfo.DOB.Month := (INTEGER) LEFT.reg_2_dob[5..6];
											SELF.RegistrantInfo.DOB.DAY := (INTEGER) LEFT.reg_2_dob[7..8];
											SELF.RegistrantInfo.Gender := case(LEFT.reg_2_sex,
                                                          'F' => 'Female',
																													'M' => 'Male',
																													''); // VALUES of M, F, U;
											SELF.RegistrantInfo.DriverLicenseNumber := LEFT.reg_2_driver_license_number;		
											SELF.RegistrantInfo.BusinessName := LEFT.reg_2_company_name;
                    
											SELF.RegistrantInfo.Name := iesp.ecl2esp.setName(LEFT.reg_2_fname,
																																					LEFT.reg_2_mname,
																																					LEFT.reg_2_lname,
																																					LEFT.reg_2_name_suffix,
																																					LEFT.reg_2_title,
																																					'');
											SELF.RegistrantInfo.Address := iesp.ECL2ESP.SetAddress(
																	//left.prim_name,left.prim_range,left.predir,left.postdir,
																	'','','','',
																	//left.suffix,left.unit_desig,left.sec_range,
																	'','',LEFT.reg_2_APARTMENT_NUMBER,
																	//left.v_city_name,
																	LEFT.reg_2_city,
																	LEFT.reg_2_state,L.reg_2_zip5,
																	//left.zip4,
																	'',
																	LEFT.reg_2_county_name,'',LEFT.reg_2_street_address,'','');         												
												SELF := [];
												));												
												
      SELF.Registrants := choosen(Registrant1+Registrant2,iesp.Constants.MV.MaxCountRegistrants);
		 SELF.unacceptableInput := badSearch; // use this field as flag to trigger roxie eror code		 	
		SELF := []		
	END;
	
 WildRecsToIESP := IF (~badSearch, PROJECT (WildCardRecsTmp, toOutRecord(LEFT)));                                   
	 
	// Now filter the recs form the Regular MVR search based on Current/historical/expired
	// AND also by color if that condition applies.  
	// NOTE : mvr wildcard search results have these filters applied.
	CURRENT_HISTORICAL_FILTER := CASE (tline_allow,
	                  VehicleV2_Services.Constant.HISTORY.CURRENT => 'CURRENT',
										VehicleV2_services.Constant.HISTORY.EXPIRED  => 'HISTORICAL',																				         
														 'ALL');
  // this accounts for regular MVR search having both HISTORICAL and EXPIRED as we want both if EXPERIED is PASSED IN
	// so use 2nd filter here as well.
  CURRENT_HISTORICAL_FILTER2 := IF (CURRENT_HISTORICAL_FILTER = 'HISTORICAL', 'EXPIRED', '');													 
  // if neither we can shortcut filter here and just use 																											
	// Filter out current/historical info from the regular MVR search results
	
	  mvrSearchIESPResults := PROJECT(getVehRecs.iespREsults, transform(VehicleV2_Services.Layouts.layout_MVRRegistrationExtra,
		                               SELF.seqNumber := counter;
																	 SELF := LEFT,
																	 SELF := []));
    // filter out rows with currrent/historical registrants.
	  filteredMVRSearchIespResults := PROJECT(mvrSearchIESPResults,
		            TRANSFORM(VehicleV2_Services.Layouts.layout_MVRRegistrationExtra,															
						vehicleRegistrants := 
					PROJECT(left.registrants,  
						TRANSFORM( iesp.motorvehicle.t_MotorvehicleSearchRegistrant,
	                self := left));									
									tmpCount := COUNT(vehicleRegistrants);
									tmpVehicleRegistrantsFiltered := vehicleRegistrants(historyDescription = CURRENT_HISTORICAL_FILTER OR                         
									                                                    historyDescription = CURRENT_HISTORICAL_FILTER2 OR
									                                                 historyDescription = '');
                  // dont' filter out any recs if default is both current/historical recs																													   
                  VehicleRegistrantsFiltered := IF (Current_historical_Filter = 'ALL',
                                                   vehicleRegistrants,
																									 tmpVehicleRegistrantsFiltered);
                  VehicleRegistrantsFilteredGender := IF (Sex_use = '' OR sex_use='A',
									                                      VehicleRegistrantsFiltered,
									                                      VehicleRegistrantsFiltered(RegistrantInfo.Gender[1] = sex_use OR
																												                           RegistrantInfo.Gender[1] = 'U')
																												);   
																												 
                 VehicleRegistrantsFilteredAge := If (ageRangeStart_ <> 0 and ageRangeEnd_ <> 0,										                                       
																											  VehicleRegistrantsFilteredGender( 
																												 ((((RegistrantInfo.DOB.Year * 10000) + (RegistrantInfo.DOB.Month *100) +  RegistrantInfo.DOB.DAY) 
																												          >= (INTEGER) (AgeStart[1..8])) AND
																												 (((RegistrantInfo.DOB.Year * 10000) + (RegistrantInfo.DOB.Month *100) +  RegistrantInfo.DOB.Day)
																																	<= (INTEGER) (AgeEND[1..8])))
																																									OR
																													RegistrantInfo.DOB.Year = 0),
																												VehicleRegistrantsFilteredGender																																									 
																												);
									tmpCountFiltered := COUNT(VehicleRegistrantsFilteredAge);									
             SELF.Registrants := vehicleRegistrantsFilteredAge;								 
						 self := IF (tmpCountFiltered > 0 OR tmpCount = 0, LEFT);											 
						 ))(VehicleInfo.vin <> '' AND VehicleInfo.Vin <> restrictedCONSTANT);			

 // filter out DOB and gender by owner:
 
  filteredMVROwners := PROJECT(filteredMVRSearchIespResults,
		            TRANSFORM(VehicleV2_Services.Layouts.layout_MVRRegistrationExtra,															
						vehicleOwners := 
					PROJECT(left.owners,  
						TRANSFORM( iesp.motorvehicle.t_MotorVehicleSearchOwner,
	                self := left));									
									tmpCount := COUNT(vehicleOwners);
									
                 VehicleOwnersFilteredAge := If (ageRangeStart_ <> 0 and ageRangeEnd_ <> 0,										                                       
																									VehicleOwners(
																									((((OwnerInfo.DOB.Year * 10000) + (OwnerInfo.DOB.Month *100) +  OwnerInfo.DOB.Day)																																																																	                
																										>= (INTEGER) (AgeStart[1..8])) AND
																									(((OwnerInfo.DOB.Year * 10000) + (OwnerInfo.DOB.Month *100) +  OwnerInfo.DOB.Day)          
																										<= (INTEGER) (AgeEND[1..8])))
																										OR
																									OwnerInfo.DOB.Year = 0),																												            																																		
																												VehicleOwners																																									 
																												);
                   VehicleOwnersGender := IF (Sex_use = '' OR sex_use='A',
									                                      VehicleOwnersFilteredAge,
									                                      VehicleOwnersFilteredAge(OwnerInfo.Gender[1] = sex_use OR
																												                           OwnerInfo.Gender[1] = 'U')
																												);   																												
									tmpCountFiltered := COUNT(VehicleOwnersGender);									
             SELF.Owners := vehicleOwnersGender;								 
						 self := IF (tmpCountFiltered > 0 OR tmpCount = 0, LEFT);											 
						 ))(VehicleInfo.vin <> '' AND VehicleInfo.Vin <> restrictedCONSTANT);			
						 
  // filter out by color
	   filteredMVRSearchIespResults2Color :=  if ( ColorTmp <> '',		    
				filteredMVROwners(VehicleInfo.MajorColor = '' OR 
				Stringlib.StringToUpperCase(trim(VehicleInfo.MajorColor,left,right)) = ColorTmp OR
				Stringlib.StringToUpperCase(trim(VehicleInfo.MajorColor,left,right)) = ColorTmp2 OR				
				Stringlib.StringToUpperCase(trim(VehicleInfo.MajorColor,left,right)) = ColorTmp3 OR
				Stringlib.StringToUpperCase(trim(VehicleInfo.MajorColor,left,right)) = ColorTmp4),	
				filteredMVROwners);
			  
 // filter by year make
         filteredMVRSearchMakeYear := if (modelYearStart_use <> 0,
				 filteredMVRSearchIespResults2Color(VehicleInfo.YearMake >= ModelYearStart_use and
				                                    VehicleInfo.YearMake <= ModelYearEnd_use),
														filteredMVRSearchIespResults2Color);
																						
  filteredMVRSearch := filteredMVRSearchMakeYear;		                                                                		           
  // also do two joins here each a left outer that way if we don't have results from either search
	// we are sure to get the results combined.
	
  RegVehRecsRegSearchTmp := JOIN(filteredMVRSearch, WildREcsToIESP,	                         
														LEFT.VehicleInfo.VIN = RIGHT.VehicleInfo.Vin,
	                          TRANSFORM(VehicleV2_Services.Layouts.layout_MVRRegistrationExtra,														 
														// SELF.dt_last_seen := RIGHT.dt_last_seen;
														// SELF.Body_style_description := RIGHT.body_style_description;
                            SELF.RealTimeDataSearched := LEFT.DataSource = 'RealTime';													
														SELF := LEFT;																
														SELF := []), LEFT OUTER);
														
  RegVehRecsWildTmp := 		JOIN(WildREcsToIESP, getVehRecs.iespResults, 	                        
														LEFT.VehicleInfo.VIN = RIGHT.VehicleInfo.Vin,
	                          TRANSFORM(VehicleV2_Services.Layouts.layout_MVRRegistrationExtra,														
														// SELF.dt_last_seen := RIGHT.dt_last_seen;
														// SELF.Body_style_description := RIGHT.body_style_description;                            
														SELF := LEFT;																
														SELF := []), LEFT OUTER);
  // took this logic out because it was causing an extra empty record to be returned in
	// search results.
	//
  // flag for the possibility	of illegal input for the wildcard search
	// but got past above doxie error code but still want to flag it for showing that 
	// error code back in top level service so doing this here.
	// possibilities
	// 1.  0 recs in regular MVR search and 1 or more good recs in wildcard and unacceptableinput flag set to false.                                                                        
	// 2.  0 recs in regular MVR search and 1 default rec in wildcard and 'unacceptable input' flag set to true.
	// 3.  1 or more recs in MVR search and 1 more more good recs in wildcard and unacceptableInput set to false.
	// 4.  0 recs in regular MVR search and 0 recs in wildcard search 
  
	// this short cut of error logic above using 'unaccceptable input' is now removed.
  RegVehRecsWildCardRegSearchTmp := if (COUNT(RegVehRecsWildTmp) = 0 
	                                      AND EXISTS(RegVehRecsRegSearchTmp),
	                                    RegVehRecsRegSearchTmp,
	                                    RegVehRecsRegSearchTmp & RegVehRecsWildTmp);
  // dedup all the recs to get rid of dups.
	// then sort the recs by sequence number not equal to 0.
  // within that sort sort the realtime recs to the front/top of the result set
	// sort to the front of the result set.
	// then sort by the sequence number 
	// MVR recs from wildcard card search ("public" value in 'datasource' field sort to 
	// the end because 0 value in seqNumber due to 1st sort.
  RegVehRecsWildCardRegSearchSorted := sort(dedup(RegVehRecsWildCardRegSearchTmp,all, except seqNumber),
	                                             if (SeqNumber <> 0, 0, 1), if (DataSource = 'RealTime', 0, 1),  
																							 seqNumber); 								  
//
// debug start.

	// output(DataRestrictionMask, named('DataRestrictionMask'));	
	//output(choosen(pre_filtered,100), named('pre_filtered'));
	//getVehRecsOut := getVehRecs.iespResults;
	//output(ainput);
	// output(_make, named('_make'));
	// output(tmpMake, named('tmpMake'));
	// output(zipRadius_val, named('zipRadius_val'));
	// output(make_use, named('make_use'));
	// output(model_use, named('model_use'));
	// output(zip_use, named('zip_use'));
	//output(state_use, named('state_use'));
	// output(choosen(filtered_wseq,2000), named('filtered_wseq'));
	
	//output(getVehRecsOut, named('getVehRecsOut'));
	// output(unacceptable_inputs, named('unacceptable_inputs'));
	// output(badSearch, named('badSearch'));
	// output(wild_bad, named('wild_bad'));
	// output(regstate, named('regstate'));
	// output(regstate_use, named('regstate_use'));
	//output(MaxResults_val, named('MaxResults_val'));
	// output(MaxResultsThisTime_val, named('MaxResultsThisTime_val'));
	//output(WildRecsToIESP, named('WildRecsToIESP'));	
	// output(mvrSearchIESPResults, named('mvrSearchIESPResults'));
	
	// output(filteredMVROwners, named('filteredMVROwners'));
	// output(filteredMVRSearch, named('filteredMVRSearch'));
	// output(RegVehRecsRegSearchTmp, named('RegVehRecsRegSearchTmp'));
	// output(RegVehRecsWildTmp, named('RegVehRecsWildTmp'));
	// output(RegVehRecsWildCardRegSearchTmp, named('RegVehRecsWildCardRegSearchTmp'));
	// output(filteredMVRSearchIespResults, named('filteredMVRSearchIespResults'));
	// output(filteredMVRSearchIespResults2, named('filteredMVRSearchIespResults2'));
	//output(RegVehRecsWildCardRegSearchSorted, named('RegVehRecsWildCardRegSearchSorted'));
	
	//output(filteredMVRSearchIespResultsTitle, named('filteredMVRSearchIespResultsTitle'));
	//output(filtered_wseq, named('filtered_wseq'));
	//output(ft, named('ft'));
	// output(ageStart, named('ageStart'));
	// output(ageEnd, named('ageEnd'));
	   // output(_tline_temp1, named('_tline_temp1'));
		 // output(tline_temp1, named('tline_temp1'));
		 // output(tline_allow, named('tline_allow'));
		 // output(CURRENT_HISTORICAL_FILTER, named('CURRENT_HISTORICAL_FILTER'));
		 // output(CURRENT_HISTORICAL_FILTER2, named('CURRENT_HISTORICAL_FILTER2'));
		  //output(wildCardRecsTmp, named('wildCardRecsTmp'));
	    // output(mvrSearchIESPResults, named('mvrSearchIESPResults'));
		 //output(WildREcsToIESP, named('WildREcsToIESP'));
		 // output(RegVehRecsRegSearchTmp, named('RegVehRecsRegSearchTmp'));
		 // output(RegVehRecsWildCardRegSearchSorted, named('RegVehRecsWildCardRegSearchSorted'));
	 // output(filteredMVRSearchIespResults, named('filteredMVRSearchIespResults'));
	  // output(filteredMVROwners, named('filteredMVROwners'));
	 //output(filteredMVRSearchIespResults2Color, named('filteredMVRSearchIespResults2Color'));
	 // output(VehicleRegistrantsFilteredGender, named('VehicleRegistrantsFilteredGender'));
	 // output(VehicleRegistrantsFilteredAge, named('VehicleRegistrantsFilteredAge'));
	 // output(RegVehRecsWildCardRegSearchSorted, named('RegVehRecsWildCardRegSearchSorted'));
	// output(city_value, named('city_value'));
	// output(zipcnty_set, named('zipcnty_set'));
	// output(county_val, named('county_val'));
	// output(state_val, named('state_val'));
	// output(zipradius_value, named('zipradius_value'));
	//output(wildCardRecstmp, named('wildCardRecsTmp'));
	EXPORT RegVehRecsWildCardRegSearch := RegVehRecsWildCardRegSearchSorted;
  END;
  