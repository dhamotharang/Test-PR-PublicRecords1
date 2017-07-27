import AutoKeyB2;

export Proc_build_Ntl_autokey(string filedate) := function

ntl_dataset := Constants.ntl_dataset;
ntl_keyname := Constants.ntl_keyname;
ntl_logical := Constants.ntl_logical(filedate);
ak_skipSet := Constants.ak_skipSet;
ak_typeStr := Constants.ak_typeStr;

AutoKeyB2.MAC_Build (ntl_dataset
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
					,ntl_keyname
					,ntl_logical
					,outaction,false
					,ak_skipSet,true,ak_typeStr
					,true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(ntl_keyname, mymove,, ak_skipset);

retval := sequential(outaction,mymove);

return retval;

end;