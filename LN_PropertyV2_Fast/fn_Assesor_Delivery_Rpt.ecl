import LN_PropertyV2, Scrubs_LN_PropertyV2_Assessor, ut;
EXPORT fn_Assesor_Delivery_Rpt () := function

temp_layout := record
string ln_fares_id;
string2 state_code := '';
string5 fips_code;
string county_name := '';
string1 vendor_source_flag;
string8 process_date;
end;

//*********using prep and old files
assessor_post_conversion := project(LN_PropertyV2_Fast.Files.prep.assessment(update_type <> 'PTU'), temp_layout);
assessor_okc_pre_conversion := project(LN_PropertyV2_Fast.Files.oldIn.LNAssessment, temp_layout);
assessor_frs_pre_conversion :=project(LN_PropertyV2.File_Fares_assessor_in, transform(temp_layout, self.vendor_source_flag := 'F', self := left, self := []));
all_assessor1 := assessor_post_conversion  + assessor_okc_pre_conversion + assessor_frs_pre_conversion;
//************************************************

//*********using base
assessor_base := LN_PropertyV2.Files.Base.Assessment;
removed_ptu := join(distribute(assessor_base, hash(ln_fares_id)), 
									 distribute(assessor_post_conversion, hash(ln_fares_id)), 
									 left.ln_fares_id = right.ln_fares_id,
									 left only, 
									 local);
all_assessor2 :=project(removed_ptu, temp_layout);
//************************************************

//*********using base with ptus
all_assessor3 :=assessor_base;



fn_rpt (all_assessor) := functionmacro
county_lookup := Scrubs_LN_PropertyV2_Assessor.File_Fips;
assessor_cnty := join(all_assessor,
						          county_lookup,
											left.fips_code = right.fips_code,
											transform(temp_layout,
											self.state_code := right.state_code,
											self.fips_code := right.fips_Code,
											self.county_name := right.county_name,
											self.vendor_source_flag := left.vendor_source_flag,
											self.process_date:= left.process_date,
											self := []),
											lookup);
											


											
assessor_cnty_tbl := table(assessor_cnty, {vendor_source_flag, fips_code, state_code, county_name, process_date, cnt := count(group)}, vendor_source_flag, fips_code, state_code, county_name,process_date);
		
int_rep_layout := record
temp_layout-ln_fares_id;
unsigned cnt;
unsigned daysapart := 0;
unsigned year := 0;
boolean dup := false;
unsigned yr_rank := 0;
end; 

assessor_cnty_tbl_t := sort(project(assessor_cnty_tbl, int_rep_layout), vendor_source_flag, fips_code, -process_date);


int_rep_layout t_daysapart(assessor_cnty_tbl_t l, assessor_cnty_tbl_t r) := TRANSFORM
	self.daysapart := if (l.vendor_source_flag = r.vendor_source_flag and l.fips_code = r.fips_code, ut.DaysApart(l.process_date, r.process_date), r.daysapart) ;
	self.dup := if(self.daysapart < 300 and r.cnt = l.cnt, true, r.dup);
	self.yr_rank := if(l.vendor_source_flag = r.vendor_source_flag and l.fips_code = r.fips_code and ~self.dup,  l.yr_rank + 1, 
										 if(self.dup, l.yr_rank, r.yr_rank));
	self:= r;
end;

assessor_cnty_tbl_i := iterate(assessor_cnty_tbl_t,t_daysapart(left,right));	

rep_l := record
assessor_cnty_tbl_i.state_code;
assessor_cnty_tbl_i.fips_code;
assessor_cnty_tbl_i.county_name;
assessor_cnty_tbl_i.vendor_source_flag;
string8 date_yr_5 := max(group, if(assessor_cnty_tbl_i.yr_rank = 4,assessor_cnty_tbl_i.process_date, ''));
unsigned cnt_year_5 := max(group, if(assessor_cnty_tbl_i.yr_rank = 4,assessor_cnty_tbl_i.cnt, 0));
string8 date_yr_4:= max(group, if(assessor_cnty_tbl_i.yr_rank = 3,assessor_cnty_tbl_i.process_date, ''));
unsigned cnt_year_4 := max(group, if(assessor_cnty_tbl_i.yr_rank = 3,assessor_cnty_tbl_i.cnt, 0));
string8 change_pct_4 := '';
string8 date_yr_3:= max(group, if(assessor_cnty_tbl_i.yr_rank = 2,assessor_cnty_tbl_i.process_date, ''));
unsigned cnt_year_3 := max(group, if(assessor_cnty_tbl_i.yr_rank = 2,assessor_cnty_tbl_i.cnt, 0));
string8 change_pct_3 := '';
string8 date_yr_2 := max(group, if(assessor_cnty_tbl_i.yr_rank = 1,assessor_cnty_tbl_i.process_date, ''));
unsigned cnt_year_2 := max(group, if(assessor_cnty_tbl_i.yr_rank = 1,assessor_cnty_tbl_i.cnt, 0));
string8 change_pct_2  := ''; 
string8 date_yr_1:= max(group, if(assessor_cnty_tbl_i.yr_rank = 0,assessor_cnty_tbl_i.process_date, ''));
unsigned cnt_year_1 := max(group, if(assessor_cnty_tbl_i.yr_rank = 0,assessor_cnty_tbl_i.cnt, 0));
string8 change_pct_1  := '';
string1 latest := '';
end;


yr_5_rpt := table(assessor_cnty_tbl_i(dup = false and vendor_source_flag <> 'D'), rep_l, vendor_source_flag, fips_code, few);

yr_5_rpt_pct := project(yr_5_rpt, transform(recordof(yr_5_rpt),
																					  self.change_pct_4 := if(left.cnt_year_5 > 0, (string) (decimal8_2) ((((real)left.cnt_year_4 - (real)left.cnt_year_5) / (real)left.cnt_year_5) * 100.00) , ''),
																						self.change_pct_3 := if(left.cnt_year_4 > 0,(string) (decimal8_2)((((real)left.cnt_year_3 - (real)left.cnt_year_4) / (real)left.cnt_year_4) * 100.00) , ''),
																						self.change_pct_2 := if(left.cnt_year_3 > 0,(string) (decimal8_2)((((real)left.cnt_year_2 - (real)left.cnt_year_3) / (real)left.cnt_year_3) * 100.00), ''),
																						self.change_pct_1 := if(left.cnt_year_2 > 0,(string) (decimal8_2)((((real)left.cnt_year_1 - (real)left.cnt_year_2) / (real)left.cnt_year_2) * 100.00), ''),
																						self := left));



recordof(yr_5_rpt_pct) t_latest(yr_5_rpt_pct l, yr_5_rpt_pct r) := TRANSFORM
	self.latest := if (l.fips_code = r.fips_code and r.date_yr_1 >  l.date_yr_1, 'Y', r.latest) ;
	self:= r;
end;

yr_5_rpt_pct_latest := iterate(sort(yr_5_rpt_pct, fips_code, date_yr_1),t_latest(left,right));	

return yr_5_rpt_pct_latest;
endmacro;

out_rpt := fn_rpt(all_assessor1);
max_delivery_date := max(out_rpt, date_yr_1);
latest_delivered := out_rpt(date_yr_1 >  ut.date_math(max_delivery_date, -30)); 

return latest_delivered ;
end;