import Anonymizer, Address,Std;
EXPORT Anonymize  := Module

	Shared nodes				:= thorlib.nodes();	

	Shared Sources_To_Anonymize := FraudGovPlatform.Files().CustomerSettings( fdn_file_info_id > 0 and Anonymize_Data = true );
	
	Export Death	(dataset(Layouts.death) pDeathFile)	:= Module

		anonymizeSources := join ( pDeathFile,
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
												
		death_orig 			:= join(pDeathFile,
											anonymizeSources,
											left =right
											,transform(Layouts.death, self := left),
											left only); 
											
		export all	:= death_anonymized + death_orig;
																																										 
	End;
	
	Export Crim(dataset(Layouts.crim) pCrimFile)		:= Module
		
	shared anonymizeSources := join ( pCrimFile,
													Sources_To_Anonymize,
													left.fdn_file_info_id = right.fdn_file_info_id,
													transform(recordof(left), self := left;),
													inner,
													LOOKUP);
													
		anonymize_Input	:= Project(anonymizeSources,FraudGovPlatform.Layouts.crim);
													
			anonymizePerson :=Anonymizer.mac_AnonymizePerson(anonymize_Input,fname,lname);
		anonymizePerson1 :=Anonymizer.mac_AnonymizePerson(anonymizePerson,,,,ssn,dob);
		anonymizeAddress :=Anonymizer.macAnonymizeAddress(anonymizePerson1,prim_range,predir,prim_name
											,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip5,zip4);									
			
		FraudGovplatform.Layouts.crim		TrAddress(anonymizeAddress l)	:=	Transform
																			self.street_address_1 :=ut.CleanSpacesAndUpper(trim(l.prim_range)+' '+
																																										 trim(l.predir) +' '+
																																										 trim(l.prim_name)+' '+
																																										 trim(l.addr_suffix)+' '+
																																										 trim(l.postdir)+' '+
																																										 trim(l.unit_desig)+' '+
																																										 trim(l.sec_range));
																			self.street_address_3	:= l.p_city_name;
																			self.street_address_4	:= l.st;
																			self.street_address_5	:= l.zip5;
																			self									:= l;
																			end;
																																										 
																																										 
		shared crim_anonymized	:= Project(anonymizeAddress,TrAddress(left));
		
		shared Crim_orig 			:= join(pCrimFile,
																	anonymizeSources,
																	left =right
																	,transform(Layouts.crim, self := left),
																	left only);
											
		export all				:= crim_anonymized + Crim_orig;						
																																										 
	End;
	
End;