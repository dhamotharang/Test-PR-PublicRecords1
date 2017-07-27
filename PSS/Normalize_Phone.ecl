import doxie, tools,autokeyb2;
EXPORT Normalize_Phone (string pversion = '',boolean pFileUseOtherEnvironment = false) := function
Base_f := Files(pversion,pFileUseOtherEnvironment).Base.Built;
Layouts.KeyBuildNorm t_norm(Base_f le, c) := transform
self.phone_pos := c;
self.response_company_phone := if(c = 1, le.response_company_phone1, le.response_company_phone2);
self.response_phone_status := if(c = 1, le.response_phone_1_status, le.response_phone_2_status);
self.response_phone_notes_date := if(c = 1, le.response_phone1_notes_date, le.response_phone2_notes_date);
self := le;

end;

norm := normalize(Base_f, 2, t_norm(left,  counter))(response_company_phone <>'');

dPhoneDedup	:=	dedup(sort(norm,bdid,response_company_phone,-response_phone_notes_date,-dt_vendor_last_reported),bdid,response_company_phone);

return dPhoneDedup;
end;


