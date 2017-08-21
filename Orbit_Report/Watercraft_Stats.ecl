export Watercraft_Stats(getretval) := macro
import watercraft,codes,ut,lib_fileservices,_Control, STD;
watercraftds := watercraft.File_Base_Main_dev(length(trim(registration_date)) = 8 and registration_date < (string8)STD.Date.Today());

wc_string_rec :=  record
 string state_origin := 'National';
 //total := count(group);
 string registration_date := '';
end;

wc_string_rec wc_proj_recs(watercraftds l) := transform
 self.registration_date := l.registration_date;
end;

national_out := project(watercraftds,wc_proj_recs(left));

wc_state_rec := record
	string state_origin;
	string registration_date;
end;

wc_state_rec wcs_proj_recs(watercraftds l) := transform
	self := l;
end;

wc_state_out := project(watercraftds,wcs_proj_recs(left));

full_wc_out := national_out + wc_state_out;

Orbit_Report.Run_Stats('watercraft',full_wc_out,state_origin,registration_date,'emailme','st',getretval,'true');

endmacro;
