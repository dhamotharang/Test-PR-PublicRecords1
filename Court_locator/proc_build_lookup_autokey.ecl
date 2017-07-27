import AutoKeyB2;

export Proc_build_lookup_autokey(string filedate) := function

ak_dataset := Court_locator.Constants.ak_dataset;
ak_keyname := Court_locator.Constants.ak_keyname;
ak_logical := Court_locator.Constants.ak_logical(filedate);
ak_skipSet := Court_locator.Constants.ak_skipSet;
ak_typeStr := Court_locator.Constants.ak_typeStr;

AutoKeyB2.MAC_Build (ak_dataset
					,blank,blank,blank
					,zero
					,zero
					,zero
					,prim_name,prim_range,st,v_city_name,z5,b_sec_range
					,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero
					,zero
					,b_name
					,zero
					,b_phone
					,b_prim_name,b_prim_range,b_st,b_v_city_name,b_zip5,b_sec_range
          ,b_did
					,ak_keyname
					,ak_logical
					,outaction,false
					,ak_skipSet,true,ak_typeStr
					,true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, ak_skipset);

retval := sequential(outaction,mymove);

return retval;

end;