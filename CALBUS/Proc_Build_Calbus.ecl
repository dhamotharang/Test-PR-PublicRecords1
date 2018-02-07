//-------------------------------------------------------------------
// Process to build the CALBUS.
//-------------------------------------------------------------------
import Lib_FileServices, STRATA, PromoteSupers, Roxiekeybuild, _Control, Orbit3;

export Proc_Build_Calbus(string filedate) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Build Base File
/////////////////////////////////////////////////////////////////////////////////

PromoteSupers.MAC_SF_BuildProcess(CALBUS.Cleaned_Calbus_DID, CALBUS.Constants.Cluster+'base::CALBUS::basefile',aCALBUSMainBuild,3);


/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := CALBUS.Proc_Build_CALBUS_Keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Boolean keys
/////////////////////////////////////////////////////////////////////////////////

build_boolean_keys := Calbus.Proc_Build_boolean_Keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build STRATA Stats
/////////////////////////////////////////////////////////////////////////////////

build_stats := CALBUS.Out_Base_Stats_Population_CALBUS(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////
emailN := fileservices.sendemail(_Control.MyInfo.EmailAddressNotify+ '; RoxieBuilds@seisint.com',								 
								'CALBUS: BUILD SUCCESS '+ filedate ,
								'base:-  1) thor_data400::base::CALBUS::basefile,\n\n' +								
								'keys:-                                                         \n' +
								'				 1) thor_data400::key::CALBUS::qa::Account_Nbr (thor_data400::key::CALBUS::'+ filedate +'::Account_Nbr),\n' +
								'        2) thor_data400::key::CALBUS::qa::BDID (thor_data400::key::CALBUS::'+ filedate +'::BDID),\n' +
								'        3) thor_data400::key::CALBUS::autokey::qa::addressB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::addressb2),\n' +
								'        4) thor_data400::key::CALBUS::autokey::qa::citystnameB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::citystnameb2),\n' +
								'        5) thor_data400::key::CALBUS::autokey::qa::nameB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::nameb2),\n' +
								'        6) thor_data400::key::CALBUS::autokey::qa::payload (thor_data400::key::CALBUS::'+ filedate +'::autokey::payload),\n' +
								'        7) thor_data400::key::CALBUS::autokey::qa::zipB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::zipb2),\n' +
								'        8) thor_data400::key::CALBUS::autokey::qa::stnameB2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::stnameb2),\n' +
								'        9) thor_data400::key::CALBUS::autokey::qa::namewords2 (thor_data400::key::CALBUS::'+ filedate +'::autokey::namewords2),\n' +
								'       10) thor_data400::key::CALBUS::autokey::qa::name(thor_data400::key::CALBUS::'+ filedate +'::autokey::name),\n' +
								'       11) thor_data400::key::CALBUS::autokey::qa::address(thor_data400::key::CALBUS::'+ filedate +'::autokey::address),\n' +
								'       12) thor_data400::key::CALBUS::autokey::qa::stname(thor_data400::key::CALBUS::'+ filedate +'::autokey::stname),\n' +
								'       13) thor_data400::key::CALBUS::autokey::qa::citystname(thor_data400::key::CALBUS::'+ filedate +'::autokey::citystname),\n' +
								'       14) thor_data400::key::CALBUS::autokey::qa::zip(thor_data400::key::CALBUS::'+ filedate +'::autokey::zip),\n' +
								'       15) thor_data400::key::CALBUS::qa::LinkIDs(thor_data400::key::CALBUS::'+ filedate +'::linkids),\n' +
								'Bkeys:-                                                          \n' +
								'				15) thor_data400::key::calbus::qa::xseglist(thor_data400::key::CALBUS::'+ filedate +'::xseglist),\n' +
								'       16) thor_data400::key::calbus::qa::dictindx(thor_data400::key::CALBUS::'+ filedate +'::dictindx),\n' +
								'       17) thor_data400::key::calbus::qa::doc.accnumber(thor_data400::key::CALBUS::'+ filedate +'::doc.accnumber),\n' +
								'       18) thor_data400::key::calbus::qa::xdstat2(thor_data400::key::CALBUS::'+ filedate +'::xdstat2),\n' +
								'       19) thor_data400::key::calbus::qa::nidx(thor_data400::key::CALBUS::'+ filedate +'::nidx),\n' +
								'         have been built and ready to be deployed to QA.'); 

/////////////////////////////////////////////////////////////////////////////////
// -- UPDATE ROXIE PAGE 
/////////////////////////////////////////////////////////////////////////////////		
UpdateRoxiePage := RoxieKeybuild.updateversion('CalbusKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N|B');

//Update ORBIT
	orbitUpdate := Orbit3.proc_Orbit3_CreateBuild('CALBUS',filedate,'N|B'); 

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_files := sequential(aCALBUSMainBuild, parallel(build_autokeys, build_boolean_keys), UpdateRoxiePage, build_stats,orbitUpdate);

return parallel(build_files, emailN);

end;
