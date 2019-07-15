import ut,tools, NID, Address, did_Add;

export Build_Base_Erie ( 
   string pversion
	,dataset(Layouts.Base.ERIE)  inBaseERIE   = Files().Base.ERIE.QA
	,dataset(Layouts.Input.ERIE) inERIEUpdate = Files().Input.ERIE.Sprayed
	,boolean                     UpdateERIE   = FraudDefenseNetwork._Flags.Update.ERIE
) := 
module 
#OPTION('multiplePersistInstances',FALSE);
	FraudDefenseNetwork.Functions.CleanFields(inERIEUpdate ,inERIEUpdateUpper); 

	FraudDefenseNetwork.Layouts.Base.Erie 	tPrep(Layouts.Input.Erie	pInput)	:=
	transform
				
           self.process_date                    := (unsigned) pversion, 
						self.Unique_Id                       := 0; 
						self.Source                          := 'ERIE'; 
						self.insuredfirstname                := pInput.insuredfname; 
						self.insuredlastname                 := pInput.insuredlname;  
						self.filestatus                      := regexreplace(Constants().special_characters, pInput.filestatus, '');
						self.findings                        := regexreplace(Constants().special_characters, pInput.findings, ''); 
						self.responsibleparty                := regexreplace(Constants().special_characters, pInput.responsibleparty, ''); 
						self.lawenf                          := regexreplace(Constants().special_characters, pInput.lawenf, ''); 
						self.nicb                            := regexreplace(Constants().special_characters, pInput.nicb, ''); 
						self.attorney                        := regexreplace(Constants().special_characters, pInput.attorney, ''); 
						self.lawref                          := regexreplace(Constants().special_characters, pInput.lawref, ''); 
						self.dateofloss                      := Functions.fHypenYMDtoCYMD(pInput.dateofloss); 
						self.dateofreferral                  := Functions.fHypenYMDtoCYMD(pInput.dateofreferral);
						self.datelogged                      := Functions.fHypenYMDtoCYMD(pInput.datelogged); 
						self.dateio                          := Functions.fHypenYMDtoCYMD(pInput.dateio); 
						self.dateclosed                      := Functions.fHypenYMDtoCYMD(pInput.dateclosed); 
						self.datereopen                      := Functions.fHypenYMDtoCYMD(pInput.datereopen); 
						self.datecalc                        := Functions.fHypenYMDtoCYMD(pInput.datecalc); 
						self.score                           := (integer)pInput.score; 
						self.validstart                      := pInput.validstart; 
						self.validend                        := pInput.validend;
						self.ffid                            := (unsigned)pInput.ffid; 
						self.ssn                             := if(pInput.ssn = '0', '', pInput.ssn);
						self.dob                             := Functions.fHypenYMDtoCYMD(pInput.dob);
						self.validstart_cp                   := pInput.validstart_cp; 
						self.validend_cp                     := pInput.validend_cp;
						self.idl                             := (unsigned)pInput.idl;
						self.adl                             := (unsigned)pInput.adl;
						self.derived_adl                     := (unsigned)pInput.derived_adl;
						self.master_party_id                 := (unsigned)pInput.master_party_id;
						self.party_id                        := (unsigned)pInput.party_id;
						self.dt_first_seen                   := (unsigned)Functions.fHypenYMDtoCYMD(pInput.validstart); 
						self.dt_last_seen                    := (unsigned)pversion;
						self.dt_vendor_last_reported         := (unsigned)pversion;
						self.dt_vendor_first_reported        := (unsigned)pversion;	
					  self.current                         := 'C' ;   
           self.address_1                       := Address.Addr1FromComponents(pInput.o_address, '','', '', '', '', '');
           self.address_2                       := Address.Addr2FromComponents(pInput.o_city, pInput.o_state, pInput.o_zip[1..5]);  
						self                                 := pInput; 
						self                                 := []; 
   end;

	 Erie_Proj                                    := project(dedup(inERIEUpdateUpper(claimnumber<>'' and (insuredfname <> '' or insuredlname <>'')),all),tPrep(left));
	 
	 Standardize_Address(Erie_Proj, ErieAddrCleaned);
	 
	 Standardize_Phone(ErieAddrCleaned, telephone_number	,EriePhoneCleaned	,clean_phones.phone_number	,,true);
	 dsEriePhoneCleaned                           :=  EriePhoneCleaned:persist(constants().ErieAddrPhClnPersist);
     	 
   Erie_Individuals                             := dsEriePhoneCleaned(insuredfirstname <> '');  
	 
