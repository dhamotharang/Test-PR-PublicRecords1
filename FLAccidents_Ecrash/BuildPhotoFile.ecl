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
													,csv(heading(1),terminator('\n'), separator(','),quote('"')))(Document_ID != 'Document_ID') ;
													
ds_Photos    := project(photo, transform(FLAccidents_Ecrash.Layouts.PhotoLayout
													  ,self:= left));	

ds_Dupe_Photos := dedup(sort(distribute(ds_photos, hash64(document_id)),document_id,incident_id,document_hash_key, local),document_id,incident_id,document_hash_key,report_type,extension, right, local );

ds_PhotosDeleted := ds_Dupe_Photos(is_deleted='1' or is_deleted = ''); 

export CmbndPhotos := JOIN(ds_Dupe_Photos, ds_PhotosDeleted, 
																		LEFT.document_id = RIGHT.document_id and
																		LEFT.Incident_id = RIGHT.incident_id and 
																		LEFT.document_hash_key = RIGHT.document_hash_key and
																		LEFT.extension = RIGHT.extension
																		, many lookup , left only );
																		
end;