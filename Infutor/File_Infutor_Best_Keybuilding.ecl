import _Control, Data_Services, Doxie, Infutor, Mdr, Std, ut;

file_best 		:= PROJECT(Infutor.file_infutor_best(did > 0), infutor.Layout_infutor_best_DID);
addGlobalSID 	:= mdr.macGetGlobalSID(file_best,'Infutor','','global_sid'); //DF-26401: Populate Global_SID Field

EXPORT File_Infutor_Best_Keybuilding := addGlobalSID;