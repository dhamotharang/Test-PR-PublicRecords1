import tools,FraudgovKEL,ut,std,Bank_Routing,IP_Metadata;

export Keys(
	 string pversion = ''
	 ,dataset(FraudGovPlatform.Layouts.Base.Main)		      pBaseMainBuilt		  =	FraudGovPlatform.Files(pversion).Base.Main.Built	

) := module
	shared pFileKeybuild           				:= File_KeyBuild(pBaseMainBuilt);
	
	shared Base_EntityProfile							:= PROJECT(FraudgovKEL.KEL_PivotIndexPrep.ds_KEL_PivotIndexPrep(aotcurrprofflag=1)
																											,Transform(Layouts_Key.EntityProfile
																											,self.entitycontextuid :=left.entitycontextuid,self:=left));	
	shared Base_ConfigAttributes					:= PROJECT(Files().Input.ConfigAttributes.Sprayed
																							,Transform(Layouts_Key.ConfigAttributes
																								,self.entitytype	:= (integer8)left.entitytype
																								,self.field	:= (string200)left.field
																								,self.low:=(decimal)left.low
																								,self.high:=(decimal)left.high
																								,self.risklevel	:=(integer)left.risklevel
																								,self.weight	:=(integer)left.weight
																								,self.customerid	:=(unsigned)left.customerid
																								,self.industrytype	:=(unsigned)left.industrytype
																								,Self:=left));
	shared Base_ConfigRules								:= PROJECT(Files().Input.ConfigRules.Sprayed,Transform(Layouts_Key.ConfigRules,Self:=left));
	shared Base_DisposableEmailDomains 					:= PROJECT(Files().Base.DisposableEmailDomains.Built,
	Transform(FraudGovPlatform.Layouts_Key.DisposableEmailDomains,	Self:=left	));
	
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
					unsigned1	digit1;
					unsigned1	digit2;
					unsigned1	digit3;
					unsigned1	digit4;
					unsigned1	digit5;
					unsigned1	digit6;
					unsigned1	digit7;
					unsigned1	digit8;
					unsigned1	digit9;
					unsigned1	digit10;
					unsigned1	digit11;
					unsigned1	digit12;
					end;										
	
	shared BaseMain           						:= Project(pFileKeybuild, Transform({record,maxlength(60000) Layouts_key.Main,unsigned8 __internal_fpos__:=0 end}
																									,self.county	:=	if(left.clean_address.fips_county='' or regexfind('E',left.clean_address.fips_county,nocase),left.county,left.clean_address.fips_county)
																									,self					:=left)
																									);
																									
	Shared BaseMain_HostUser 							:= Project(BaseMain
																						,Transform(layout_hostuser 
																							,self.hash64_host		:=if(regexfind('(.*)@(.*)$',left.email_address,2)<>'',hash64(STD.Str.ToUpperCase(regexfind('(.*)@(.*)$',left.email_address,2))),0)
																							,self.hash64_user		:=if(regexfind('(.*)@(.*)$',left.email_address,1)<>'',hash64(STD.Str.ToUpperCase(regexfind('(.*)@(.*)$',left.email_address,1))),0)
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
  																												
 shared BaseMain_AccountNumber 				:= dedup(table(Normalize(BaseMain(bank_account_number_1<>'' or bank_account_number_2<>'')
																									,If(left.bank_account_number_2<>'',2,1) 
																									,Transform({Layouts_Key.main,string20 Bank_Account_Number}
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
																		
// ISP End

//Ip Range Begin 
LEADING_ZERO_FILL := 1;
OCTECT_WIDTH := 3;

 layout_iprange triprange(BaseMain l) := transform

				octects := Std.Str.SplitWords(l.ip_address,'.');

				octect1 := intformat( (unsigned1) octects[1],OCTECT_WIDTH,LEADING_ZERO_FILL) ;
				octect2 := intformat( (unsigned1) octects[2],OCTECT_WIDTH,LEADING_ZERO_FILL) ;
				octect3 := intformat( (unsigned1) octects[3],OCTECT_WIDTH,LEADING_ZERO_FILL) ;
				octect4 := intformat( (unsigned1) octects[4],OCTECT_WIDTH,LEADING_ZERO_FILL) ;

				self.digit1	:= (unsigned1)octect1[1];
				self.digit2	:= (unsigned1)octect1[2];
				self.digit3	:= (unsigned1)octect1[3];

				self.digit4	:= (unsigned1)octect2[1];
				self.digit5	:= (unsigned1)octect2[2];
				self.digit6	:= (unsigned1)octect2[3];

				self.digit7	:= (unsigned1)octect3[1];
				self.digit8	:= (unsigned1)octect3[2];
				self.digit9	:= (unsigned1)octect3[3];

				self.digit10:= (unsigned1)octect4[1];
				self.digit11:= (unsigned1)octect4[2];
				self.digit12:= (unsigned1)octect4[3];
				self:=l;
			end;	
	
	shared BaseMain_IPRangePrep						:= Project(BaseMain(Ip_address<>'',IP_address<>'0.0.0.0'),triprange(left));

// Ip Range End

	shared pFileKeyFDNMasterID     				:= File_FDNMasterIDBuild.FDNMasterID;
  shared pFileKeyFDNMasterIDExcl 				:= File_FDNMasterIDBuild.FDNMasterIDExcl;
	shared pFileKeyFDNMasterIDIndTypIncl 	:= File_FDNMasterIDBuild.FdnmasterIdIndTypIncl;
 	shared BaseMain_DID            				:= BaseMain(DID != 0);
	shared BaseMain_Email          				:= BaseMain(Email_Address != '');
	shared BaseMain_DeviceID       				:= BaseMain(Device_ID != '');
	shared BaseMain_DriversLicense 				:= BaseMain(drivers_license != '');
	shared BaseMain_BankAccount						:= BaseMain_AccountNumber(bank_account_number!= '');
	shared BaseMain_CityState 						:= BaseMain(clean_address.p_city_name != '' and clean_address.st != '');
	shared BaseMain_Zip				 						:= BaseMain(clean_address.zip != '');
	shared BaseMain_CustomerID 						:= BaseMain(customer_id != '');
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
	shared MbsIndTypExclusion      				:= project(Files().Input.MbsIndtypeExclusion.Sprayed,Layouts_Key.MbsindtypeExclusion)(status=1);  
	shared MbsProdutInclude        				:= project(Files().Input.MbsProductInclude.Sprayed,Layouts_Key.MbsProductInclude)(status=1);  
	shared MbsFDNMasterID          				:= project(pFileKeyFDNMasterID,Layouts_Key.FDNMasterID);  
	shared MbsFDNMasterIDExcl      				:= project(pFileKeyFDNMasterIDExcl,Layouts_Key.MbsFdnMasterIdExcl);  
	shared MbsFDNMasterIDIndTypIncl				:= project(pFileKeyFDNMasterIDIndTypIncl,Layouts_Key.MbsFdnMasterIDIndTypeIncl);  
	shared BaseMbsFdnIndType        			:= project(Files().Input.MbsFdnIndType.Sprayed,Transform(Layouts_Key.MbsFdnIndType,self.description:=ut.CleanSpacesAndUpper(left.description),self:=left))(status=1);
	
 export Main := module
	tools.mac_FilesIndex('BaseMain,{record_id, UID},{BaseMain}',KeyNames(pversion).Main.ID,ID);
	tools.mac_FilesIndex('BaseMain_DID,{DID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.DID,DID);
	tools.mac_FilesIndex('BaseMain_Email,{Email_Address , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.email,email);
	tools.mac_FilesIndex('BaseMain_DeviceID,{Device_ID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.DeviceID,DeviceID);
	tools.mac_FilesIndex('BaseMain_DriversLicense,{drivers_license ,drivers_license_state, classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.DriversLicense,DriversLicense);
	tools.mac_FilesIndex('BaseMain_BankAccount,{bank_account_number ,Entity_type_id, Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.BankAccount,BankAccount);
	tools.mac_FilesIndex('BaseMain_CityState,{clean_address.p_city_name, clean_address.st , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.CityState,CityState);		
	tools.mac_FilesIndex('BaseMain_Zip,{clean_address.zip , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.Zip,Zip);		
	tools.mac_FilesIndex('BaseMain_CustomerID,{customer_id , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.CustomerID,CustomerID);		
	tools.mac_FilesIndex('BaseMain_ReportedDate,{reported_date , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.ReportedDate,ReportedDate);		
	tools.mac_FilesIndex('BaseMain_SerialNumber,{serial_number , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.SerialNumber,SerialNumber);		
	tools.mac_FilesIndex('BaseMain_MACAddress,{mac_address , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.MACAddress,MACAddress);		
	tools.mac_FilesIndex('BaseMain_Host,{hash64_host , hash64_user, classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.Host,Host);		
	tools.mac_FilesIndex('BaseMain_User,{hash64_user , hash64_host, classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.User,User);		
	tools.mac_FilesIndex('BaseMain_HouseholdID,{Household_ID , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.HouseholdID,HouseholdID);		
	tools.mac_FilesIndex('BaseMain_AmountPaid,{Amount_Paid , classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.AmountPaid,AmountPaid);		
	tools.mac_FilesIndex('BaseMain_BankRoutingNumber,{Bank_Routing_Number , Entity_type_id, Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.BankRoutingNumber,BankRoutingNumber);		
	tools.mac_FilesIndex('BaseMain_BankName,{Bank_Name , Entity_type_id, Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.BankName,BankName);		
	tools.mac_FilesIndex('BaseMain_ISP,{isp , Entity_type_id, Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.Isp,Isp);		
	tools.mac_FilesIndex('BaseMain_IPRange,{digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8, digit9, digit10, digit11, digit12, classification_Entity.Entity_type_id, classification_Entity.Entity_sub_type_id},{record_id , UID}',KeyNames(pversion).Main.IPRange,IPRange);		
	// MBS exclusions 
	tools.mac_FilesIndex('MbsIndTypExclusion,{fdn_file_info_id},{MbsIndTypExclusion}',KeyNames(pversion).Main.MbsIndTypeExclusion,MbsIndTypeExclusion);
	tools.mac_FilesIndex('MbsProdutInclude,{fdn_file_info_id},{MbsProdutInclude}',KeyNames(pversion).Main.MbsProductInclude,MbsProductInclude);
	tools.mac_FilesIndex('MbsFDNMasterID,{gc_id},{MbsFDNMasterID}',KeyNames(pversion).Main.MbsFDNMasterID,MbsFDNMasterIDKey);
	tools.mac_FilesIndex('MbsFDNMasterIDExcl,{fdn_file_info_id},{MbsFDNMasterIDExcl}',KeyNames(pversion).Main.MbsFDNMasterIDExcl,MbsFDNMasterIDExclKey);
	tools.mac_FilesIndex('MbsFDNMasterIDIndTypIncl,{fdn_file_info_id},{MbsFDNMasterIDIndTypIncl}',KeyNames(pversion).Main.MbsFDNMasterIDIndTypIncl,MbsFDNMasterIDIndTypInclKey);
	tools.mac_FilesIndex('BaseMbsFdnIndType,{description},{BaseMbsFdnIndType}',KeyNames(pversion).Main.MbsFdnIndType,MbsFdnIndType);

	tools.mac_FilesIndex('Base_EntityProfile,{customerid,industrytype,entitycontextuid},{Base_EntityProfile}',KeyNames(pversion).Main.EntityProfile,EntityProfile);
	tools.mac_FilesIndex('Base_ConfigAttributes,{Field, EntityType, CustomerId, IndustryType,value},{Base_ConfigAttributes}',KeyNames(pversion).Main.ConfigAttributes,ConfigAttributes);
	tools.mac_FilesIndex('Base_ConfigRules,{CustomerId, IndustryType, Field, EntityType,rulename},{Base_ConfigRules}',KeyNames(pversion).Main.ConfigRules,ConfigRules);
	tools.mac_FilesIndex('Base_DisposableEmailDomains,{domain},{dispsblemail}',KeyNames(pversion).Main.DisposableEmailDomains,DisposableEmailDomains);
	end; 	
end;