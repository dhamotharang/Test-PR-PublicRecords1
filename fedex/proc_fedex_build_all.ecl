//#workunit('name', 'Yoguart::FEDEX-NOHIT Build');
import _control,ut,Orbit3, lib_Datalib,std;

#workunit ('priority','high');
#workunit	('priority',11);
#option 	('activitiesPerCpp', 50);
// do not use thor400_44 until BEGINC++ fixed
//#option 	('AllowClusters','thor400_20,thor400_44,thor400_60');
#option 	('AllowClusters','thor400_20,thor400_60');
#option 	('AllowAutoQueueSwitch','1');
#option 	('multiplePersistInstances',FALSE);

export	proc_fedex_build_all(string	version_date) := function	
	spray_file			:=	fedex.Spray_Prep_Fedex(version_date);
	build_base_keys	:=	fedex.proc_fedex_build_base(version_date);
	//build_keys	:=	fedex.proc_fedex_build_keys2(version_date);
	sample_recs	:=	fedex.fedex_qa_samples(version_date);
	filedate 				:= version_date[1..8];
	//STRATA 					:= fedex.FedEx_Stats(version_date); 
	send_email			:= if (	fileservices.remotedirectory(_control.IPAddress.bctlpedata10, '/data/hds_4/FedEx/logs', 'parseError.log')[1].size > 0,
													fileservices.sendemail(	'michael.gould@lexisnexis.com',
																									'FEDEX - BAD XML WELLFORMED DOCUMENT RECEIVED',
																									'\nGood Morning!\n\naddresses.xml file received on ' + version_date + ' with parsing errors was processed successfully\n\n' + 'LN DataOps Team'
													));
										
	return sequential(spray_file,build_base_keys/*,STRATA*/
	                        ,if(ut.Weekday((integer)version_date) <> 'SATURDAY' and ut.Weekday((integer)version_date) <> 'SUNDAY'
													,Orbit3.proc_Orbit3_CreateBuild ( 'FedEx',version_date,'N')
													,output('No Orbit Entries Needed for weekend builds'))
													,fileservices.Despray('~thor200::out::fedex::dupes_v1'
		  									  , _Control.IPAddress.bctlpedata10 
												  , '/data/hds_4/FedEx/out/fedex_dupes_all.csv',,,,true)
  												,fileservices.Despray('~thor200::out::fedex::new_dupes_v1'
													,_Control.IPAddress.bctlpedata10
 												  , '/data/hds_4/FedEx/out/fedex_dupes_new.csv',,,,true)
													,fileservices.Despray('~thor200::out::fedex::new_uniques_v1'
													,_Control.IPAddress.bctlpedata10
												  , '/data/hds_4/FedEx/out/fedex_new_records.csv',,,,true)
													,send_email
													,output(_control.fSubmitNewWorkunit('#workunit(\'name\',\'FedEx Strata - '+filedate+'\');\r\n'+
                          'fedex.FedEx_Stats(\''+version_date+'\');\r\n'
                          ,std.system.job.target()))
													); 

end;