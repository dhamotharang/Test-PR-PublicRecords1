IMPORT AutoKeyB2,AutoKeyI,doxie, ut, LaborActions_MSHA;

EXPORT Autokey_Ids := MODULE
	
	SHARED autokey_lookup(in_mod, in_ak_keyname, in_ak_dataset, in_ak_skipSet, in_ak_typeStr) := functionmacro
		ak_keyname := in_ak_keyname;
		ak_dataset := in_ak_dataset;
		ak_skipSet := in_ak_skipSet;
		ak_typestr := in_ak_typeStr;
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := ak_keyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups := true;
		end;
		// get fake ids from autokey files here
		fake_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

		AutokeyB2.mac_get_payload(fake_ids, ak_keyname, ak_dataset, outpl,did , bdid, ak_typeStr)
		
	  results	:= dedup(outpl, fakeid, ALL, HASH);  
		RETURN results;
			
	endmacro;
	
	export contractor_val(IParam.autokey_search in_mod) := function
		RETURN(autokey_lookup(in_mod,
													LaborActions_MSHA.Constants(,'base_contractor').ak_qa_keyname,
													LaborActions_MSHA.Constants().ak_dataset_contractor,
													LaborActions_MSHA.Constants().ak_skipSet,
													LaborActions_MSHA.Constants().ak_typeStr));

	END;
	
	export controller_val(IParam.autokey_search in_mod) := function
		RETURN(autokey_lookup(in_mod,
													LaborActions_MSHA.Constants(,'base_mine::controller').ak_qa_keyname,
													LaborActions_MSHA.Constants().ak_dataset_mine,
													LaborActions_MSHA.Constants().ak_skipSet,
													LaborActions_MSHA.Constants().ak_typeStr));


	END;
	
	export mine_val(IParam.autokey_search in_mod) := function
		RETURN(autokey_lookup(in_mod,
														LaborActions_MSHA.Constants(,'base_mine::mine').ak_qa_keyname,
														LaborActions_MSHA.Constants().ak_dataset_mine,
														LaborActions_MSHA.Constants().ak_skipSet,
														LaborActions_MSHA.Constants().ak_typeStr));

	END;
	
	export operator_val(IParam.autokey_search in_mod) := function
		RETURN(autokey_lookup(in_mod,
													LaborActions_MSHA.Constants(,'base_mine::operator').ak_qa_keyname,
													LaborActions_MSHA.Constants().ak_dataset_mine,
													LaborActions_MSHA.Constants().ak_skipSet,
													LaborActions_MSHA.Constants().ak_typeStr));

	END;
	
	export val(IParam.autokey_search in_mod) := function
						
			payload_record := Layouts.rawrec;
						
			contractor_recs := PROJECT(contractor_val(in_mod),TRANSFORM(payload_record,SELF := LEFT, SELF := []));
			controller_recs := PROJECT(controller_val(in_mod),TRANSFORM(payload_record,SELF := LEFT, SELF := []));
			mine_recs := PROJECT(mine_val(in_mod),TRANSFORM(payload_record,SELF := LEFT, SELF := []));
			operator_recs := PROJECT(operator_val(in_mod),TRANSFORM(payload_record,SELF := LEFT, SELF := []));
			
			all_recs := DEDUP(SORT(contractor_recs+controller_recs+mine_recs+operator_recs,RECORD),RECORD);
	
			return(all_recs);
	END;
	
	
END;