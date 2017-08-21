import Business_Header, ut, address,mdr;

export fCredit_Unions_As_Business_Header(

	dataset(layout_credit_unions_base) pInput = File_Credit_Unions_Base

) :=
function

	cu := pInput;

	Business_Header.Layout_Business_Header_New Translate_CU_To_BHF(cu l) := transform
	self.source := MDR.sourceTools.src_Credit_Unions;          // Source file type
	self.source_group := trim(l.state) + l.charter;
	self.vl_id := trim(l.state) + l.charter;
	self.vendor_id := trim(l.state) + l.charter;
	self.dt_first_seen :=20050919; //(unsigned4)StringLib.GetDateYYYYMMDD();
	self.dt_last_seen  :=20050919;// (unsigned4)StringLib.GetDateYYYYMMDD();
    self.dt_vendor_first_reported := (unsigned4)StringLib.GetDateYYYYMMDD();
	self.dt_vendor_last_reported := (unsigned4)StringLib.GetDateYYYYMMDD();
	self.company_name := if (StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'CREDIT UNION', 1) > 0 or
												  StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'C U ', 1) > 0 or
										 StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), ' C U', 1) > 0 or
										 StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'C.U.', 1) > 0 or
										 StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'C. U.', 1) > 0,
							 Stringlib.StringToUpperCase(l.CU_NAME),
						trim(Stringlib.StringToUpperCase(l.CU_NAME)) + ' CREDIT UNION');
	self.city := l.v_city_name;
	self.state := l.st;
	self.county := l.fipscounty;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.phone := (unsigned6)address.CleanPhone(l.Phone);
	self.phone_score := if(self.phone = 0, 0, 1);
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	cu_init := project(cu, Translate_CU_To_BHF(left));

	return cu_init;

end;