import AutoStandardI, doxie, DeathV2_Services, dx_death_master;
#STORED('GLBPurpose', '1');

// dids := dataset([{000673170701}], doxie.layout_references);
dids := dataset([
	{150, 'subject is alive'}, // I'm still alive...
	{1431, 'subject is dead'}, // dead
	{4010, 'subject is dead'}, // dead, 3 records, 1 glb - in dataland
	{239885, 'dead with supplemental'} // dead with supplemental - 2 death records, only one with supplemental
	], {unsigned6 did; string ref;});

g_mod := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(g_mod);
death_params := DeathV2_Services.IParam.GetRestrictions(mod_access);

append_recs := dx_death_master.Append.byDid(dids, did, death_params);
OUTPUT(append_recs, named('append_by_did'));

get_recs := dx_death_master.Get.byDid(dids, did, death_params, recs_per_did := 10);
// get_recs := dx_death_master.Get.byDid(dids, did, death_params);
OUTPUT(get_recs, named('get_recs'));

exclude_recs := dx_death_master.Exclude(dids, did, death_params);
OUTPUT(exclude_recs, named('exclude_recs'));

l_death_ids := {string16 state_death_id;};
death_ids := project(get_recs, transform(l_death_ids, self.state_death_id := left.death.state_death_id));

get_recs_by_id := dx_death_master.Get.byDeathId(death_ids, state_death_id, death_params,,100);
OUTPUT(get_recs_by_id, named('get_recs_by_id'));

supp_recs := dx_death_master.Append.supplementalByDeathId(death_ids, state_death_id);
OUTPUT(supp_recs, named('supp_recs'));
