IMPORT _control, STD, data_services;

EXPORT Copy_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::bankruptcy','~prte::key::testseed::' + current_version + '::businesscreditreport::bankruptcy',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::bestinfo','~prte::key::testseed::' + current_version + '::businesscreditreport::bestinfo',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::corterab2b','~prte::key::testseed::' + current_version + '::businesscreditreport::corterab2b',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::inputecho','~prte::key::testseed::' + current_version + '::businesscreditreport::inputecho',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::matchinfo','~prte::key::testseed::' + current_version + '::businesscreditreport::matchinfo',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::ownguartor','~prte::key::testseed::' + current_version + '::businesscreditreport::ownguartor',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::scoring','~prte::key::testseed::' + current_version + '::businesscreditreport::scoring',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::summary','~prte::key::testseed::' + current_version + '::businesscreditreport::summary',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusacraft','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusacraft',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusactivity','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusactivity',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusconnect','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusconnect',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbuscontact','~prte::key::testseed::' + current_version + '::businesscreditreport::topbuscontact',dest_cluster);  
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusincorp','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusincorp',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbuslicense','~prte::key::testseed::' + current_version + '::businesscreditreport::topbuslicense',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusliens','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusliens',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusmvehicle','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusmvehicle',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusoper','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusoper',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusparent','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusparent',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusprop','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusprop',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbusucc','~prte::key::testseed::' + current_version + '::businesscreditreport::topbusucc',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'thor_data400::key::testseed::qa::businesscreditreport::topbuswcraft','~prte::key::testseed::' + current_version + '::businesscreditreport::topbuswcraft',dest_cluster); 


RETURN 'Success';	
	END;
END;