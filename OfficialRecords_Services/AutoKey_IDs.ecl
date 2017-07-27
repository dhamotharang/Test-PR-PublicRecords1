import AutoKeyB2,AutoKeyI,doxie,official_records,ut;

export AutoKey_IDs := MODULE
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard   := true;
		export boolean noFail     := false;
		export boolean isdeepDive := false;
	end;
	
	export val(params in_mod) := function
		ak_keyname := official_records.Constants.ak_keyname;
		ak_dataset := official_records.Constants.ak_dataset;
		ak_skipSet := official_records.Constants.ak_skipset;
		ak_typestr := official_records.Constants.ak_typeStr;
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := ak_keyname;
			export string typestr              := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups       := true;
	  end;
    
		// Get fake-ids from autokey files depending upon search field(s) entered
		fake_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

    // Use fake-ids to get records from the autokey payload file
	  //AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, b_did, ak_typeStr)
		AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl, zero, zero, ak_typeStr)
		
		// Dedup, sort & project the payload records to get the orids involved
		by_auto := dedup(sort(project(outpl,
	        	                      transform (OfficialRecords_Services.Layouts.search,
			 	  				                           self := left )),record),record);

    //Uncomment lines below as needed to assist in debugging
 	  //output(fake_ids,named('akids_fake_ids'));
	  //output(by_auto,named('akids_by_auto'));

		return by_auto;
	
	end;
	
end;
