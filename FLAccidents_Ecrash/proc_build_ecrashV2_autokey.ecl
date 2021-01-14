IMPORT AutoKeyB2;
IMPORT dx_eCrash AS dx;

EXPORT Proc_build_ecrashV2_autokey(STRING filedate) := FUNCTION

ak_skipSet := dx.Constants.ak_skipSet;
ak_typeStr := dx.Constants.ak_typeStr;

ak_keyname  := dx.Constants.ak_keyname;
ak_logical	:= dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ECRASHV2_AUTOKEY + '::';

ak_dataset	:= File_Ecrash_AutoKeyV2;

AutoKeyB2.MAC_Build (ak_dataset
					,fname,mname,lname
					,zero
					,zero
					,zero
					,prim_name,prim_range,st,v_city_name,zip5,sec_range
					,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero
					,DID
					,b_name
					,zero
					,zero
					,b_prim_name,b_prim_range,b_st,b_v_city_name,b_zip5,b_sec_range
          ,b_did
					,ak_keyname
					,ak_logical
					,outaction,FALSE
					,ak_skipSet,TRUE,ak_typeStr
					,TRUE,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, ak_skipset);

retval := SEQUENTIAL(outaction,mymove);

RETURN retval;

END;
