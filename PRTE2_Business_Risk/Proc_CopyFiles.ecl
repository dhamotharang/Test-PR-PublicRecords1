IMPORT _control, STD, data_services;

EXPORT Proc_CopyFiles := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION
 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::key::business_header::qa::business_risk_geolink',
                                         '~prte::key::business_header::'+current_version+'::business_risk_geolink',dest_cluster); 
 // FileServices.AddSuperFile('~prte::key::Business_Header::qa::business_risk_geolink','~prte::key::business_header::'+current_version+'::business_risk_geolink');                                        
 
 CopyFiles1(data_services.foreign_prod + 'thor_data400::key::business_header::qa::siccode_description',
                                         '~prte::key::business_header::'+current_version+'::siccode_description',dest_cluster); 
 // FileServices.AddSuperFile('~prte::key::Business_Header::qa::siccode_description','~prte::key::business_header::'+current_version+'::siccode_description');                                        

  
RETURN 'Success';	
	END;
END;
