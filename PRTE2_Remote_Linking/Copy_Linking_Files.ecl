IMPORT _control, STD, data_services;

EXPORT Copy_Linking_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING prev_version, STRING current_version, string dest_cluster) := FUNCTION


 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::ssn::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::ssn::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::dob_year::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::dob_year::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::dob_month::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::dob_month::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::dob_day::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::dob_day::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::dl_nbr::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::dl_nbr::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::sname::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::sname::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::fname::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::fname::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::mname::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::mname::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::lname::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::lname::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::gender::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::gender::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::derived_gender::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::derived_gender::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::prim_name::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::prim_name::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::prim_range::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::prim_range::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::sec_range::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::sec_range::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::city::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::city::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::st::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::st::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::zip::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::zip::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::policy_number::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::policy_number::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::claim_number::' + prev_version +'::publish','~prte::insuranceheader_remotelinking::did::word::claim_number::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::mainname::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::mainname::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::addr1::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::addr1::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::locale::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::locale::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::address::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::address::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::fullname::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::fullname::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::dt_first_seen::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::dt_first_seen::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::dt_last_seen::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::dt_last_seen::' + current_version + '::publish',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::insuranceheader_remotelinking::did::word::specificities::' + prev_version + '::publish','~prte::insuranceheader_remotelinking::did::word::specificities::' + current_version + '::publish',dest_cluster); 
 

RETURN 'Success';	
	END;
END;