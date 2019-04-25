// EXPORT FDN_sample_generator := 'todo';
// EXPORT FDN_basefile_validation := function;
// riskwise.shortcuts
import FraudDefenseNetwork, ut;

eyeball := 50;
// build_date := '20151221';
build_date := advfiles.fdn.buildVersion;

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

// ds_basefile := distribute(dataset(ut.foreign_prod + 'thor_data400::base::fdn::qa::main', FraudDefenseNetwork.Layouts.base.main, thor), random());
ds_basefile := distribute(dataset('~thor_data400::base::fdn::qa::main', FraudDefenseNetwork.Layouts.base.main, thor), random());

expand_lay check_expired_recs(FraudDefenseNetwork.Layouts.base.main le) := transform
		early := map( 	le.source in ['DDFELONY', 'DDINCARCERATED', 'TIGER', 'CFNA'] => le.event_date,
										le.source in ['ADDRESSINSPECTION', 'GLB5'] => le.reported_date,
										'0');
		
		sources := ['DDFELONY', 'DDINCARCERATED', 'TIGER', 'CFNA', 'ADDRESSINSPECTION', 'GLB5', 'SUSPECTIPADDRESS'];
		
		late := map(		le.source in ['DDFELONY', 'DDINCARCERATED', 'TIGER', 'CFNA', 'ADDRESSINSPECTION', 'SUSPECTIPADDRESS'] => build_date,
										le.source in ['GLB5'] => ut.date_math(build_date, -180),
										'99999');
										
		time_days := ut.DaysApart(early, late);

		self.flags.expired_flag := 	(early > late) or
																(le.source = 'DDFELONY' and time_days > ut.DaysInNYears(1)) or
																(le.source = 'DDINCARCERATED' and time_days > ut.DaysInNYears(1)) or
																(le.source = 'ADDRESSINSPECTION' and time_days > ut.DaysInNYears(3)) or
																(le.source = 'TIGER' and time_days > ut.DaysInNYears(2)) or
																(le.source = 'CFNA' and time_days > ut.DaysInNYears(2)) or
																(le.source = 'GLB5' and time_days > 185) or
																(le.source not in sources);
																
		self.flags.Source := MAP((early > late) => 'INVALID EVENT DATE',
															(le.source = 'DDFELONY' and time_days > ut.DaysInNYears(1)) => 'DDFELONY',
															(le.source = 'DDINCARCERATED' and time_days > ut.DaysInNYears(1)) => 'DDINCARCERATED',
															(le.source = 'ADDRESSINSPECTION' and time_days > ut.DaysInNYears(3)) => 'ADDRESSINSPECTION',
															(le.source = 'TIGER' and time_days > ut.DaysInNYears(2)) => 'TIGER',
															(le.source = 'CFNA' and time_days > ut.DaysInNYears(2)) => 'CFNA',
															(le.source = 'GLB5' and time_days > 185) => 'GLB5',
															'NO_FAILURE');
		
		self.flags.time_days := time_days;
		self.flags.Event_Date := early;
				
		self := le;
end;

ds_flags := project(ds_basefile, check_expired_recs(left));

ds_bad_recs := ds_flags(flags.expired_flag = true);
tb_exp_source := table(distribute(ds_bad_recs, hash64(source)), {source; _count := count(group)}, source);
output(count(ds_bad_recs), named('expired_records_count'));
output(choosen(ds_bad_recs, eyeball), named('expired_records'));
output(tb_exp_source, named('expired_counts_by_source'));

ds_good_recs := ds_flags(flags.expired_flag = false);
tb_exp_source_good := table(distribute(ds_good_recs, hash64(source)), {source; _count := count(group)}, source);
output(count(ds_good_recs), named('not_expired_records_count'));
output(choosen(ds_good_recs, eyeball), named('not_expired_records'));
output(tb_exp_source_good, named('not_expired_counts_by_source'));

//********** Create a random sample by source *********************************************************
rand_sample_size := 50;
felony_sample 				:= enth(ds_good_recs(source='DDFELONY'), rand_sample_size);
// afi_sample 						:= enth(ds_good_recs(source='AFI'), rand_sample_size);
incarceration_sample 	:= enth(ds_good_recs(source='DDINCARCERATED'), rand_sample_size);
ainspection_sample 		:= enth(ds_good_recs(source='ADDRESSINSPECTION'), rand_sample_size);
tigr_sample 					:= enth(ds_good_recs(source='TIGER'), rand_sample_size);
cfna_sample 					:= enth(ds_good_recs(source='CFNA'), rand_sample_size);
glb5_sample 					:= enth(ds_good_recs(source='GLB5'), rand_sample_size);
IP_sample 					:= enth(ds_good_recs(source='SUSPECTIPADDRESS'), rand_sample_size);

output(felony_sample, named('DDFELONY_sample'));
// output(afi_sample, named('afi_sample'));
output(incarceration_sample, named('DDINCARCERATED_sample'));
output(ainspection_sample, named('ADDRESSINSPECTION_sample'));
output(tigr_sample, named('TIGER_sample'));
output(cfna_sample, named('CFNA_sample'));
output(glb5_sample, named('GLB5_sample'));
output(IP_sample, named('IP_sample'));
