import ut, doxie;

export File_AVM_Hist(dataset(AVM_V2.layouts.Layout_Automated_Valuations) valuations_current) := function

hist2005 := dataset('~thor_data400::avm_v2::2005_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2006 := dataset('~thor_data400::avm_v2::2006_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2007 := dataset('~thor_data400::avm_v2::2007_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
  
hist2008_q1 := dataset('~thor_data400::avm_v2::2008_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2008_q2 := dataset('~thor_data400::avm_v2::2008_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2008_q3 := dataset('~thor_data400::avm_v2::2008_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2008_q4 := dataset('~thor_data400::avm_v2::2008_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2009_q1 := dataset('~thor_data400::avm_v2::2009_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2009_q2 := dataset('~thor_data400::avm_v2::2009_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2009_q3 := dataset('~thor_data400::avm_v2::2009_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2009_q4 := dataset('~thor_data400::avm_v2::2009_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2010_q1 := dataset('~thor_data400::avm_v2::2010_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2010_q2 := dataset('~thor_data400::avm_v2::2010_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2010_q3 := dataset('~thor_data400::avm_v2::2010_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2010_q4 := dataset('~thor_data400::avm_v2::2010_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2011_q1 := dataset('~thor_data400::avm_v2::2011_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2011_q2 := dataset('~thor_data400::avm_v2::2011_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2011_q3 := dataset('~thor_data400::avm_v2::2011_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2011_q4 := dataset('~thor_data400::avm_v2::2011_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2012_q1 := dataset('~thor_data400::avm_v2::2012_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2012_q2 := dataset('~thor_data400::avm_v2::2012_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2012_q3 := dataset('~thor_data400::avm_v2::2012_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2012_q4 := dataset('~thor_data400::avm_v2::2012_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2013_q1 := dataset('~thor_data400::avm_v2::2013_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2013_q2 := dataset('~thor_data400::avm_v2::2013_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2013_q3 := dataset('~thor_data400::avm_v2::2013_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2013_q4 := dataset('~thor_data400::avm_v2::2013_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2014_q1 := dataset('~thor_data400::avm_v2::2014_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2014_q2 := dataset('~thor_data400::avm_v2::2014_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2014_q3 := dataset('~thor_data400::avm_v2::2014_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2014_q4 := dataset('~thor_data400::avm_v2::2014_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2015_q1 := dataset('~thor_data400::avm_v2::2015_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2015_q2 := dataset('~thor_data400::avm_v2::2015_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2015_q3 := dataset('~thor_data400::avm_v2::2015_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2015_q4 := dataset('~thor_data400::avm_v2::2015_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2016_q1 := dataset('~thor_data400::avm_v2::2016_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2016_q2 := dataset('~thor_data400::avm_v2::2016_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2016_q3 := dataset('~thor_data400::avm_v2::2016_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2016_q4 := dataset('~thor_data400::avm_v2::2016_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2017_q1 := dataset('~thor_data400::avm_v2::2017_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2017_q2 := dataset('~thor_data400::avm_v2::2017_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2017_q3 := dataset('~thor_data400::avm_v2::2017_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2017_q4 := dataset('~thor_data400::avm_v2::2017_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2018_q1 := dataset('~thor_data400::avm_v2::2018_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2018_q2 := dataset('~thor_data400::avm_v2::2018_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2018_q3 := dataset('~thor_data400::avm_v2::2018_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2018_q4 := dataset('~thor_data400::avm_v2::2018_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2019_q1 := dataset('~thor_data400::avm_v2::2019_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2019_q2 := dataset('~thor_data400::avm_v2::2019_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2019_q3 := dataset('~thor_data400::avm_v2::2019_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2019_q4 := dataset('~thor_data400::avm_v2::2019_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2020_q1 := dataset('~thor_data400::avm_v2::2020_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2020_q2 := dataset('~thor_data400::avm_v2::2020_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2020_q3 := dataset('~thor_data400::avm_v2::2020_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2020_q4 := dataset('~thor_data400::avm_v2::2020_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2021_q1 := dataset('~thor_data400::avm_v2::2021_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2021_q2 := dataset('~thor_data400::avm_v2::2021_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2021_q3 := dataset('~thor_data400::avm_v2::2021_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2021_q4 := dataset('~thor_data400::avm_v2::2021_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2022_q1 := dataset('~thor_data400::avm_v2::2022_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2022_q2 := dataset('~thor_data400::avm_v2::2022_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2022_q3 := dataset('~thor_data400::avm_v2::2022_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2022_q4 := dataset('~thor_data400::avm_v2::2022_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2023_q1 := dataset('~thor_data400::avm_v2::2023_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2023_q2 := dataset('~thor_data400::avm_v2::2023_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2023_q3 := dataset('~thor_data400::avm_v2::2023_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2023_q4 := dataset('~thor_data400::avm_v2::2023_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2024_q1 := dataset('~thor_data400::avm_v2::2024_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2024_q2 := dataset('~thor_data400::avm_v2::2024_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2024_q3 := dataset('~thor_data400::avm_v2::2024_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2024_q4 := dataset('~thor_data400::avm_v2::2024_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2025_q1 := dataset('~thor_data400::avm_v2::2025_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2025_q2 := dataset('~thor_data400::avm_v2::2025_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2025_q3 := dataset('~thor_data400::avm_v2::2025_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2025_q4 := dataset('~thor_data400::avm_v2::2025_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2026_q1 := dataset('~thor_data400::avm_v2::2026_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2026_q2 := dataset('~thor_data400::avm_v2::2026_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2026_q3 := dataset('~thor_data400::avm_v2::2026_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2026_q4 := dataset('~thor_data400::avm_v2::2026_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2027_q1 := dataset('~thor_data400::avm_v2::2027_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2027_q2 := dataset('~thor_data400::avm_v2::2027_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2027_q3 := dataset('~thor_data400::avm_v2::2027_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2027_q4 := dataset('~thor_data400::avm_v2::2027_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2028_q1 := dataset('~thor_data400::avm_v2::2028_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2028_q2 := dataset('~thor_data400::avm_v2::2028_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2028_q3 := dataset('~thor_data400::avm_v2::2028_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2028_q4 := dataset('~thor_data400::avm_v2::2028_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2029_q1 := dataset('~thor_data400::avm_v2::2029_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2029_q2 := dataset('~thor_data400::avm_v2::2029_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2029_q3 := dataset('~thor_data400::avm_v2::2029_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2029_q4 := dataset('~thor_data400::avm_v2::2029_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);

hist2030_q1 := dataset('~thor_data400::avm_v2::2030_Q1_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2030_q2 := dataset('~thor_data400::avm_v2::2030_Q2_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2030_q3 := dataset('~thor_data400::avm_v2::2030_Q3_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);
hist2030_q4 := dataset('~thor_data400::avm_v2::2030_Q4_automated_valuations', AVM_V2.layouts.Layout_Automated_Valuations, thor)(automated_valuation<>0);



AVM_V2.layouts.layout_base_with_history merge_base_with_archive1(AVM_V2.layouts.Layout_Automated_Valuations le, AVM_V2.layouts.Layout_Automated_Valuations rt) := transform 
		self.history := project(rt, transform(AVM_V2.layouts.layout_history_slim, self := left));
		base_available := le.land_use<>'';
		self.ln_fares_id_ta := if(base_available, le.ln_fares_id_ta , rt.ln_fares_id_ta );
		self.ln_fares_id_pi := if(base_available, le.ln_fares_id_pi , rt.ln_fares_id_pi );
		self.unformatted_apn := if(base_available, le.unformatted_apn , rt.unformatted_apn );
		self.prim_range := if(base_available, le.prim_range , rt.prim_range );
		self.predir := if(base_available, le.predir , rt.predir  );
		self.prim_name := if(base_available, le.prim_name  , rt.prim_name  );
		self.suffix := if(base_available, le.suffix  , rt.suffix  );
		self.postdir := if(base_available, le.postdir , rt.postdir );
		self.unit_desig := if(base_available, le.unit_desig , rt.unit_desig );
		self.sec_range := if(base_available, le.sec_range , rt.sec_range );
		self.p_city_name := if(base_available, le.p_city_name , rt.p_city_name );
		self.st := if(base_available, le.st , rt.st );
		self.zip := if(base_available, le.zip , rt.zip );
		self.zip4 := if(base_available, le.zip4 , rt.zip4 );
		self.lat := if(base_available, le.lat , rt.lat );
		self.long := if(base_available, le.long , rt.long );
		self.geo_blk := if(base_available, le.geo_blk , rt.geo_blk );
		self.fips_code := if(base_available, le.fips_code , rt.fips_code );
		self.land_use := if(base_available, le.land_use , rt.land_use );

		self := le;
end;

current := distribute(valuations_current, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
archive2005 := distribute(hist2005, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));

with2005 := join(current, archive2005, 
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					merge_base_with_archive1(left, right),
						full outer, local);


// this transform gets used to append history on the rest of the snapshots
AVM_V2.layouts.layout_base_with_history append_more_history(AVM_V2.layouts.layout_base_with_history le, AVM_V2.layouts.Layout_Automated_Valuations rt) := transform 
		htemp :=le.history + project(rt, transform(AVM_V2.layouts.layout_history_slim, self := left));
		self.history := htemp(automated_valuation<>0); // filter out any history rows where a record didn't exist
		
		base_available := le.land_use<>'';
		self.ln_fares_id_ta := if(base_available, le.ln_fares_id_ta , rt.ln_fares_id_ta );
		self.ln_fares_id_pi := if(base_available, le.ln_fares_id_pi , rt.ln_fares_id_pi );
		self.unformatted_apn := if(base_available, le.unformatted_apn , rt.unformatted_apn );
		self.prim_range := if(base_available, le.prim_range , rt.prim_range );
		self.predir := if(base_available, le.predir , rt.predir  );
		self.prim_name := if(base_available, le.prim_name  , rt.prim_name  );
		self.suffix := if(base_available, le.suffix  , rt.suffix  );
		self.postdir := if(base_available, le.postdir , rt.postdir );
		self.unit_desig := if(base_available, le.unit_desig , rt.unit_desig );
		self.sec_range := if(base_available, le.sec_range , rt.sec_range );
		self.p_city_name := if(base_available, le.p_city_name , rt.p_city_name );
		self.st := if(base_available, le.st , rt.st );
		self.zip := if(base_available, le.zip , rt.zip );
		self.zip4 := if(base_available, le.zip4 , rt.zip4 );
		self.lat := if(base_available, le.lat , rt.lat );
		self.long := if(base_available, le.long , rt.long );
		self.geo_blk := if(base_available, le.geo_blk , rt.geo_blk );
		self.fips_code := if(base_available, le.fips_code , rt.fips_code );
		self.land_use := if(base_available, le.land_use , rt.land_use );

		self := le;
end;

archive2006 := distribute(hist2006, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));									
with2006 := join(with2005, archive2006,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);

archive2007 := distribute(hist2007, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));									
with2007 := join(with2005, archive2007,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);


// start with quarterly snapshots in 2008					
archive1 := distribute(hist2008_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));									
j1 := join(with2007, archive1,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);


archive2 := distribute(hist2008_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));									
j2 := join(j1, archive2,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
	
archive3 := distribute(hist2008_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
j3 := join(j2, archive3,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
				
archive4 := distribute(hist2008_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
j4 := join(j3, archive4,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);

archive5 := distribute(hist2009_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j5 := join(j4, archive5,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
						
archive6 := distribute(hist2009_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j6 := join(j5, archive6,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
						
archive7 := distribute(hist2009_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j7 := join(j6, archive7,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);


archive8 := distribute(hist2009_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j8 := join(j7, archive8,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);

archive9 := distribute(hist2010_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j9 := join(j8, archive9,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
						
archive10 := distribute(hist2010_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j10 := join(j9, archive10,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);						

archive11 := distribute(hist2010_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j11 := join(j10, archive11,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive12 := distribute(hist2010_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j12 := join(j11, archive12,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);							

archive13 := distribute(hist2011_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j13 := join(j12, archive13,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);		
						
archive14 := distribute(hist2011_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
j14 := join(j13, archive14,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);		
						
archive15 := distribute(hist2011_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j15 := join(j14, archive15,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);		
						
archive16 := distribute(hist2011_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j16 := join(j15, archive16,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);		
						
archive17 := distribute(hist2012_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
j17 := join(j16, archive17,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);		
						
						
archive18 := distribute(hist2012_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j18 := join(j17, archive18,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);		
						
archive19 := distribute(hist2012_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j19 := join(j18, archive19,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);		
						
archive20 := distribute(hist2012_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
j20 := join(j19, archive20,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);		
						
archive21 := distribute(hist2013_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j21 := join(j20, archive21,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);		
						
archive22 := distribute(hist2013_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j22 := join(j21, archive22,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive23 := distribute(hist2013_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j23 := join(j22, archive23,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive24 := distribute(hist2013_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
j24 := join(j23, archive24,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
								
archive25 := distribute(hist2014_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j25 := join(j24, archive25,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive26 := distribute(hist2014_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j26 := join(j25, archive26,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive27 := distribute(hist2014_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j27 := join(j26, archive27,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive28 := distribute(hist2014_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j28 := join(j27, archive28,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive29 := distribute(hist2015_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j29 := join(j28, archive29,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive30 := distribute(hist2015_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j30 := join(j29, archive30,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive31 := distribute(hist2015_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j31 := join(j30, archive31,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive32 := distribute(hist2015_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j32 := join(j31, archive32,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive33 := distribute(hist2016_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j33 := join(j32, archive33,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive34 := distribute(hist2016_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j34 := join(j33, archive34,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive35 := distribute(hist2016_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j35 := join(j34, archive35,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive36 := distribute(hist2016_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j36 := join(j35, archive36,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive37 := distribute(hist2017_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j37 := join(j36, archive37,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive38 := distribute(hist2017_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j38 := join(j37, archive38,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive39 := distribute(hist2017_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j39 := join(j38, archive39,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive40 := distribute(hist2017_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j40 := join(j39, archive40,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive41 := distribute(hist2018_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j41 := join(j40, archive41,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive42 := distribute(hist2018_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j42 := join(j41, archive42,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive43 := distribute(hist2018_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j43 := join(j42, archive43,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive44 := distribute(hist2018_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j44 := join(j43, archive44,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive45 := distribute(hist2019_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j45 := join(j44, archive45,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive46 := distribute(hist2019_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j46 := join(j45, archive46,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive47 := distribute(hist2019_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));		
j47 := join(j46, archive47,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive48 := distribute(hist2019_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j48 := join(j47, archive48,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	

archive49 := distribute(hist2020_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j49 := join(j48, archive49,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	
						
archive50 := distribute(hist2020_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j50 := join(j49, archive50,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	

archive51 := distribute(hist2020_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j51 := join(j50, archive51,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);	

archive52 := distribute(hist2020_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j52 := join(j51, archive52,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);

archive53 := distribute(hist2021_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j53 := join(j52, archive53,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);

archive54 := distribute(hist2021_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j54 := join(j53, archive54,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive55 := distribute(hist2021_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j55 := join(j54, archive55,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive56 := distribute(hist2021_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j56 := join(j55, archive56,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive57 := distribute(hist2022_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j57 := join(j56, archive57,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive58 := distribute(hist2022_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j58 := join(j57, archive58,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive59 := distribute(hist2022_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j59 := join(j58, archive59,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive60 := distribute(hist2022_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j60 := join(j59, archive60,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive61:= distribute(hist2023_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j61 := join(j60, archive60,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive62 := distribute(hist2023_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j62 := join(j61, archive62,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);

archive63 := distribute(hist2023_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j63 := join(j62, archive63,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive64 := distribute(hist2023_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j64 := join(j63, archive64,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive65 := distribute(hist2024_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j65 := join(j64, archive65,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive66 := distribute(hist2024_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j66 := join(j65, archive66,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive67 := distribute(hist2024_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j67 := join(j66, archive67,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive68 := distribute(hist2024_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j68 := join(j67, archive68,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive69 := distribute(hist2025_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j69 := join(j68, archive69,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive70 := distribute(hist2025_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j70 := join(j69, archive70,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive71 := distribute(hist2025_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j71 := join(j70, archive71,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive72 := distribute(hist2025_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j72 := join(j71, archive72,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive73 := distribute(hist2026_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j73 := join(j72, archive73,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive74 := distribute(hist2026_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j74 := join(j73, archive74,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive75 := distribute(hist2026_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j75 := join(j74, archive75,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive76 := distribute(hist2026_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j76 := join(j75, archive76,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive77 := distribute(hist2027_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j77 := join(j76, archive77,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive78 := distribute(hist2027_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j78 := join(j77, archive78,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive79 := distribute(hist2027_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j79 := join(j78, archive79,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive80 := distribute(hist2027_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j80 := join(j79, archive80,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive81 := distribute(hist2028_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j81 := join(j80, archive81,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive82 := distribute(hist2028_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j82 := join(j81, archive82,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive83 := distribute(hist2028_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j83 := join(j82, archive83,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive84 := distribute(hist2028_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j84 := join(j83, archive84,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive85 := distribute(hist2029_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j85 := join(j84, archive85,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive86 := distribute(hist2029_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j86 := join(j85, archive86,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);

archive87 := distribute(hist2029_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j87 := join(j86, archive87,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive88 := distribute(hist2029_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j88 := join(j87, archive88,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive89 := distribute(hist2030_q1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j89 := join(j88, archive89,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive90 := distribute(hist2030_q2, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j90 := join(j89, archive90,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive91 := distribute(hist2030_q3, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j91 := join(j90, archive91,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);
archive92 := distribute(hist2030_q4, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	
j92 := join(j91, archive92,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
					append_more_history(left, right),
						full outer, local);


// will need to decide in 2030 if we can keep going with more child records or if we need to remove 2008 because of limits in nested child rows in roxie keys
						
return j92;

end;