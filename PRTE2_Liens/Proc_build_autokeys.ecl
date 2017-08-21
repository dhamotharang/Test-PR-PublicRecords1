import autokeyb2, LiensV2, PRTE2_Liens;

export Proc_build_autokeys(	string filedate) := FUNCTION

file_party := project(PRTE2_Liens.files.Party_out,transform(LiensV2.Layout_liens_party, self := left;));

d2 := PRTE2_Liens.file_SearchAutokey(file_party, PRTE2_Liens.files.Main_out) : independent;

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
						PRTE2_Liens.constants.ak_keyname,
						PRTE2_Liens.constants.ak_logical(filedate),
						outaction,false,
						[],true,,
						true,,,zero) 





AutoKeyB2.MAC_AcceptSK_to_QA(PRTE2_Liens.constants.ak_keyname,mymove)
r := sequential(outaction,mymove);
 
return r;

end;

