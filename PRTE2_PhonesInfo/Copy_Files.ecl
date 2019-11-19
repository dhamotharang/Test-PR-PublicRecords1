IMPORT _control, STD, data_services;

EXPORT Copy_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1(data_services.foreign_prod + 'thor_data400::key::phones_transaction_qa','~prte::key::' + current_version + '::phones_transaction',dest_cluster); 

CopyFiles1(data_services.foreign_prod + 'thor_data400::key::phones_type_qa','~prte::key::' + current_version + '::phones_type',dest_cluster); 

 
RETURN 'Success';	
	END;
END;