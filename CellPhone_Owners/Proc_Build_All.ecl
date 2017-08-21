Import versioncontrol,Lib_FileServices, STRATA, ut;

Export Proc_Build_All(String Filedate) := Function
BaseFile:= Proc_Build_Base;
ut.MAC_SF_BuildProcess(BaseFile, '~thor_data400::base::CellPhoneOwners', CellPhoneOwnerBase, 3, false, true);
filename := FileServices.GetSuperFileSubName('~thor_data400::base::CellPhoneOwners',1,true);

Build_Base := CellPhoneOwnerBase : success(
									sequential(
										output('Build for base file successful'),
										fileServices.StartSuperFileTransaction(),
										fileServices.ClearSuperFile('~thor_data400::base::CellPhoneOwners',true),
										fileServices.AddSuperFile('~thor_data400::base::CellPhoneOwners',filename),
										fileServices.FinishSuperFileTransaction()
							                   )),
									failure(output('Build for base file FAILED'));
Build_Stats	:= Out_Base_Stats_Population(Filedate);
Build_All := Sequential(Build_Base,
										Build_Stats);
Return Build_All;
End;