

stats_lay := RECORD
  string name;
  real8 mean;
  real8 median;
  real8 std_dev;
  real8 miss_rate;
  real8 zero_rate;
  real8 neg_one_rate;
  real8 hit_rate;
  real8 outlier_count;
 END;

ds_sprt3 := dataset('~nkoubsky::out::businessshell_stats_w20150103-143827', stats_lay, thor);
// ds_sprt4 := dataset('~nkoubsky::out::businessshell_stats_w20150107-120238', stats_lay, thor);
ds_sprt4 := dataset('~nkoubsky::out::businessshell_stats_w20150121-103503', stats_lay, thor);

// output(ds_sprt3);
// output(ds_sprt4);

stats_lay diff_trans (stats_lay le, stats_lay ri) := transform
		self.name := le.name;
		self.mean := if(	abs(le.mean - ri.mean) < .001 or  abs(le.mean - ri.mean) < abs(le.mean * 0.25), 0, 1);
		self.median := if(	abs(le.median - ri.median) < .001 or  abs(le.median - ri.median) < abs(le.median * 0.25), 0, 1);
		self.std_dev := if(	abs(le.std_dev - ri.std_dev) < .001 or  abs(le.std_dev - ri.std_dev) < abs(le.std_dev * 0.25), 0, 1);
		self.miss_rate := if(	abs(le.miss_rate - ri.miss_rate) < .001 or  abs(le.miss_rate - ri.miss_rate) < abs(le.miss_rate * 0.25), 0, 1);
		self.zero_rate := if(	abs(le.zero_rate - ri.zero_rate) < .001 or  abs(le.zero_rate - ri.zero_rate) < abs(le.zero_rate * 0.25), 0, 1);
		self.neg_one_rate := if(	abs(le.neg_one_rate - ri.neg_one_rate) < .001 or  abs(le.neg_one_rate - ri.neg_one_rate) < abs(le.neg_one_rate * 0.25), 0, 1);
		self.hit_rate := if(	abs(le.hit_rate - ri.hit_rate) < .001 or  abs(le.hit_rate - ri.hit_rate) < abs(le.hit_rate * 0.25), 0, 1);
		self := [];
end;


results := join(ds_sprt3, ds_sprt4, left.name = right.name, diff_trans(left, right));
temp_results := sort(results, -mean, -median, -std_dev);
final_results := temp_results (	mean <> 0 or
																median <> 0 or
																std_dev <> 0 or
																miss_rate <> 0 or
																zero_rate <> 0 or
																neg_one_rate <> 0 or
																hit_rate <> 0);

diff_set := set(final_results, name);

combined_lay := record
		dataset(stats_lay) res;
end;

det_results := join(ds_sprt3, ds_sprt4, left.name = right.name and left.name in diff_set,
										transform(combined_lay, self.res := left + right));

output(final_results, named('difference_matrix'));
output(det_results, named('detailed_differences'));
