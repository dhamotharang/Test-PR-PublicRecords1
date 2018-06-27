export fedex_qa_samples(string filedate) := function

	ds := fedex.file_fedex_base;
	ds_father := dataset('~thor_200::base::fedex::nohits_father', fedex.Layout_FedEx.Base, flat);

	sample_recs := join(ds(phone <> '' and regexfind('[0]',phone) = false),
											ds_father(phone <> '' and regexfind('[0]',phone) = false),
											left.phone = right.phone and
											left.prim_range = right.prim_range and
											left.prim_name	= right.prim_name and
											left.sec_range	= right.sec_range and
											left.zip				= right.zip,
											transform(recordof(ds), self := left),
											left only
											);
	new_sample := distribute(sample_recs)  ;										
	return sequential(output(choosen(sort(new_sample,-file_date,local),1000), named('FedEx_sample_records')),
											fileservices.sendemail('michael.gould@lexisnexis.com;qualityassurance@seisint.com',
																						 'FedEx sample records for build version ' + filedate,
																						 'New FedEx QA sample records: http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit)
										);



end;