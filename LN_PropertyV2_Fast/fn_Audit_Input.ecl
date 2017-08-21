import std, ut;
EXPORT fn_Audit_Input (string8 pversion) := function
//******************Reports********************************************************
//Input Reports
taxreport_frs := LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs;
taxreport_bk := LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_bk;
deedreport_frs := LN_PropertyV2_Fast.Files_Vendor_Rpts.deedreport_frs;
deedreport_bk := LN_PropertyV2_Fast.Files_Vendor_Rpts.deedreport_bk;

//Validate Reports

zcheckreports := map (  count (taxreport_frs) = 0 => FAIL('Tax report FRS superfile is empty.Skip the process....'),
                        count(taxreport_bk) = 0 => FAIL('Tax report BK superfile is empty.Skip the process....'),
											  count(deedreport_frs) = 0 => FAIL('Deed report FRS superfile is empty.Skip the process....'),
											  count(deedreport_bk) = 0 => FAIL('Deed report BK superfile is empty.Skip the process....'),
											Output('All the Report Superfiles contain subfiles')
											);


//**********Data********************************************************
//Raw Input Data
taxraw_frs := LN_PropertyV2_Fast.Files.raw.frs_assessment + LN_PropertyV2_Fast.Files.raw.frs_assessment_ptu;
taxraw_bk := sort(LN_PropertyV2_Fast.Files.raw.bk_assessment + LN_PropertyV2_Fast.Files.raw.bk_assessment_repl, new_record_type_legal_description);
deedraw_frs := LN_PropertyV2_Fast.Files.raw.frs_deed;
deedraw_bk := LN_PropertyV2_Fast.Files.raw.bk_deed + LN_PropertyV2_Fast.Files.raw.bk_deed_repl;
mtgraw_bks := LN_PropertyV2_Fast.Files.raw.bk_mortgage + LN_PropertyV2_Fast.Files.raw.bk_mortgage_repl;

//******************Aggregated Reports and Raw Data********************************************************
//Reports
taxreport_frs_a := table(taxreport_frs, {filetype := 'TAX-FRS', filedate,fips, state, county_name := trim(STD.Str.FilterOut(county,'12345'), left, right), cnt_rpt := sum(group,(unsigned)Total)}, filedate,fips, few);

county_lookup := dataset('~thor_400::fips_code_lookup',{string5 fips_code, string2 state_code, string30 county_name}, thor);
taxreport_bk_a_ := table(taxreport_bk, {filetype := 'TAX-BK', filedate, string5 fips := '', state := st, county_name := STD.Str.ToUpperCase(county), cnt_rpt := sum(group,(unsigned)num_of_records)}, filedate,st,county,few);
taxreport_bk_b := join(taxreport_bk_a_, county_lookup, left.state[..2] = right.state_code[..2] and trim(left.county_name, all) = trim(right.county_name, all), transform(recordof(taxreport_bk_a_), self.fips := right.fips_code, self := left), left outer);
taxreport_bk_a := join(taxreport_bk_b, county_lookup, left.state[..2] = right.state_code[..2] and ut.StringSimilar(ut.word(ut.Word(left.county_name, 1, ' '), 2, '-'), ut.word(ut.Word(right.county_name, 1, ' '), 2, '-')) < 3, transform(recordof(taxreport_bk_a_), self.fips := if(left.fips = '', right.fips_code, left.fips), self := left), keep(1),left outer);

deedreport_frs_a := table(deedreport_frs, {filetype := 'DEED-FRS',filedate,fips, state, county_name := trim(STD.Str.FilterOut(county,'12345'), left, right), cnt_rpt := sum(group,(unsigned)Total)}, filedate,fips, few);

//Data
string8 getfiledate(string filename) := if(~ut.isNumeric((string1)filename[STD.Str.Find(filename, '20', 1)+4]) , 
																filename[STD.Str.Find(filename, '20', 1)..STD.Str.Find(filename, '20', 1)+3] +																
																filename[STD.Str.Find(filename, '20', 1)-2..STD.Str.Find(filename, '20', 1)-1] +
																filename[STD.Str.Find(filename, '20', 1)-4..STD.Str.Find(filename, '20', 1)-3],
																filename[STD.Str.Find(filename, '20', 1)..]
																);

