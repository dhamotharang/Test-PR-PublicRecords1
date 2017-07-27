import _control, ut;

export _Missing_Industry_Values_Stat := module

#workunit('name','Weekly - Find Empty Industry Values')

/////////////////// Finds Empty Industry Values for top offenders. Creates word doc and sends to sharepoint site weekly. http://lngbctshrp001/sites/InquiryTracking/default.aspx

Hist := inquiry_acclogs.fn_ProdHist().File(bus_intel.industry = '');

tHist := table(Hist, {mbs.company_id, search_info.product_code, mbs.global_company_id, count_empty := count(group)},
											mbs.company_id, search_info.product_code, mbs.global_company_id, few);

Mbs_File := table(inquiry_acclogs.File_MBS.File(idflag = 'GCID'), 
									{id, hash_id, idflag, cust_name, mbs_company_name, billing_id, banko_mn, sub_acct_id, vertical, industry, use, disable_observation, opt_out, string10000 email_body := ''});

jnHist1	:= join(tHist, Mbs_File,
								left.global_company_id = right.id, left outer);
jnHist2	:= join(table(jnHist1(idflag = ''), {company_id, product_code, global_company_id, count_empty}), 
								Mbs_File,
								left.global_company_id = right.hash_id);
shared jnHist := sort(dedup(jnHist1(idflag <> '') + jnHist2, record, all), -count_empty) : independent;

for_email_layout := record 
	string email_body{maxLength(3145728)} := '';
end;

body_File := project(jnHist, 
									transform(for_email_layout,
														self.email_body := stringlib.stringcleanspaces(
																								'Customer Name: ' + left.cust_name + '\n' +
																								'MBS Customer Name: ' + left.mbs_company_name + '\n\t' +
																								'Count Empty Records: ' + (string)left.count_empty + '\n\t' +
																								'Company ID: ' + left.company_id + ' | ' +
																								'Product ID: ' + left.product_code + ' | ' +
																								'Global Company ID: ' + left.company_id + '\n\t' +
																								'Billing ID: ' + left.billing_id + ' | ' +
																								'Banko MN: ' + left.banko_mn + ' | ' +
																								'Sub-Account ID: ' + left.sub_acct_id + '\n\t' +
																								'Use: ' + left.use + ' | ' +
																								'Vertical: ' + left.vertical + ' | ' +
																								'Industry: ' + left.industry + '\n\t' +
																								'Disable Observation: ' + left.disable_observation + ' | ' +
																								'Opt-Out: ' + left.opt_out + '\n------------------------------------------------------\n\n'
																								))) : independent;

