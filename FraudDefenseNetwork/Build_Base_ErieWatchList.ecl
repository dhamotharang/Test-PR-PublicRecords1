import ut, std, tools, NID, Address, did_Add;

export Build_Base_ErieWatchList( 
   string pversion
	,dataset(Layouts.Base.ErieWatchList) inBaseErieWL = Files().Base.ErieWatchList.QA
	,dataset(Layouts.Input.ErieWatchList) inErieWLUpdate = Files().Input.ErieWatchList.Sprayed
	,boolean UpdateErieWatchList = _Flags.Update.ErieWatchList
) := 
module 
#option('multiplePersistInstances',false);
	 Functions.CleanFields(inErieWLUpdate ,inErieWLUpdateUpper);
	
   Layouts.Base.ErieWatchList 	tPrep(Layouts.Input.ErieWatchList	pInput)	:=	transform				
           self.process_date                   := (unsigned) pversion, 
           self.Unique_Id                      := 0; 
           self.source                         := map(pInput.alertnumber[1..2] in ['SA','CA']         => 'ERIE_NICB_WATCHLIST',
                                                      pInput.alertnumber[1..3] in ['TFA','AMD','LEA'] => 'ERIE_NICB_WATCHLIST',
                                                      'ERIE_WATCHLIST');
						self.firstname                       := pInput.firstname; 
						self.lastname                        := pInput.lastname;
						self.business_name                   := pInput.businessname;  
						self.clean_business_name             := ut.cleancompany(pInput.businessname);
						dob_yyyymmdd                         := Functions.fHypenYMDtoCYMD(pInput.dob);
						IsDobValid                           := STD.DATE.IsValidDate((unsigned)dob_yyyymmdd);
						self.dob                             := if(IsDobValid, dob_yyyymmdd, '');
						self.phone                           := if(pInput.phone1 <> '', pInput.phone1, pInput.phone2);
						self.ffid                            := (unsigned)pInput.ffid;
						ValidStDt                            := Functions.fHypenYMDtoCYMD(pInput.validstart);
						self.ValidStartDate                  := ValidStDt; 
						self.ValidEndDate                    := Functions.fHypenYMDtoCYMD(pInput.validend); 
						self.ValidStartTS                    := trim(pInput.validstart[11..19], left, right);
						self.createdate                      := Functions.fHypenYMDtoCYMD(pInput.createdate);
						self.dt_first_seen                   := (unsigned)ValidStDt; 
						self.dt_last_seen                    := (unsigned)ValidStDt; 
						self.dt_vendor_last_reported         := (unsigned)pversion;
						self.dt_vendor_first_reported        := (unsigned)pversion;	
						self.current                         := 'C' ;   
						self.address_1                       := Address.Addr1FromComponents(pInput.addressline1, pInput.addressline2,'', '', '', '', '');
						self.address_2                       := Address.Addr2FromComponents(pInput.city, pInput.state, pInput.zip[1..5]);  
						self                                 := pInput; 
						self                                 := []; 
  end;

   ErieWL_Proj := project(dedup(inErieWLUpdateUpper(~(firstname = '' and lastname ='' and businessname = '' and
                                                      tin = '' and ssn = '' and dln = '' and dlstate = ''   and
                                                      dob = '' and addressline1 = '' and addressline2 = ''  and 
                                                      city = '' and state = '' and phone1 = '' and  
																											      phone2 = ''and zip = '' and country = '' and
                                                      vin = '' )),all),tPrep(left));
																											
		//Filters - Remove invalid & Minors Recs																											
   ErieWLValidOnly	:= ErieWL_Proj((unsigned)ValidendDate > mod_Utilities.CurrentDate):independent;
   ErieWLNoDob	:= ErieWLValidOnly(dob = '');
   ErieWLWithDob	:= ErieWLValidOnly(dob <> '');
   ErieWLRemoveMinors	:= ErieWLWithDob(ut.Age((unsigned)dob) >=18);
	 ErieWLToClean :=  ErieWLNoDob + ErieWLRemoveMinors;
	 
	 //Cleaning - Address, Phone, Names
	 Standardize_Address(ErieWLToClean, ErieWLAddrCleaned);
	 Standardize_Phone(ErieWLAddrCleaned, phone	,ErieWLPhoneCleaned	,clean_phones.phone_number	,,true);
	 Standardize_Name(ErieWLPhoneCleaned, firstname, middlename, lastname, suffixname, ErieWLCleanName);	 
   
	 //Linking - Lexid & BusinessID
   Mac_LexidAppend(ErieWLCleanName, ErieWithIDL);	
   Mac_BusinessIDAppend(ErieWithIDL, ErieWithBDID);	 	
	 ErieWLClnLinked :=  ErieWithBDID:persist(constants().ErieWLClnLinkedPersist);
  
	// Remove Duplicates 
	 ErieWL_Indiv_dist := distribute(ErieWLClnLinked(did>0), hash(did)); 																		 
	 ErieWL_Indiv_Unq := dedup(sort(ErieWL_Indiv_dist, did, validstartDate, -ffid, local), did, validstartDate, local);
   ErieWLIndvidual := project(ErieWL_Indiv_Unq, transform(recordof(ErieWL_Indiv_Unq), self.entity :='PERSON', self := left));
	 
	 ErieWL_Business_dist  := distribute(ErieWLClnLinked(seleid>0 or orgid>0 or ultid>0), hash(seleid, orgid, ultid ));																				 
	 ErieWL_Business_Unq  := dedup(sort(ErieWL_Business_dist, seleid, orgid, ultid, validstartDate, -ffid, local), seleid, orgid, ultid, validstartDate, local);
	 ErieWLBusiness := project(ErieWL_Business_Unq, transform(recordof(ErieWL_Business_Unq), self.entity :='BUSINESS', self := left));

	 
	 ErieWL_Unknown_dist := distribute(ErieWLClnLinked(did =0 and seleid=0 and orgid=0 and ultid=0), hash(cleaned_name.fname,cleaned_name.mname,cleaned_name.lname,clean_business_name,tin,ssn,dln,dlstate,dob,addressline1,addressline2,city,state,phone1,phone2,zip,country,vin,validstartDate));																				 
	 ErieWL_Unknown_Unq := dedup(sort(ErieWL_Unknown_dist,cleaned_name.fname,cleaned_name.mname,cleaned_name.lname,clean_business_name,tin,ssn,dln,dlstate,dob,addressline1,addressline2,city,state,phone1,phone2,zip,country,vin,validstartDate, -ffid , local), cleaned_name.fname,cleaned_name.mname,cleaned_name.lname,clean_business_name,tin,ssn,dln,dlstate,dob,addressline1,addressline2,city,state,phone1,phone2,zip,country,vin,validstartDate, local);
	 ErieWLUnknown := project(ErieWL_Unknown_Unq, transform(recordof(ErieWL_Unknown_Unq), self.entity :='UNKNOWN', self := left));

   ErieWL_All := ErieWLIndvidual + ErieWLBusiness + ErieWLUnknown;
	 
	 ErieWLUpdate := distribute(ErieWL_All, hash(alertnumber, cleaned_name.fname, cleaned_name.mname, cleaned_name.lname, clean_business_name, ssn,  dob, validstartDate, entity ));
	 ErieWLBase   := distribute(inBaseErieWL, hash(alertnumber, cleaned_name.fname, cleaned_name.mname, cleaned_name.lname, clean_business_name, ssn,  dob, validstartDate, entity )); 

	 Layouts.Base.ErieWatchList getSrcRid(ErieWLBase l, ErieWLUpdate r) := transform
		self.dt_first_seen 													 := ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		self.dt_last_seen 													 := max(l.dt_last_seen,r.dt_last_seen);
		self.dt_vendor_last_reported 							 := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.dt_vendor_first_reported 						 := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.source_rec_id 													 := l.source_rec_id ;
		self.current	 													      := if(l.current = 'C' or r.current = 'C', 'C', 'H');
		self 					                             := r;
	 end;
	
	//*** this join assigns the Src_rids for the older records.
	dBase_with_rids                           := join(ErieWLBase, ErieWLUpdate, 
																												left.alertnumber          = right.alertnumber        and
																												left.cleaned_name.fname   = right.cleaned_name.fname and
																												left.cleaned_name.mname   = right.cleaned_name.mname and
																												left.cleaned_name.lname   = right.cleaned_name.lname and
																												left.ssn                  = right.ssn                and
																												left.dob                  = right.dob                and
																												left.validstartDate       = right.validstartDate     and
																												left.clean_business_name  = right.clean_business_name and
																												left.entity               = right.entity, 
																												getSrcRid (left,right),
																												right outer,																									
																												local);
													
	ut.MAC_Append_Rcid (dBase_with_rids, source_rec_id, pDataset_rollup);
	tools.mac_WriteFile(Filenames(pversion).Base.ErieWatchList.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping ErieWatchList atribute')
	);
	
end;