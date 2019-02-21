IMPORT _control, STD, data_services;

EXPORT Copy_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION


CopyFiles1(data_services.foreign_prod + 'prte::key::proxid::bipv2_proxid::protected::specificities_debug','~prte::key::proxid::bipv2_proxid::' + current_version + '::specificities_debug',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2_lgid3::protected::specificities_debug','~prte::key::bipv2_lgid3::' + current_version + '::specificities_debug',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'prte::key::proxid::bipv2_proxid::protected::match_candidates_debug','~prte::key::proxid::bipv2_proxid::' + current_version + '::match_candidates_debug',dest_cluster); 


CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2_seleid_relative::protected::specificities','~prte::key::bipv2_seleid_relative::' + current_version + '::specificities',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2_seleid_relative::protected::match_candidates','~prte::key::bipv2_seleid_relative::' + current_version + '::match_candidates',dest_cluster); 

 
 
RETURN 'Success';	
	END;
END;