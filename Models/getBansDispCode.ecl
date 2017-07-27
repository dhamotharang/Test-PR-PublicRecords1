
// convert the bocashell disposition into code that surecontact was passing.  If surecontact field is populated, use that
export getBansDispCode(UNSIGNED4 date_last_seen, STRING35 disposition, string2 surecontact_bans_disp_code='') := function

disp_description := stringlib.stringtouppercase(trim(disposition));
 
	bans_disp_code := map(trim(surecontact_bans_disp_code)<>'' => surecontact_bans_disp_code,
												date_last_seen<>0 and disp_description='' => '02',
												disp_description in ['CASE DISMISSED', 'DISMISSED'] => '15',
												disp_description in ['DISCHARGED', 'DISCHARGE GRANTED'] => '20',
												disp_description in ['DISPOSED'] => '99',
												'');
								
	return bans_disp_code;
	
end;

