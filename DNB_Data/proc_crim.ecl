import CrimSrch;
export proc_crim :=
module

		// Criminal
//	1. match to CrimSrch.File_Moxie_Offender_Dev on did, then to CrimSrch.File_Moxie_Offenses_Dev on offender_key
//		and, if they want the punishment, CrimSrch.File_Moxie_Punishment_Dev.

offender := CrimSrch.File_Moxie_Offender_Dev(did != '' or did != '000000000000');

offender_dist := distribute(offender, hash(did));

all_contacts := (files.contacts_address + files.contacts_mail)(did != '');
all_contacts_table := table(all_contacts, {did}, did);

all_contacts_dist := distribute(all_contacts_table, hash(did));

layouts.out.crim_offender tgetoffender(offender_dist l, all_contacts_table r) :=
transform

	self := l;
end;

offender_join := join(offender_dist, 
											all_contacts_table,
											left.did = right.did,
											tgetoffender(left,right),
											local
											);

//offenses join											
offender_table := distribute(table(offender_join, {offender_key, did}, offender_key, did), hash(offender_key));

offenses := CrimSrch.File_Moxie_Offenses_Dev;

offenses_dist := distribute(offenses, hash(offender_key));

layouts.out.crim_offense tgetoffense(offenses_dist l, offender_table r) :=
transform
	self := l;
	self.did := r.did;
end;

offense_join := join(offenses_dist,
										offender_table,
										left.offender_key = right.offender_key
										,tgetoffense(left,right)
										,local
										);

export myoutput :=
	sequential(
		output(offender_join,,thor_clusters.files + 'base::dnb_data::20061210::crim_offender', overwrite)
		,output(offense_join,,thor_clusters.files + 'base::dnb_data::20061210::crim_offense', overwrite)
	);
end;