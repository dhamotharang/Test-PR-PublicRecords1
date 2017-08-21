import marketing_best;

equifax_ttl_sol_dist := distribute(marketing_best.file_equifax_base(did > 0),hash(did));
equifax_ttl_sol_father_dist := distribute(marketing_best.file_equifax_base_father(did > 0),hash(did));

marketing_best.layout_equifax_base tSampleDID(equifax_ttl_sol_dist l, equifax_ttl_sol_father_dist r) := transform
	self := l;
end;

new_sample_did := join(equifax_ttl_sol_dist,
											 equifax_ttl_sol_father_dist,
											 left.DID = right.DID,
											 tSampleDID(left, right),
											 left only,
											 local);
											 
export equifax_new_records_sample := if (count(new_sample_did) > 0,
																				sequential(output(choosen(new_sample_did,1000),named('Equifax_Sample_DID_QA')),
																										fileservices.sendemail('kgummadi@seisint.com;qualityassurance@seisint.com',
																																					 'Equifax Total Soutions Sample Records',
																																					 'Total Solution Sample Records: http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit)),
																				output('No new DIDs created'));