IMPORT _control, STD, data_services;

EXPORT Copy_Overrides := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING prev_version, STRING current_version, string dest_cluster) := FUNCTION

  CopyFiles1(data_services.foreign_prod + 'prte::key::override::pcr::' + prev_version + '::ssn','~prte::key::override::pcr::' + current_version + '::ssn',dest_cluster); 
	CopyFiles1(data_services.foreign_prod + 'prte::key::override::pcr::' + prev_version + '::did','~prte::key::override::pcr::' + current_version + '::did',dest_cluster); 
 
 	RETURN 'Success';	
	END;
END;