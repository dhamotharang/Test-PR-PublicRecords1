IMPORT _control, STD, data_services;

EXPORT Proc_CopyFiles := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION
 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::key::neighborhood::qa::crime::geolink','~prte::key::neighborhood::' + current_version + '::crime::geolink',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::key::addrfraud::geoblk_info_geolink_qa','~prte::key::neighborhood::' + current_version + '::geoblk_info_geolink',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::key::addrfraud::geoblk_latlon_qa','~prte::key::neighborhood::' + current_version + '::geoblk_latlon',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::key::neighborhood::qa::geolink_to_geolink::geolink_dist_100th','~prte::key::neighborhood::' + current_version + '::geolink_to_geolink::geolink_dist_100th',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::key::neighborhood::qa::fbi_cius_city::address','~prte::key::neighborhood::' + current_version + '::fbi_cius_city::address',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::key::neighborhood::qa::neighborhoodstats::geolink','~prte::key::neighborhood::' + current_version + '::neighborhoodstats::geolink',dest_cluster); 
  
RETURN 'Success';	
	END;
END;
