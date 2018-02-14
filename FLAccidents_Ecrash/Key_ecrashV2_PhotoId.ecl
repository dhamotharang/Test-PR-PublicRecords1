/*2015-11-16T20:59:11Z (Srilatha Katukuri)
#193680 - CR323
*/
/*2015-08-28T21:26:05Z (Srilatha Katukuri)
#181860 - changed the order of fields in sort and dedup clause
*/
/*2015-08-14T23:18:56Z (Srilatha Katukuri)
#181860 - key builds in PRUS folder for testing.
*/
/*2015-08-03T23:16:05Z (Srilatha Katukuri)
#18160 PRUS, check in for Review
*/
import ut,Data_Services, Doxie;

//ds_SupplementalBase := dataset(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::ecrash_supplemental',FLAccidents_Ecrash.Layouts.ReportVersion,thor);
ds_SupplementalBase := FLAccidents_Ecrash.Files.Base.Supplemental(trim(report_type_id,all) in ['A','DE']);
//ds_PhotoBase := dataset(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::ecrash_documents',FLAccidents_Ecrash.Layouts.PhotoLayout,thor);//FLAccidents_Ecrash.Files.Base.PhotoBase;
ds_PhotoBase := FLAccidents_Ecrash.Files.Base.PhotoBase;

ds_SuperReport := dedup(sort(distribute(ds_SupplementalBase, hash64(Super_report_id)), super_report_id,report_id, local), Super_report_id,report_id,local);

layout_photo_SuperReport := RECORD
	String11 Super_report_id,
	FLAccidents_Ecrash.Layouts.PhotoLayout
END;

layout_photo_SuperReport trans_PhotoSuperReport(ds_PhotoBase le, ds_SuperReport ri):= transform
	self.Super_report_id := ri.Super_report_id;
	self := le;
end;

ds_PhotoSuperCmbnd	:= JOIN(ds_PhotoBase, ds_SuperReport,
													 trim(LEFT.incident_id,left,right) = trim(RIGHT.Incident_id, left,right)
													 , trans_PhotoSuperReport(Left, Right), hash);

EXPORT Key_ecrashV2_PhotoId := index(ds_PhotoSuperCmbnd
                                     ,{Super_report_id,Document_id}
							                       ,{ds_PhotoSuperCmbnd}
							                       ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_PhotoId_' + doxie.Version_SuperKey);
																		
																		