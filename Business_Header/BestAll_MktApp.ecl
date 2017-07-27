// Marketing Version

//split out business header file into two files, one with dppa= true, one with dppa=false
//join the two files on bdid, left only, so you get all dppa records that do not have a
//cooresponding non-dppa record(dppa only records)
//take those dppa only records, and sort them on bdid and source state, and dedup
//them on bdid.
//then join that deduped file back to the non-deduped file on bdid and source state, 
//right outer , so you get all dppa records for that bdid and state
//Add that resulting file back to the dppa = true records, and pass that into the 
//BestJoined function

bh := Business_Header.File_Business_Header_MktApp;

////////////////////////////////////////////////////////////////////////
// Split out DPPA records from Non-DPPA records
////////////////////////////////////////////////////////////////////////
bh_with_dppa := bh(dppa = true);
bh_without_dppa := bh(dppa = false);

////////////////////////////////////////////////////////////////////////
// Join DPPA records to NON-DPPA records to get DPPA only Bdids
////////////////////////////////////////////////////////////////////////
bh_with_dppa_dist := distribute(bh_with_dppa, hash(bdid));
bh_with_dppa_sort := sort(bh_with_dppa_dist, bdid,local);

bh_without_dppa_dist := distribute(bh_without_dppa, hash(bdid));
bh_without_dppa_sort := sort(bh_without_dppa_dist, bdid,local);

Layout_Business_Header_Base joindppa2nondppa(bh_without_dppa_sort l, bh_with_dppa_sort r) := transform
self := r;
end;

bh_dppa_only_bdids_join := join(bh_without_dppa_sort, bh_with_dppa_sort, left.bdid = right.bdid, 
							 joindppa2nondppa(left,right),right only,local);

////////////////////////////////////////////////////////////////////////
// Dedup DPPA only Bdids to get first Alphabetical DPPA state record
////////////////////////////////////////////////////////////////////////
bh_dppa_only_bdids_sort := sort(bh_dppa_only_bdids_join, bdid, vendor_id[1..2], local);
bh_dppa_only_bdids_dedup := dedup(bh_dppa_only_bdids_sort, bdid, local);

Layout_Business_Header_Base joindppa2state(bh_dppa_only_bdids_dedup l, bh_dppa_only_bdids_sort r) := transform
self := r;
end;

bh_dppa_only_bdids_all_join := join(bh_dppa_only_bdids_dedup, bh_dppa_only_bdids_sort, left.bdid = right.bdid and
								left.vendor_id[1..2] = right.vendor_id[1..2], 
							 joindppa2state(left,right),local);
bh_all_in := bh_without_dppa + bh_dppa_only_bdids_all_join : persist('BH::BestAll_MktApp');
export BestAll_MktApp := BestJoined(bh_all_in);