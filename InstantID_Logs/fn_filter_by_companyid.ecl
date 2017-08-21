export fn_filter_by_companyid(dataset(instantid_logs.Layout_InstantID_logs_Base) infile) := function

dummy_company_ids := ['1385345',
									'1006061',
									'1448650',
									'1488800',
									'1028725',
									'1104341',
									'1357055',
									'1005199'// Accurint Admin
									];
		
outfile := infile(trim(orig_company_id, left, right) not in dummy_company_ids);

return outfile;
end;