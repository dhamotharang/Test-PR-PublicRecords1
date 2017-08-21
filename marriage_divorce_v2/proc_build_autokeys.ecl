import AutoKeyB2; 

export proc_build_autokeys(string filedate) := function

c						:= constants(filedate);
ak_keyname	:= c.ak_keyname;
ak_logical	:= c.ak_logical;
ak_dataset	:= c.ak_dataset;
ak_skipSet	:= c.ak_skipSet;
ak_typeStr	:= c.ak_typeStr;

AutoKeyB2.MAC_Build (ak_dataset,name.fname,name.mname,name.lname,
						zero,
						party_dob,
						zero,
						addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						DID,
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						ak_keyname,
						ak_logical,
						outaction,false,
						ak_skipSet,true,ak_typeStr,
						true,,,zero); 

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove)

retval := sequential(outaction,mymove);
 
return retval;

end;