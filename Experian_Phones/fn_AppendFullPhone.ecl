import Gong,Phonesplus_v2,PhoneMart,ExperianCred,watchdog;
EXPORT fn_AppendFullPhone(dataset(recordof(layouts.base)) ExperianBase) := Function
//***********************************************************************************************************************************
//*********Process : Append full phone inhouse from phonesplus,Gong,Equifax and possibly best file
//*********Step1 Get the address from ExperianCredFile 
//*********Step2 Combine phoneplus,Gong, and equifax records and get the latest phone for each did.
//*********Step3 Using DID and last three phone digits get the full phone 
//*********Step4 For the records with no did or no full phone after did match use address to get the full phone from three files.
//***********************************************************************************************************************************
tempbase:= record
  Layouts.base;	
	//string10  fullphone:='';
	string10  prim_range;
  string28  prim_name;
  string10  unit_desig;
  string8   sec_range;
  string25  p_city_name;
  string5   zip;
end;

// ExperianBase:=Experian_Phones.Files.base;

GongFile:=Gong.File_History;
PhonesPlusFile:=Phonesplus_v2.File_Phonesplus_Base; 
PhoneMartFile :=PhoneMart.Files.base;
ExperianCredFile:=ExperianCred.Files.Base_File_Out;

file_best_withdid := distribute(Watchdog.File_Best(did <> 0),HASH(did));

AppendAddress     := join(distribute(ExperianBase,hash(Encrypted_Experian_PIN)),
                          distribute(ExperianCredFile(current_rec_flag=1),hash(Encrypted_Experian_PIN)),
													left.Encrypted_Experian_PIN=right.Encrypted_Experian_PIN,
													transform(tempbase,self.prim_name  :=right.prim_name;
													                  self.prim_range :=right.prim_range;
													 								  self.unit_desig :=right.unit_desig;
																						self.sec_range  :=right.sec_range;
																						self.p_city_name:=right.p_city_name;
																						self.zip        :=right.zip;self:=left; ), left outer,local):INDEPENDENT;
ExperianWithDID   :=AppendAddress(did<>0);
ExperianWithoutDID:=AppendAddress(did=0);

Slim_layout := record
			unsigned6 did:=0;
			string10  phone:='';
			string3   phone_digits:='';
      unsigned3 dt_last_seen;
			string1   curr_flag;
			string3   src;
      string10  prim_range;
      string28  prim_name;
      string10  unit_desig;
      string8   sec_range;
      string25  p_city_name;
      string5   zip;
