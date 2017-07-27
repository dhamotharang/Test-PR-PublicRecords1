IMPORT AutoKeyI, AutoKeyB2, Ingenix_NatlProf, doxie, NPPES, AMS;

EXPORT AutoKey_Ids(IParams.searchParams input) := MODULE

		// SEARCH THE SANCTIONS AUTOKEYS
		tempmod_sanc := module(project(input,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := Ingenix_NatlProf.Constants.autokey_qa_name_sanc;
			export string typestr := ^.Ingenix_NatlProf.Constants.autokey_typeStr_sanc;
			export set of string1 get_skip_set := Ingenix_NatlProf.Constants.autokey_skip_set_sanc;
			export boolean useAllLookups := true;
			export boolean workHard := true;
		end;
	
		export sanctions := AutoKeyI.AutoKeyStandardFetch(tempmod_sanc).ids;
	
		// SEARCH THE PROVIDERS AUTOKEYS
		tempmod_prov := module(project(input,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := Ingenix_NatlProf.Constants.autokey_qa_name_prov;
			export string typestr := ^.Ingenix_NatlProf.Constants.autokey_typeStr_prov;
			export set of string1 get_skip_set := Ingenix_NatlProf.Constants.autokey_skip_set_prov;
			export boolean useAllLookups := true;
			export boolean workHard := true;
		end;
	
		export providers := AutoKeyI.AutoKeyStandardFetch(tempmod_prov).ids;	
		
		// SEARCH THE NPPES AUTOKEYS
		nppes_constants := NPPES.Constants();
		tempmod_nppes := module(project(input,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := nppes_constants.str_autokeyname;
			export string typestr := ^.nppes_constants.ak_typeStr;
			export set of string1 get_skip_set := nppes_constants.ak_skipSet;
			export boolean useAllLookups := true;
			export boolean workHard := true;
		end;
		
		export nppes := AutoKeyI.AutoKeyStandardFetch(tempmod_nppes).ids;
			
		// SEARCH THE AMS AUTOKEYS
		tempmod_AMS := module(project(input,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			EXPORT STRING autokey_keyname_root := AMS._Constants().AUTOKEY_NAME;
			EXPORT STRING typestr              := AMS._Constants().TYPE_STR;
			EXPORT SET OF STRING1 get_skip_set := AMS._Constants().autokey_buildskipset;
			EXPORT BOOLEAN workHard            := AMS._Constants().WORK_HARD;
			EXPORT BOOLEAN noFail              := AMS._Constants().NO_FAIL;
			EXPORT BOOLEAN useAllLookups       := AMS._Constants().USE_ALL_LOOKUPS;
		end;
		
		export ams := AutoKeyI.AutoKeyStandardFetch(tempmod_ams).ids;
END;