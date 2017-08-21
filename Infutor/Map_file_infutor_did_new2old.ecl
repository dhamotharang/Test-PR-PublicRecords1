import ut;

starting_point := infutor.File_Infutor_DID(name_type[1]	=	'O'	and	addr_type[1]	=	'O');

ut.mac_suppress_by_phonetype(starting_point,phone,st,inf_supp_out,true,did);

Infutor.Layout_DID	reformat(inf_supp_out	l)	:=
transform 
 self.infutor_or_mktg_ind	:=	'1'; 
 self                     :=	l;
end;

inf_supp_phone	:=	project(inf_supp_out,reformat(left));

// Correct phone numbers which have invalid area codes
inf_supp_phone_populated	:=	inf_supp_phone(phone	!=	'');
inf_supp_phone_blank			:=	inf_supp_phone(phone	=		'');

ut.mac_phone_areacode_corrections(inf_supp_phone_populated,inf_areacode_corrections,phone);

// Blank out phone numbers which we aren't able to correct where area code or exchange code is not valid
yellowpages.NPA_PhoneType(inf_areacode_corrections,phone,phonetype,inf_phone_type);

inf_invalid_areacode	:=	inf_phone_type(phonetype	=		'INVALID-NPA/NXX/TB');
inf_valid_areacode		:=	inf_phone_type(phonetype	!=	'INVALID-NPA/NXX/TB');

Infutor.Layout_DID	tBlankPhone(inf_invalid_areacode	pInput)	:=
transform
	self.phone	:=	'';
	self				:=	pInput;
end;

inf_blank_invalid_areacode	:=	project(inf_invalid_areacode,tBlankPhone(left));

export Map_file_infutor_did_new2old  := 	inf_blank_invalid_areacode
																				+	project(inf_valid_areacode,Infutor.Layout_DID)
																				+	inf_supp_phone_blank;