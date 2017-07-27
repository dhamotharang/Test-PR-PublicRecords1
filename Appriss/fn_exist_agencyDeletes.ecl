
export fn_exist_agencyDeletes() := FUNCTION 
delbasename:=cluster_name+'::in::appriss_agency_delete_raw_xml'; // samplebookingexport
// Check if there are any agency delete files.. RVH email July6th,2009
del_file_count := if(FileServices.SuperFileExists(delbasename),
                   FileServices.GetSuperFileSubCount(delbasename),
									 0);

return IF(del_file_count < 1, false, true);
END;