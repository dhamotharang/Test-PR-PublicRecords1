/*2016-09-26T21:59:42Z (Srilatha Katukuri)
ECH4454 - Webcruiser Integration - checkin for review
*/
/*2016-09-26T21:56:48Z (Srilatha Katukuri)
ECH$454 - Webcruiser Integration changes - Checkin for review
*/
/*2016-09-21T17:26:41Z (Srilatha Katukuri)
ECH4454 - Webcruiser Integration changes - For Review
*/
/*2015-10-30T22:02:44Z (Srilatha Katukuri)
#191728 - Supressing documents

*/
/*2015-10-13T00:40:19Z (Srilatha Katukuri)
#181860
*/
/*2015-08-28T21:04:33Z (Srilatha Katukuri)
#181860 changed the name of the inout file

*/
/*2015-08-07T23:47:24Z (Srilatha Katukuri)
#181860 - PRUS
*/
import ut,lib_fileservices;

export BuildPhotoFile := module

photo      :=  dataset(ut.foreign_prod+'thor_data400::in::ecrash::document_raw'
													,FLAccidents_Ecrash.Layouts.PhotoLayout
													,csv(heading(1),terminator('\n'), separator(','),quote('"')),opt)(Document_ID != 'Document_ID')/*+ 
								dataset(ut.foreign_dataland+'thor_data400::in::ecrash::document_raw_qc'
													,FLAccidents_Ecrash.Layouts.PhotoLayout
													,csv(heading(1),terminator('\n'), separator(','),quote('"')))(Document_ID != 'Document_ID')*/  ; 
	
ds_Photos    := distribute(project(photo(trim(report_type,all) not in ['M','m']), transform(FLAccidents_Ecrash.Layouts.PhotoLayout
													  ,self:= left)), hash(incident_id));	

ds_incidents_delete := FLAccidents_Ecrash.Infiles.incidents_todelete;


ds_photos_sup := join(ds_photos, ds_incidents_delete,
											trim(left.incident_id, all)= trim(right.incident_id,all),
											TRANSFORM(FLAccidents_Ecrash.Layouts.PhotoLayout,SELF := LEFT)
											,left only, local);

ds_Dupe_Photos := dedup(sort(distribute(ds_photos_sup, hash64(document_id)),document_id, -is_deleted, local),document_id,local );

ds_PhotosDeleted := ds_Dupe_Photos(is_deleted='1' or is_deleted = ''); 

export CmbndPhotos := JOIN(ds_Dupe_Photos, ds_PhotosDeleted, 
																		LEFT.document_id = RIGHT.document_id and
																		LEFT.Incident_id = RIGHT.incident_id and 
																		LEFT.document_hash_key = RIGHT.document_hash_key and
																		LEFT.extension = RIGHT.extension
																		, many lookup , left only );
																		
end;