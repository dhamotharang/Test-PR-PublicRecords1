import doxie, tools;

export Keys(string pversion = '',
            dataset(Layouts.Base.Main)  pBaseMainBuilt  =	Files(pversion).Base.Main.Built	   
            ) := module

	shared pFileKeybuild           				:= Get_File_KeyBuild(pBaseMainBuilt).File_KeyBuild;	
	
	shared BaseMain           						:= Project(pFileKeybuild, Transform({record,maxlength(60000) Layouts_key.Main,unsigned8 __internal_fpos__:=0 end}
																									,self.county	:=	if(left.clean_address.fips_county='' or regexfind('E',left.clean_address.fips_county,nocase),left.county,left.clean_address.fips_county)
																									,self					:=left)
																									);
																									
	shared BaseMain_AccountNumber 				:= dedup(table(Normalize(BaseMain(bank_account_number_1<>'' or bank_account_number_2<>'')
																									,If(left.bank_account_number_2<>'',2,1) 
																									,Transform({Layouts_Key.main,string20 Bank_Account_Number}
																									,self.Bank_Account_Number	:=	Choose(Counter,left.Bank_Account_Number_1,left.Bank_Account_Number_2)
																									,self :=left)
																									),{Bank_Account_Number,classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id,record_id , UID},few),all);	
		
	shared pFileKeyFDNMasterID     				:= File_FDNMasterIDBuild.FDNMasterID;
  shared pFileKeyFDNMasterIDExcl 				:= File_FDNMasterIDBuild.FDNMasterIDExcl;
	shared pFileKeyFDNMasterIDIndTypIncl 	:= File_FDNMasterIDBuild.FdnmasterIdIndTypIncl;
 	shared BaseMain_DID            				:= BaseMain(DID != 0);
  shared BaseMain_Email          				:= BaseMain(Email_Address != '');
	shared BaseMain_Ip             				:= BaseMain(IP_Address != '');
	shared BaseMain_ProfessionalID 				:= BaseMain(Professional_ID != '');
	shared BaseMain_DeviceID       				:= BaseMain(Device_ID != '');
	shared BaseMain_TIN            				:= BaseMain(TIN != '');
	shared BaseMain_NPI            				:= BaseMain(NPI != '');
	shared BaseMain_AppProviderID  				:= BaseMain(Appended_Provider_ID != 0);
	shared BaseMain_LNPID          				:= BaseMain(LNPID != 0);
	shared BaseMain_DriversLicense 				:= BaseMain(drivers_license != '');
	shared BaseMain_BankAccount						:= BaseMain_AccountNumber(bank_account_number!= '');
	// MBS exclusions
	shared MbsIndTypExclusion      				:= project(Files().Input.MbsIndtypeExclusion.Sprayed,Layouts_Key.MbsindtypeExclusion)(status=1);  
	shared MbsProdutInclude        				:= project(Files().Input.MbsProductInclude.Sprayed,Layouts_Key.MbsProductInclude)(status=1);  
	shared MbsFDNMasterID          				:= project(pFileKeyFDNMasterID,Layouts_Key.FDNMasterID);  
	shared MbsFDNMasterIDExcl      				:= project(pFileKeyFDNMasterIDExcl,Layouts_Key.MbsFdnMasterIdExcl);  
	shared MbsFDNMasterIDIndTypIncl				:= project(pFileKeyFDNMasterIDIndTypIncl,Layouts_Key.MbsFdnMasterIDIndTypeIncl);  
	
 export Main := module
	tools.mac_FilesIndex('BaseMain,{record_id, UID},{BaseMain}',KeyNames(pversion).Main.ID,ID);
	tools.mac_FilesIndex('BaseMain_DID,{DID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.DID,DID);
	tools.mac_FilesIndex('BaseMain_Email,{Email_Address , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.email,email);
	tools.mac_FilesIndex('BaseMain_Ip,{IP_Address , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.IP,IP);
	tools.mac_FilesIndex('BaseMain_ProfessionalID,{Professional_ID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.ProfessionalID,ProfessionalID);
	tools.mac_FilesIndex('BaseMain_DeviceID,{Device_ID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.DeviceID,DeviceID);
	tools.mac_FilesIndex('BaseMain_TIN,{TIN , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.TIN,TIN);
	tools.mac_FilesIndex('BaseMain_NPI,{NPI , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.NPI,NPI);
	tools.mac_FilesIndex('BaseMain_AppProviderID,{Appended_Provider_ID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.AppProviderID,AppProviderID);
	tools.mac_FilesIndex('BaseMain_LNPID,{LNPID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.LNPID,LNPID);
	tools.mac_FilesIndex('BaseMain_DriversLicense,{drivers_license ,drivers_license_state, classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.DriversLicense,DriversLicense);
	tools.mac_FilesIndex('BaseMain_BankAccount,{bank_account_number ,Entity_type_id, Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.BankAccount,BankAccount);
	// MBS exclusions 
	tools.mac_FilesIndex('MbsIndTypExclusion,{fdn_file_info_id},{MbsIndTypExclusion}',KeyNames(pversion).Main.MbsIndTypeExclusion,MbsIndTypeExclusion);
	tools.mac_FilesIndex('MbsProdutInclude,{fdn_file_info_id},{MbsProdutInclude}',KeyNames(pversion).Main.MbsProductInclude,MbsProductInclude);
	tools.mac_FilesIndex('MbsFDNMasterID,{gc_id},{MbsFDNMasterID}',KeyNames(pversion).Main.MbsFDNMasterID,MbsFDNMasterIDKey);
	tools.mac_FilesIndex('MbsFDNMasterIDExcl,{fdn_file_info_id},{MbsFDNMasterIDExcl}',KeyNames(pversion).Main.MbsFDNMasterIDExcl,MbsFDNMasterIDExclKey);
	tools.mac_FilesIndex('MbsFDNMasterIDIndTypIncl,{fdn_file_info_id},{MbsFDNMasterIDIndTypIncl}',KeyNames(pversion).Main.MbsFDNMasterIDIndTypIncl,MbsFDNMasterIDIndTypInclKey);
	
	end; 	
end;
