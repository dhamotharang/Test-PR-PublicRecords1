export FBN_Stats(getretval) := macro

import fbnv2,census_data,codes,ut,lib_fileservices,_Control;
#uniquename(myds)
%myds% := FBNV2.File_FBN_Business_Base;

#uniquename(add_cty_name)
%add_cty_name% := record
	%myds%;
	string state := '';
	string county_name := '';
end;

#uniquename(tab_cty)
%tab_cty% := table(%myds%,%add_cty_name%);

#uniquename(join_fips)
%add_cty_name% %join_fips%(%tab_cty% l,census_data.File_Fips2County r) := transform
	self.state := r.state_code;
	self.county_name := r.county_name;
	self := l;
end;

#uniquename(join_cty_out)
%join_cty_out% := join(%tab_cty%(fips_state <> '' and fips_county <> ''),census_data.File_Fips2County,
						left.fips_state = right.state_fips and
						left.fips_county = right.county_fips,
						%join_fips%(left,right),
						left outer,
						lookup);


#uniquename(combo_rec)
%combo_rec% := record
	string instate := '';
	string filing_date := '';
end;

#uniquename(proj_combo)
%combo_rec% %proj_combo%(%join_cty_out% l,Codes.File_Codes_V3_In r) := transform
	self.instate := trim(r.long_desc) + if(l.county_name <> '',','+stringlib.stringtouppercase(trim(l.county_name)[1..1])+
										stringlib.stringtolowercase(trim(l.county_name)[2..]),',');
	self.filing_date := if(l.filing_date <> 0,(string)l.filing_date,(string)l.orig_filing_date);
end;

#uniquename(join_out)
%join_out% := join(%join_cty_out%((filing_date <> 0 or orig_filing_date <> 0) 
							and trim(state) <> ''),
							Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG'),
							left.state = right.code,
							%proj_combo%(left,right),
							left outer,
							lookup);

Orbit_Report.Run_Stats('fbn',%join_out%,instate,filing_date,'emailme','nst',getretval);

endmacro;