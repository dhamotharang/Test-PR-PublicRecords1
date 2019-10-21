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
 
RETURN 'Success';	
	END;
END;