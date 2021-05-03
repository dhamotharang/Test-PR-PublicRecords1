IMPORT _control, STD, data_services;

EXPORT Copy_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

// CopyFiles1(data_services.foreign_prod + 'prte::key::oshair::protected::accident::delta_rid','~prte::key::oshair::' + current_version + '::accident::delta_rid',dest_cluster); 

// CopyFiles1(data_services.foreign_prod + 'prte::key::oshair::protected::autokey_payload::delta_rid','~prte::key::oshair::' + current_version + '::autokey_payload::delta_rid',dest_cluster); 

// CopyFiles1(data_services.foreign_prod + 'prte::key::oshair::protected::hazardous_substance::delta_rid','~prte::key::oshair::' + current_version + '::hazardous_substance::delta_rid',dest_cluster); 

// CopyFiles1(data_services.foreign_prod + 'prte::key::oshair::protected::inspection::delta_rid','~prte::key::oshair::' + current_version + '::inspection::delta_rid',dest_cluster);

// CopyFiles1(data_services.foreign_prod + 'prte::key::oshair::protected::program::delta_rid','~prte::key::oshair::' + current_version + '::program::delta_rid',dest_cluster);

CopyFiles1(data_services.foreign_prod + 'prte::key::oshair::protected::violations::delta_rid','~prte::key::oshair::' + current_version + '::violations::delta_rid',dest_cluster);

                                                                                 
 RETURN 'Success';	
	END;
END;