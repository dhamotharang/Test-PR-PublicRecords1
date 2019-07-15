import doxie, tools,FraudShared,ut,std,Bank_Routing,IP_Metadata,FraudGovPlatform;

export Keys(
	 string pversion = ''
   ,dataset(FraudShared.Layouts.Base.Main)		      pBaseMainBuilt		  =	Files(pversion).Base.Main.Built	

) := module

	shared pFileKeybuild           				:= Get_File_KeyBuild(pBaseMainBuilt).File_KeyBuild;
	
  shared  layout_hostuser :=record,maxlength(60000) //only used for host & user indexing & will not be part of shared layout. GRP-394,465
					Layouts_Key.Main;
					unsigned8 hash64_host; 
					unsigned8 hash64_user;		
					end;
					
	shared  layout_bankrouting :=record,maxlength(60000) //only used for bank routing indexing & will not be part of shared layout. GRP-447
					Layouts_Key.Main;
					string20 Bank_Routing_Number; 		
					end;
					
	shared  layout_iprange :=record,maxlength(60000) //only used for ip range indexing & will not be part of shared layout. GRP-446
					Layouts_Key.Main;
					unsigned1	octet1;
					unsigned1	octet2;
					unsigned1	octet3;
					unsigned1	octet4;
					end;										
	
	shared BaseMain           						:= Project(pFileKeybuild, Transform(Layouts_key.Main
																									,self.county	:=	if(left.clean_address.fips_county='' or regexfind('E',left.clean_address.fips_county,nocase),left.county,left.clean_address.fips_county)
																									,self					:=left)
																									);
																									
	Shared BaseMain_HostUser 							:= Project(BaseMain
																						,Transform(layout_hostuser 
																							,self.hash64_host		:=if(left.email_address<>'',hash64(STD.Str.ToUpperCase(regexfind('(.*)@(.*)$',left.email_address,2))),0)
																							,self.hash64_user		:=if(left.email_address<>'',hash64(STD.Str.ToUpperCase(regexfind('(.*)@(.*)$',left.email_address,1))),0)
																							,self:=left)
																							);
																																								
  shared BaseMain_RoutingNumber					:= dedup(table(Normalize(BaseMain(Bank_Routing_Number_1<>'' or Bank_Routing_Number_2<>'')
																									,2
																									,Transform(layout_bankrouting
																									,self.Bank_Routing_Number	:=	Choose(Counter,left.Bank_Routing_Number_1,left.Bank_Routing_Number_2)
																									,self					:=left)
																									),{Bank_Routing_Number,classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id,record_id , UID},few),all);																									
  
	shared BaseMain_BankNamePrep					:= Dedup(Join(BaseMain_RoutingNumber,Bank_Routing.key_rtn
																									,left.bank_routing_number=right.routing_number_micr
																										,transform({string50 bank_name,recordof(BaseMain_RoutingNumber)-[bank_routing_number]}
																											,self.Bank_Name :=right.institution_name_abbreviated
																											,self:=left)
																											,left outer),all); 		
  																												
	Export BankNames_JSON									:= Dedup(Table(BaseMain_BankNamePrep(Bank_Name<>''),{Bank_Name},few),all); 	//Json file for webteam GRP_518
	
	shared BaseMain_AccountNumber 				:= dedup(table(Normalize(BaseMain(bank_account_number_1<>'' or bank_account_number_2<>'')
																									,If(left.bank_account_number_2<>'',2,1) 
																									,Transform({Fraudshared.Layouts_Key.main,string20 Bank_Account_Number}
																									,self.Bank_Account_Number	:=	Choose(Counter,left.Bank_Account_Number_1,left.Bank_Account_Number_2)
																									,self :=left)
																									),{Bank_Account_Number,classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id,record_id , UID},few),all);	
	
	//ISP Begin
	
	shared BaseIsp_Tbl										:= Table(BaseMain,{isp,ip_address,classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id,record_id , UID},few);
	
	shared Key_iprecs											:= Normalize(IP_Metadata.Key_IP_Metadata_IPv4(isp_name<>'')
																										,(left.end_octets34-left.beg_octets34) +1
																										,transform({recordof(IP_Metadata.Key_IP_Metadata_IPv4),unsigned8 octets34}
																										,self.octets34	 := (left.beg_octets34 + counter) - 1 ,self:=left));
																																																
	shared BaseIspPrep										:= Project(BaseIsp_Tbl(isp='',ip_address<>'')
																									,transform({recordof(BaseIsp_Tbl), unsigned8 octet1, unsigned8 octet2, unsigned8 octets34}
																									,self.octet1		:= (unsigned8)Std.Str.SplitWords(left.ip_address,'.')[1]
																									,self.octet2		:= (unsigned8)Std.Str.SplitWords(left.ip_address,'.')[2]
																									,self.octets34	:= IP_Metadata._Functions.IPv4toInt(left.ip_address)
																									,self:=left));
																									
	Shared BaseIsp_FromIPKey							:= Join(distribute(Key_iprecs,hash(beg_octet1,beg_octet2,octets34)),distribute(BaseIspPrep,hash(octet1,octet2,octets34))
																								,left.beg_octet1 = right.octet1
																								 and left.beg_octet2 = right.octet2
																								 and left.octets34 =right.octets34
																								,Transform(recordof(BaseIsp_Tbl)
																								,self.isp :=trim(left.isp_name,left,right)
																								,self:=right),right outer,local);
  
	Shared BaseMain_IspPrep								:= Project(BaseIsp_Tbl(isp<>'') + BaseIsp_FromIPKey(isp<>''), Transform(recordof(BaseIsp_Tbl)-[ip_address],self:=left));
	
	Export Isp_JSON												:= Table(BaseMain_IspPrep,{Isp},Isp,few,merge);	//Json file for webteam GRP_519										
																									
