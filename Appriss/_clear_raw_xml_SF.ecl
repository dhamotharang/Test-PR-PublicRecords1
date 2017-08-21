 basename:=cluster_name+'::in::appriss_booking_charges_raw_xml'; // samplebookingexport
 delbasename:=cluster_name+'::in::appriss_agency_delete_raw_xml'; // samplebookingexport
// Check if there are any agency delete files.. RVH email July6th,2009
del_file_count := if(FileServices.SuperFileExists(delbasename),
                   FileServices.GetSuperFileSubCount(delbasename),
									 0);

export _clear_raw_xml_SF := sequential(
		FileServices.StartSuperFileTransaction(),
		FileServices.ClearSuperFile(basename),
		if(del_file_count < 1 , output('Agency delete file is EMPTY'),
		   FileServices.ClearSuperFile(delbasename)
		   ),
		//FileServices.addsuperfile('~appriss_images::in::all_images_daily_updates','~appriss_images::in::all_appriss_images',,true),
		FileServices.ClearSuperFile('~appriss_images::in::all_appriss_images'), 
		FileServices.FinishSuperFileTransaction());
		
		