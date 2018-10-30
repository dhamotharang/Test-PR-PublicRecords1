IMPORT _control, STD, data_services;

EXPORT Copy_FraudGov_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING prev_version, STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::amountpaid','~prte::key::fraudgov::' + current_version + '::amountpaid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::appproviderid','~prte::key::fraudgov::' + current_version + '::appproviderid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::address','~prte::key::fraudgov::' + current_version + '::autokey::address',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::addressb2','~prte::key::fraudgov::' + current_version + '::autokey::addressb2',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::citystname','~prte::key::fraudgov::' + current_version + '::autokey::citystname',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::citystnameb2','~prte::key::fraudgov::' + current_version + '::autokey::citystnameb2',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::fein2','~prte::key::fraudgov::' + current_version + '::autokey::fein2',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::name','~prte::key::fraudgov::' + current_version + '::autokey::name',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::nameb2','~prte::key::fraudgov::' + current_version + '::autokey::nameb2',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::namewords2','~prte::key::fraudgov::' + current_version + '::autokey::namewords2',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::payload','~prte::key::fraudgov::' + current_version + '::autokey::payload',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::phone2','~prte::key::fraudgov::' + current_version + '::autokey::phone2',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::phoneb2','~prte::key::fraudgov::' + current_version + '::autokey::phoneb2',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::ssn2','~prte::key::fraudgov::' + current_version + '::autokey::ssn2',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::stname','~prte::key::fraudgov::' + current_version + '::autokey::stname',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::stnameb2','~prte::key::fraudgov::' + current_version + '::autokey::stnameb2',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::zip','~prte::key::fraudgov::' + current_version + '::autokey::zip',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::autokey::zipb2','~prte::key::fraudgov::' + current_version + '::autokey::zipb2',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::bankaccount','~prte::key::fraudgov::' + current_version + '::bankaccount',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::bankname','~prte::key::fraudgov::' + current_version + '::bankname',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::bankroutingnumber','~prte::key::fraudgov::' + current_version + '::bankroutingnumber',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::bdid','~prte::key::fraudgov::' + current_version + '::bdid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::citystate','~prte::key::fraudgov::' + current_version + '::citystate',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::county','~prte::key::fraudgov::' + current_version + '::county',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::customerid','~prte::key::fraudgov::' + current_version + '::customerid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::customerprogram','~prte::key::fraudgov::' + current_version + '::customerprogram',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::deviceid','~prte::key::fraudgov::' + current_version + '::deviceid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::did','~prte::key::fraudgov::' + current_version + '::did',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::driverslicense','~prte::key::fraudgov::' + current_version + '::driverslicense',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::email','~prte::key::fraudgov::' + current_version + '::email',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::gcid_2_mbsfdnmasterid','~prte::key::fraudgov::' + current_version + '::gcid_2_mbsfdnmasterid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::host','~prte::key::fraudgov::' + current_version + '::host',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::householdid','~prte::key::fraudgov::' + current_version + '::householdid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::id','~prte::key::fraudgov::' + current_version + '::id',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::ip','~prte::key::fraudgov::' + current_version + '::ip',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::iprange','~prte::key::fraudgov::' + current_version + '::iprange',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::isp','~prte::key::fraudgov::' + current_version + '::isp',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::kel::clusterdetails','~prte::key::fraudgov::' + current_version + '::kel::clusterdetails',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::kel::elementpivot','~prte::key::fraudgov::' + current_version + '::kel::elementpivot',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::kel::scorebreakdown','~prte::key::fraudgov::' + current_version + '::kel::scorebreakdown',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::linkids','~prte::key::fraudgov::' + current_version + '::linkids',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::lnpid','~prte::key::fraudgov::' + current_version + '::lnpid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::macaddress','~prte::key::fraudgov::' + current_version + '::macaddress',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::mbs','~prte::key::fraudgov::' + current_version + '::mbs',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::mbsdeltabase','~prte::key::fraudgov::' + current_version + '::mbsdeltabase',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::mbsfdnindtype','~prte::key::fraudgov::' + current_version + '::mbsfdnindtype',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::mbsfdnmasteridexclusion','~prte::key::fraudgov::' + current_version + '::mbsfdnmasteridexclusion',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::mbsfdnmasteridindtypeinclusion','~prte::key::fraudgov::' + current_version + '::mbsfdnmasteridindtypeinclusion',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::mbsindtypeexclusion','~prte::key::fraudgov::' + current_version + '::mbsindtypeexclusion',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::mbsproductinclude','~prte::key::fraudgov::' + current_version + '::mbsproductinclude',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::mbsvelocityrules','~prte::key::fraudgov::' + current_version + '::mbsvelocityrules',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::npi','~prte::key::fraudgov::' + current_version + '::npi',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::professionalid','~prte::key::fraudgov::' + current_version + '::professionalid',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::reporteddate','~prte::key::fraudgov::' + current_version + '::reporteddate',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::serialnumber','~prte::key::fraudgov::' + current_version + '::serialnumber',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::tin','~prte::key::fraudgov::' + current_version + '::tin',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::user','~prte::key::fraudgov::' + current_version + '::user',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::zip','~prte::key::fraudgov::' + current_version + '::zip',dest_cluster);

CopyFiles1(data_services.foreign_prod + 'prte::key::fraudgov::' + prev_version + '::kel::weightingchart','~prte::key::fraudgov::' + current_version + '::kel::weightingchart',dest_cluster); 

RETURN 'Success';	
	END;
END;






