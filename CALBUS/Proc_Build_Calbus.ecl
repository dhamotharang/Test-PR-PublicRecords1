// Process to build the CALBUS.
//-------------------------------------------------------------------
import Lib_FileServices, STRATA, ut;

export Proc_Build_Calbus(string filedate) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Build Base File
/////////////////////////////////////////////////////////////////////////////////

ut.MAC_SF_BuildProcess(CALBUS.Cleaned_Calbus_DID, CALBUS.Constants.Cluster+'base::CALBUS::basefile',aCALBUSMainBuild,2);


/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := CALBUS.Proc_Build_CALBUS_Keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_boolean_keys := Calbus.Proc_Build_boolean_Keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build STRATA Stats
/////////////////////////////////////////////////////////////////////////////////

build_stats := CALBUS.Out_Base_Stats_Population_CALBUS(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

//emailN := fileservices.sendemail('RoxieBuilds@seisint.com ; giri.rajulapalli@lexisnexis.com ',
emailN := fileservices.sendemail('giri.rajulapalli@lexisnexis.com',								 
								'CALBUS: BUILD SUCCESS '+ filedate ,
								'base: 1) thor_data400::base::CALBUS::basefile,\n\n' +								
								'keys: 1) thor_data400::key::CALBUS::qa::Account_Nbr (thor_data400::key::CALBUS::'+ filedate +'::Account_Nbr),\n' +
								'      2) thor_data400::key::CALBUS::qa::BDID (thor_data400::key::CALBUS::'+ filedate +'::BDID),\n' +
								'      3) thor_data400::key::CALBUS::autokey::qa::addressB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::addressb2),\n' +
								'      4) thor_data400::key::CALBUS::autokey::qa::citystnameB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::citystnameb2),\n' +
								'      5) thor_data400::key::CALBUS::autokey::qa::nameB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::nameb2),\n' +
								'      6) thor_data400::key::CALBUS::autokey::qa::payload (thor_data400::key::CALBUS::'+ filedate +'::autokey::payload),\n' +
								'      7) thor_data400::key::CALBUS::autokey::qa::zipB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::zipb2),\n' +
								'      8) thor_data400::key::CALBUS::autokey::qa::stnameB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::stnameb2),\n' +
								'      9) thor_data400::key::CALBUS::autokey::qa::namewords2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::namewords2),\n' +
								'     10) thor_data400::key::CALBUS::autokey::qa::name(thor_data400::key::CALBUS::'+ filedate +'::autokey::name),\n' +
								'     11) thor_data400::key::CALBUS::autokey::qa::address(thor_data400::key::CALBUS::'+ filedate +'::autokey::address),\n' +
								'     12) thor_data400::key::CALBUS::autokey::qa::stname(thor_data400::key::CALBUS::'+ filedate +'::autokey::stname),\n' +
								'     13) thor_data400::key::CALBUS::autokey::qa::citystname(thor_data400::key::CALBUS::'+ filedate +'::autokey::citystname),\n' +
								'     14) thor_data400::key::CALBUS::autokey::qa::zip(thor_data400::key::CALBUS::'+ filedate +'::autokey::zip),\n' +
								'         have been built and ready to be deployed to QA.'); 
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_files := sequential(aCALBUSMainBuild, parallel(build_autokeys, build_boolean_keys, build_stats));

return parallel(build_files, emailN);

end;
