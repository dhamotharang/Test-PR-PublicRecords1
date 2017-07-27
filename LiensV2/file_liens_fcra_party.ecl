import ut, BIPV2; 
// Remove Vacate records from FCRA. 
main_Vacated := LiensV2.file_liens_main((regexfind('VACATE', filing_type_desc)) or 
(regexfind('VACATE', filing_status[1].filing_status_desc)));

EXPORT file_liens_fcra_party := join (LiensV2.File_Liens_Party_BIPV2,distribute(main_Vacated,hash(tmsid))  , left.tmsid = right.tmsid , 
                  transform({LiensV2.file_liens_party,BIPV2.IDlayouts.l_xlink_ids}, self := left),left only , local); 
									
