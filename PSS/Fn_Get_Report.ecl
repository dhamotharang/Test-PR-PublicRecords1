import mdr;
export Fn_Get_Report(
	 string									pversion,
	 boolean	pFileUseOtherEnvironment	= false,
	 string6  month = ''

):= function

pss := Files(pversion, pFileUseOtherEnvironment).base.qa(if(month = '', dt_vendor_last_reported <> 0, ((string)dt_vendor_last_reported)[..6] = (string)month));

new_ly := record
  string20 response_customer_client_code;
	  unsigned4 dt_vendor_last_reported;
    string2 source;
		unsigned1 phone_position;
	  string1 response_phone_status;	
end;

new_ly t_norm(pss le, c) := transform
self.phone_position := c;
self.response_phone_status := if(c =1 , le.response_phone_1_status,
											 le.response_phone_2_status
											);
self := le;
self := [];
end;

norm := normalize(pss,2,t_norm(left,  counter))(response_phone_status <>'');

report := sort(table(norm, {response_customer_client_code, dt_vendor_last_reported, phone_position, source,  source_name := MDR.sourceTools.fTranslateSource(source),response_phone_status ,count(group)},
									 response_customer_client_code, dt_vendor_last_reported, phone_position, MDR.sourceTools.fTranslateSource(source), response_phone_status ),
									 response_customer_client_code, dt_vendor_last_reported, phone_position, source, source_name,response_phone_status );

return report;
end;