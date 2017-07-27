IMPORT AutoKeyB2,AutoKeyI,doxie, ut, ECRulings;

EXPORT Autokey_Ids := MODULE
	
	export val(IParam.autokey_search in_mod) := function
	  ak_keyname := ECRulings.Constants().autokey_qa_root;
		ak_dataset := ECRulings.File_SearchAutoKey;
		ak_skipSet := ECRulings.Constants().autokey_buildskipset;
		ak_typestr := 'AK';
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := ak_keyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups := true;
		end;
		// get fake ids from autokey files here
		fake_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

		AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl,did , bdid, ak_typeStr)
		
	  results	:= dedup(sort(outpl, fakeid), fakeid); 
		RETURN results;

	END;
END;