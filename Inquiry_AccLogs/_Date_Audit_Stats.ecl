import _control;

export _Date_Audit_Stats := module

#workunit('name','Weekly - File/Date Audit')

/////////////////// Partial for Inquiry Stats that can be done on logs thor

Hist := inquiry_acclogs.fn_ProdHist().File;

trimHist := table(hist, {datetime := search_info.datetime[..8], source, search_info.product_code, 
												 search_info.transaction_id, search_info.sequence_number, search_info.function_description});
												 
distrHist := distribute(trimHist, hash(datetime, source, product_code, transaction_id, sequence_number, function_description));

dedupHist := dedup(sort(distrHist, datetime, source, product_code, transaction_id, sequence_number, function_description, local)
												,datetime, source, product_code, transaction_id, sequence_number, function_description, local);

shared tHist := table(dedupHist, {yyyy := datetime[..4], 
											mm := datetime[5..6], 
											dd := datetime[7..8], 
											source, product_code, 
											count_records := count(group)}, source, product_code, datetime[..8], few)(yyyy between '1900' and '2099');
											
shared srtHist	:= sort(tHist, -(yyyy+mm+dd), source, product_code) : independent;

r := record 
  string line{maxLength(3145728)} := ''; // 3 mb email attachement max or 20 years of data for 10 sources
end;

pHist := project(srtHist, transform({tHist, r}, 
													self.line := stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringcleanspaces(left.yyyy + ',' + left.mm + ',' + left.dd + ',' + left.source + ',' + left.product_code + ',' + (string)left.count_records),
																				'BATCHR3','PROD R3'), ', ', ',');
													self := left));

rll := trim(rollup(pHist, transform(recordof(pHist), 
							self.line := left.line + '\n' + right.line;
							self := right), 'all')[1].line, left, right);

export build_stats := parallel(
		output(srtHist,,'out::inquiry_acclogs::weekly_date_audit', overwrite, csv(heading, quote('"'), separator(',')));
		fileservices.Despray('out::inquiry_acclogs::weekly_date_audit', 
												 _control.IPAddress.edata12, 
												 '/inquiry_data_01/stats/weekly_date_audit', 
												 , 
												 , 
												 , 
												 true);
		fileservices.SendEmailAttachText('cecelie.reid@lexisnexis.com,inquirytracking@lngbctshrp001.br.seisint.com',
																						 'Non FCRA Inquiry Logs - Weekly Date Audit',
																						 'Weekly Date Audit - '+ workunit + '\nPlease view attachment.',
																						 rll,
																						 'text/plain; charset=ISO-8859-3', 
																						 'Weekly Date Audit.csv',
																						 ,
																						 ,
																						 'cecelie.guyton@lexisnexis.com'));
																						 
export file := dataset('out::inquiry_acclogs::weekly_date_audit', recordof(srtHist), csv);

end;