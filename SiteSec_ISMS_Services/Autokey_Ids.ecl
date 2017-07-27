IMPORT AutoKeyB2,AutoKeyI,doxie, ut, SiteSec_ISMS;

EXPORT Autokey_Ids := MODULE
	
	export val(IParam.autokey_search in_mod) := function
	  ak_keyname := SiteSec_ISMS.Constants('').ak_qa_keyname;
		ak_dataset := SiteSec_ISMS.Constants('').ak_dataset;
		ak_skipSet := SiteSec_ISMS.Constants('').ak_skipset;
		ak_typestr := SiteSec_ISMS.Constants('').ak_typeStr;
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := ak_keyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups := true;
		end;
		// get fake ids from autokey files here
		fake_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
			
		AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl,did , bdid, ak_typeStr)

		RETURN outpl;

	END;
END;