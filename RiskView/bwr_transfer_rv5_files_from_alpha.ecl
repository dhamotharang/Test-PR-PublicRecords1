import _Control, rampscopy, dops;

// ***********************
// RUN this script on hthor
// if the copy doesn't appear to do anything, make sure that file "copyfiles::in::transfer::filelistdev_copyinprogress" doesn't already exist.  
// if it does delete it, or rename line 127 below to something other than dev
// ***********************

filestocopyds := dataset([
{'key::personcontext_deltakey::delta_key::lexid_qa','','',''}
,{'key::personcontext_deltakey::delta_key::recid_qa','','',''}
			]
															,rampscopy.layouts.filestocopy);
															
dops.xFerRoxieFiles(filestocopyds
											,'10.194.90.203'  									// vault ESP
											,'10.194.90.202'  									// vault dali
											,'analyt_thor400_90_a'  						// vault cluster
											,'8010' 														// vault ESP port
											,'dev' 															// prod or dr or dev or some environment identity, this value will be used in dops.copyconstants.copyfile
											,'laura.weiner@lexisnexisrisk.com'
											,'qa' 															// suffixSuperName
											,true
											,false
											,_Control.RoxieEnv.prod_batch_fcra 	// FCRA prod roxie IP
											, '10.194.112.105' 									// alpha prod thor ESP
											, '10.194.112.105' 									// alpha prod thor dali
											, '8010'														// alpha prod thor ESP port
											,['thor400_112']										// alpha prod clusters
											 , '8010'														// FCRA prod roxie ESP port
											 , '10.173.1.135' 									// FCRA prod roxie ESP
											 , 'roxie_208' 											// FCRA prod roxie target
											 , '8010'														// FCRA cert roxie ESP port
											 , '10.173.235.22'									// FCRA cert roxie ESP
											 , 'roxie_221'											// FCRA cert roxie target
											 , true 														// useRoxieToGetSubFilenames
											).begincopy;	
