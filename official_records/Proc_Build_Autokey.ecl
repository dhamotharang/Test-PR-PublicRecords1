import AutoKeyB2;

string filedate := official_records.Version_Development;

export Proc_Build_Autokey := function

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
					// AutokeyB2.MAC_Build doesn't like non-business address parts all set to the 
					// same "blank" attribute, so individual address blank attributes 
					// (except for state and city) were used.
					,blank_prim_name,blank_prim_range,per_state,city,blank_zip5,blank_sec_range
					,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero
					// AutokeyB2.MAC_Build doesn't like the same "zero" attribute used for both 
					// did & bdid, so individual attributes were used.
					,zeroDID
					,cname
					,zero
					,zero
					,blank,blank,bus_state,city,blank,blank
          ,zeroBDID
					,ak_keyname
					,ak_logical
					,outaction,false
					,ak_skipSet,true,ak_typeStr
					,true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, ak_skipset);

retval := sequential(outaction,mymove);

return retval;

end;