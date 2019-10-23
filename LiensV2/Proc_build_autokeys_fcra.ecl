import AutoKeyB2, liensv2; 
EXPORT Proc_build_autokeys_fcra (string filedate) := function

ds := LiensV2.file_liens_party_keybuild_fcra;

Liensv2.layout_liens_party proj_rec(ds L) := transform
		self.ssn		:=	IF((UNSIGNED6)L.ssn <> 0, IF(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), '');
		// self.tax_id	:=	IF(L.tax_id <> '', IF(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), '');
		//DF-22188 clear tax_id field in thor_data400::key::liensv2::fcra::qa::autokey_payload
		self.tax_id	:=	'';
		self := L;
	end;

file_party := project(ds,proj_rec(left));

d2 := liensv2.file_SearchAutokey(file_party, LiensV2.file_liens_fcra_main) : independent;

ak_keyname := '~thor_data400::key::liensv2::fcra::@version@::autokey_';  
ak_logical := '~thor_data400::key::liensv2::fcra::'+filedate+'::autokey_'; 

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
						ak_keyname,
						ak_logical,
						outaction,false,
						[],true,,
						true,,,zero) 


AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,mymove)

r := sequential(outaction,mymove);
 
return r;

end;
