import autokeyb2, doxie_build;

export proc_build_autokey(string filedate) := function

ak_dataset := file_offenders_autokey;

c := Criminal_Records.constants(filedate);
ak_keyname := c.ak_keyname;
ak_logical := c.ak_logical;
ak_typestr := c.ak_typestr;
skip_set := c.skip_set;

autokeyb2.mac_build(ak_dataset,fname,mname,lname,
						ssn,
						dob,
						zero,
						prim_name,prim_range,state,v_city_name,zip5,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						did,
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						ak_keyname,
						ak_logical,
						outaction,
						false,
						skip_set,true,ak_typestr,
						true,,,offender_key,true);

postkey := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILT','~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING')
		);
		
AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,mymove,,skip_set)
r := sequential(outaction,mymove,postkey);

return r;	

end;