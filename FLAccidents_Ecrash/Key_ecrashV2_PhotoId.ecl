IMPORT Data_Services, Doxie, STD;

ds_SupplementalBase := FLAccidents_Ecrash.Files.Base.Supplemental(TRIM(report_type_id,all) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD');
ds_PhotoBase := FLAccidents_Ecrash.Files.Base.PhotoBase;

ds_SuperReport := DEDUP(SORT(DISTRIBUTE(ds_SupplementalBase, HASH64(Super_report_id)), super_report_id,report_id, LOCAL), Super_report_id,report_id,LOCAL);

layout_photo_SuperReport := RECORD
	STRING11 Super_report_id,
	FLAccidents_Ecrash.Layouts.PhotoLayout
END;

layout_photo_SuperReport trans_PhotoSuperReport(ds_PhotoBase le, ds_SuperReport ri):= TRANSFORM
	SELF.Super_report_id := ri.Super_report_id;
	SELF := le;
END;

ds_PhotoSuperCmbnd	:= JOIN(ds_PhotoBase, ds_SuperReport,
																											TRIM(LEFT.incident_id,LEFT,RIGHT) = TRIM(RIGHT.Incident_id, LEFT,RIGHT),
																											trans_PhotoSuperReport(LEFT, RIGHT), HASH);

EXPORT Key_ecrashV2_PhotoId := INDEX(ds_PhotoSuperCmbnd
                                     ,{Super_report_id,Document_id,Report_Type}
							                       ,{ds_PhotoSuperCmbnd}
							                       ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_PhotoId_' + doxie.Version_SuperKey);
																		
																		