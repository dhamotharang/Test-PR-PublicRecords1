import dnb,standard,address,TopBusiness_External;

export Finance := module

export spray_raw :=
	fileservices.sprayVariable( Analytics_POC.Constants.landing_ip,
															'w:\\poc\\FS Online Data.txt',
															8192,
															'\\t',
															, , 'thor20_11',
															'poc::fs_accts_raw'
															,,,,true
														 );




layout_fs_raw := record	
	string SYS_CD;
	string CUST_CD;
	string VC_ID;
	string MIGRATION_TYPE;
	string MIG_GEN03_CD;
	string CUST_SD;
	string HH_ID;
	string HH_NAME;
	string VERTICAL;
	string SUB_MKT;
	string PMC;
	string DIRECT_RESELLER;
	string TOP_BASE;
	string CRD_CUST;
	string VERID_CUST;
	string BILLING_START;
	string BILLING_END;
	string SALES_REP;
	string SALES_MGR;
	string SALES_VP;
	string SALES_TEAM;
	string PRODUCT_ALT_ROLLUP;
	string PRODUCT_CODE;
	string PRODUCT_NAME;
	string TRANS_TYPE;
	string TRANS_TYPE_CD;
	string TRANS_TYPE_SD;
	string SEARCH_TYPE_CD;
	string SEARCH_TYPE_DESCR;
	string SEARCH_TYPE_GEN01_CD;
	string SEARCH_TYPE_GEN02_CD;
	string REV_JAN_2008;
	string REV_FEB_2008;
	string REV_MAR_2008;
	string REV_APR_2008;
	string REV_MAY_2008;
	string REV_JUN_2008;
	string REV_JUL_2008;
	string REV_AUG_2008;
	string REV_SEP_2008;
	string REV_OCT_2008;
	string REV_NOV_2008;
	string REV_DEC_2008;
	string REV_FY_2008;
	string REV_JAN_2009;
	string REV_FEB_2009;
	string REV_MAR_2009;
	string REV_APR_2009;
	string REV_MAY_2009;
	string REV_JUN_2009;
	string REV_JUL_2009;
	string REV_AUG_2009;
	string REV_SEP_2009;
	string REV_OCT_2009;
	string REV_NOV_2009;
	string REV_DEC_2009;
	string REV_FY_2009;
	string REV_JAN_2010;
	string REV_FEB_2010;
	string REV_MAR_2010;
	string REV_APR_2010;
	string REV_MAY_2010;
	string REV_JUN_2010;
	string REV_JUL_2010;
	string REV_AUG_2010;
	string REV_SEP_2010;
	string REV_OCT_2010;
	string REV_NOV_2010;
	string REV_DEC_2010;
	string REV_FY_2010;
	string REV_JAN_2011;
	string REV_FEB_2011;
	string REV_MAR_2011;
	string REV_APR_2011;
	string REV_MAY_2011;
	string REV_JUN_2011;
	string REV_JUL_2011;
	string REV_AUG_2011;
	string REV_SEP_2011;
	string REV_OCT_2011;
	string REV_NOV_2011;
	string REV_DEC_2011;
	string REV_FY_2011;
	integer UNITS_JAN_2008;
	integer UNITS_FEB_2008;
	integer UNITS_MAR_2008;
	integer UNITS_APR_2008;
	integer UNITS_MAY_2008;
	integer UNITS_JUN_2008;
	integer UNITS_JUL_2008;
	integer UNITS_AUG_2008;
	integer UNITS_SEP_2008;
	integer UNITS_OCT_2008;
	integer UNITS_NOV_2008;
	integer UNITS_DEC_2008;
	integer UNITS_FY_2008;
	integer UNITS_JAN_2009;
	integer UNITS_FEB_2009;
	integer UNITS_MAR_2009;
	integer UNITS_APR_2009;
	integer UNITS_MAY_2009;
	integer UNITS_JUN_2009;
	integer UNITS_JUL_2009;
	integer UNITS_AUG_2009;
	integer UNITS_SEP_2009;
	integer UNITS_OCT_2009;
	integer UNITS_NOV_2009;
	integer UNITS_DEC_2009;
	integer UNITS_FY_2009;
	integer UNITS_JAN_2010;
	integer UNITS_FEB_2010;
	integer UNITS_MAR_2010;
	integer UNITS_APR_2010;
	integer UNITS_MAY_2010;
	integer UNITS_JUN_2010;
	integer UNITS_JUL_2010;
	integer UNITS_AUG_2010;
	integer UNITS_SEP_2010;
	integer UNITS_OCT_2010;
	integer UNITS_NOV_2010;
	integer UNITS_DEC_2010;
	integer UNITS_FY_2010;
	integer UNITS_JAN_2011;
	integer UNITS_FEB_2011;
	integer UNITS_MAR_2011;
	integer UNITS_APR_2011;
	integer UNITS_MAY_2011;
	integer UNITS_JUN_2011;
	integer UNITS_JUL_2011;
	integer UNITS_AUG_2011;
	integer UNITS_SEP_2011;
	integer UNITS_OCT_2011;
	integer UNITS_NOV_2011;
	integer UNITS_DEC_2011;
	integer UNITS_FY_2011;
	integer mig_sort;

