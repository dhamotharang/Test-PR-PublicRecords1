IMPORT yellowpages,cellphone;
EXPORT mac_clean_daily_phone(fdaily_did, outfile) := macro

inf_phone_populated	:=	fdaily_did(trim(phone,left,right)	!=	'' or trim(work_phone,left,right)	!=	'');
inf_phone_blank			:=	fdaily_did(~(trim(phone,left,right)	!=	'' or trim(work_phone,left,right)	!=	''));

// Blank out phone numbers which we aren't able to correct where area code or exchange code is not valid
yellowpages.NPA_PhoneType(inf_phone_populated,phone,phonetype,inf_phone_type);

out_phone_phonetype	:=	project(inf_phone_type, transform(recordof(fdaily_did), self.phone := if(trim(left.phonetype,left,right)	  =		'INVALID-NPA/NXX/TB', '', left.phone),self := left));

inf_workphone_populated := out_phone_phonetype(trim(work_phone,left,right)	!=	'');
inf_workphone_blank := out_phone_phonetype(trim(work_phone,left,right)	=	'');

yellowpages.NPA_PhoneType(inf_workphone_populated,work_phone,phonetype,inf_workphone_type);

out_workphone_type	:=	project(inf_workphone_type, transform(recordof(fdaily_did), self.work_phone := if(trim(left.phonetype,left,right)	  =		'INVALID-NPA/NXX/TB', '', left.work_phone),self := left));

out_valid_phone := out_workphone_type + inf_workphone_blank + inf_phone_blank;

outfile := out_valid_phone;

endmacro;


