IMPORT _control, STD, data_services;

EXPORT proc_CopyFiles := module;


SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1(data_services.foreign_prod + 'thor_data400::key::citystzip_qa',	'~prte::key::citystzip::'+ current_version + '::citystzip', dest_cluster);
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::zipcityst_qa',	'~prte::key::zipcityst::'+ current_version + '::zipcityst', dest_cluster);
 
RETURN 'Success';	
	END;
END;
