/////////////////////////////////////////////////////////////////////////////////
// -- Process to build the Professional Licenses.
/////////////////////////////////////////////////////////////////////////////////
import Lib_FileServices, STRATA, ut;

export Proc_Build_ProfLic(string filedate) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Build Base File
/////////////////////////////////////////////////////////////////////////////////

build_base := Proc_Build_V2_base_from_V1(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Roxie Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := Prof_LicenseV2.proc_build_Proflic_keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Roxie Keys
/////////////////////////////////////////////////////////////////////////////////

build_Roxiekeys := Prof_LicenseV2.Proc_Build_Roxie_Keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Boolean Keys
/////////////////////////////////////////////////////////////////////////////////

build_Booleankeys := Prof_LicenseV2.Proc_Build_Boolean_Keys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- Build STRATA Stats
/////////////////////////////////////////////////////////////////////////////////

//build_stats := Prof_LicenseV2.Out_Base_Stats_Population_Prolic(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

//emailN := fileservices.sendemail('RoxieBuilds@seisint.com;giri.rajulapalli@lexisnexis.com',
emailN := fileservices.sendemail('snarra@seisint.com',								 
								'PROFESSIONAL LICENSES(V2): BUILD SUCCESS'+ filedate ,
								'base: 1) thor_data400::base::Prolicv2::proflic_base::built,\n\n' +
								
								'keys: 1) thor_data400::key::prolicv2::qa::Prolic_Id(thor_data400::key::prolicV2::'+ filedate +'::Prolic_Id),\n' +
								'      2) thor_data400::key::prolicv2::autokey::qa::addressB2(thor_data400::key::prolicV2::'+ filedate +'::autokey::addressb2),\n' +
								'      3) thor_data400::key::prolicv2::autokey::qa::citystnameB2(thor_data400::key::prolicV2::'+ filedate +'::autokey::citystnameb2),\n' +
								'      4) thor_data400::key::prolicv2::autokey::qa::nameB2(thor_data400::key::prolicV2::'+ filedate +'::autokey::nameb2),\n' +
								'      5) thor_data400::key::prolicv2::autokey::qa::payload(thor_data400::key::prolicV2::'+ filedate +'::autokey::payload),\n' +
								'      6) thor_data400::key::prolicv2::autokey::qa::zipB2(thor_data400::key::prolicV2::'+ filedate +'::autokey::zipb2),\n' +
								'      7) thor_data400::key::prolicv2::autokey::qa::stnameB2(thor_data400::key::prolicV2::'+ filedate +'::autokey::stnameb2),\n' +
								'      8) thor_data400::key::prolicv2::autokey::qa::namewords2(thor_data400::key::prolicV2::'+ filedate +'::autokey::namewords2),\n' +
								'      9) thor_data400::key::prolicv2::autokey::qa::phoneb2(thor_data400::key::prolicV2::'+ filedate +'::autokey::phoneb2),\n' +
								'     10) thor_data400::key::prolicv2::autokey::qa::name(thor_data400::key::prolicV2::'+ filedate +'::autokey::name),\n' +
								'     11) thor_data400::key::prolicv2::autokey::qa::address(thor_data400::key::prolicV2::'+ filedate +'::autokey::address),\n' +
								'     12) thor_data400::key::prolicv2::autokey::qa::stname(thor_data400::key::prolicV2::'+ filedate +'::autokey::stname),\n' +
								'     13) thor_data400::key::prolicv2::autokey::qa::citystname(thor_data400::key::prolicV2::'+ filedate +'::autokey::citystname),\n' +
								'     14) thor_data400::key::prolicv2::autokey::qa::zip(thor_data400::key::prolicV2::'+ filedate +'::autokey::zip),\n' +
								'     15) thor_data400::key::prolicv2::autokey::qa::ssn2(thor_data400::key::prolicV2::'+ filedate +'::autokey::ssn2),\n' +
								
								'     16) thor_data400::key::prolicv2::qa::proflic_licensenum(thor_data400::key::prolicv2::'+ filedate +'::licensenum),\n' +
								'     17) thor_data400::key::prolicv2::qa::proflic_bdid(thor_data400::key::prolicv2::'+ filedate +'::bdid),\n' +
								'     18) thor_data400::key::prolicv2::qa::prolicense_did(thor_data400::key::prolicv2::'+ filedate +'::did),\n' +
								'     19) thor_data400::key::prolicv2::qa::cbrs.addr_proflic(thor_data400::key::prolicv2::'+ filedate +'::cbrs.addr),\n' +
								'     20) thor_data400::key::prolicv2::qa::linkids(thor_data400::key::prolicv2::'+ filedate +'::LinkIds),\n' +
								'Boolean Keys:, \n' +
								'     21) thor_data400::key::prolic::qa::xseglist(thor_data400::key::prolic::'+ filedate +'::xseglist),\n' +
								'     22) thor_data400::key::prolic::qa::dictindx(thor_data400::key::prolic::'+ filedate +'::dictindx),\n' +
								'     23) thor_data400::key::prolic::qa::nidx(thor_data400::key::prolic::'+ filedate +'::nidx),\n' +
								'         have been built and ready to be deployed to QA.'); 
			


/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

//sequential(/*prolicMainBuild, parallel(*/build_autokeys, build_RoxieKeys/*, build_stats)*/);

build_keys 		:=  parallel(build_autokeys, build_RoxieKeys, build_Booleankeys);

build_files 	:= sequential(build_base, build_keys);

return sequential(build_files,  emailN);

end;
