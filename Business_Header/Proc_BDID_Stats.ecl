import mdr, ut;


//****** Check out the results of the DIDing
h_old := business_header.File_Business_Header_father;
h_new := business_header.File_Business_Header;

business_header.MAC_BDID_Stats(h_new, h_old, bdid, did_stats)


//****** Check integration of the different sources
full_in := h_new;
slimrec := record
	full_in.bdid;
	full_in.rcid;
	full_in.source;
end;

slimhead := table(full_in, slimrec);

statrec := record
	slimhead.source;
	string20 src_desc := '';//header.translateSource(slimhead.src);
	counted := count(group);
	p_integrated := ave(group, if(slimhead.rcid <> slimhead.bdid, 100, 0));
end;

stats := table(slimhead, statrec, source);
integration_stats := output(stats, NAMED('Integration_by_source'));


//****** Do some field counts from the new header file
//mdr.mac_header_stats(h_new, statsout)
//mdr.mac_header_blanks(h_new,1000, blanksout)



export Proc_BDID_Stats := parallel(
//hsc,
did_stats,
integration_stats/*,
statsout,
blanksout*/
);