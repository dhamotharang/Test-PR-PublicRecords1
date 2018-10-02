import autokeyb2;

export proc_autokeybuild(
	string filedate, 
	dataset(LiensV2.Layout_liens_party) party_files,
	dataset(LiensV2.Layout_liens_main_module.layout_liens_main) main_files
	) :=
FUNCTION

d2 := liensv2.file_SearchAutokey(party_files, main_files) : independent;

AutoKeyB2.MAC_Build (d2,person_name.fname,person_name.mname,person_name.lname,
						ssn,
						zero,
						zero,
						person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						party_bits,
						intDID,
						cname,
						tax_id,
						zero,
						company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
						intbdid,
						liensv2.str_AutokeyName,
						liensv2.str_AutokeyLogicalName(filedate),
						outaction,false,
						[],true,,
						true,,,zero) 





AutoKeyB2.MAC_AcceptSK_to_QA(liensv2.str_AutokeyName,mymove)
r := sequential(outaction,mymove);
 
return r;

end;

