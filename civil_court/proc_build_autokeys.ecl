import AutoKeyB2, civil_court;

export Proc_Build_Autokeys(string filedate) := function

ak_dataset := civil_court.Constants('').ak_dataset;
ak_keyname := civil_court.Constants('').ak_keyname;
ak_logical := civil_court.Constants(filedate).ak_logical;
ak_skipSet := civil_court.Constants('').ak_skipSet;
ak_typeStr := civil_court.Constants('').ak_typeStr;

AutoKeyB2.MAC_Build (ak_dataset
					,fname,mname,lname
					,zero
					,zero
					,zero
					//AutokeyB2.MAC_Build doesn't like non-business address parts all set to the same 
					// "blank" attribute, so individual blank attributes were used.
					,blank_prim_name,blank_prim_range,state,city,blank_zip5,blank_sec_range
					,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero,zero,zero
					,zero
					// AutokeyB2.MAC_Build doesn't like the same "zero" attribute used for both did & bdid,
					// so individual attributes were used.
					,zeroDID
					,companyname
					,zero
					,zero
					//prim_name,prim_range,st,p_city_name,zip,sec_range,
					,blank,blank,state,city,blank,blank
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