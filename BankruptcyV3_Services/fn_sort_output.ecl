import Text_Search;

export fn_sort_output(dataset({layouts.layout_rollup, Text_Search.Layout_ExternalKey}) ds_in,
											integer1 state_sort, 
											integer1 case_sort,  
											integer1 fdate_sort, 
											integer1 lname_sort, 
											integer1 cname_sort) := function

	rec_in 	:= recordof(ds_in);

	rec_sort := record (rec_in)
		string state_sort_param;
		string case_sort_param;
		string fdate_sort_param;
		string lname_sort_param;
		string cname_sort_param;
	end;

	/* project sort params down to case level */
	rec_sort xfm_add_sort_params(rec_in le) := transform

		/* debtors already sorted to give preference to Primary in fn_rollup_debtors */
		self.case_sort_param		:= le.case_number;  // not necessary, for consistency
		self.fdate_sort_param		:= le.date_filed;
		self.state_sort_param		:= le.debtors[1].addresses[1].st;
		self.lname_sort_param		:= le.debtors[1].names[1].lname;
		/* for company name sort, check for secondary alias since the first alias for cname is often a person's name */
		self.cname_sort_param		:= if(le.debtors[1].names[1].cname=''	and le.debtors[1].names[2].cname <>'',
																	le.debtors[1].names[2].cname,
																	le.debtors[1].names[1].cname);
		self := le;
	end;

	/* project to layout with sort params */
	ds_added_params := project(ds_in, xfm_add_sort_params(left));

	/* sort based on desired sort param (give preference to non-empty fields) */
	ds_sorted_w_params := map(
												state_sort = 1 		=> sort(ds_added_params, state_sort_param='', state_sort_param),
												case_sort  = 1		=> sort(ds_added_params, case_sort_param),
												fdate_sort = 1		=> sort(ds_added_params, fdate_sort_param),
												lname_sort = 1		=> sort(ds_added_params, lname_sort_param='', lname_sort_param),
												cname_sort = 1		=> sort(ds_added_params, cname_sort_param='', cname_sort_param),
												state_sort = -1 	=> sort(ds_added_params, state_sort_param='', -state_sort_param),
												case_sort  = -1		=> sort(ds_added_params, -case_sort_param),
												fdate_sort = -1		=> sort(ds_added_params, -fdate_sort_param),
												lname_sort = -1		=> sort(ds_added_params, lname_sort_param='', -lname_sort_param),
												cname_sort = -1 	=> sort(ds_added_params, cname_sort_param='', -cname_sort_param),
												ds_added_params);
	
	/* project back to original layout */
	ds_rollup_sorted := project(ds_sorted_w_params, rec_in);
	
	return ds_rollup_sorted;
	
end;
