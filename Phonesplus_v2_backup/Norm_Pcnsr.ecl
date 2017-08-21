//***************Normalize PCNSR when more than one individual per record is available********************
import DayBatchPCNSR;

denorm_f := DayBatchPCNSR.File_PCNSR;

layout_norm_phone := record
	string10 	Phone;
	unsigned1 	Phone_Ind;
	string1		Phone_Type;
	denorm_f;
end;
//Normalize Phone
layout_norm_phone t_norm_phone (denorm_f le, integer cnt) := transform
	self.Phone		:=	choose(cnt, le.area_code+ le.phone_number, if(le.area_code + le.phone_number <> le.phone2_number,le.phone2_number, '') );
	self.Phone_ind	:=	cnt;
	self.Phone_Type	:=	choose(cnt, le.telephone_number_type, le.telephone2_number_type);	
	self			:=  le;
end;

norm_phone := normalize(denorm_f, 2, t_norm_phone(left, counter));

layout_norm_spouse := record
	unsigned1	rec_num;
	layout_norm_phone;
end;

//Normalize Names (main name and spouse name)
layout_norm_spouse t_norm_spouse (norm_phone le, integer cnt) := transform
	self.rec_num := cnt;
	self	:= le;
end;

norm_spouse	:= normalize(norm_phone(Phone <> ''), 2, t_norm_spouse(left, counter));

export Norm_Pcnsr := norm_spouse(rec_num = 1 or (rec_num = 2 and trim(spouse_fname + spouse_lname, all) <> ''))
				  : persist('~thor_data400::persist::Phonesplus::Norm_Pcnsr');