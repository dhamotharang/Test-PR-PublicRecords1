/*2017-08-15T23:40:28Z (Oscar Barrientos)
PROJOTTO-166
*/
import doxie, tools,FraudShared;

export Keys(
	 string pversion = ''
   ,dataset(FraudShared.Layouts.Base.Main)		      pBaseMainBuilt		  =	Files(pversion).Base.Main.Built	

) := module
  shared pFileKeybuild           				:= Get_File_KeyBuild(pBaseMainBuilt).File_KeyBuild;
	shared pFileKeyFDNMasterID     				:= File_FDNMasterIDBuild.FDNMasterID;
  shared pFileKeyFDNMasterIDExcl 				:= File_FDNMasterIDBuild.FDNMasterIDExcl;
	shared pFileKeyFDNMasterIDIndTypIncl 	:= File_FDNMasterIDBuild.FdnmasterIdIndTypIncl;
 	shared BaseMain                				:= project(pFileKeybuild, FraudShared.Layouts_Key.Main);
	shared BaseMain_DID            				:= BaseMain(DID != 0);
	shared BaseMain_BDID           				:= BaseMain(BDID != 0);
	shared BaseMbs                 				:= BaseMain(classification_Permissible_use_access.fdn_file_info_id != 0);
  shared BaseMain_Email          				:= BaseMain(Email_Address != '');
	shared BaseMain_Ip             				:= BaseMain(IP_Address != '');
	shared BaseMain_ProfessionalID 				:= BaseMain(Professional_ID != '');
	shared BaseMain_DeviceID       				:= BaseMain(Device_ID != '');
	shared BaseMain_TIN            				:= BaseMain(TIN != '');
	shared BaseMain_NPI            				:= BaseMain(NPI != '');
	shared BaseMain_AppProviderID  				:= BaseMain(Appended_Provider_ID != 0);
	shared BaseMain_LNPID          				:= BaseMain(LNPID != 0);
	shared MbsIndTypExclusion      				:= project(Files().Input.MbsIndtypeExclusion.Sprayed,FraudShared.Layouts_Key.MbsindtypeExclusion)(status=1);  
	shared MbsProdutInclude        				:= project(Files().Input.MbsProductInclude.Sprayed,FraudShared.Layouts_Key.MbsProductInclude)(status=1);  
	shared MbsFDNMasterID          				:= project(pFileKeyFDNMasterID,FraudShared.Layouts_Key.FDNMasterID);  
	shared MbsFDNMasterIDExcl      				:= project(pFileKeyFDNMasterIDExcl,FraudShared.Layouts_Key.MbsFdnMasterIdExcl);  
	shared MbsFDNMasterIDIndTypIncl				:= project(pFileKeyFDNMasterIDIndTypIncl,FraudShared.Layouts_Key.MbsFdnMasterIDIndTypeIncl);  

 export Main := module
		tools.mac_FilesIndex('BaseMain,{record_id, UID},{BaseMain}',KeyNames(pversion).Main.ID,ID);
		tools.mac_FilesIndex('BaseMain_DID,{DID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.DID,DID);
		tools.mac_FilesIndex('BaseMain_BDID,{BDID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.BDID,BDID);
	  tools.mac_FilesIndex('BaseMain_Email,{Email_Address , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.email,email);
	  tools.mac_FilesIndex('BaseMain_Ip,{IP_Address , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.IP,IP);
	  tools.mac_FilesIndex('BaseMain_ProfessionalID,{Professional_ID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.ProfessionalID,ProfessionalID);
	  tools.mac_FilesIndex('BaseMain_DeviceID,{Device_ID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.DeviceID,DeviceID);
	  tools.mac_FilesIndex('BaseMain_TIN,{TIN , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.TIN,TIN);
	  tools.mac_FilesIndex('BaseMain_NPI,{NPI , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.NPI,NPI);
	  tools.mac_FilesIndex('BaseMain_AppProviderID,{Appended_Provider_ID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.AppProviderID,AppProviderID);
	  tools.mac_FilesIndex('BaseMain_LNPID,{LNPID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.LNPID,LNPID);
		
    // MBS exclusions 
		tools.mac_FilesIndex('BaseMbs,{classification_Permissible_use_access.fdn_file_info_id},{record_id , UID}',KeyNames(pversion).Main.Mbs,Mbs);
    tools.mac_FilesIndex('MbsIndTypExclusion,{fdn_file_info_id},{MbsIndTypExclusion}',KeyNames(pversion).Main.MbsIndTypeExclusion,MbsIndTypeExclusion);
	  tools.mac_FilesIndex('MbsProdutInclude,{fdn_file_info_id},{MbsProdutInclude}',KeyNames(pversion).Main.MbsProductInclude,MbsProductInclude);
	  tools.mac_FilesIndex('MbsFDNMasterID,{gc_id},{MbsFDNMasterID}',KeyNames(pversion).Main.MbsFDNMasterID,MbsFDNMasterIDKey);
	  tools.mac_FilesIndex('MbsFDNMasterIDExcl,{fdn_file_info_id},{MbsFDNMasterIDExcl}',KeyNames(pversion).Main.MbsFDNMasterIDExcl,MbsFDNMasterIDExclKey);
		tools.mac_FilesIndex('MbsFDNMasterIDIndTypIncl,{fdn_file_info_id},{MbsFDNMasterIDIndTypIncl}',KeyNames(pversion).Main.MbsFDNMasterIDIndTypIncl,MbsFDNMasterIDIndTypInclKey);

	end; 	
end;