//filedate,fips, state code, county 
taxraw_frs_a := table(taxraw_frs,{filetype := 'TAX-FRS', filedate := getfiledate(raw_file_name), raw_file_name, fips := fips_code, state := prop_state, county_name := '', cnt_raw := count(group)}, getfiledate(raw_file_name),raw_file_name, fips_code);
taxraw_bk_a := table(taxraw_bk,{filetype := 'TAX-BK', filedate :=  getfiledate(raw_file_name), raw_file_name, fips := fips_code_state_county, state := state_postal_code, county_name, cnt_raw := count(group)}, getfiledate(raw_file_name), raw_file_name,state_postal_code, county_name);
deedraw_frs_a := table(deedraw_frs,{filetype := 'DEED-FRS', filedate := getfiledate(raw_file_name), raw_file_name, fips, state := prop_state, county_name := '', cnt_raw := count(group)}, getfiledate(raw_file_name),fips);
deedraw_bk_a := table(deedraw_bk,{filetype := 'DEED-BK', filedate :=  getfiledate(raw_file_name), raw_file_name, fips := fipscountycode, state := statecode, county_name := countyname, cnt_raw := count(group)}, getfiledate(raw_file_name), raw_file_name, fipscountycode, statecode,countyname);
mtgraw_bk_a := table(mtgraw_bks,{filetype := 'MTG-BK', filedate :=  getfiledate(raw_file_name), raw_file_name, fips := FIPSCode, state, county_name := CountyName, cnt_raw := count(group)}, getfiledate(raw_file_name),raw_file_name, fipscode, state,countyname);

//******************Report vs Raw Data Comparison********************************************************
rpt_a_l := record
string8 filetype;
string8 filedate;
string5 fips;
string2 state;
string30 county_name;
unsigned cnt_rpt;
end;

raw_a_l := record
rpt_a_l - cnt_rpt;
string100 raw_file_name;
unsigned cnt_raw;
end;

//filetype filedates,county
report_all_a := project(taxreport_frs_a, rpt_a_l) + project(taxreport_bk_a, rpt_a_l) + project(deedreport_frs_a, rpt_a_l) : independent;
raw_all_a_ := project(taxraw_frs_a,  raw_a_l) +   project(taxraw_bk_a, raw_a_l) + project(deedraw_frs_a, raw_a_l) + project(deedraw_bk_a,raw_a_l) +  project(mtgraw_bk_a, raw_a_l): independent;
raw_all_a := table(raw_all_a_,{filetype, filedate, fips, state, county_name, cnt__raw := sum(group, cnt_raw)}, filetype, filedate, fips, state, county_name, few): independent;

//filetype filedates
report_all_f := table(report_all_a, {filetype, filedate,  cnt__rpt := sum(group, cnt_rpt)}, filetype, filedate): independent;
raw_all_f:=  table(raw_all_a_, {filetype, filedate, raw_file_name,  cnt__raw := sum(group, cnt_raw)}, filetype, filedate, raw_file_name): independent;

//Comparison
//File level
comp_all_cf := join(report_all_f, raw_all_f(filetype not in['DEED-BK','MTG-BK']), left.filetype = right.filetype and left.filedate = right.filedate, full outer): independent;

//county level
comp_all_cc := join(report_all_a, raw_all_a(filetype not in['DEED-BK','MTG-BK']),  left.filetype = right.filetype and left.fips = right.fips and left.filedate = right.filedate, full outer) (filetype <> 'TAX-FRS' and cnt_rpt <> 0): independent;

//*******************Log audited files********************************************************
input_raw_audited_ly := record
string8 filetype := '';
string100 raw_file_name;
unsigned cnt__raw := 0;
string8 filedate := '';
string8 auditdate := '';
string9 version;
string17 wuid :=  '';
unsigned daysapart := 0;
end;

input_raw_audited_ly_out :=  record
string8 build_status := '';
input_raw_audited_ly 
end;

input_raw_audited := project(raw_all_f, transform(input_raw_audited_ly_out,
																				   self.build_status := 'current',
																					 self.auditdate := ut.getdate,
																					 self.wuid := STD.System.Job.WUID();
																					 self.version := pversion;
																					 self := left));
//******************Find Delivery Gaps********************************************************
input_raw_audited_ly_out t_daysapart(input_raw_audited l, input_raw_audited r) := TRANSFORM
	self.daysapart := if (l.filetype = r.filetype, ut.DaysApart(l.filedate, r.filedate), r.daysapart) ;
	self:= r;
end;

input_raw_audited_i := iterate(sort(input_raw_audited,filetype, filedate),t_daysapart(left,right)) : independent;	

log_fname := '~thor_400::log::ln_propertyv2::raw_audited';
input_raw_audited_h := project(dataset(log_fname, input_raw_audited_ly , thor), input_raw_audited_ly_out);
input_raw_audited_hd := project(dedup(sort(input_raw_audited_h, filetype, -filedate), filetype), transform(input_raw_audited_ly_out, self.build_status := 'previous', self := left));

input_raw_audited_i2 := iterate(sort(input_raw_audited_i + input_raw_audited_hd, filetype, filedate),t_daysapart(left,right)) : independent;	

new_raw_audited := project(iterate(sort(input_raw_audited_i + input_raw_audited_h, filetype, filedate),t_daysapart(left,right)), input_raw_audited_ly); 

