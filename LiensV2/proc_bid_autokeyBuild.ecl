import autokeyb2;
export proc_bid_autokeybuild(
	string filedate, 
	dataset(LiensV2.Layout_liens_party_bid) party_files) :=
FUNCTION

d2 := LiensV2.file_SearchAutokey_bid(party_files) ;
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
						liensv2.str_bid_Autokey.Name,
						liensv2.str_bid_Autokey.LogicalName(filedate),
						outaction,false,
						[],true,,
						true,,,zero) 





AutoKeyB2.MAC_AcceptSK_to_QA(liensv2.str_bid_Autokey.Name,mymove)
r := sequential(outaction,mymove);
 
return r;

end;

