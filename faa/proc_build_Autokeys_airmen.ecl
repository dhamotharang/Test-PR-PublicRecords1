import AutoKeyB2,faa;

export proc_build_Autokeys_airmen(string filedate) := function

c						:= faa.faa_airmen_ak_constants(filedate); 
ak_keyname	:= c.str_autokeyname;
ak_logical	:= c.ak_logical(filedate);
ak_dataset	:= c.ak_dataset;
ak_skipSet	:= c.ak_skipSet;
ak_typeStr	:= c.ak_typeStr;
							
AutoKeyB2.MAC_Build (ak_dataset,fname,mname,lname,
						best_ssn,
						zero,
						zero,
						prim_name,
						prim_range,
						st,
						p_city_name,
						zip,
						sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
					  did_out6, // converted type of did_out to unsigned6
						blank, // compname which is string thus "blank"
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero, // bdid_out
						ak_keyname,
						ak_logical,
						bld_auto_keys,false,
						ak_skipSet,true,ak_typeStr,
						true,,,zero); 						


AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, ak_skipSet)

retval := sequential(bld_auto_keys,mymove);

return retval;

end;