// ISP End

//Ip Range Begin 

 layout_iprange triprange(BaseMain l) := transform
				octets := Std.Str.SplitWords(l.ip_address,'.');
				self.octet1	:= (unsigned1)octets[1];
				self.octet2	:= (unsigned1)octets[2];
				self.octet3	:= (unsigned1)octets[3];
				self.octet4	:= (unsigned1)octets[4];
				self:=l;
			end;	
	
	shared BaseMain_IPRangePrep						:= Project(BaseMain(Ip_address<>'',IP_address<>'0.0.0.0'),triprange(left));

// Ip Range End

//Mbs DeltaBase

	shared Mbs_demo	:= FraudGovPlatform.Files().Input.MbsDemoData.Sprayed(status=1,regexfind('DELTA',fdn_file_code,nocase));

	shared Mbs_orig	:= FraudShared.files().input.Mbs.Sprayed(status=1,regexfind('DELTA',fdn_file_code,nocase));

	shared MbsSrt			:= Sort((Mbs_orig + Mbs_demo), fdn_file_info_id,fdn_file_code,gc_id,file_type,ind_type);

	shared MbsRoll			:= Rollup(MbsSrt, Transform(recordof(left),self:=left), fdn_file_info_id,fdn_file_code,gc_id,file_type,ind_type);
	
	shared Base_MbsDeltaBase							:= Join(if(FraudGovPlatform._Flags.UseDemoData,MbsRoll,Mbs_orig)
																							,Files().Input.MbsFdnIndType.Sprayed(status=1)
																							,left.ind_type=right.ind_type
																							,Transform(Layouts_Key.Classification.Permissible_use_access,
																										self.Ind_type_description:=ut.CleanSpacesAndUpper(right.description)
																										,self:=left,self:=[]));

	
	shared pFileKeyFDNMasterID     				:= File_FDNMasterIDBuild.FDNMasterID;
  shared pFileKeyFDNMasterIDExcl 				:= File_FDNMasterIDBuild.FDNMasterIDExcl;
	shared pFileKeyFDNMasterIDIndTypIncl 	:= File_FDNMasterIDBuild.FdnmasterIdIndTypIncl;
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
	shared BaseMain_DriversLicense 				:= BaseMain(drivers_license != '');
	shared BaseMain_BankAccount						:= BaseMain_AccountNumber(bank_account_number!= '');
	shared BaseMain_CityState 						:= BaseMain(clean_address.p_city_name != '' and clean_address.st != '');
	shared BaseMain_Zip				 						:= BaseMain(clean_address.zip != '');
	shared BaseMain_CustomerID 						:= BaseMain(customer_id != '');
	shared BaseMain_County 								:= BaseMain(county != '');
	shared BaseMain_ReportedDate 					:= BaseMain(Reported_Date != '');
	shared BaseMain_SerialNumber 					:= BaseMain(Serial_Number != '');
	shared BaseMain_MACAddress 						:= BaseMain(MAC_Address != '');
	shared BaseMain_Host 									:= BaseMain_HostUser(hash64_host != 0);
	shared BaseMain_User 									:= BaseMain_HostUser(hash64_user != 0);
	shared BaseMain_HouseholdID						:= BaseMain(Household_ID != '');
	shared BaseMain_AmountPaid						:= BaseMain(Amount_Paid != '');
	shared BaseMain_BankRoutingNumber			:= BaseMain_RoutingNumber(Bank_Routing_Number != '');
	shared BaseMain_BankName							:= BaseMain_BankNamePrep(Bank_Name != '');
	shared BaseMain_ISP										:= BaseMain_IspPrep;
	shared BaseMain_IPRange								:= BaseMain_IPRangePrep;
	shared BaseMain_CustomerProgram				:= BaseMain(classification_permissible_use_access.ind_type_description != '');
	shared MbsIndTypExclusion      				:= project(Files().Input.MbsIndtypeExclusion.Sprayed,FraudShared.Layouts_Key.MbsindtypeExclusion)(status=1);  
	shared MbsProdutInclude        				:= project(Files().Input.MbsProductInclude.Sprayed,FraudShared.Layouts_Key.MbsProductInclude)(status=1);  
	shared MbsFDNMasterID          				:= project(pFileKeyFDNMasterID,FraudShared.Layouts_Key.FDNMasterID);  
	shared MbsFDNMasterIDExcl      				:= project(pFileKeyFDNMasterIDExcl,FraudShared.Layouts_Key.MbsFdnMasterIdExcl);  
	shared MbsFDNMasterIDIndTypIncl				:= project(pFileKeyFDNMasterIDIndTypIncl,FraudShared.Layouts_Key.MbsFdnMasterIDIndTypeIncl);  
	shared BaseMbsVelocityRules						:= File_Velocityrules.Velocity_Key;  
	shared BaseMbsFdnIndType        			:= project(Files().Input.MbsFdnIndType.Sprayed,Transform(Layouts_Key.MbsFdnIndType,self.description:=ut.CleanSpacesAndUpper(left.description),self:=left))(status=1);
	shared BaseMbsDeltaBase        				:= Base_MbsDeltaBase;

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
	tools.mac_FilesIndex('BaseMain_DriversLicense,{drivers_license ,drivers_license_state, classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.DriversLicense,DriversLicense);
	tools.mac_FilesIndex('BaseMain_BankAccount,{bank_account_number ,Entity_type_id, Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.BankAccount,BankAccount);
	tools.mac_FilesIndex('BaseMain_CityState,{clean_address.p_city_name, clean_address.st , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.CityState,CityState);		
	tools.mac_FilesIndex('BaseMain_Zip,{clean_address.zip , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.Zip,Zip);		
	tools.mac_FilesIndex('BaseMain_CustomerID,{customer_id , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.CustomerID,CustomerID);		
	tools.mac_FilesIndex('BaseMain_County,{county , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.County,County);		
	tools.mac_FilesIndex('BaseMain_ReportedDate,{reported_date , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.ReportedDate,ReportedDate);		
	tools.mac_FilesIndex('BaseMain_SerialNumber,{serial_number , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.SerialNumber,SerialNumber);		
	tools.mac_FilesIndex('BaseMain_MACAddress,{mac_address , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.MACAddress,MACAddress);		
	tools.mac_FilesIndex('BaseMain_Host,{hash64_host , hash64_user, classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.Host,Host);		
	tools.mac_FilesIndex('BaseMain_User,{hash64_user , hash64_host, classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.User,User);		
	tools.mac_FilesIndex('BaseMain_HouseholdID,{Household_ID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.HouseholdID,HouseholdID);		
	tools.mac_FilesIndex('BaseMain_CustomerProgram,{classification_permissible_use_access.ind_type_description , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.CustomerProgram,CustomerProgram);		
	tools.mac_FilesIndex('BaseMain_AmountPaid,{Amount_Paid , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.AmountPaid,AmountPaid);		
	tools.mac_FilesIndex('BaseMain_BankRoutingNumber,{Bank_Routing_Number , Entity_type_id, Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.BankRoutingNumber,BankRoutingNumber);		
	tools.mac_FilesIndex('BaseMain_BankName,{Bank_Name , Entity_type_id, Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.BankName,BankName);		
	tools.mac_FilesIndex('BaseMain_ISP,{isp , Entity_type_id, Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.Isp,Isp);		
	tools.mac_FilesIndex('BaseMain_IPRange,{octet1, octet2, octet3, octet4, classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.IPRange,IPRange);		
	// MBS exclusions 
	tools.mac_FilesIndex('BaseMbs,{classification_Permissible_use_access.fdn_file_info_id},{record_id , UID}',KeyNames(pversion).Main.Mbs,Mbs);
	tools.mac_FilesIndex('MbsIndTypExclusion,{fdn_file_info_id},{MbsIndTypExclusion}',KeyNames(pversion).Main.MbsIndTypeExclusion,MbsIndTypeExclusion);
	tools.mac_FilesIndex('MbsProdutInclude,{fdn_file_info_id},{MbsProdutInclude}',KeyNames(pversion).Main.MbsProductInclude,MbsProductInclude);
	tools.mac_FilesIndex('MbsFDNMasterID,{gc_id},{MbsFDNMasterID}',KeyNames(pversion).Main.MbsFDNMasterID,MbsFDNMasterIDKey);
	tools.mac_FilesIndex('MbsFDNMasterIDExcl,{fdn_file_info_id},{MbsFDNMasterIDExcl}',KeyNames(pversion).Main.MbsFDNMasterIDExcl,MbsFDNMasterIDExclKey);
	tools.mac_FilesIndex('MbsFDNMasterIDIndTypIncl,{fdn_file_info_id},{MbsFDNMasterIDIndTypIncl}',KeyNames(pversion).Main.MbsFDNMasterIDIndTypIncl,MbsFDNMasterIDIndTypInclKey);
	tools.mac_FilesIndex('BaseMbsVelocityRules,{gc_id},{BaseMbsVelocityRules}',KeyNames(pversion).Main.MbsVelocityRules,MbsVelocityRules);
	tools.mac_FilesIndex('BaseMbsFdnIndType,{description},{BaseMbsFdnIndType}',KeyNames(pversion).Main.MbsFdnIndType,MbsFdnIndType);
	tools.mac_FilesIndex('BaseMbsDeltaBase,{gc_id,ind_type},{BaseMbsDeltaBase}',KeyNames(pversion).Main.MbsDeltaBase,MbsDeltaBase);

	end; 	
end;