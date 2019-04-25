EXPORT FDN_basefile_validation := function;

import FraudDefenseNetwork, ut;

eyeball := 50;
// build_date := ut.getdate;
build_date := '20150518';

input_lay := record
	FraudDefenseNetwork.Layouts.base.main;
end;

flag_lay := record
		integer time_days;
		boolean expired_flag;
		STRING8 Event_Date; 
		STRING Source;
end;

expand_lay := record
		FraudDefenseNetwork.Layouts.base.main;
		flag_lay flags;
end;

ds_basefile := dataset('~thor_data400::base::fdn::qa::main', FraudDefenseNetwork.Layouts.base.main, thor);

// output(count(ds_basefile), named('basefile_count'));
// output(choosen(ds_basefile, eyeball), named('basefile'));

// ashirey.flatten(ds_basefile, ds_flat_base);
// zz_Koubsky_SALT.mac_profile(ds_flat_base);

// tb_source := table(distribute(ds_basefile, hash64(source)), {source; _count := count(group)}, source);
// output(tb_source, named('counts_by_source'));


expand_lay check_expired_recs(FraudDefenseNetwork.Layouts.base.main le) := transform
		early := le.event_date;
		late := build_date;
		time_days := ut.DaysApart(early, late);

		self.flags.expired_flag := 	(early > late) or
																(le.source = 'FELONY' and time_days > ut.DaysInNYears(1)) or
																(le.source = 'AFI' and time_days > ut.DaysInNYears(3)) or
																(le.source = 'INCARCERATION' and time_days > ut.DaysInNYears(1)) or
																(le.source = 'AINSPECTION' and time_days > ut.DaysInNYears(3)) or
																(le.source = 'TIGR' and time_days > ut.DaysInNYears(2)) or
																(le.source = 'CFNA' and time_days > ut.DaysInNYears(2));
		self.flags.Source := MAP((early > late) => 'INVALID EVENT DATE',
															(le.source = 'FELONY' and time_days > ut.DaysInNYears(1)) => 'FELONY',
															(le.source = 'AFI' and time_days > ut.DaysInNYears(3)) => 'AFI',
															(le.source = 'INCARCERATION' and time_days > ut.DaysInNYears(1)) => 'INCARCERATION',
															(le.source = 'AINSPECTION' and time_days > ut.DaysInNYears(3)) => 'AINSPECTION',
															(le.source = 'TIGR' and time_days > ut.DaysInNYears(2)) => 'TIGR',
															(le.source = 'CFNA' and time_days > ut.DaysInNYears(2)) => 'CFNA',
															'NO_FAILURE');
		self.flags.time_days := time_days;
		self.flags.Event_Date := early;
				
		self := le;
end;

ds_flags := project(ds_basefile, check_expired_recs(left));

// ds_bad_recs := ds_flags(flags.expired_flag = true);
// tb_exp_source := table(distribute(ds_bad_recs, hash64(source)), {source; _count := count(group)}, source);
// output(count(ds_bad_recs), named('expired_records_count'));
// output(choosen(ds_bad_recs, eyeball), named('expired_records'));
// output(tb_exp_source, named('expired_counts_by_source'));

ds_good_recs := ds_flags(flags.expired_flag = false);
// tb_exp_source_good := table(distribute(ds_good_recs, hash64(source)), {source; _count := count(group)}, source);
// output(count(ds_good_recs), named('not_expired_records_count'));
// output(choosen(ds_good_recs, eyeball), named('not_expired_records'));
// output(tb_exp_source_good, named('not_expired_counts_by_source'));

//********** Create a random sample by source *********************************************************
/*
rand_sample_size := 50;
felony_sample 				:= enth(ds_good_recs(source='FELONY'), rand_sample_size);
afi_sample 						:= enth(ds_good_recs(source='AFI'), rand_sample_size);
incarceration_sample 	:= enth(ds_good_recs(source='INCARCERATION'), rand_sample_size);
ainspection_sample 		:= enth(ds_good_recs(source='AINSPECTION'), rand_sample_size);
tigr_sample 					:= enth(ds_good_recs(source='TIGR'), rand_sample_size);
cfna_sample 					:= enth(ds_good_recs(source='CFNA'), rand_sample_size);

output(felony_sample, named('felony_sample'));
output(afi_sample, named('afi_sample'));
output(incarceration_sample, named('incarceration_sample'));
output(ainspection_sample, named('ainspection_sample'));
output(tigr_sample, named('tigr_sample'));
output(cfna_sample, named('cfna_sample'));
*/

return ds_good_recs;
// return ds_bad_recs;
end;