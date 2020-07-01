#WORKUNIT('name', 'BWR dx_death (thor)');

import AutoStandardI, doxie, DeathV2_Services, dx_death_master;
#STORED('GLBPurpose', '0');

dids := dataset([
  {0, 'no did'},  
	{150, 'subject is alive'}, 
	{376475600, 'subject is dead but opted out'}, 
	{383779201, 'subject is dead but opted out'}, 
	{1431, 'subject is dead'}, // dead
	{4010, 'subject is dead'}, // dead, 3 records, 1 glb - in dataland
	{239885, 'dead with supplemental'}, // dead with supplemental - 2 death records, only one with supplemental
	{6968, 'dead with SSA record'} // death with SSA - for unrestricted append
	], {unsigned6 did; string ref;});

infile := dids;
// infile := pull(gong.Key_address_current); // for testing with large files on thor (set _use_distributed=true)

_use_distributed := FALSE;
g_mod := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(g_mod);
death_params := DeathV2_Services.IParam.GetRestrictions(mod_access);

append_recs := dx_death_master.Append.byDid(infile, did, death_params, recs_per_did := 1, use_distributed := _use_distributed);
OUTPUT(CHOOSEN(append_recs, 100), named('append_by_did'));

append_recs_unrestricted := dx_death_master.Append.byDidUnrestricted(infile, did, death_params, recs_per_did := 10, use_distributed := _use_distributed);
OUTPUT(CHOOSEN(append_recs_unrestricted, 100), named('append_recs_unrestricted'));

get_recs := dx_death_master.Get.byDid(infile, did, death_params, use_distributed := _use_distributed);
OUTPUT(CHOOSEN(get_recs, 100), named('get_recs'));

exclude_recs := dx_death_master.Exclude(infile, did, death_params, use_distributed := _use_distributed);
OUTPUT(CHOOSEN(exclude_recs, 100), named('exclude_recs'));
