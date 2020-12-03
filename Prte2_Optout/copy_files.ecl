IMPORT _control, STD, data_services;

EXPORT Copy_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1(data_services.foreign_prod + 'prte::key::fcra::optout::protected::address',  '~prte::key::fcra::optout::' + current_version + '::address',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'prte::key::fcra::optout::protected::ssn',      '~prte::key::fcra::optout::' + current_version + '::ssn',dest_cluster);

CopyFiles1(data_services.foreign_prod + 'prte::key::fcra::optout::protected::did',      '~prte::key::fcra::optout::' + current_version + '::did',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'prte::key::fcra::optout::protected::delta_rid','~prte::key::fcra::optout::' + current_version + '::delta_rid',dest_cluster); 


 RETURN 'Success';	
	END;
END;