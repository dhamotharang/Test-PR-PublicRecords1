﻿IMPORT STD;

ds_PhotoBase := Files.Base.PhotoBase;

ds_SupplementalBase := Files.Base.Supplemental(TRIM(report_type_id, ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD');
d_SupplementalBase := DISTRIBUTE(ds_SupplementalBase, HASH32(Super_report_id));
ds_SuperReport := DEDUP(SORT(d_SupplementalBase, super_report_id,report_id, LOCAL), Super_report_id,report_id, LOCAL);

Layout_Keys_eCrash.PhotoId trans_PhotoSuperReport(ds_PhotoBase le, ds_SuperReport ri):= TRANSFORM
	SELF.Super_report_id := ri.Super_report_id;
	SELF := le;
END;
ds_PhotoSuperCmbnd	:= JOIN(ds_PhotoBase, ds_SuperReport,
														TRIM(LEFT.incident_id,LEFT,RIGHT) = TRIM(RIGHT.Incident_id, LEFT,RIGHT),
														trans_PhotoSuperReport(LEFT, RIGHT), HASH);

EXPORT Key_ecrashV2_PhotoId := INDEX(ds_PhotoSuperCmbnd
                                     ,{Super_report_id,Document_id,Report_Type}
							                       ,{ds_PhotoSuperCmbnd}
							                       ,Files_eCrash.FILE_KEY_PHOTO_ID_SF);
																		
																		