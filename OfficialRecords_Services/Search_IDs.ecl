import doxie,doxie_raw;

export Search_IDs := MODULE

	export params := interface(AutoKey_IDs.params)
	end;
		
	export val(params in_mod) := function
	
    // NOTE: Either person name or companyname must be entered, the other search 
    // fields: State, County, FilingDateRange StartDate/EndDate are just for 
    // filtering, not searching.
		
		// Search using autokeys
		by_auto	:= OfficialRecords_Services.AutoKey_IDs.val(in_mod);

	  temp_orids := by_auto;
		 
		orids_deduped := dedup(sort(temp_orids, official_record_key), 
		                       official_record_key);
		
    //Uncomment lines below as needed to assist in debugging
    //output(by_auto,named('si_by_auto'));
		//output(temp_orids,named('si_temp_orids'));
		//output(orids_deduped,named('si_orids_deduped'));

		return orids_deduped;
	end;
	
end;