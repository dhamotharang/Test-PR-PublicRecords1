/////////////////////////////////////////////////////////////////////////////////
// -- Process to build the Txbus.
/////////////////////////////////////////////////////////////////////////////////
import Lib_FileServices, STRATA, Roxiekeybuild, _Control, PromoteSupers, Orbit3;

export Proc_build_Txbus(string filedate) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Build Base File
/////////////////////////////////////////////////////////////////////////////////

PromoteSupers.MAC_SF_BuildProcess(TXBUS.Cleaned_Txbus_DID,Txbus.Constants.Cluster+'base::Txbus::basefile',aTxbusMainBuild,3);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := Txbus.proc_build_Txbus_keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build STRATA Stats
/////////////////////////////////////////////////////////////////////////////////

build_stats := Txbus.Out_Base_Stats_Population_Txbus(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Boolean keys
/////////////////////////////////////////////////////////////////////////////////

build_booleanKeys := Txbus.Proc_Build_Boolean_Keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

emailN := fileservices.sendemail(_Control.MyInfo.EmailAddressNotify+ '; RoxieBuilds@seisint.com',								 
								'Txbus: BUILD SUCCESS '+ filedate ,
								'base:   1) thor_data400::base::txbus::basefile,      \n\n' +								
								'keys:- 																							\n' +
								'				 1) thor_data400::key::txbus::qa::Taxpayer_Nbr(thor_data400::key::txbus::'+ filedate +'::Taxpayer_Nbr),\n' +
								'        2) thor_data400::key::txbus::qa::BDID(thor_data400::key::txbus::'+ filedate +'::BDID),\n' +
								'        3) thor_data400::key::txbus::qa::DID(thor_data400::key::txbus::'+ filedate +'::DID),\n' +
								'        4) thor_data400::key::txbus::qa::LinkIDs(thor_data400::key::txbus::'+ filedate +'::LinkIDs),\n' +
								'        5) thor_data400::key::txbus::autokey::qa::addressB2(thor_data400::key::txbus::'+ filedate +'::autokey::addressb2),\n' +
								'        6) thor_data400::key::txbus::autokey::qa::citystnameB2(thor_data400::key::txbus::'+ filedate +'::autokey::citystnameb2),\n' +
								'        7) thor_data400::key::txbus::autokey::qa::nameB2(thor_data400::key::txbus::'+ filedate +'::autokey::nameb2),\n' +
								'        8) thor_data400::key::txbus::autokey::qa::payload(thor_data400::key::txbus::'+ filedate +'::autokey::payload),\n' +
								'        9) thor_data400::key::txbus::autokey::qa::zipB2(thor_data400::key::txbus::'+ filedate +'::autokey::zipb2),\n' +
								'       10) thor_data400::key::txbus::autokey::qa::stnameB2(thor_data400::key::txbus::'+ filedate +'::autokey::stnameb2),\n' +
								'       11) thor_data400::key::txbus::autokey::qa::namewords2(thor_data400::key::txbus::'+ filedate +'::autokey::namewords2),\n' +
								'       12) thor_data400::key::txbus::autokey::qa::phoneb2(thor_data400::key::txbus::'+ filedate +'::autokey::phoneb2),\n' +
								'       13) thor_data400::key::txbus::autokey::qa::name(thor_data400::key::txbus::'+ filedate +'::autokey::name),\n' +
								'       14) thor_data400::key::txbus::autokey::qa::address(thor_data400::key::txbus::'+ filedate +'::autokey::address),\n' +
								'       15) thor_data400::key::txbus::autokey::qa::stname(thor_data400::key::txbus::'+ filedate +'::autokey::stname),\n' +
								'       16) thor_data400::key::txbus::autokey::qa::citystname(thor_data400::key::txbus::'+ filedate +'::autokey::citystname),\n' +
								'       17) thor_data400::key::txbus::autokey::qa::zip(thor_data400::key::txbus::'+ filedate +'::autokey::zip),\n' +
							
								'BKeys:- 																							\n' +
								'			  18) thor_data400::key::txbus::qa::dictindx(thor_data400::key::txbus::'+ filedate +'::dictindx),\n' +
								'       19) thor_data400::key::txbus::qa::docref.taxpayernumber(thor_data400::key::txbus::'+ filedate +'::docref.taxpayernumber),\n' +
								'       20) thor_data400::key::txbus::qa::xdstat2(thor_data400::key::txbus::'+ filedate +'::xdstat2),\n' +
								'       21) thor_data400::key::txbus::qa::xseglist(thor_data400::key::txbus::'+ filedate +'::xseglist),\n' +
								'       22) thor_data400::key::txbus::qa::nidx(thor_data400::key::txbus::'+ filedate +'::nidx),\n' +
								'     have been built and ready to be deployed to QA.'); 

/////////////////////////////////////////////////////////////////////////////////
// -- UPDATE ROXIE PAGE 
/////////////////////////////////////////////////////////////////////////////////		
UpdateRoxiePage := RoxieKeybuild.updateversion('TxbusKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N|B');

//Update ORBIT
orbitUpdate := Orbit3.proc_Orbit3_CreateBuild_AddItem('TXBUS',filedate,'N|B'); 

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_files := sequential(aTxbusMainBuild, parallel(build_autokeys, build_booleanKeys), UpdateRoxiePage, build_stats, orbitUpdate);

return parallel(build_files, emailN);

end;