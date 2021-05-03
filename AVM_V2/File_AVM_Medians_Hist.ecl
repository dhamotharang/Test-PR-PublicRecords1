import ut, doxie;

export File_AVM_Medians_Hist(dataset(AVM_V2.layouts.Layout_Median_Valuations) medians_current) := function

hist2005 := dataset('~thor_data400::avm_v2::2005_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2006 := dataset('~thor_data400::avm_v2::2006_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2007 := dataset('~thor_data400::avm_v2::2007_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2008_q1 := dataset('~thor_data400::avm_v2::2008_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2008_q2 := dataset('~thor_data400::avm_v2::2008_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2008_q3 := dataset('~thor_data400::avm_v2::2008_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2008_q4 := dataset('~thor_data400::avm_v2::2008_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2009_q1 := dataset('~thor_data400::avm_v2::2009_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2009_q2 := dataset('~thor_data400::avm_v2::2009_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2009_q3 := dataset('~thor_data400::avm_v2::2009_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2009_q4 := dataset('~thor_data400::avm_v2::2009_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2010_q1 := dataset('~thor_data400::avm_v2::2010_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2010_q2 := dataset('~thor_data400::avm_v2::2010_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2010_q3 := dataset('~thor_data400::avm_v2::2010_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2010_q4 := dataset('~thor_data400::avm_v2::2010_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2011_q1 := dataset('~thor_data400::avm_v2::2011_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2011_q2 := dataset('~thor_data400::avm_v2::2011_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2011_q3 := dataset('~thor_data400::avm_v2::2011_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2011_q4 := dataset('~thor_data400::avm_v2::2011_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2012_q1 := dataset('~thor_data400::avm_v2::2012_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2012_q2 := dataset('~thor_data400::avm_v2::2012_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2012_q3 := dataset('~thor_data400::avm_v2::2012_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2012_q4 := dataset('~thor_data400::avm_v2::2012_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2013_q1 := dataset('~thor_data400::avm_v2::2013_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2013_q2 := dataset('~thor_data400::avm_v2::2013_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2013_q3 := dataset('~thor_data400::avm_v2::2013_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2013_q4 := dataset('~thor_data400::avm_v2::2013_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2014_q1 := dataset('~thor_data400::avm_v2::2014_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2014_q2 := dataset('~thor_data400::avm_v2::2014_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2014_q3 := dataset('~thor_data400::avm_v2::2014_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2014_q4 := dataset('~thor_data400::avm_v2::2014_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2015_q1 := dataset('~thor_data400::avm_v2::2015_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2015_q2 := dataset('~thor_data400::avm_v2::2015_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2015_q3 := dataset('~thor_data400::avm_v2::2015_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2015_q4 := dataset('~thor_data400::avm_v2::2015_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2016_q1 := dataset('~thor_data400::avm_v2::2016_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2016_q2 := dataset('~thor_data400::avm_v2::2016_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2016_q3 := dataset('~thor_data400::avm_v2::2016_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2016_q4 := dataset('~thor_data400::avm_v2::2016_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2017_q1 := dataset('~thor_data400::avm_v2::2017_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2017_q2 := dataset('~thor_data400::avm_v2::2017_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2017_q3 := dataset('~thor_data400::avm_v2::2017_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2017_q4 := dataset('~thor_data400::avm_v2::2017_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2018_q1 := dataset('~thor_data400::avm_v2::2018_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2018_q2 := dataset('~thor_data400::avm_v2::2018_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2018_q3 := dataset('~thor_data400::avm_v2::2018_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2018_q4 := dataset('~thor_data400::avm_v2::2018_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2019_q1 := dataset('~thor_data400::avm_v2::2019_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2019_q2 := dataset('~thor_data400::avm_v2::2019_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2019_q3 := dataset('~thor_data400::avm_v2::2019_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2019_q4 := dataset('~thor_data400::avm_v2::2019_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2020_q1 := dataset('~thor_data400::avm_v2::2020_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2020_q2 := dataset('~thor_data400::avm_v2::2020_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2020_q3 := dataset('~thor_data400::avm_v2::2020_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2020_q4 := dataset('~thor_data400::avm_v2::2020_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2021_q1 := dataset('~thor_data400::avm_v2::2021_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2021_q2 := dataset('~thor_data400::avm_v2::2021_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2021_q3 := dataset('~thor_data400::avm_v2::2021_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2021_q4 := dataset('~thor_data400::avm_v2::2021_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2022_q1 := dataset('~thor_data400::avm_v2::2022_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2022_q2 := dataset('~thor_data400::avm_v2::2022_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2022_q3 := dataset('~thor_data400::avm_v2::2022_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2022_q4 := dataset('~thor_data400::avm_v2::2022_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2023_q1 := dataset('~thor_data400::avm_v2::2023_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2023_q2 := dataset('~thor_data400::avm_v2::2023_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2023_q3 := dataset('~thor_data400::avm_v2::2023_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2023_q4 := dataset('~thor_data400::avm_v2::2023_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2024_q1 := dataset('~thor_data400::avm_v2::2024_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2024_q2 := dataset('~thor_data400::avm_v2::2024_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2024_q3 := dataset('~thor_data400::avm_v2::2024_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2024_q4 := dataset('~thor_data400::avm_v2::2024_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2025_q1 := dataset('~thor_data400::avm_v2::2025_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2025_q2 := dataset('~thor_data400::avm_v2::2025_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2025_q3 := dataset('~thor_data400::avm_v2::2025_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2025_q4 := dataset('~thor_data400::avm_v2::2025_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2026_q1 := dataset('~thor_data400::avm_v2::2026_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2026_q2 := dataset('~thor_data400::avm_v2::2026_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2026_q3 := dataset('~thor_data400::avm_v2::2026_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2026_q4 := dataset('~thor_data400::avm_v2::2026_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2027_q1 := dataset('~thor_data400::avm_v2::2027_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2027_q2 := dataset('~thor_data400::avm_v2::2027_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2027_q3 := dataset('~thor_data400::avm_v2::2027_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2027_q4 := dataset('~thor_data400::avm_v2::2027_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2028_q1 := dataset('~thor_data400::avm_v2::2028_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2028_q2 := dataset('~thor_data400::avm_v2::2028_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2028_q3 := dataset('~thor_data400::avm_v2::2028_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2028_q4 := dataset('~thor_data400::avm_v2::2028_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2029_q1 := dataset('~thor_data400::avm_v2::2029_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2029_q2 := dataset('~thor_data400::avm_v2::2029_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2029_q3 := dataset('~thor_data400::avm_v2::2029_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2029_q4 := dataset('~thor_data400::avm_v2::2029_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

hist2030_q1 := dataset('~thor_data400::avm_v2::2030_Q1_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2030_q2 := dataset('~thor_data400::avm_v2::2030_Q2_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2030_q3 := dataset('~thor_data400::avm_v2::2030_Q3_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);
hist2030_q4 := dataset('~thor_data400::avm_v2::2030_Q4_median_valuations', AVM_V2.layouts.Layout_Median_Valuations, thor)(median_valuation<>0);

AVM_V2.layouts.layout_medians_with_history merge_base_with_archive1(AVM_V2.layouts.Layout_Median_Valuations le, AVM_V2.layouts.Layout_Median_Valuations rt) := transform 
		self.history := project(rt, transform(AVM_V2.layouts.layout_median_history_slim, self := left));
		base_available := le.fips_geo_12<>'';
		self.fips_geo_12 := if(base_available, le.fips_geo_12, rt.fips_geo_12);
		self := le;
end;

current := distribute(medians_current, hash(fips_geo_12));
archive2005 := distribute(hist2005, hash(fips_geo_12));

with2005 := join(current, archive2005, 
						left.fips_geo_12=right.fips_geo_12,
					merge_base_with_archive1(left, right),
						full outer, local);


AVM_V2.layouts.layout_medians_with_history append_more_history(AVM_V2.layouts.layout_medians_with_history le, AVM_V2.layouts.Layout_Median_Valuations rt) := transform 
		
		htemp :=le.history + project(rt, transform(AVM_V2.layouts.layout_median_history_slim, self := left));
		self.history := htemp(Median_valuation<>0); // filter out any history rows where a record didn't exist
		
		base_available := le.fips_geo_12<>'';
		self.fips_geo_12 := if(base_available, le.fips_geo_12, rt.fips_geo_12);

		self := le;
end;

archive2006 := distribute(hist2006, hash(fips_geo_12));						
with2006 := join(with2005, archive2006,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive2007 := distribute(hist2007, hash(fips_geo_12));						
with2007 := join(with2006, archive2007,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);				

archive1 := distribute(hist2008_q1, hash(fips_geo_12));						
j1 := join(with2007, archive1,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive2 := distribute(hist2008_q2, hash(fips_geo_12));						
j2 := join(j1, archive2,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

archive3 := distribute(hist2008_q3, hash(fips_geo_12));
j3 := join(j2, archive3,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);			

archive4 := distribute(hist2008_q4, hash(fips_geo_12));
j4 := join(j3, archive4,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive5 := distribute(hist2009_q1, hash(fips_geo_12));
j5 := join(j4, archive5,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

archive6 := distribute(hist2009_q2, hash(fips_geo_12));
j6 := join(j5, archive6,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

archive7 := distribute(hist2009_q3, hash(fips_geo_12));
j7 := join(j6, archive7,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

archive8 := distribute(hist2009_q4, hash(fips_geo_12));
j8 := join(j7, archive8,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive9 := distribute(hist2010_q1, hash(fips_geo_12));
j9 := join(j8, archive9,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive10 := distribute(hist2010_q2, hash(fips_geo_12));
j10 := join(j9, archive10,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive11 := distribute(hist2010_q3, hash(fips_geo_12));
j11 := join(j10, archive11,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive12 := distribute(hist2010_q4, hash(fips_geo_12));
j12 := join(j11, archive12,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive13 := distribute(hist2011_q1, hash(fips_geo_12));
j13 := join(j12, archive13,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive14 := distribute(hist2011_q2, hash(fips_geo_12));
j14 := join(j13, archive14,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive15 := distribute(hist2011_q3, hash(fips_geo_12));
j15 := join(j14, archive15,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive16 := distribute(hist2011_q4, hash(fips_geo_12));
j16 := join(j15, archive16,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive17 := distribute(hist2012_q1, hash(fips_geo_12));
j17 := join(j16, archive17,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive18 := distribute(hist2012_q2, hash(fips_geo_12));
j18 := join(j17, archive18,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive19 := distribute(hist2012_q3, hash(fips_geo_12));
j19 := join(j18, archive19,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive20 := distribute(hist2012_q4, hash(fips_geo_12));
j20 := join(j19, archive20,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive21 := distribute(hist2013_q1, hash(fips_geo_12));
j21 := join(j20, archive21,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive22 := distribute(hist2013_q2, hash(fips_geo_12));
j22 := join(j21, archive22,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive23 := distribute(hist2013_q3, hash(fips_geo_12));
j23 := join(j22, archive23,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive24 := distribute(hist2013_q4, hash(fips_geo_12));
j24 := join(j23, archive24,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive25 := distribute(hist2014_q1, hash(fips_geo_12));
j25 := join(j24, archive25,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive26 := distribute(hist2014_q2, hash(fips_geo_12));
j26 := join(j25, archive26,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive27 := distribute(hist2014_q3, hash(fips_geo_12));
j27 := join(j26, archive27,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive28 := distribute(hist2014_q4, hash(fips_geo_12));
j28 := join(j27, archive28,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive29 := distribute(hist2015_q1, hash(fips_geo_12));
j29 := join(j28, archive29,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive30 := distribute(hist2015_q2, hash(fips_geo_12));
j30 := join(j29, archive30,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive31 := distribute(hist2015_q3, hash(fips_geo_12));
j31 := join(j30, archive31,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);
						
archive32 := distribute(hist2015_q4, hash(fips_geo_12));
j32 := join(j31, archive32,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);						

archive33 := distribute(hist2016_q1, hash(fips_geo_12));
j33 := join(j32, archive33,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive34 := distribute(hist2016_q2, hash(fips_geo_12));
j34 := join(j33, archive34,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
						
archive35 := distribute(hist2016_q3, hash(fips_geo_12));
j35 := join(j34, archive35,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive36 := distribute(hist2016_q4, hash(fips_geo_12));
j36 := join(j35, archive36,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);							
						
archive37 := distribute(hist2017_q1, hash(fips_geo_12));
j37 := join(j36, archive37,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive38 := distribute(hist2017_q2, hash(fips_geo_12));
j38 := join(j37, archive38,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
						
archive39 := distribute(hist2017_q3, hash(fips_geo_12));
j39 := join(j38, archive39,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
						
archive40 := distribute(hist2017_q4, hash(fips_geo_12));
j40 := join(j39, archive40,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);							

archive41 := distribute(hist2018_q1, hash(fips_geo_12));
j41 := join(j40, archive41,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive42 := distribute(hist2018_q2, hash(fips_geo_12));
j42 := join(j41, archive42,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);							
						
archive43 := distribute(hist2018_q3, hash(fips_geo_12));
j43 := join(j42, archive43,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
						
archive44 := distribute(hist2018_q4, hash(fips_geo_12));
j44 := join(j43, archive44,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
						
archive45 := distribute(hist2019_q1, hash(fips_geo_12));
j45 := join(j44, archive45,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
						
archive46 := distribute(hist2019_q2, hash(fips_geo_12));
j46 := join(j45, archive46,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
						
archive47 := distribute(hist2019_q3, hash(fips_geo_12));
j47 := join(j46, archive47,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
						
archive48 := distribute(hist2019_q4, hash(fips_geo_12));
j48 := join(j47, archive48,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive49 := distribute(hist2020_q1, hash(fips_geo_12));
j49 := join(j48, archive49,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive50 := distribute(hist2020_q2, hash(fips_geo_12));
j50 := join(j49, archive50,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive51 := distribute(hist2020_q3, hash(fips_geo_12));
j51 := join(j50, archive51,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive52 := distribute(hist2020_q4, hash(fips_geo_12));
j52 := join(j51, archive52,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive53 := distribute(hist2021_q1, hash(fips_geo_12));
j53 := join(j52, archive53,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive54 := distribute(hist2021_q2, hash(fips_geo_12));
j54 := join(j53, archive54,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive55 := distribute(hist2021_q3, hash(fips_geo_12));
j55 := join(j54, archive55,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
archive56 := distribute(hist2021_q4, hash(fips_geo_12));
j56 := join(j54, archive56,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
						
archive57 := distribute(hist2022_q1, hash(fips_geo_12));
j57 := join(j56, archive57,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
archive58 := distribute(hist2022_q2, hash(fips_geo_12));
j58 := join(j57, archive58,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive59 := distribute(hist2022_q3, hash(fips_geo_12));
j59 := join(j58, archive59,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	
archive60 := distribute(hist2022_q4, hash(fips_geo_12));
j60 := join(j59, archive60,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive61 := distribute(hist2023_q1, hash(fips_geo_12));
j61 := join(j60, archive61,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive62 := distribute(hist2023_q2, hash(fips_geo_12));
j62 := join(j61, archive62,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive63 := distribute(hist2023_q3, hash(fips_geo_12));
j63 := join(j62, archive63,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive64 := distribute(hist2023_q4, hash(fips_geo_12));
j64 := join(j63, archive64,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive65 := distribute(hist2024_q1, hash(fips_geo_12));
j65 := join(j64, archive65,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive66 := distribute(hist2024_q2, hash(fips_geo_12));
j66 := join(j65, archive66,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive67 := distribute(hist2024_q3, hash(fips_geo_12));
j67 := join(j66, archive67,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive68 := distribute(hist2024_q4, hash(fips_geo_12));
j68 := join(j67, archive68,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive69 := distribute(hist2025_q1, hash(fips_geo_12));
j69 := join(j68, archive69,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive70 := distribute(hist2025_q2, hash(fips_geo_12));
j70 := join(j69, archive70,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive71 := distribute(hist2025_q3, hash(fips_geo_12));
j71 := join(j70, archive71,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive72 := distribute(hist2025_q4, hash(fips_geo_12));
j72 := join(j71, archive72,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive73 := distribute(hist2026_q1, hash(fips_geo_12));
j73 := join(j72, archive73,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive74 := distribute(hist2026_q2, hash(fips_geo_12));
j74 := join(j73, archive74,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive75 := distribute(hist2026_q3, hash(fips_geo_12));
j75 := join(j74, archive75,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive76 := distribute(hist2026_q4, hash(fips_geo_12));
j76 := join(j75, archive76,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive77 := distribute(hist2027_q1, hash(fips_geo_12));
j77 := join(j76, archive77,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive78 := distribute(hist2027_q2, hash(fips_geo_12));
j78 := join(j77, archive78,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

archive79 := distribute(hist2027_q3, hash(fips_geo_12));
j79 := join(j78, archive79,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive80 := distribute(hist2027_q4, hash(fips_geo_12));
j80 := join(j79, archive80,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive81 := distribute(hist2028_q1, hash(fips_geo_12));
j81 := join(j80, archive81,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive82 := distribute(hist2028_q2, hash(fips_geo_12));
j82 := join(j81, archive82,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive83 := distribute(hist2028_q3, hash(fips_geo_12));
j83 := join(j82, archive83,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

archive84 := distribute(hist2028_q4, hash(fips_geo_12));
j84 := join(j83, archive84,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive85 := distribute(hist2029_q1, hash(fips_geo_12));
j85 := join(j84, archive85,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive86 := distribute(hist2029_q2, hash(fips_geo_12));
j86 := join(j85, archive86,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive87 := distribute(hist2029_q3, hash(fips_geo_12));
j87 := join(j86, archive87,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive88 := distribute(hist2029_q4, hash(fips_geo_12));
j88 := join(j87, archive88,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);	

archive89 := distribute(hist2030_q1, hash(fips_geo_12));
j89 := join(j88, archive89,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

archive90 := distribute(hist2030_q2, hash(fips_geo_12));
j90 := join(j89, archive90,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

archive91 := distribute(hist2030_q3, hash(fips_geo_12));
j91 := join(j90, archive91,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

archive92 := distribute(hist2030_q4, hash(fips_geo_12));
j92 := join(j91, archive92,
						left.fips_geo_12=right.fips_geo_12,
					append_more_history(left, right),
						full outer, local);

// will need to decide in 2030 if we can keep going with more child records or if we need to remove 2008 because of limits in nested child rows in roxie keys

return j92;

end;