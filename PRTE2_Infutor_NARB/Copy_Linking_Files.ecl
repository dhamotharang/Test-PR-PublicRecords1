IMPORT _control, STD, data_services;

EXPORT Copy_Linking_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING prev_version, STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1(data_services.foreign_prod + 'prte::key::infutor_narb::' + prev_version + '::linkids','~prte::key::infutor_narb::' + current_version + '::linkids',dest_cluster);


RETURN 'Success';	
	END;
END;