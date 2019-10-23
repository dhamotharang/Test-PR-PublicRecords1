IMPORT _control, STD, data_services;

EXPORT Copy_FDN_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING prev_version, STRING current_version, string dest_cluster) := FUNCTION
	
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::appproviderid','~prte::key::fdn::' + current_version + '::appproviderid',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::address','~prte::key::fdn::' + current_version + '::autokey::address',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::addressb2','~prte::key::fdn::' + current_version + '::autokey::addressb2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::citystname','~prte::key::fdn::' + current_version + '::autokey::citystname',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::citystnameb2','~prte::key::fdn::' + current_version + '::autokey::citystnameb2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::fein2','~prte::key::fdn::' + current_version + '::autokey::fein2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::name','~prte::key::fdn::' + current_version + '::autokey::name',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::nameb2','~prte::key::fdn::' + current_version + '::autokey::nameb2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::namewords2','~prte::key::fdn::' + current_version + '::autokey::namewords2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::payload','~prte::key::fdn::' + current_version + '::autokey::payload',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::phone2','~prte::key::fdn::' + current_version + '::autokey::phone2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::phoneb2','~prte::key::fdn::' + current_version + '::autokey::phoneb2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::ssn2','~prte::key::fdn::' + current_version + '::autokey::ssn2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::stname','~prte::key::fdn::' + current_version + '::autokey::stname',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::stnameb2','~prte::key::fdn::' + current_version + '::autokey::stnameb2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::zip','~prte::key::fdn::' + current_version + '::autokey::zip',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::autokey::zipb2','~prte::key::fdn::' + current_version + '::autokey::zipb2',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::bdid','~prte::key::fdn::' + current_version + '::bdid',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::deviceid','~prte::key::fdn::' + current_version + '::deviceid',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::did','~prte::key::fdn::' + current_version + '::did',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::email','~prte::key::fdn::' + current_version + '::email',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::gcid_2_mbsfdnmasterid','~prte::key::fdn::' + current_version + '::gcid_2_mbsfdnmasterid',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::id','~prte::key::fdn::' + current_version + '::id',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::ip','~prte::key::fdn::' + current_version + '::ip',dest_cluster); 
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::linkids','~prte::key::fdn::' + current_version + '::linkids',dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::lnpid','~prte::key::fdn::' + current_version + '::lnpid',dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::mbs','~prte::key::fdn::' + current_version + '::mbs',dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::mbsfdnmasteridexclusion','~prte::key::fdn::' + current_version + '::mbsfdnmasteridexclusion',dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::mbsindtypeexclusion','~prte::key::fdn::' + current_version + '::mbsindtypeexclusion',dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::mbsproductinclude','~prte::key::fdn::' + current_version + '::mbsproductinclude',dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::npi','~prte::key::fdn::' + current_version + '::npi',dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::professionalid','~prte::key::fdn::' + current_version + '::professionalid',dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::fdn::' + prev_version + '::tin','~prte::key::fdn::' + current_version + '::tin',dest_cluster);
			
 	RETURN 'Success';	
	END;
END;