import FraudShared, Anonymizer, Address,Std;
EXPORT Anonymize  := Module

	Shared nodes				:= thorlib.nodes();	

	Shared Sources_To_Anonymize := FraudGovPlatform.Files().Input.SourcesToAnonymize.Sprayed;
	
	Shared Base_Orig	:= FraudGovPlatform.Files().base.main_orig.qa;
	
	Export Ciid(dataset(Layouts.ciid) pCiidFile)		:= Module
		
		//get file_info_id for a ciid pii from the main base
		
		shared ciid_source		:= Join(Base_Orig	,	pCiidfile	,
																	left.did											=	(unsigned6)right.did
															and left.cleaned_name.fname				=	right.fname
															and left.cleaned_name.mname 			=	right.mname									
															and left.cleaned_name.lname				=	right.lname									
															and left.cleaned_name.name_suffix =	right.suffix
															and left.clean_address.prim_name	=	right.prim_name							
															and left.clean_address.prim_range	= right.prim_range	
															and left.clean_address.sec_range	= right.sec_range
															and left.clean_address.st					= right.st
															and left.clean_address.zip				=	right.z5
															and left.ssn											=	right.ssn									
															and left.dob											=	right.dob
															and left.drivers_license					=	right.dl_number
															and left.drivers_license_state		=	right.dl_state
															and left.clean_phones.phone_number=	right.phone10
															and left.clean_phones.work_phone	=	right.wphone10
															and left.ip_address								= right.ip_address	
														,Transform({Layouts.Ciid,unsigned6	fdn_file_info_id }
														,self.fdn_file_info_id	:= left.classification_Permissible_use_access.fdn_file_info_id
														,self	:=right));
		
		shared anonymizeSources := join ( ciid_source,
													Sources_To_Anonymize,
													left.fdn_file_info_id = right.fdn_file_info_id,
													transform(recordof(left), self := left;),
													inner,
													LOOKUP);
													
		anonymize_Input	:= Project(anonymizeSources,FraudGovPlatform.Layouts.ciid);
													
		anonymizePerson :=Anonymizer.mac_AnonymizePerson(anonymize_Input,fname,lname);
		anonymizePerson1 :=Anonymizer.mac_AnonymizePerson(anonymizePerson,,,,ssn,dob,,phone10,email_address);
		anonymizePerson2 :=Anonymizer.mac_AnonymizePerson(anonymizePerson1,verfirst,verlast);
		anonymizePerson3 :=Anonymizer.mac_AnonymizePerson(anonymizePerson2,,,,verssn,verdob,,verhphone);
		anonymizePerson4 :=Anonymizer.mac_AnonymizePerson(anonymizePerson3,current_fname,current_lname);
		anonymizePerson5 :=Anonymizer.mac_AnonymizePerson(anonymizePerson4,phone_fname,phone_lname);
		anonymizePerson6 :=Anonymizer.mac_AnonymizePerson(anonymizePerson5,,,,,,,name_addr_phone);
		anonymizeAddress :=Anonymizer.macAnonymizeAddress(anonymizePerson6,prim_range,predir,prim_name
											,addr_suffix,postdir,unit_desig,sec_range,p_city_name,,st,z5,zip4,county,geo_blk,lat,long);									
		anonymizeAddress1 :=Anonymizer.macAnonymizeAddress(anonymizeAddress,,,,,,,,vercity,,verstate,verzip,verzip4,vercounty);
		anonymizeAddress2 :=Anonymizer.macAnonymizeAddress(anonymizeAddress1,,,,,,,,chron_city_2,,chron_st_2,chron_zip_2,chron_zip4_2);
		anonymizeAddress3 :=Anonymizer.macAnonymizeAddress(anonymizeAddress2,,,,,,,,chron_city_3,,chron_st_3,chron_zip_3,chron_zip4_3);									

		FraudGovplatform.Layouts.ciid		TrAddress(anonymizeAddress3 l)	:=	Transform
																			self.in_streetaddress :=ut.CleanSpacesAndUpper(trim(l.prim_range)+' '+
																																										 trim(l.predir) +' '+
																																										 trim(l.prim_name)+' '+
																																										 trim(l.addr_suffix)+' '+
																																										 trim(l.postdir)+' '+
																																										 trim(l.unit_desig)+' '+
																																										 trim(l.sec_range));
																			self.in_city					:= l.p_city_name;
																			self.in_state					:= l.st;
																			self.in_zipcode				:= l.z5;
																			self									:= l;
																			end;
																																										 
																																										 
		shared ciid_anonymized	:= Project(anonymizeAddress3,TrAddress(left));
		
		shared Ciid_orig 			:= join(ciid_source,
																	anonymizeSources,
																	left =right
																	,transform(Layouts.ciid, self := left),
																	left only);
											
		export all				:= ciid_anonymized + ciid_orig;						
																																										 
	End;
	
	Export Death	(dataset(Layouts.death) pDeathFile)	:= Module
		
	//get file_info_id for a ciid pii from the base
		
		death_source		:= Join(Base_Orig,	pDeathFile,
													left.did											=(unsigned6)right.did
											and left.cleaned_name.fname				=	right.fname
											// and left.cleaned_name.mname 			=	right.mname									
											and left.cleaned_name.lname				=	right.lname									
											// and left.cleaned_name.name_suffix =	right.name_suffix
											// and left.clean_address.prim_name	=	right.prim_name							
											// and left.clean_address.prim_range	= right.prim_range	
											// and left.clean_address.sec_range	= right.sec_range
											// and left.clean_address.st					= right.st
											// and left.clean_address.zip				=	right.zip
											and left.ssn											= right.ssn
											and left.dob											=	right.dob8
											,Transform({FraudGovPlatform.Layouts.death,unsigned6	fdn_file_info_id }
												,self.fdn_file_info_id	:=left.classification_Permissible_use_access.fdn_file_info_id
												,self	:=right));
		
		anonymizeSources := join ( death_source,
													Sources_To_Anonymize,
													left.fdn_file_info_id = right.fdn_file_info_id,
													transform(recordof(left), self := left;),
													inner,
													LOOKUP);
													
		anonymize_Input	:= Project(anonymizeSources,FraudGovPlatform.Layouts.death);
													
		anonymizePerson :=Anonymizer.mac_AnonymizePerson(anonymize_Input,fname,lname);
		anonymizePerson1 :=Anonymizer.mac_AnonymizePerson(anonymizePerson,,,,ssn,dob8);
		anonymizePerson2 :=Anonymizer.mac_AnonymizePerson(anonymizePerson1,,,,,dod8);
		anonymizeAddress :=Anonymizer.macAnonymizeAddress(anonymizePerson2,prim_range,predir,prim_name
												,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,county_name);

		death_anonymized		:= project(anonymizeAddress,transform(recordof(anonymizeAddress)
												,self.dob8 := if(left.dod8<>'00000000' and left.dod8<>'' and left.dod8<left.dob8 ,left.dod8,left.dob8)
												,self.dod8 := if(left.dod8<>'00000000' and left.dod8<>'' and left.dod8<left.dob8 ,left.dob8,left.dod8)
												,self:=left));
												
		death_orig 			:= join(death_source,
											anonymizeSources,
											left =right
											,transform(Layouts.death, self := left),
											left only); 
											
		export all	:= death_anonymized + death_orig;
																																										 
	End;
	
End;