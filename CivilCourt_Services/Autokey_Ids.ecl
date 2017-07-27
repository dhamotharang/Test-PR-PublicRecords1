import AutoKeyB2,AutoKeyI,doxie,civil_court, ut;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;
	export val(params in_mod) := function
	  ak_keyname := civil_court.Constants('').ak_QAname;
		ak_dataset := civil_court.Constants('').ak_dataset;
		ak_skipSet := civil_court.Constants('').ak_skipset;
		ak_typestr := civil_court.Constants('').ak_typeStr;
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := ak_keyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups := true;
		end;
		// get fake ids from autokey files here
		fake_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
		
		// hitting company keys and person keys.
		
		AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl, zero , zero, ak_typeStr)
		
		by_auto := dedup(sort(project(outpl,
	      	transform (Layouts.caseIdLayout, 
								 self := left )),record),record);
		
		results	:= dedup(sort(by_auto, case_key), case_key);
		return results;
	end;
end;