//Cleaning ERIE SIU Names	 
	 FraudDefenseNetwork.Standardize_Name(Erie_Individuals, insuredfirstname, insuredmiddlename, insuredlastname, insuredsuffixname, ErieCleanName_Siu); 
	 
//Cleaning ERIE Party Names
//Standardize_Name name cannot be used because of the output clean names are coming with "cleaned_name" format which are already used in line62
	 NID.Mac_CleanParsedNames(ErieCleanName_Siu, ErieCleanName_cp, name_first, name_middle, name_last, name_suffix);
	 
	 typeof(ErieCleanName_Siu) CName(ErieCleanName_cp L) := transform
			self.cleaned_name_cp.title                 := L.cln_title;
			self.cleaned_name_cp.fname                 := L.cln_fname;
			self.cleaned_name_cp.mname                 := L.cln_mname;
			self.cleaned_name_cp.lname                 := L.cln_lname;
			self.cleaned_name_cp.name_suffix           := L.cln_suffix;
			self := L;
		END;	
   ErieCleanName_Indiv                           := project(ErieCleanName_cp, CName(LEFT));	 
	 ErieCleanName_Indiv_dist                      := distribute(ErieCleanName_Indiv, hash(claimnumber,cleaned_name.fname,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.fname, cleaned_name_cp.lname));																				 
	 ErieCleanName_Indiv_rmDup                     := dedup(sort(ErieCleanName_Indiv_dist,
	                                                             claimnumber,cleaned_name.fname,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.fname, cleaned_name_cp.lname, -ffid , local),
	                                                        claimnumber,cleaned_name.fname,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.fname, cleaned_name_cp.lname, local);
	
	 Erie_Business                                 := dsEriePhoneCleaned(insuredfirstname = '');	
	 ErieCleanName_Business                        := project(Erie_Business, transform(recordof(Erie_Business),
																																	 self.cleaned_name.fname                 := '';
																																	 self.cleaned_name.lname                 := ut.cleancompany(left.insuredlastname);
																																	 self.cleaned_name_cp.fname              := '';
																																	 self.cleaned_name_cp.lname              := ut.cleancompany(left.name_last);
	                                                          self := left));
   ErieCleanName_Business_dist                   := distribute(ErieCleanName_Business,hash(claimnumber,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.lname));
	 ErieCleanName_Busi_rmDup                      := dedup(sort(ErieCleanName_Business_dist,
	                                                             claimnumber,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.lname, -ffid, local),
	                                                        claimnumber,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.lname, local);
																													
   ErieClean                                     := ErieCleanName_Indiv_rmDup + ErieCleanName_Busi_rmDup;
	 

   ErieClean_Proj                                := project(ErieClean, transform(recordof(ErieClean),
																													Entity_Ind     	         := map(left.cleaned_name_cp.fname <>'' and left.cleaned_name_cp.lname <>'' => 'PERSON',
																																															left.cleaned_name_cp.fname = '' and left.cleaned_name_cp.lname <>'' => 'BUSINESS',
																																															'UNKNOWN');
																													self.entity              := Entity_Ind;
																													IsInsuredClaimParty      := left.responsibleparty  in ['I', 'i']  and (left.cleaned_name.fname = left.cleaned_name_cp.fname and left.cleaned_name.lname = left.cleaned_name_cp.lname); 
																													Type_Of_Mapping          := map(left.responsibleparty not in ['I', 'i']           => 'ERIE_PARTY_MAPPING',
																																															IsInsuredClaimParty and  Entity_Ind <> 'UNKNOWN'  => 'ERIE_INSURED_MAPPING',
																																																									                                   'ERIE_PARTY_MAPPING');
                                                   self.TypeOfMapping       :=  Type_Of_Mapping;
	
			                                              IsErieInsMapIndiv        := Type_Of_Mapping = 'ERIE_INSURED_MAPPING' and 
																										                                 (left.insuredfirstname <> '' and left.insuredlastName <> '');																																										 
			                                              IsErieInsMapBusi         := Type_Of_Mapping = 'ERIE_INSURED_MAPPING' and 
																										                                 (left.insuredfirstname = '' and left.insuredlastName <> '');
			
			                                              IsEriePartyMapIndivUnk   := Type_Of_Mapping = 'ERIE_PARTY_MAPPING' and 
																										                                 (Entity_Ind = 'PERSON' or Entity_Ind = 'UNKNOWN');
			                                              IsEriePartyMapBusi       := Type_Of_Mapping = 'ERIE_PARTY_MAPPING' and Entity_Ind ='BUSINESS';																								
			  
			                                              prepInsLastName          := regexreplace(constants().special_char_bname, left.insuredlastName, '');
			                                              prepName_last            := regexreplace(constants().special_char_bname, left.name_last, '');			
			
			                                              self.business_name       := map(IsErieInsMapBusi                         => left.insuredlastName,
			                                                                              IsEriePartyMapBusi                       => left.name_last,
			                                                                              '');                                                                              
			                                              self.clean_business_name := map(IsErieInsMapBusi                         => NID.clnBizName(prepInsLastName),
			                                                                              IsEriePartyMapBusi                       => NID.clnBizName(prepName_last),
			                                                                              '');			
																													self.cleaned_name.title  := map(IsErieInsMapIndiv                        => left.cleaned_name.title,
                                                                                   IsEriePartyMapIndivUnk                    => left.cleaned_name_cp.title,
																																															'');
																													self.cleaned_name.fname  := map(IsErieInsMapIndiv                         => left.cleaned_name.fname, 
                                                                                   IsEriePartyMapIndivUnk                    => left.cleaned_name_cp.fname,
																																														 '');
																													self.cleaned_name.mname	:= map(IsErieInsMapIndiv                         => left.cleaned_name.mname, 
																																															IsEriePartyMapIndivUnk                    => left.cleaned_name_cp.mname,
																																															'');
																													self.cleaned_name.lname	:= map(IsErieInsMapIndiv                         => left.cleaned_name.lname, 
																																															IsEriePartyMapIndivUnk                    => left.cleaned_name_cp.lname,
																																															'');
																													self.cleaned_name.name_suffix  := map(IsErieInsMapIndiv                   => left.cleaned_name.name_suffix, 
																																															     IsEriePartyMapIndivUnk               => left.cleaned_name_cp.name_suffix,
																																															     '');																												
																													 self                    := left)); 

   Mac_LexidAppend(ErieClean_Proj, ErieWithIDL);																										
   Mac_BusinessIDAppend(ErieWithIDL, ErieWithBDID);
	 