end;
    /*********************************Inputs********************************/
		//1Phones plus records
		PhonesPlusds      := project(PhonesPlusFile(cellphone<>''),transform({Slim_layout},
		                                                                         self.phone       := left.cellphone;
		                                                                         self.phone_digits:= left.cellphone[8..10];
																														                 self.did         := left.did;
																														                 self.dt_last_seen:= left.DateLastSeen;
																														                 self.src         := 'PP';
 																																						 self.curr_flag   :=  MAP(left.current_rec =true =>'Y','N');
																																						 self.prim_range  := left.prim_range;
																																						 self.prim_name   := left.prim_name;
																																						 self.unit_desig  := left.unit_desig;
																																						 self.sec_range   := left.sec_range;
																																						 self.p_city_name := left.p_city_name;
																																						 self.zip         := left.zip5;
																														                 self := [])) :INDEPENDENT;																																									 

		//2Gong Records																																							
    Gongds            :=	project(GongFile(phone10<>''),transform({Slim_layout},self.phone       := left.phone10;
											                                                          self.phone_digits:= left.phone10[8..10];
																															                  self.did         := left.did;
																																								self.dt_last_seen:= (unsigned3)left.dt_last_seen;
																																								self.curr_flag   :=  MAP(left.current_record_flag ='Y' =>'Y','N');
																															                  self.src         := 'GNG';
																																								self.prim_range  := left.prim_range;
																																						    self.prim_name   := left.prim_name;
																																						    self.unit_desig  := left.unit_desig;
																																						    self.sec_range   := left.sec_range;
																																						    self.p_city_name := left.p_city_name;
																																						    self.zip         := left.z5;
																															                  self := [])):INDEPENDENT;
																																		 
		//3Equifax
		Equifaxds		      := project(PhoneMartFile(phone<>''),transform({Slim_layout},self.phone       := left.phone;
		                                                                              self.phone_digits:= left.phone[8..10];
																																									self.dt_last_seen:= left.dt_last_seen;
																																									self.curr_flag   :=  MAP(left.HISTORY_FLAG ='Y' =>'N','Y');
																															                  	self.prim_range  := '';
																																						      self.prim_name   := '';
																																						      self.unit_desig  := '';
																																						      self.sec_range   := '';
																																						      self.p_city_name := '';
																																						      self.zip         := '';
																           						                            self             := []));
																																														
		All_phones        := (PhonesPlusds+Gongds+Equifaxds) :INDEPENDENT; //for did match
		PhonesplusGong    := (PhonesPlusds+Gongds) :INDEPENDENT; //for address match
		
		MostCur_phonesWDid:= dedup(sort(distribute(All_phones(did <> 0),hash(did,phone_digits)),
		                                           did,phone_digits,-curr_flag,-dt_last_seen,local),
																							 did,phone_digits,local);//:persist('~thor_400::persist::DIDFullphonesSet');
		
		MostCur_phonesWAdd:= dedup(sort(distribute(PhonesplusGong(did = 0 and zip <> ''),hash(prim_name,prim_range,unit_desig,sec_range,p_city_name,zip,phone_digits)),
		                                           prim_name,prim_range,unit_desig,sec_range,p_city_name,zip,phone_digits,-curr_flag,-dt_last_seen,local),
																							 prim_name,prim_range,unit_desig,sec_range,p_city_name,zip,phone_digits,local);//:persist('~thor_400::persist::AddressFullphonesSet');



   MatchDID          :=join(distribute(ExperianWithDID,hash(did,phone_digits)),MostCur_phonesWDid,
												     left.did=right.did and left.Phone_digits=right.phone_digits,
												     transform(tempbase,self.fullphone:=right.phone;self:=left;),left outer, local):persist('~thor_400::persist::MatchDID');



   MatchDIDFinal     := join(MatchDID,file_best_withdid,
	                           left.did = right.did and left.Phone_digits=right.phone[8..10],
                             transform(tempbase,self.fullphone:=if(left.fullphone='',right.phone,left.fullphone);self:=left;),left outer ,local) :persist('~thor_400::persist::MatchDIDBEST');


										
   ContinueAdd:=ExperianWithoutDID+MatchDIDFinal(fullphone='');

   AddressMatchCandidates:=ContinueAdd(zip<>'');
   Experian_withnoaddress:=ContinueAdd(zip='');

	

															
   MatchAddrFinal    := join(distribute(AddressMatchCandidates,hash(prim_name,prim_range,unit_desig,sec_range,p_city_name,zip,phone_digits)),
                        MostCur_phonesWAdd,
												left.prim_name   = right.prim_name and 
												left.prim_range  = right.prim_range and 
												left.unit_desig  = right.unit_desig and 
												left.sec_range   = right.sec_range and 
												left.p_city_name = right.p_city_name and 
												left.zip         = right.zip and 
												left.Phone_digits= right.phone_digits,
												transform(tempbase,self.fullphone:=if(left.fullphone='',right.phone,left.fullphone);self:=left;),left outer, local);



FinalList:=MatchAddrFinal+MatchDIDFinal(fullphone<>'')+Experian_withnoaddress;

// output(count(ExperianBase),named('TotalExperianBase'));
// output(count(WithDID+WithoutDID),named('TotalExperianBaseWithAddress'));
// output(count(WithDID),named('TotalExperianBaseWithDID'));
// output(All_phones(did in [658625236,20]));
// output(MostCur_phoneswdid(did in [658625236,20]));
// output(count(MatchDID),named('TotalRecordsMatchDID'));
// output(count(MatchDID(fullphone <> '')),named('PostMatchDID_fullphonecnt'));															
// output(MatchDID(did in [658625236,20])); 
// output(count(MatchDIDFinal),named('TotalDIDRecordsAfterBestMatch'));
// output(count(MatchDIDFinal(fullphone <> '')),named('PostMatchBest_fullphonecnt'));		
// output(count(WithAdd)   ,named('TotAddrrecsgoingintoaddressmatch'));
// output(count(WithoutAdd),named('TotRecsWithoutAdd'));	
// output(count(MatchAddress),named('totrecsAfteraddressmatch'));
// output(Count(MatchAddress(fullphone<>'')+MatchDIDFinal(fullphone<>'')),named('AfterallmatchesFullPhonecnt'));
// output(count(FinalList),named('TotalRecordsAfter'));
return FinalList;

End;