import AutoKeyB2, AutoKeyI, doxie, SexOffender, AutoStandardI;

export AutoKey_IDs := MODULE

	export val(SexOffender_Services.IParam.ids_params in_mod) := function
	
		ak_keyname := SexOffender.Constants.ak_keyname;
		ak_dataset := SexOffender.Constants.ak_dataset;
		ak_skipSet := SexOffender.Constants.ak_skipset;
		ak_typestr := SexOffender.Constants.ak_typeStr;
		
		// inputs
		location_value := AutoStandardI.InterfaceTranslator.location_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.location_value.params));
		SearchAroundAddress_value := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params));

		// If we're searching by Lat/Long, we need to disable other location-based fetches
		skipLoc := SearchAroundAddress_value and (location_value.latitude<>0.0 or location_value.longitude<>0.0);
		skipSet := if(skipLoc, ak_skipSet+['C','B'], ak_skipSet);
		
		// Get fake-ids from autokey files depending upon search field(s) entered.
		fake_ids := AutoKeyB2.get_ids(
			ak_keyname,					// STRING t, 
			ak_typeStr,					// string typestr='', 
			skipSet,						// set of STRING1 get_skip_set=[], 
			true,								// boolean PworkHard = true,
			false,							// boolean nofail =true,
			SexOffender.MFetch	// Autokey.IFetch visitor = MODULE (Autokey.IFetch) END,
													// AutokeyB.IFetch visitorb = MODULE (AutokeyB.IFetch) END
		);
		
    // Use fake-ids to get records from the autokey payload file
	  AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr)
		
		// Dedup, sort & project the payload records to get the seisint primary keys involved.
		by_auto := dedup(sort(project(outpl,
	        	                      transform (SexOffender_Services.Layouts.search,
			 	  				                           self := left )),record),record);

    //Uncomment lines below as needed to assist in debugging
 	  //output(fake_ids,named('akids_fake_ids'));
	  //output(by_auto,named('akids_by_auto'));
	  //output(in_mod.latitude,named('in_mod_latitude'));
	  //output(in_mod.longitude,named('in_mod_longitude'));

		return by_auto;
	
	end;
	
end;