//updates
	 ErieUpdate                                    := distribute(ErieWithBDID, hash(claimnumber,cleaned_name.fname,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.fname, cleaned_name_cp.lname, clean_business_name)); 

	 ErieBase                                      := distribute(inBaseERIE, hash(claimnumber,cleaned_name.fname,cleaned_name.lname,typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.fname, cleaned_name_cp.lname, clean_business_name));
	
	//Change Capture 
	 FraudDefenseNetwork.Layouts.Base.Erie getSrcRid(ErieUpdate l, ErieBase r) := transform
		self.dt_first_seen 													 := ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		self.dt_last_seen 													 := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 							 := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported 						 := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id 													 := r.source_rec_id ;
		self.current	 													      := if(l.current = 'C' or r.current = 'C', 'C', 'H');
		self 					                             := l;
	 end;
	
	//*** this join assigns the Src_rids for the older records.
	dBase_with_rids                           := join(ErieUpdate, ErieBase,
																												left.claimnumber                              = right.claimnumber                and
																												left.cleaned_name.fname                       = right.cleaned_name.fname         and
																												left.cleaned_name.lname                       = right.cleaned_name.lname         and
																												left.typeofloss                               = right.typeofloss                 and
																												left.dateofloss                               = right.dateofloss                 and
																												left.dateio                                   = right.dateio                     and
																												left.findings                                 = right.findings                   and
																												left.responsibleparty                         = right.responsibleparty           and
																												left.policynumber                             = right.policynumber               and
																												left.cleaned_name_cp.fname                    = right.cleaned_name_cp.fname      and
																												left.cleaned_name_cp.lname                    = right.cleaned_name_cp.lname      and
																												left.clean_business_name                      = right.clean_business_name       , 
																												getSrcRid (left,right),
																												left outer,
																												keep(1),
																												local);
													
	ut.MAC_Append_Rcid (dBase_with_rids, source_rec_id, pDataset_rollup);
	tools.mac_WriteFile(Filenames(pversion).Base.Erie.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Erie atribute')
	);
	
end;