//******************Fail/Pass Email Msg********************************************************
fail_msg := if(count(comp_all_cf(cnt__rpt = 0)) > 0,
						 'MISSING REPORT(s) - View ' + workunit + ' Result: Missing Reports \n\n' 
						 , '') + 
						  if(count(comp_all_cf(cnt__raw = 0)) > 0,
						 'MISSING Files(s) - View ' + workunit + ' Result: Missing Raw Files \n\n' 
						 , '')  +
							
						 if(count(comp_all_cc(cnt_rpt <> cnt__raw)) > 0 ,
						 'REPORT VS RAW FILE COUNTY LEVEL DISCREPANCIES - View ' + workunit + ' Result: Report vs File County Level Discrepancies \n\n' 
						 , '') +
						 
						 if(count(input_raw_audited_i(filetype in ['DEED-FRS', 'TAX-FRS'] and daysapart > 9)) > 0, 'THERE ARE FARES FILES WITH DELIVERY DATES MORE THAN 9 DAYS APART \n View Result: ' + workunit + ' Fares Delivery Date Gaps \n\n', '') +
						 if(count(input_raw_audited_i(filetype in ['TAX-BK'] and daysapart > 3)) >  0 , 'THERE ARE BK FILES WITH DELIVERY DATES MORE THAN 3 DAYS APART \n View Result: ' + workunit + ' bk Delivery Date Gaps \n\n', '') +
						 if(count(input_raw_audited_i2(filetype in ['DEED-FRS', 'TAX-FRS'] and daysapart > 9)) > 0, 'EARLIEST DELIVERY DATE IN FARES FILES IS MORE THAN 9 DAYS APART \n COMPARED TO LATEST DELIVERY DATE IN PREVIOUS BUILD \n View Result: ' + workunit + ' Fares Delivery Date Gaps \n\n', '') +
						 if(count(input_raw_audited_i2(filetype in ['TAX-BK'] and daysapart > 3)) >  0 , 'EARLIEST DELIVERY DATE IN BK FILES IS MORE THAN 3 DAYS APART \n COMPARED TO LATEST DELIVERY DATE IN PREVIOUS BUILD \n View Result: ' + workunit + ' bk Delivery Date Gaps \n\n', '') 
						 ;

pass_msg := 'REPORTS MATCH RAW FILES\n Attached is a the list of files audited and to be processed in this update \n\n Same list can be viewed in '+ workunit + ' Result: Files Audited';

//Format email attachment
mail_data := record, maxlength(10000000)
   string mail_text;
  end;
	
hdr := dataset([{'filetype, raw_file_name, cnt__raw , filedate, auditdate, version, wuid, daysapart\n'}],mail_data) ;

mail_data convertToString(input_raw_audited_i l) := transform
 self.mail_text := l.filetype + ',' + l.raw_file_name + ',' + (string)l.cnt__raw + ',' + l.filedate  + ',' + l.auditdate  + ',' + l.version + ',' + l.wuid + ',' + (string)l.daysapart + '\n';
end;

stringRecs := hdr + PROJECT (input_raw_audited_i, convertToString(left));

mail_data convertToText(mail_data L, mail_data R) := transform
	self.mail_text := trim(L.mail_text) + trim(R.mail_text);	                  
end;
	
textDs := iterate(stringRecs,  convertToText(left, right));
textCount := count(textDs);
csvname := pversion+'_' + 'Audited_Raw_Input_Property_Files.csv';

//Send Email
email_fail := fileservices.sendemail(LN_PropertyV2_Fast.Constants.email_recipients,
			'ALERT! Disprepancy in Property Input Files  ' + workunit,
			fail_msg);

email_pass := fileServices.sendEmailAttachData(LN_PropertyV2_Fast.Constants.email_recipients
																						,'Property Input Files Report - No Issues Found  ' + workunit
																						, pass_msg
																						,(data)textDs[textCount].mail_text
																						,'text/csv'
																						,csvname);

//******************Execute processes/outputs********************************************************		
out := sequential(//zcheckreports,					
    							output(comp_all_cf(cnt__rpt = 0), named('Missing_Reports')),
									output(comp_all_cf(cnt__raw = 0), named('Missing_Raw_Files')),
									output(comp_all_cc(cnt_rpt <> cnt__raw), named('Report_vs_File_County_Level_Discrepancies')),
									output(input_raw_audited_i2(filetype in ['DEED-FRS', 'TAX-FRS']), named('Fares_Delivery_Date_Gaps')),
									output(input_raw_audited_i2(filetype in ['TAX-BK']), named('Bk_Delivery_Date_Gaps')),
									output(input_raw_audited_i, named('Files_Audited')),
									if(fail_msg <> '', email_fail, 
										sequential(output(new_raw_audited,, log_fname + '_temp', overwrite, compressed),
															 fileservices.DeleteLogicalFile(log_fname),
															 fileservices.RenameLogicalFile(log_fname +'_temp', log_fname),
															 email_pass/*, 
															 fileservices.clearsuperfile(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_fname),
															 fileservices.clearsuperfile(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_bk_fname),
															 fileservices.clearsuperfile(LN_PropertyV2_Fast.Files_Vendor_Rpts.deedreport_frs_fname),
															 fileservices.clearsuperfile(LN_PropertyV2_Fast.Files_Vendor_Rpts.deedreport_bk_fname),*/
															 )
									));

return out;

end;