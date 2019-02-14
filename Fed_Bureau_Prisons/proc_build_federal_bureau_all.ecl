//
import STD, PromoteSupers//, scrubs_Fed_Bureau_Prisons
                          ,RoxieKeyBuild,Orbit3,_Control;

EXPORT proc_build_federal_bureau_all (string version):= function

	//Spray
	spray := Fed_Bureau_Prisons.spray_federal_bureau_files(version);

  //Build base and superfile suffle 	
	build_base :=  Fed_Bureau_Prisons.proc_build_federal_bureau_base(version);
	
	clear_delete_sf		:= nothor(fileservices.clearsuperfile('~thor_data400::base::federal_bureau_of_prisons_delete', true));		

  superfile_shuffle	:= STD.File.PromoteSuperFileList(['~thor_data400::base::federal_bureau_of_prisons',
																											'~thor_data400::base::federal_bureau_of_prisons_father',
																											'~thor_data400::base::federal_bureau_of_prisons_grandfather',
																											'~thor_data400::base::federal_bureau_of_prisons_great_grandfather',
																											'~thor_data400::base::federal_bureau_of_prisons_delete'], '~thor_data400::base::federal_bureau_of_prisons_'+version+'_'+thorlib.wuid(), true);																				
	
	//Build keys	
	//build_Keys := proc_build_Keys(version);
	
	//Scrubs
	//scrubs := scrubs_Fed_Bureau_Prisons.fnRunScrubs(version,'tarun.patel@lexisnexis.com');
		
  //DOPS Entry Creation  
	dops_update	:=	RoxieKeyBuild.updateversion('FBOPKeys', version, _Control.MyInfo.EmailAddressNotify+';tarun.patel@lexisnexisrisk.com',,'N');														
 
  //Orbit Entry Creation  
	orbit_update := Orbit3.proc_Orbit3_CreateBuild ('FBOP',version,'N');
	
  //strata	
	strata := Strata_Population_Stats(version);
	
  return sequential(spray,
	                  //scrubs, //scrubs on raw
										build_base,
										clear_delete_sf,
										superfile_shuffle//,
										//build_Keys									
										// Strata;
										//dops_update
										//orbit_update
				           );	
	
	end;