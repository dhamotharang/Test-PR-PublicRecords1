IMPORT _control, STD, data_services;

EXPORT Copy_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1(data_services.foreign_prod + 'prte::key::proflic_mari::fcra::protseed::search::delta_rid','~prte::key::proflic_mari::fcra::' + current_version + '::search::delta_rid',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'prte::key::proflic_mari::protseed::regulatory_actions::delta_rid','~prte::key::proflic_mari::' + current_version + '::regulatory_actions::delta_rid',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'prte::key::proflic_mari::protseed::individual_detail::delta_rid','~prte::key::proflic_mari::' + current_version + '::individual_detail::delta_rid',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'prte::key::proflic_mari::protseed::search::delta_rid','~prte::key::proflic_mari::' + current_version + '::search::delta_rid',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'prte::key::proflic_mari::protseed::disciplinary_actions::delta_rid','~prte::key::proflic_mari::' + current_version + '::disciplinary_actions::delta_rid',dest_cluster); 
                                                                                                                                                                                            
 
RETURN 'Success';	
	END;
END;