import mdr, ut;

//****** Check that all the sourcing is properly done
hsc := output(header.Source_Check, all,NAMED('Source_Check'));

//****** Check out the results of the DIDing
h_old := dataset('~thor_data400::base::header_w20100927-082254',header.Layout_Header,flat)(header.Blocked_data());
h_new := dataset('~thor400_84::persist::last_rollup',header.Layout_Header,flat);

header.MAC_DID_Stats(h_new, h_old, did, did_stats);


//****** Check integration of the different sources
full_in := h_new;
slimrec := record
	full_in.did;
	full_in.rid;
	full_in.src;
end;

slimhead := table(full_in, slimrec);

statrec := record
	slimhead.src;
	string20 src_desc := header.translateSource(slimhead.src);
	counted := count(group);
	p_integrated := ave(group, if(slimhead.rid <> slimhead.did, 100, 0));
end;

stats := table(slimhead, statrec, src);
integration_stats := output(stats, all,NAMED('Integration_by_source'));


//****** Do some field counts from the new header file
mdr.mac_header_stats(h_new, statsout)
mdr.mac_header_blanks(h_new,1000, blanksout)


//****** Some other stats people want to see
prev_max_rid := mdr.fn_max_rid(h_old);
nhr := count(h_new(rid > prev_max_rid)); 
/*
dr0 		:= header.with_did.mod_pass1.mod_dr0.result;
dr1			:= header.with_did.mod_pass1.DR1;
hmc 		:= header.with_did.mod_pass1.mca;
*/

dr0  := DATASET('~thor400_84::did_rules0_1',{ unsigned integer6 new_rid, unsigned integer6 old_rid, unsigned integer1 pflag },flat);
dr0_1:= 		project(dr0,header.Layout_PairMatch);
DR1 := 		header.fn_Did_Rules1(dr0_1);
hmc 		:= DATASET('~thor400_84::match_candidates_1',header.test,flat);
/*
dr0_2		:= header.with_did.mod_pass2.mod_dr0.result;
dr1_2		:= header.with_did.mod_pass2.DR1;
hmc_2		:= header.with_did.mod_pass2.mca;
*/ 

dr0_2		:= DATASET('~thor400_84::did_rules0_2',{ unsigned integer6 new_rid, unsigned integer6 old_rid, unsigned integer1 pflag },flat);
dr0_2_1     := project(dr0_2,header.Layout_PairMatch);
dr1_2		:= header.fn_Did_Rules1(dr0_2_1);
hmc_2		:= DATASET('~thor400_84::match_candidates_2',header.test,flat);

dodgies1 := dataset('~thor400_84::persist::dodgy_dids1',{ unsigned integer6 did, string1 rule_number },flat);
dodgies2 := dataset('~thor400_84::persist::dodgy_dids2',{ unsigned integer6 did, string1 rule_number },flat);
/*
dodgies1 := header.with_did.dodgies1;
dodgies2 := header.with_did._dodgies2;
*/

ut.MAC_Field_Count(dr0,		dr0.pflag, 		'Did_Rules0_type', 		true, true, Did_Rules0_type, true)
ut.MAC_Field_Count(dr0_2,	dr0_2.pflag, 	'Did_Rules0_2_type', 	true, true, Did_Rules0_2_type, true)
ut.MAC_Field_Count(dodgies1,dodgies1.rule_number, 'DodgyDids1_rule', true, true, DodgyDids1_rule, true)
ut.MAC_Field_Count(dodgies2,dodgies2.rule_number, 'DodgyDids2_rule', true, true, DodgyDids2_rule, true)

otherstats := parallel(
ut.fn_AddStat((unsigned4)header.version_build, 'Build Stats: Build date'),
ut.fn_AddStat(count(h_new), 'Build Stats: Total Header Recs'),
ut.fn_AddStat(nhr, 'Build Stats: New Header Recs'),
ut.fn_AddStat(nhr/count(h_old), 'Build Stats: Header Inc Rate'),
ut.fn_AddStat(mdr.fn_max_rid(h_new(not header.isDemoData())), 'Build Stats: MaxRID'),
ut.fn_AddStat(count(hmc), 	'Build Stats: match_candidates'),
ut.fn_AddStat(count(hmc_2), 'Build Stats: match_candidates_2'),
ut.fn_AddStat(count(dr0), 	'Build Stats: Did_Rules0'),
ut.fn_AddStat(count(dr0_2), 'Build Stats: Did_Rules0_2'),
Did_Rules0_type,
Did_Rules0_2_type,
ut.fn_AddStat(count(dr0)/count(hmc), 			'Build Stats: Did_Rules0 Rate'),
ut.fn_AddStat(count(dr0_2)/count(hmc_2), 	'Build Stats: Did_Rules0_2 Rate'),
ut.fn_AddStat(count(dr1), 	'Build Stats: Did_Rules1'),
ut.fn_AddStat(count(dr1_2), 'Build Stats: Did_Rules1_2'),
ut.fn_AddStat(count(dr1)/count(hmc), 			'Build Stats: Did_Rules1 Rate'),
ut.fn_AddStat(count(dr1_2)/count(hmc_2), 	'Build Stats: Did_Rules1_2 Rate'),
ut.fn_AddStat(count(dodgies1), 'Build Stats: Dodgy Dids1'),
DodgyDids1_rule,
ut.fn_AddStat(count(dodgies1)/uniquenewdids, 'Build Stats: Dodgy Dids1 Rate'),
ut.fn_AddStat(count(dodgies2), 'Build Stats: Dodgy Dids2'),
DodgyDids2_rule,
ut.fn_AddStat(count(dodgies2)/uniquenewdids, 'Build Stats: Dodgy Dids2 Rate')
);

export Proc_BuildStats := parallel(
									hsc
									,did_stats
									,integration_stats
									,statsout
									,blanksout
									,otherstats
									,Header.Fn_RidDidStats(h_new)
									,header.fn_new_dids_by_src(h_new,h_old)
									,output(header.fn_ADLSegmentation(h_new).tab,named('SegmentationStats'))
									// ,header.fn_adl_segmentStats_across_builds(h_new,h_old)
									);


Proc_BuildStats;