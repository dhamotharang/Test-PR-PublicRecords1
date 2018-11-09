import rampscopy, dops;

// ***********************
// RUN this script on hthor
// if the copy doesn't appear to do anything, make sure that file "copyfiles::in::transfer::filelistdev_copyinprogress" doesn't already exist.  
// if it does delete it, or rename line 29 below to something other than dev
// ***********************

filestocopyds := dataset([
{'thor_data400::key::insuranceheader_segmentation::did_ind_qa','','',''}
,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::address','','',''}
,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::dob','','',''}
,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz','','',''}
,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::name','','',''}
,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::ph','','',''}
,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn','','',''}
,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4','','',''}
,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr','','',''}
,{'thor_data400::key::watchdog_best.did_qa','','',''}
,{'thor_data400::key::watchdog_best_nonen.did_qa','','',''}
			]
															,rampscopy.layouts.filestocopy);
															
dops.xFerRoxieFiles(filestocopyds
											,'prod_esp.br.seisint.com'  // prod thor ESP
											,'prod_dali.br.seisint.com'  // prod dali
											,'thor400_44'  // different cluster
											,'8010' 
											,'dev' // prod or dr or dev or some environment identity, this value will be used in dops.copyconstants.copyfile
											,'laura.weiner@lexisnexisrisk.com'
											,'RiskViewKey'
											,true
											,false
											,srcthorclusters := ['thor400_44'
											                     ,'thor400_20'
																					 ,'thor400_60'
																					 ,'hthor__eclagent'
																					 //,'thor400_31_store'
																					 ]
											).begincopy;															