// EXPORT FDN_payload_validation := 'todo';

import FraudDefenseNetwork, ut;

eyeball := 50;
// build_date := '20151221';
build_date := advfiles.fdn.buildVersion;

pay_key := FraudDefenseNetwork.Keys().main.id.qa;

output(count(pay_key), named('payload_count'));
output(choosen(pay_key, eyeball), named('payload'));

input_lay := record
	RECORDOF(pay_key);
end;

flag_lay := record
		integer time_days;
		boolean expired_flag;
		STRING8 Event_Date; 
		STRING Source;
end;

expand_lay := record
		RECORDOF(pay_key);
		flag_lay flags;
end;

// ashirey.flatten(ds_basefile, ds_flat_base);
// zz_Koubsky_SALT.mac_profile(ds_flat_base);

tb_source := table(distribute(pay_key, hash64(source)), {source; _count := count(group)}, source);
output(tb_source, named('counts_by_source'));


expand_lay check_expired_recs(RECORDOF(pay_key) le) := transform
		early := map( 	le.source in ['DDFELONY', 'DDINCARCERATED', 'TIGER', 'CFNA'] => le.event_date,
										le.source in ['ADDRESSINSPECTION', 'GLB5', 'SUSPECTIPADDRESS'] => le.reported_date,
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
																(le.source = 'SUSPECTIPADDRESS' and time_days > 90) or
																(le.source not in sources);
																
		self.flags.Source := MAP((early > late) => 'INVALID EVENT DATE',
															(le.source = 'DDFELONY' and time_days > ut.DaysInNYears(1)) => 'DDFELONY',
															(le.source = 'DDINCARCERATED' and time_days > ut.DaysInNYears(1)) => 'DDINCARCERATED',
															(le.source = 'ADDRESSINSPECTION' and time_days > ut.DaysInNYears(3)) => 'ADDRESSINSPECTION',
															(le.source = 'TIGER' and time_days > ut.DaysInNYears(2)) => 'TIGER',
															(le.source = 'CFNA' and time_days > ut.DaysInNYears(2)) => 'CFNA',
															(le.source = 'GLB5' and time_days > 185) => 'GLB5',
															(le.source = 'SUSPECTIPADDRESS' and time_days > 90) => 'SUSPECTIPADDRESS',
															'NO_FAILURE');
		
		self.flags.time_days := time_days;
		self.flags.Event_Date := early;
				
		self := le;
end;

ds_flags := project(pay_key, check_expired_recs(left));
ds_bad_recs := ds_flags(flags.expired_flag = true);

tb_exp_source := table(distribute(ds_bad_recs, hash64(source)), {source; _count := count(group)}, source);
output(count(ds_bad_recs), named('expired_records_count'));
output(choosen(ds_bad_recs, eyeball), named('expired_records'));
output(tb_exp_source, named('expired_counts_by_source'));

