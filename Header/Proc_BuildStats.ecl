import mdr, ut;

//****** Check that all the sourcing is properly done
hsc := output(header.Source_Check, all,NAMED('Source_Check'));

//****** Check out the results of the DIDing
h_old := header.file_headers(header.Blocked_data());
h_new := header.Last_Rollup;

header.MAC_DID_Stats(h_new, h_old, did, did_stats)


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



export Proc_BuildStats := parallel(
hsc,
did_stats,
integration_stats,
statsout,
blanksout
);