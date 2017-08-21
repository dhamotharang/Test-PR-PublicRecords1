
import iesp, ut, doxie, NID;
import BairRx_Common, Bair_composite, Bair_ExternalLinkKeys;


//
// Assumption is that the wildcard search parameters have already been vetted at this point
// code based on doxie.Wildcard_Search_Local

export GetWildcardRecords(BairRx_PSS.IParam.VehicleSearchParam in_params, BairRx_PSS.WParam.VehicleWildcardSearchParam wc_params) := function

	wildfile := Bair_composite.Key_Vehicle_Wild();
	WILDFILE_READ_LIMIT := 50000; // to avoid excessive reading before postfiltering
	KeyEIDHash 	:= Bair_ExternalLinkKeys.Key_eid_hash();
	
	
	// matching the plate #
	string tag_blur := ut.blur(wc_params.Tag);
	boolean fnTagMatch(string25 tag) := function
		v := map(wc_params.Tag = '' or wc_params.Tag = tag => true,
             wc_params.UseTagBlur    => StringLib.StringFind(ut.blur(tag), tag_blur, 1) > 0,
		         wc_params.DoTagContains => StringLib.StringContains(tag, wc_params.Tag, TRUE),
		         wc_params.doWildTag     => stringlib.StringWildMatch(tag, wc_params.Wild_Tag, true),
		            false);
		return(v);
	end;
	
	TagMatch := fnTagMatch(wildfile.wd_plate_number);

	// matching the VIN (no contains search)
	boolean fnVINMatch(string27 vin) := function
		v := MAP(wc_params.VIN = ''   => TRUE,
  	         wc_params.doWildVIN  => stringlib.StringWildMatch(vin, wc_params.Wild_VIN, true),
		         wc_params.VIN = vin);
		return(v);
	end;
	VINMatch := fnVINMatch(wildfile.wd_vin);


	// Zip5 wildcard matching
	boolean fnWildZipMatch(unsigned3 zip) := function
		v := MAP(wc_params.doWildZip => stringlib.StringWildMatch((string5)zip, wc_params.Wild_Zip, true),
						 true);
		return(v);
	end;
	WildZipMatch := fnWildZipMatch(wildfile.wd_zip);

	// Age range
	CurrentYear := (INTEGER)(stringlib.GetDateYYYYMMDD()[1..4]);
	boolean fnAgeMatch(unsigned1 years_since_1900) := function
		age := currentYear - (1900 + years_since_1900);
		v := wc_params.AgeLow = 0 OR 
	       wc_params.AgeHigh = 0 OR 
				 (wc_params.AgeLow-1 <= age AND wc_params.AgeHigh+1 >= age);
		return(v);
	end;
	AgeMatch := fnAgeMatch(wildfile.wd_years_since_1900);
	
	// matching the car year range
	boolean fnYearMatch(unsigned2 year_make) := function
		v := (wc_params.YearMakeLow   = 0 AND wc_params.YearMakeHigh = 0) OR
	       (wc_params.YearMakeLow  <= year_make AND (wc_params.YearMakeHigh >= year_make OR wc_params.YearMakeHigh = 0)) OR
	       (wc_params.YearMakeHigh >= year_make AND (wc_params.YearMakeLow  <= year_make OR wc_params.YearMakeLow = 0));
		return(v);
	end;
	YearMatch := fnYearMatch(wildfile.wd_year_make);


	// Gender match
	boolean fnGenderMatch(string1 gender) := function
		v := wc_params.gender NOT IN ['M', 'F'] OR wc_params.gender = gender;
		return(v);
	end;
	GenderMatch := fnGenderMatch(wildfile.wd_gender);

	unsigned3 bd := 0;

	// Combine matches
	pre_filtered := 
		limit(wildfile(keyed(wc_params.Make_codes  = [] or wd_make_code IN wc_params.Make_codes),             
		               keyed(wc_params.Model_codes = [] or wd_model_description IN wc_params.Model_codes),    
									 keyed(wc_params.Color_codes = [] or wd_color_code IN wc_params.Color_codes),           
		               keyed(wc_params.State_code  = 0  or wd_state_code = wc_params.State_code),             
		               keyed(wc_params.zips        = [] or wd_zip IN wc_params.zips),                    
									 keyed(bd = 0                     or wd_body_code = 0),                            
									 TagMatch,        
		               YearMatch,       
									 AgeMatch,        
		               GenderMatch,     
		               VINMatch,        
		               WildZipMatch),   
		      WILDFILE_READ_LIMIT, ONFAIL(TRANSFORM(Bair_composite.layouts.veh_wd_hole, self.wd_VIN:='FAILED', self:=[])));
					
					
	// Failure? Note that use of wc_params.doWildSearch in the iff below. This was needed because if no wild search params are entered, then the
	// above pre_filtered may result in a failure and the Fail was executing. Adding the additional boolean to the expression eliminated the problem.
	limitFailed := iff (exists(pre_filtered), (pre_filtered[1].wd_VIN='FAILED'), false);
	filtered := iff (wc_params.doWildSearch and limitFailed, Fail(wildfile, BairRx_Common.STDError.TooManyRecords, BairRx_Common.STDError.GetMessage(BairRx_Common.STDError.TooManyRecords)), pre_filtered);
	
	
	filtered_dedup := dedup(sort(filtered, eid), eid);

	hash_records := join(filtered_dedup, KeyEIDHash, Bair_composite.fn_scale_eid(left.eid) = right.eid_hash, 
	                     transform(right), keep(50), limit(2000, skip));
	
	//
	// Filter names based on the input name and preferred names (will also need to convert salt record name to preferred). From that
	// list get unique EIDs and joing back to original SALT results to get all records with those EIDs as they are related via the name.
	no_postfiltering := wc_params.FirstName='' and wc_params.MiddleName='' and wc_params.LastName='';   // name filtering?
	fname_pref := NID.PreferredFirstNew (stringlib.stringtouppercase(wc_params.FirstName));
	mname_pref := NID.PreferredFirstNew (stringlib.stringtouppercase(wc_params.MiddleName));
	
	lfetch := record
		KeyEIDHash.eid_hash;
		KeyEIDHash.fname;
		KeyEIDHash.mname;
		KeyEIDHash.lname;
	end;

	boolean FullNameMatch (lfetch r, string firstName, string midName, string lastName) := function
		return ((firstName = '' OR firstName = r.fname) and
						(midName   = '' OR midName   = r.mname) and
						(lastName  = '' OR lastName  = r.lname));
	end;

	boolean FullNameMatchPreferred (lfetch r, string firstName, string midName, string lastName) := function
		prefRecFirstName  := NID.PreferredFirstNew (stringlib.stringtouppercase(r.fname));
		prefRecMiddleName := NID.PreferredFirstNew (stringlib.stringtouppercase(r.mname));
		return ((firstName = '' OR firstName = prefRecFirstName)  and
						(midName   = '' OR midName   = prefRecMiddleName) and
						(lastName  = '' OR lastName  = r.lname));
	end;
	
	
	boolean NameMatch (lfetch r) := function
		return (FullNameMatch (r, wc_params.FirstName, wc_params.MiddleName, wc_params.LastName) OR
					  FullNameMatch (r, fname_pref, mname_pref, wc_params.LastName)                    OR
						fullNameMatchPreferred(r, fname_pref, mname_pref, wc_params.LastName));
  end;

	//
	// Join with external link keys based on eid to get just relevant name data.
	short_name_recs := join(filtered_dedup, KeyEIDHash, Bair_composite.fn_scale_eid(left.eid) = right.eid_hash, 
	                        transform(lfetch, self.eid_hash := right.eid_hash,
										 		                    self.fname := right.fname,
																						self.mname := right.mname,
																					  self.lname := right.lname),
													keep(50), limit(2000, skip));

	match_name_recs := short_name_recs(NameMatch(short_name_recs));
	name_eid_hash := dedup(sort(match_name_recs, eid_hash), eid_hash);
	hash_name_results := join(name_eid_hash, KeyEIDHash, left.eid_hash = right.eid_hash, transform(right),
	                          keep(50), limit(2000, skip));
	
	// results based on whether a name filter is applied or not. Then we need to set the match column to true so
	// records will be processed
	results_womatch := if (no_postfiltering, hash_records, hash_name_results);

	//
	// Functions to score vehicle and person records
	integer2 vehScore(KeyEIDHash r) := function
		score := if(wc_params.Makes = [], 0, if(r.wd_make IN wc_params.Makes, 2, -2)) +
		         if(wc_params.Models = [], 0, if(r.wd_model IN wc_params.Models, 2, -2)) +
						 if(wc_params.Colors = [], 0, if(r.wd_color IN wc_params.Colors, 2, -2)) +
						 if(wc_params.State = '', 0, if(r.st = wc_params.State, 2, -2))          +
						 if(wc_params.Tag = '', 0, if(fnTagMatch(r.plate), 2, -2))               +
						 if(wc_params.vin = '', 0, if(fnVINMatch(r.vin), 2, -2))                 +
						 if(wc_params.zips = [], 0, if((unsigned3)r.zip IN wc_params.zips or fnWildZipMatch((unsigned3)r.zip), 2, -2)) +
						 if(wc_params.YearMakeLow = 0 and wc_params.YearMakeHigh = 0, 0, if(fnAgeMatch((unsigned2)r.year), 2, -2));
		retval := if(BairRx_PSS.Constants.IsVehicleRecord(r.prepped_rec_type), score, 0);
		return(retval);
	end;

	integer2 personScore(KeyEIDHash r) := function
		
		nameRec := project(r, transform(lfetch, self := left, self := []));
		score :=  if(wc_params.gender = '', 0, if(fnGendermatch((string1)r.clean_gender), 2, -2))               +
		          if((wc_params.FirstName <> '' or wc_params.LastName <> ''), if(NameMatch(nameRec), 2, -2), 0) +    
							if(wc_params.AgeLow = 0 or wc_params.AgeHigh = 0, 0, if(fnAgeMatch(CurrentYear - 1900 - r.age), 2, -2));
		retval := if(BairRx_PSS.Constants.IsPersonalRecord(r.prepped_rec_type), score, 0);
		return(retval);
	end;

	BairRx_PSS.SALTLayout.LayoutOut finalLayoutXForm(KeyEIDHash r) := transform
		score :=  vehScore(r) + personScore(r);
		self.vehicle_match := vehScore(r) > 0;
		self.person_match := personScore(r) > 0;
		self.match := SELF.vehicle_match OR SELF.person_match,
		self.record_score := score; 
		self := r;
		self := [];
	end;
	
	results_unclean := project(results_womatch, finalLayoutXForm(left));
	results_clean := BairRx_Common.GroupAccessControl.Clean(results_unclean, in_params.agencyORI, data_provider_ori);
	// output(filtered, named('filtered'));
	// output(results_womatch, named('results_womatch'));  
	// output(wc_params, named('wc_params'));
	// output(results_clean, named('results_clean'));
	return(results_clean);

end;