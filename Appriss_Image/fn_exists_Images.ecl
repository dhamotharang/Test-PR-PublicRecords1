
export fn_exists_Images() := FUNCTION 
ImageSFilename:='~appriss_images::in::all_appriss_images'; // samplebookingexport
// Check if there are any image files.. RVH email July6th,2009
del_file_count := if(FileServices.SuperFileExists(ImageSFilename),
                   FileServices.GetSuperFileSubCount(ImageSFilename),
									 0);

return IF(del_file_count < 1, false, true);
END;