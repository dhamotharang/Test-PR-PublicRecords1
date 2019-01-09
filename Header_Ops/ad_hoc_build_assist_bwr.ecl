import header;
// misc.header_hash_split;
// Header.Proc_Copy_Keys_To_Dataland.Full;

// Header.Proc_Copy_Keys_To_Dataland.Incrementals;
//header.Verify_XADL1_base_files;

// header_quick.proc_quickHdr_build_all


ds:=dataset('~thor_data400::base::header_raw_incremental_20180501',header.Layout_Header,thor)
            (rid>197758987570, src='OD') // from: max_rid_previous_month

:persist('~thor_data400::base::header_raw_20180501::persist::new::OD');
//count(ds);
// */

//  2297967
// 2207599
// 90368
ds2 := dataset('~thor_data400::base::header_raw_incremental_20180501',header.Layout_Header,thor)
            (
                ~(rid>197758987570 AND src='OD') AND
                ~(rid>197758987570 AND src='QW')
            );

output(ds2,,'~thor_data400::base::header_raw_incremental_20180501::no_new_od_qw',compressed)