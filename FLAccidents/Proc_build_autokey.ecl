import AutoKeyB2;

export Proc_build_autokey := function
filedate := FLAccidents.Version_Development;

ak_dataset := Constants.ak_dataset;
ak_keyname := Constants.ak_keyname;
ak_logical := Constants.ak_logical(filedate);
ak_skipSet := Constants.ak_skipSet;
ak_typeStr := Constants.ak_typeStr;

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
					,outaction,false
					,ak_skipSet,true,ak_typeStr
					,true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, ak_skipset);

retval := sequential(outaction,mymove);

return retval;

end;