Import Lib_FileServices, STRATA, ut, Roxiekeybuild, Orbit3;
//FileName is the filename in edata10
//Filedate is the update date
Export Proc_Build_All(String FileName, String Filedate) := Function

#workunit('name','Yogurt: BadAddresses Build - ' + filedate);
#workunit('priority','high');

SprayFile := BadAddresses.fsprayInFile(filename, filedate);

ut.MAC_SF_BuildProcess(BadAddresses.Proc_Build_Base(FileDate), '~thor400_92::base::BadAddresses', BadAddresses_Base);
file_name := FileServices.GetSuperFileSubName('~thor400_92::base::BadAddresses',1,true);
BadAddressesBase := BadAddresses_Base : success(
									sequential(
										output('Build for base file successful'),
										fileServices.StartSuperFileTransaction(),
										fileServices.ClearSuperFile('~thor400_92::base::BadAddresses',true),
										fileServices.AddSuperFile('~thor400_92::base::BadAddresses',file_name),
										fileServices.FinishSuperFileTransaction()
							                   )),
									failure(output('Build for base file FAILED'));

Build_Key := BadAddresses.Proc_Build_Keys(filedate) : 
							//success(output('Roxie key build successful')),
							success(RoxieKeyBuild.updateversion('BadAddressesKeys',(string)filedate,'randy.reyes@lexisnexisrisk.com, abednego.escobal@lexisnexisrisk.com',,'N')),
							failure(output('roxie key build FAILED'));

orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('Bad Addresses',(string)filedate,'N');

Build_All := 	Sequential(SprayFile, 
											BadAddressesBase, 
											Build_Key,
											orbit_update);
											
Return Build_All;
End;