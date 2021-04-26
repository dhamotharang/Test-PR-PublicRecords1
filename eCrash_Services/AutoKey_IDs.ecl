import AutoKeyI, dx_eCrash, AutokeyB2;

export AutoKey_IDs(IParam.autokey_search in_mod) := function
		
		ak_keyname := dx_eCrash.Constants.ak_keyname;
		ak_dataset := dx_eCrash.Constants.ak_dataset;
		ak_skipSet := dx_eCrash.Constants.ak_skipset;
		ak_typestr := dx_eCrash.Constants.ak_typeStr;
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := ak_keyname;
			export string typestr              := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups       := true;
	  end;
    
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
    
	  AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, b_did, ak_typeStr)
		
		by_auto := dedup(sort(project(outpl, 
	        	                      transform (Layouts.search,
			 	  				                           self.reportnumber := left.accident_nbr;self := []; )),record),record);
		return by_auto;
end;