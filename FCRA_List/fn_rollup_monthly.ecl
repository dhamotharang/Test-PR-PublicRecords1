IMPORT watchdog;

EXPORT fn_rollup_monthly(dataset(fcra_list.layout_optout.base) infile) := function

fcra_best_monthly := fcra_list.file_best;

combine_file := infile + project(fcra_best_monthly, transform(fcra_list.layout_optout.base, self := left, self := []));

combine_file_dist := distribute(combine_file, hash(did));
combine_file_sort := sort(combine_file_dist, did, -opt_out_hit, -run_date, local);
combine_file_group := group(combine_file_sort, did, local);

combine_file trollup_monthly(combine_file_group le, combine_file_group ri) := transform
   self.opt_out_hit := if(le.opt_out_hit, le.opt_out_hit, ri.opt_out_hit);
   self.run_date := if(le.run_date > ri.run_date, le.run_date, ri.run_date);
	 self := le;
	 end;
	
monthly_rollup := group(rollup(combine_file_group,true, trollup_monthly(left, right)));

return monthly_rollup;

end;

	

																									


