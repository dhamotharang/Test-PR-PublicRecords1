//****************Normalize Cellphone sources records when two phones per record are available********************

import cellphone;

denorm_f := cellphone.Cellphones_DID;;

layout_norm_phone := record
	string10 	Phone;
	string1		Phone_Type;
	denorm_f;
end;

//Normalize Phone
layout_norm_phone t_norm_phone (denorm_f le, integer cnt) := transform
	self.Phone		:=	choose(cnt, le.cellphone, if(le.cellphone <> le.homephone,le.homephone, ''));
	self.Phone_Type	:=	choose(cnt, '', 'L');	
	self			:=  le;
end;

norm_phone := normalize(denorm_f, 2, t_norm_phone(left, counter));

export Norm_Cellphone := norm_phone (phone <> '');