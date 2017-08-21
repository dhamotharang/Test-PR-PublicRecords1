IMPORT ut;

EXPORT Proc_build_base(STRING file_date) := FUNCTION

	base_file_name := '~thor_data400::base::vintelligence';
	ut.MAC_SF_BuildProcess(VINA.map_VINtelligence_to_VINA ,base_file_name,vintelligence_base,2,,TRUE, file_date);

	RETURN SEQUENTIAL(
	                  if(NOT fileservices.superfileexists(base_file_name),fileservices.createsuperfile(base_file_name)),
	                  if(NOT fileservices.superfileexists(base_file_name+'_father'),fileservices.createsuperfile(base_file_name+'_father')),
	                  if(NOT fileservices.superfileexists(base_file_name+'_grandfather'),fileservices.createsuperfile(base_file_name+'_grandfather')),
                    vintelligence_base);

END;																			