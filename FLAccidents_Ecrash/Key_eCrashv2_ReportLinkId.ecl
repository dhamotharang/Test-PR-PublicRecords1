/*2015-11-16T21:03:19Z (Srilatha Katukuri)
#193680 - CR323
*/
/*2015-06-23T00:57:14Z (Srilatha Katukuri)
#173799 
*/
/*2015-04-15T17:47:50Z (Srilatha Katukuri)
#173799 -
 Removed the key field vendor code
*/
import doxie, ut, Data_Services ; 

ds := project (FLAccidents_Ecrash.File_KeybuildV2.out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and trim(report_type_id,all) in ['A','DE']), FLAccidents_Ecrash.Layouts.key_slim_layout );  

ReportLinkId_DS	:= ds(ReportLinkID <> '');

dst_ReportLink	:= distribute(ReportLinkId_DS, hash64(accident_nbr));
srt_ReportLink := sort(dst_ReportLink, reportlinkid,accident_nbr,accident_date,report_type_id, report_id, jurisdiction_state, jurisdiction_nbr, agency_ori, local);
dep_ReportLink := dedup(srt_ReportLink, reportlinkid,accident_nbr,accident_date,report_type_id, report_id, jurisdiction_state, jurisdiction_nbr, agency_ori, local);

EXPORT Key_eCrashv2_ReportLinkId := index(	dep_ReportLink 
																									,{reportlinkid}
																									,{dep_ReportLink}
																									,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashv2_ReportLinkId_' + doxie.Version_SuperKey);
																							  

