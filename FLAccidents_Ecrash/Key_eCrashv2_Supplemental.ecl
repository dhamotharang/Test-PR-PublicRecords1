/*2015-11-16T21:04:30Z (Srilatha Katukuri)
#193680 - CR323
*/
/*2015-08-14T23:18:41Z (Srilatha Katukuri)
#181860 - key builds in PRUS folder for testing.
*/
/*2015-08-07T23:53:47Z (Srilatha Katukuri)
#181860
*/
import doxie,FLAccidents,Data_Services, STD;

// Update and latest hashkeys included. 
allrecs   := FLAccidents_Ecrash.Files.Base.Supplemental( u_d_flag <> 'D' and  (((trim(report_type_id,all) in ['A','DE'] or STD.str.ToUpperCase(trim(vendor_code,left,right)) = 'CMPD')) or 
																												  trim(vendor_code,left,right) = 'COPLOGIC'));
  
dst_allrecs := distribute(allrecs, hash(super_report_id));
srt_base    := sort(dst_allrecs, super_report_id,hash_key,report_code,creation_date,Sent_to_HPCC_DateTime,map(u_d_flag='' => 3,u_d_flag = 'U' => 2, 1),report_id, local);
ded_base    := dedup(srt_base, super_report_id,hash_key,report_code,right, local);  

export Key_eCrashv2_Supplemental := index(ded_base
                                     ,{super_report_id}
								                    ,{report_id,hash_key,accident_nbr,report_code,jurisdiction,jurisdiction_state,accident_date,orig_accnbr,work_type_id,report_type_id,agency_ori,addl_report_number,Vendor_Code,vendor_report_id,Page_Count }
															     ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_Supplemental_' + doxie.Version_SuperKey);
                                  