fn_email_body(dataset(recordof(body_File)) body_File) := 
			stringlib.stringcleanspaces(if(count(body_File) >= 1, body_File[1].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 2, body_File[2].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 3, body_File[3].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 4, body_File[4].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 5, body_File[5].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 6, body_File[6].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 7, body_File[7].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 8, body_File[8].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 9, body_File[9].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 10, body_File[10].email_body, '')) + 
			stringlib.stringcleanspaces(if(count(body_File) >= 11, body_File[11].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 12, body_File[12].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 13, body_File[13].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 14, body_File[14].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 15, body_File[15].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 16, body_File[16].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 17, body_File[17].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 18, body_File[18].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 19, body_File[19].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 20, body_File[20].email_body, '')) + 
			stringlib.stringcleanspaces(if(count(body_File) >= 21, body_File[21].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 22, body_File[22].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 23, body_File[23].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 24, body_File[24].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 25, body_File[25].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 26, body_File[26].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 27, body_File[27].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 28, body_File[28].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 29, body_File[29].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 30, body_File[30].email_body, '')) + 
			stringlib.stringcleanspaces(if(count(body_File) >= 31, body_File[31].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 32, body_File[32].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 33, body_File[33].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 34, body_File[34].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 35, body_File[35].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 36, body_File[36].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 37, body_File[37].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 38, body_File[38].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 39, body_File[39].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 40, body_File[40].email_body, '')) + 
			stringlib.stringcleanspaces(if(count(body_File) >= 41, body_File[41].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 42, body_File[42].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 43, body_File[43].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 44, body_File[44].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 45, body_File[45].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 46, body_File[46].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 47, body_File[47].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 48, body_File[48].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 49, body_File[49].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 50, body_File[50].email_body, '')) + 
			stringlib.stringcleanspaces(if(count(body_File) >= 51, body_File[51].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 52, body_File[52].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 53, body_File[53].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 54, body_File[54].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 55, body_File[55].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 56, body_File[56].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 57, body_File[57].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 58, body_File[58].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 59, body_File[59].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 60, body_File[60].email_body, '')) + 
			stringlib.stringcleanspaces(if(count(body_File) >= 61, body_File[61].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 62, body_File[62].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 63, body_File[63].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 64, body_File[64].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 65, body_File[65].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 66, body_File[66].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 67, body_File[67].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 68, body_File[68].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 69, body_File[69].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 70, body_File[70].email_body, '')) + 
			stringlib.stringcleanspaces(if(count(body_File) >= 71, body_File[71].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 72, body_File[72].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 73, body_File[73].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 74, body_File[74].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 75, body_File[75].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 76, body_File[76].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 77, body_File[77].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 78, body_File[78].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 79, body_File[79].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 80, body_File[80].email_body, '')) + 
			stringlib.stringcleanspaces(if(count(body_File) >= 81, body_File[81].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 82, body_File[82].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 83, body_File[83].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 84, body_File[84].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 85, body_File[85].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 86, body_File[86].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 87, body_File[87].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 88, body_File[88].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 89, body_File[89].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 90, body_File[90].email_body, '')) + 
			stringlib.stringcleanspaces(if(count(body_File) >= 91, body_File[91].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 92, body_File[92].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 93, body_File[93].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 94, body_File[94].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 95, body_File[95].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 96, body_File[96].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 97, body_File[97].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 98, body_File[98].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 99, body_File[99].email_body, '')) +
			stringlib.stringcleanspaces(if(count(body_File) >= 100, body_File[100].email_body, ''));

email_body := 	'Please forward this email to Analytics\n\nTop 1,000 Accounts missing Industry Information\n\n' + workunit + '\n\n'
							+ fn_email_body(choosen(body_file, 100))
							+ fn_email_body(choosen(body_file, 100, 101))
							+ fn_email_body(choosen(body_file, 100, 201))
							+ fn_email_body(choosen(body_file, 100, 301))
							+ fn_email_body(choosen(body_file, 100, 401))
							+ fn_email_body(choosen(body_file, 100, 501))
							+ fn_email_body(choosen(body_file, 100, 601))
							+ fn_email_body(choosen(body_file, 100, 701))
							+ fn_email_body(choosen(body_file, 100, 801))
							+ fn_email_body(choosen(body_file, 100, 901));

export build_stat := sequential(
	output(jnHist, ,'out::inquiry_acclogs::weekly_industry_blanks_list', overwrite, csv(heading, quote('"'), separator(',')), named('Populated_CIDs_WOut_Industry'));
	fileservices.Despray('out::inquiry_acclogs::weekly_industry_blanks_list', 
										 _control.IPAddress.edata12, 
										 '/inquiry_data_01/stats/weekly_industry_blanks_list', 
										 , 
										 , 
										 , 
										 true),
	if(count(body_File) >= 1, fileservices.SendEmailAttachText('cecelie.reid@lexisnexis.com, john.freibaum@lexisnexis.com, inquirytracking@lngbctshrp001.br.seisint.com',
																									 'Non FCRA Inquiry Logs - Missing Industry Values',
																									 'Weekly Industry Audit - '+ workunit + '\nPlease view attachment.',
																									 email_body,
																									 'application/msword', 
																									 'Missing Industry Values '+ut.getdate+'.doc',
																									 ,
																									 ,
																									 'cecelie.guyton@lexisnexis.com')));

export file := dataset('out::inquiry_acclogs::weekly_industry_blanks_list', recordof(jnHist), csv);

end;
