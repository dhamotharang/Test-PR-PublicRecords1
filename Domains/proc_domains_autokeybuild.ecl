import AutoKeyB2; 

export proc_domains_autokeybuild(string filedate) := function

b := domains.file_whois_autokey;

skip_set := domains.constants(filedate).ak_skipset;

  AutokeyB2.MAC_Build (b,
            fname,mname,lname, 
						zero, // SSN field
						zero,
						zero,
						prim_name,prim_range,state,v_city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						did, // converted type of did_out to unsigned6
						compname,
						zero,
						zero,
						prim_name,prim_range,state,v_city_name,zip,sec_range,
						bdid,
						Domains.Constants(filedate).ak_keyname,
						Domains.Constants(filedate).ak_logicalname,
						outaction,false,
						skip_set,
						true,
						Domains.Constants(filedate).ak_typeStr,
						true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(Domains.Constants(filedate).ak_keyname, mymove,, skip_set)

retval := sequential(outaction,mymove);
 
return retval;

end;
