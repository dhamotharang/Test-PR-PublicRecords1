IMPORT Data_Services;

EXPORT BuildPhotoFile := MODULE

photo := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::document_raw'
																	,FLAccidents_Ecrash.Layouts.PhotoLayout
																	,CSV(HEADING(1),TERMINATOR('\n'), SEPARATOR(','),QUOTE('"')),OPT)(Document_ID != 'Document_ID')/*+ 
									DATASET(Data_Services.foreign_dataland+'thor_data400::in::ecrash::qc::document_raw'
																	,FLAccidents_Ecrash.Layouts.PhotoLayout
																	,csv(heading(1),terminator('\n'), separator(','),quote('"')))(Document_ID != 'Document_ID') */ ; 

ds_incidents_delete := FLAccidents_Ecrash.Infiles.incidents_todelete;

ds_photos_sup := JOIN(DISTRIBUTE(photo, HASH64(Incident_id)), ds_incidents_delete,
																						TRIM(left.incident_id, ALL)= TRIM(right.incident_id,ALL),
																						TRANSFORM(FLAccidents_Ecrash.Layouts.PhotoLayout,SELF := LEFT)
																						,LEFT ONLY, LOCAL);
																						
// Allow Photos of Report type 'M' only for jurisdiction state LA and rest 'M' reports needs to be ingnored. #DF-20479

ds_incidents := DISTRIBUTE(FLAccidents_Ecrash.Infiles.tincident(TRIM(loss_state_abbr,LEFT,RIGHT) = 'LA'),HASH64(Incident_Id));

JnGetMPhotos := JOIN(ds_incidents, ds_Photos_Sup(TRIM(Report_Type,LEFT,RIGHT) IN ['M','m']), 
																		   TRIM(LEFT.Incident_Id,LEFT,RIGHT) = TRIM(RIGHT.Incident_id,LEFT,RIGHT),
																		   TRANSFORM(FLAccidents_Ecrash.Layouts.PhotoLayout,SELF := RIGHT), LOCAL );
																			 
AllPhotos := ds_photos_sup(TRIM(Report_Type,LEFT,RIGHT) NOT IN ['M','m']) + JnGetMPhotos;
	
	// End of Allow Photos Of report Type 'M'. DF#20479
	
ds_Dupe_Photos := DEDUP(SORT(DISTRIBUTE(AllPhotos, HASH64(document_id)),document_id, -is_deleted, LOCAL),document_id,LOCAL );

ds_PhotosDeleted := ds_Dupe_Photos(is_deleted='1' or is_deleted = ''); 

EXPORT CmbndPhotos := JOIN(ds_Dupe_Photos, ds_PhotosDeleted, 
																											LEFT.document_id = RIGHT.document_id AND
																											LEFT.Incident_id = RIGHT.incident_id AND 
																											LEFT.document_hash_key = RIGHT.document_hash_key AND
																											LEFT.extension = RIGHT.extension
																										 ,MANY LOOKUP , LEFT ONLY );
																		
END;