end;

layout_fs_raw fix_MIG_GEN03_CD(layout_fs_raw L) := transform
	self.MIG_GEN03_CD := if(L.MIG_GEN03_CD='Not Applicable', L.cust_cd, L.MIG_GEN03_CD);
	self.mig_sort := case(L.sys_cd, 'ACC' => 1,
	                                'RWS' => 2,
																	'IDM' => 4,
																	'IQA' => 7,
																	'KX'  => 8,
																	'MA'  => 10,
																	'DYT' => 12,																	
																	'CM'  => 15,
																	'PF'  => 20,
																	100);
	self := L;
end;

export file_FSRaw :=
	sort(project(dataset('~thor20_11::poc::fs_accts_raw', layout_fs_raw, csv(heading(2), quote(''), separator('\t'), terminator(['\r\n', '\n'])), opt), 
	             fix_MIG_GEN03_CD(left)),
			 MIG_GEN03_CD,mig_sort);

	

decimal10_2 convertMoney(string input) := function

	decimal10_2 money := (decimal10_2)regexreplace('[^0-9]', input,'');
	return if( stringlib.stringcontains(input, '(', false),
	           -money,
						 money );

end;

layout_fs_agg := record	
	file_FSRaw.SYS_CD;
	file_FSRaw.CUST_CD;
	file_FSRaw.VC_ID;
	file_FSRaw.MIGRATION_TYPE;
	file_FSRaw.MIG_GEN03_CD;
	string MIG_CUST_ID := regexreplace('[\\w]*-+', file_FSRaw.MIG_GEN03_CD,'');
	file_FSRaw.CUST_SD;
	file_FSRaw.HH_ID;
	file_FSRaw.HH_NAME;
	file_FSRaw.VERTICAL;
	file_FSRaw.SUB_MKT;
	file_FSRaw.PMC;
	file_FSRaw.DIRECT_RESELLER;
	file_FSRaw.TOP_BASE;
	file_FSRaw.CRD_CUST;
	file_FSRaw.VERID_CUST;
	file_FSRaw.BILLING_START;
	file_FSRaw.BILLING_END;
	file_FSRaw.SALES_REP;
	file_FSRaw.SALES_MGR;
	file_FSRaw.SALES_VP;
	file_FSRaw.SALES_TEAM;
	file_FSRaw.PRODUCT_ALT_ROLLUP;
	file_FSRaw.PRODUCT_CODE;
	file_FSRaw.PRODUCT_NAME;
	// file_FSRaw.TRANS_TYPE;
	// file_FSRaw.TRANS_TYPE_CD;
	// file_FSRaw.TRANS_TYPE_SD;
	// file_FSRaw.SEARCH_TYPE_CD;
	// file_FSRaw.SEARCH_TYPE_DESCR;
	// file_FSRaw.SEARCH_TYPE_GEN01_CD;
	// file_FSRaw.SEARCH_TYPE_GEN02_CD;

	decimal10_2 REV_JAN_2008 := sum(group, convertMoney(file_FSRaw.REV_JAN_2008));
	decimal10_2 REV_FEB_2008 := sum(group, convertMoney(file_FSRaw.REV_FEB_2008));
	decimal10_2 REV_MAR_2008 := sum(group, convertMoney(file_FSRaw.REV_MAR_2008));
	decimal10_2 REV_APR_2008 := sum(group, convertMoney(file_FSRaw.REV_APR_2008));
	decimal10_2 REV_MAY_2008 := sum(group, convertMoney(file_FSRaw.REV_MAY_2008));
	decimal10_2 REV_JUN_2008 := sum(group, convertMoney(file_FSRaw.REV_JUN_2008));
	decimal10_2 REV_JUL_2008 := sum(group, convertMoney(file_FSRaw.REV_JUL_2008));
	decimal10_2 REV_AUG_2008 := sum(group, convertMoney(file_FSRaw.REV_AUG_2008));
	decimal10_2 REV_SEP_2008 := sum(group, convertMoney(file_FSRaw.REV_SEP_2008));
	decimal10_2 REV_OCT_2008 := sum(group, convertMoney(file_FSRaw.REV_OCT_2008));
	decimal10_2 REV_NOV_2008 := sum(group, convertMoney(file_FSRaw.REV_NOV_2008));
	decimal10_2 REV_DEC_2008 := sum(group, convertMoney(file_FSRaw.REV_DEC_2008));
	decimal10_2 REV_FY_2008 := sum(group, convertMoney(file_FSRaw.REV_FY_2008));
	decimal10_2 REV_JAN_2009 := sum(group, convertMoney(file_FSRaw.REV_JAN_2009));
	decimal10_2 REV_FEB_2009 := sum(group, convertMoney(file_FSRaw.REV_FEB_2009));
	decimal10_2 REV_MAR_2009 := sum(group, convertMoney(file_FSRaw.REV_MAR_2009));
	decimal10_2 REV_APR_2009 := sum(group, convertMoney(file_FSRaw.REV_APR_2009));
	decimal10_2 REV_MAY_2009 := sum(group, convertMoney(file_FSRaw.REV_MAY_2009));
	decimal10_2 REV_JUN_2009 := sum(group, convertMoney(file_FSRaw.REV_JUN_2009));
	decimal10_2 REV_JUL_2009 := sum(group, convertMoney(file_FSRaw.REV_JUL_2009));
	decimal10_2 REV_AUG_2009 := sum(group, convertMoney(file_FSRaw.REV_AUG_2009));
	decimal10_2 REV_SEP_2009 := sum(group, convertMoney(file_FSRaw.REV_SEP_2009));
	decimal10_2 REV_OCT_2009 := sum(group, convertMoney(file_FSRaw.REV_OCT_2009));
	decimal10_2 REV_NOV_2009 := sum(group, convertMoney(file_FSRaw.REV_NOV_2009));
	decimal10_2 REV_DEC_2009 := sum(group, convertMoney(file_FSRaw.REV_DEC_2009));
	decimal10_2 REV_FY_2009 := sum(group, convertMoney(file_FSRaw.REV_FY_2009));
	decimal10_2 REV_JAN_2010 := sum(group, convertMoney(file_FSRaw.REV_JAN_2010));
	decimal10_2 REV_FEB_2010 := sum(group, convertMoney(file_FSRaw.REV_FEB_2010));
	decimal10_2 REV_MAR_2010 := sum(group, convertMoney(file_FSRaw.REV_MAR_2010));
	decimal10_2 REV_APR_2010 := sum(group, convertMoney(file_FSRaw.REV_APR_2010));
	decimal10_2 REV_MAY_2010 := sum(group, convertMoney(file_FSRaw.REV_MAY_2010));
	decimal10_2 REV_JUN_2010 := sum(group, convertMoney(file_FSRaw.REV_JUN_2010));
	decimal10_2 REV_JUL_2010 := sum(group, convertMoney(file_FSRaw.REV_JUL_2010));
	decimal10_2 REV_AUG_2010 := sum(group, convertMoney(file_FSRaw.REV_AUG_2010));
	decimal10_2 REV_SEP_2010 := sum(group, convertMoney(file_FSRaw.REV_SEP_2010));
	decimal10_2 REV_OCT_2010 := sum(group, convertMoney(file_FSRaw.REV_OCT_2010));
	decimal10_2 REV_NOV_2010 := sum(group, convertMoney(file_FSRaw.REV_NOV_2010));
	decimal10_2 REV_DEC_2010 := sum(group, convertMoney(file_FSRaw.REV_DEC_2010));
	decimal10_2 REV_FY_2010 := sum(group, convertMoney(file_FSRaw.REV_FY_2010));
	decimal10_2 REV_JAN_2011 := sum(group, convertMoney(file_FSRaw.REV_JAN_2011));
	decimal10_2 REV_FEB_2011 := sum(group, convertMoney(file_FSRaw.REV_FEB_2011));
	decimal10_2 REV_MAR_2011 := sum(group, convertMoney(file_FSRaw.REV_MAR_2011));
	decimal10_2 REV_APR_2011 := sum(group, convertMoney(file_FSRaw.REV_APR_2011));
	decimal10_2 REV_MAY_2011 := sum(group, convertMoney(file_FSRaw.REV_MAY_2011));
	decimal10_2 REV_JUN_2011 := sum(group, convertMoney(file_FSRaw.REV_JUN_2011));
	decimal10_2 REV_JUL_2011 := sum(group, convertMoney(file_FSRaw.REV_JUL_2011));
	decimal10_2 REV_AUG_2011 := sum(group, convertMoney(file_FSRaw.REV_AUG_2011));
	decimal10_2 REV_SEP_2011 := sum(group, convertMoney(file_FSRaw.REV_SEP_2011));
	decimal10_2 REV_OCT_2011 := sum(group, convertMoney(file_FSRaw.REV_OCT_2011));
	decimal10_2 REV_NOV_2011 := sum(group, convertMoney(file_FSRaw.REV_NOV_2011));
	decimal10_2 REV_DEC_2011 := sum(group, convertMoney(file_FSRaw.REV_DEC_2011));
	decimal10_2 REV_FY_2011 := sum(group, convertMoney(file_FSRaw.REV_FY_2011));

	integer UNITS_JAN_2008 := sum(group, file_FSRaw.UNITS_JAN_2008);
	integer UNITS_FEB_2008 := sum(group, file_FSRaw.UNITS_FEB_2008);
	integer UNITS_MAR_2008 := sum(group, file_FSRaw.UNITS_MAR_2008);
	integer UNITS_APR_2008 := sum(group, file_FSRaw.UNITS_APR_2008);
	integer UNITS_MAY_2008 := sum(group, file_FSRaw.UNITS_MAY_2008);
	integer UNITS_JUN_2008 := sum(group, file_FSRaw.UNITS_JUN_2008);
	integer UNITS_JUL_2008 := sum(group, file_FSRaw.UNITS_JUL_2008);
	integer UNITS_AUG_2008 := sum(group, file_FSRaw.UNITS_AUG_2008);
	integer UNITS_SEP_2008 := sum(group, file_FSRaw.UNITS_SEP_2008);
	integer UNITS_OCT_2008 := sum(group, file_FSRaw.UNITS_OCT_2008);
	integer UNITS_NOV_2008 := sum(group, file_FSRaw.UNITS_NOV_2008);
	integer UNITS_DEC_2008 := sum(group, file_FSRaw.UNITS_DEC_2008);
	integer UNITS_FY_2008 := sum(group, file_FSRaw.UNITS_FY_2008);
	integer UNITS_JAN_2009 := sum(group, file_FSRaw.UNITS_JAN_2009);
	integer UNITS_FEB_2009 := sum(group, file_FSRaw.UNITS_FEB_2009);
	integer UNITS_MAR_2009 := sum(group, file_FSRaw.UNITS_MAR_2009);
	integer UNITS_APR_2009 := sum(group, file_FSRaw.UNITS_APR_2009);
	integer UNITS_MAY_2009 := sum(group, file_FSRaw.UNITS_MAY_2009);
	integer UNITS_JUN_2009 := sum(group, file_FSRaw.UNITS_JUN_2009);
	integer UNITS_JUL_2009 := sum(group, file_FSRaw.UNITS_JUL_2009);
	integer UNITS_AUG_2009 := sum(group, file_FSRaw.UNITS_AUG_2009);
	integer UNITS_SEP_2009 := sum(group, file_FSRaw.UNITS_SEP_2009);
	integer UNITS_OCT_2009 := sum(group, file_FSRaw.UNITS_OCT_2009);
	integer UNITS_NOV_2009 := sum(group, file_FSRaw.UNITS_NOV_2009);
	integer UNITS_DEC_2009 := sum(group, file_FSRaw.UNITS_DEC_2009);
	integer UNITS_FY_2009 := sum(group, file_FSRaw.UNITS_FY_2009);
	integer UNITS_JAN_2010 := sum(group, file_FSRaw.UNITS_JAN_2010);
	integer UNITS_FEB_2010 := sum(group, file_FSRaw.UNITS_FEB_2010);
	integer UNITS_MAR_2010 := sum(group, file_FSRaw.UNITS_MAR_2010);
	integer UNITS_APR_2010 := sum(group, file_FSRaw.UNITS_APR_2010);
	integer UNITS_MAY_2010 := sum(group, file_FSRaw.UNITS_MAY_2010);
	integer UNITS_JUN_2010 := sum(group, file_FSRaw.UNITS_JUN_2010);
	integer UNITS_JUL_2010 := sum(group, file_FSRaw.UNITS_JUL_2010);
	integer UNITS_AUG_2010 := sum(group, file_FSRaw.UNITS_AUG_2010);
	integer UNITS_SEP_2010 := sum(group, file_FSRaw.UNITS_SEP_2010);
	integer UNITS_OCT_2010 := sum(group, file_FSRaw.UNITS_OCT_2010);
	integer UNITS_NOV_2010 := sum(group, file_FSRaw.UNITS_NOV_2010);
	integer UNITS_DEC_2010 := sum(group, file_FSRaw.UNITS_DEC_2010);
	integer UNITS_FY_2010 := sum(group, file_FSRaw.UNITS_FY_2010);
	integer UNITS_JAN_2011 := sum(group, file_FSRaw.UNITS_JAN_2011);
	integer UNITS_FEB_2011 := sum(group, file_FSRaw.UNITS_FEB_2011);
	integer UNITS_MAR_2011 := sum(group, file_FSRaw.UNITS_MAR_2011);
	integer UNITS_APR_2011 := sum(group, file_FSRaw.UNITS_APR_2011);
	integer UNITS_MAY_2011 := sum(group, file_FSRaw.UNITS_MAY_2011);
	integer UNITS_JUN_2011 := sum(group, file_FSRaw.UNITS_JUN_2011);
	integer UNITS_JUL_2011 := sum(group, file_FSRaw.UNITS_JUL_2011);
	integer UNITS_AUG_2011 := sum(group, file_FSRaw.UNITS_AUG_2011);
	integer UNITS_SEP_2011 := sum(group, file_FSRaw.UNITS_SEP_2011);
	integer UNITS_OCT_2011 := sum(group, file_FSRaw.UNITS_OCT_2011);
	integer UNITS_NOV_2011 := sum(group, file_FSRaw.UNITS_NOV_2011);
	integer UNITS_DEC_2011 := sum(group, file_FSRaw.UNITS_DEC_2011);
	integer UNITS_FY_2011 := sum(group, file_FSRaw.UNITS_FY_2011);

	// integer mig_sort;

end;

export file_fs := table( file_FSRaw, 
												 layout_fs_agg, 
												 MIG_GEN03_CD );

export spray_raw_rev_vol :=
	fileservices.sprayVariable( Analytics_POC.Constants.landing_ip,
															'w:\\poc\\jacob_fin_svcs_data_by_month.tsv',
															8192,
															'\\t',
															, , 'thor20_11',
															'poc::fs_accts_raw_rev_vol'
															,,,,true
														 );




end;