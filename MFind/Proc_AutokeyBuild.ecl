import AutoKeyB2, mfind; 

export proc_autokeybuild(string filedate) := function

d2 := MFind.file_SearchAutokey;

skip_set := ['P','S','B'];

AutoKeyB2.MAC_Build (d2,name.fname,name.mname,name.lname,
						zero,
						zero,
						zero,
						addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						DID,
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						MFind.constant.str_AutokeyName,
						MFind.constant.str_AutokeyLogicalName(filedate),
						outaction,false,
						skip_set,true,'BC',
						true,,,zero); 


AutoKeyB2.MAC_AcceptSK_to_QA(MFind.constant.Str_autokeyName,mymove)
r := sequential(outaction,mymove);
 
return r;

end;
