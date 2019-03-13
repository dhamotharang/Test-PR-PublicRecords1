import mdr, ut, Strata, header;

//****** Check that all the sourcing is properly done
hsc := output(header.Source_Check, all,NAMED('Source_Check'));

//****** Check out the results of the DIDing
h_old := dataset('~thor_data400::base::header_prod',header.Layout_Header,flat)(header.Blocked_data());
h_new := dataset('~thor_data400::base::header',header.Layout_Header,flat);

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
Strata.modOrbitAdaptersForPersonHdrBld.fnGetTotalCleanRecordsAction(stats, Header.version_build);
integration_stats := output(stats, all,NAMED('Integration_by_source'));


//****** Do some field counts from the new header file
mdr.mac_header_stats(h_new, statsout)
mdr.mac_header_blanks(h_new,1000, blanksout)


//****** Some other stats people want to see
prev_max_rid := mdr.fn_max_rid(h_old);
nhr := count(h_new(rid > prev_max_rid)); 

otherstats := parallel(
ut.fn_AddStat((unsigned4)header.version_build, 'Build Stats: Build date'),
ut.fn_AddStat(count(h_new), 'Build Stats: Total Header Recs'),
ut.fn_AddStat(nhr, 'Build Stats: New Header Recs'),
ut.fn_AddStat(nhr/count(h_old), 'Build Stats: Header Inc Rate'),
// ut.fn_AddStat(count(entropy_nonmatches),'Build Stats: Entropy Records Flagged Ambiguous'),
ut.fn_AddStat(mdr.fn_max_rid(h_new(not header.isDemoData())), 'Build Stats: MaxRID')
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
									,output(Header.fn_ADLSegmentation_v2(h_new).tab,named('SegmentationStats'))
									,header.fn_adl_segmentStats_across_builds(h_new,h_old)
									,header.stats.GenerateLinkingStats
									);