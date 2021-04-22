  Photo := Infiles.Document;                                
  dPhoto := DISTRIBUTE(Photo, HASH32(Incident_id));
  
  ds_incidents_delete := Infiles.incidents_todelete;
  ds_photos_sup := JOIN(dPhoto, ds_incidents_delete,
                        TRIM(left.incident_id,LEFT,RIGHT) = TRIM(right.incident_id,LEFT,RIGHT),
                        TRANSFORM(Layout_Infiles_Fixed.Document, SELF := LEFT;),
                        LEFT ONLY, LOCAL);
                                              
  // Allow Photos of Report type 'M' only for jurisdiction state LA and rest 'M' reports needs to be ingnored. #DF-20479
  ds_incidents := DISTRIBUTE(Infiles.tincident(TRIM(loss_state_abbr,LEFT,RIGHT) = 'LA'), HASH32(Incident_Id));
  JnGetMPhotos := JOIN(ds_incidents, ds_Photos_Sup(TRIM(Report_Type,LEFT,RIGHT) IN ['M','m']), 
                       TRIM(LEFT.Incident_Id,LEFT,RIGHT) = TRIM(RIGHT.Incident_id,LEFT,RIGHT),
                       TRANSFORM(RIGHT), LOCAL);
                                         
  AllPhotos := PROJECT(ds_photos_sup(TRIM(Report_Type,LEFT,RIGHT) NOT IN ['M','m']) + JnGetMPhotos, 
                       TRANSFORM(Layouts.PhotoLayout,SELF := LEFT; SELF := [];));
  
  dAllPhotos := DISTRIBUTE(AllPhotos, HASH32(document_id));
  
  // End of Allow Photos Of report Type 'M'. DF#20479
  ds_Dupe_Photos := DEDUP(SORT(dAllPhotos, document_id, -is_deleted, -date_created, LOCAL), document_id, LOCAL);
  ds_PhotosDeleted := ds_Dupe_Photos(is_deleted='1' or is_deleted = ''); 
  
EXPORT Map_eCrashAccidents_To_DocumentBase := JOIN(ds_Dupe_Photos, ds_PhotosDeleted, 
                                                   LEFT.document_id = RIGHT.document_id AND
                                                   LEFT.incident_id = RIGHT.incident_id AND 
                                                   LEFT.document_hash_key = RIGHT.document_hash_key AND
                                                   LEFT.extension = RIGHT.extension AND 
                                                   LEFT.report_source = RIGHT.report_source,
                                                   MANY LOOKUP, LEFT ONLY);

