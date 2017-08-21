EXPORT notes := 'todo';old:

1. dn0_deduped := dn0(recording_date_weight100 + did_weight100>=2300); // Use specificity to flag high-dup counts

2. ut.MAC_Patch_Id(ih,DPROPTXID,BasicMatch(ih).patch_file,DPROPTXID1,DPROPTXID2,ihbp); // Perform basic matches

3. ut.MAC_Patch_Id(sliced,DPROPTXID,Matches,DPROPTXID1,DPROPTXID2,o); // Join Clusters

4. ut.MAC_Patch_Id(h,DPROPTXID,Matches,DPROPTXID1,DPROPTXID2,o1);


new:

1. dn0_deduped := dn0(recording_date_weight100 + did_weight100>=1500); // Use specificity to flag high-dup counts

2. ut.MAC_Patch_Id_local(ih,DPROPTXID,BasicMatch(ih).patch_file,DPROPTXID1,DPROPTXID2,ihbp); // Perform basic matches

3. ut.MAC_Patch_Id_local(sliced,DPROPTXID,Matches,DPROPTXID1,DPROPTXID2,o); // Join Clusters

4. ut.MAC_Patch_Id_local(h,DPROPTXID,Matches,DPROPTXID1,DPROPTXID2,o1);

// debug
d := DEDUP(r(rid1 <> rid2), ALL, WHOLE RECORD);