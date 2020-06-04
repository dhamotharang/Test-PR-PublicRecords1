IMPORT _control, STD, data_services;

EXPORT proc_CopyFiles := module


SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1(data_services.foreign_prod + 'thor_data400::key::areacode_change_plus_qa',	'~prte::key::business_header::'+ current_version + '::hri::oldnpa.oldnxx.fixeddates', dest_cluster);
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::areacode_change_qa',			'~prte::key::business_header::'+ current_version + '::hri::oldnpa.oldnxx', dest_cluster);
 
RETURN 'Success';	
	END;
END;
