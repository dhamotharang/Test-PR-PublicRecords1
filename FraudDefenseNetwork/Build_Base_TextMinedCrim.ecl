Import ut,tools,hygenics_crim,_control,Consumer_DW_Layout, STD; 

Export Build_Base_TextMinedCrim( 
   string pversion
	,dataset(Layouts.Base.TextMinedCrim)  inBaseTextMinedCrim   = Files().Base.TextMinedCrim.QA
	,boolean                    UpdateTextMinedCrim    = FraudDefenseNetwork._Flags.Update.TextMinedCrim
) := 

module 

Offenders                 := hygenics_crim.File_Moxie_Crim_Offender2_Dev ; //thor_data400::base::corrections_offenders_public; Offenders; 459,015,563
Public_Offenses           := hygenics_crim.File_Moxie_DOC_Offenses_Dev;    //thor_data400::base::corrections_offenses_public; DOC; 63,744,868
Court_Offenses            := hygenics_crim.File_Moxie_Court_Offenses_Dev;  //thor_data400::base::corrections_court_offenses_public; AOC; 427,250,273
Conv_lookup_ds            := Files().temp.File_Conviction_Lookup;     //thor_200::base::crimsrch_conviction_lookup; Conv_flag_lookup;court_disp_desc,conviction_flag;

Public_Offenses_slim_lay  := {Public_Offenses.offender_key; Public_Offenses.stc_desc_2; Public_Offenses.off_desc_1; Public_Offenses.off_desc_2; string8 st_start_dt; Public_Offenses.off_date;  Public_Offenses.convict_dt; Public_Offenses.ct_disp_dt; Public_Offenses.stc_dt; Public_Offenses.inc_adm_dt};
Court_Offenses_slim_lay   := {Court_Offenses.offender_key; Court_Offenses.court_disp_desc_1; Court_Offenses.court_off_desc_1; Court_Offenses.court_off_desc_2;  Court_Offenses.off_date; Court_Offenses.convict_dt; Court_Offenses.court_disp_date; Court_Offenses.sent_date};

//DOC
Public_offenses_slim      := project(Public_Offenses(off_typ = 'F'),transform(Public_Offenses_slim_lay, 
                                                                              self.st_start_dt := regexreplace('(Sent Start Date: )([0-9]+)[ ]*',left.stc_desc_2,'$2');
																																							self             := left)); 
Unq_Public_offenses       := dedup(sort(distribute(Public_Offenses_slim,hash(offender_key)),offender_key,off_desc_1,off_desc_2, off_date, convict_dt, ct_disp_dt, stc_dt, inc_adm_dt, st_start_dt,local),offender_key,off_desc_1,off_desc_2, off_date, convict_dt, ct_disp_dt, stc_dt, inc_adm_dt, st_start_dt,local); 
Unq_offenders             := dedup(sort(distribute(Offenders(pty_typ ='0' and data_type = '1'),hash(offender_key)),offender_key,local),offender_key,local);

temp_layout1              := {Unq_offenders; string150 off_desc; string75 off_desc_1; string50 off_desc_2; string8 off_date; 
                              string8 convict_dt; string8	ct_disp_dt; string8	stc_dt; string8	inc_adm_dt; string8 st_start_dt; 
															   string8 event_date};
JDOC                      := JOIN(Unq_Public_Offenses, Unq_offenders
																 ,left.offender_key = right.offender_key
																 ,transform(temp_layout1
																 , Self := right,
																   self.off_desc    := left.off_desc_1 + left.off_desc_2;
																	 self.off_desc_1  := left.off_desc_1; 
																	 self.off_desc_2  := left.off_desc_2; 
																	 self.off_date    := left.off_date;
																	 self.convict_dt  := left.convict_dt;
																	 self.ct_disp_dt  := left.ct_disp_dt;
																	 self.stc_dt      := left.stc_dt ; 
																	 self.inc_adm_dt  := left.inc_adm_dt;
																	 self.st_start_dt := left.st_start_dt;													
																	 self.event_date  := map(	left.inc_adm_dt <>'' => left.inc_adm_dt ,
																														left.stc_dt     <>'' => left.stc_dt ,
																														left.convict_dt <>'' => left.convict_dt ,
																														left.ct_disp_dt <>'' => left.ct_disp_dt ,
																														left.off_date   <>'' => left.off_date ,
																														left.st_start_dt<>'' => left.st_start_dt,
																														'');
																	           ),local);
// AOC
ct_offenses_slim          := project(Court_Offenses(regexfind('FELONY',court_off_lev_mapped)),Court_Offenses_slim_lay); 
jConv_lkp                 := join(ct_Offenses_slim, Conv_lookup_ds(conviction_flag='Y')
																	,trim(StringLib.StringToUppercase(left.court_disp_desc_1),left,right) = trim(StringLib.StringToUppercase(right.court_disp_desc),left,right)
																	,transform(recordof(ct_Offenses_slim),self :=left)
																	,lookup);  // Conv_lookup_ds will be updated eventually by dataowner

unq_ct_Offenses           := dedup(sort(distribute(jConv_lkp,hash(offender_key)),offender_key,court_off_desc_1,court_off_desc_2, off_date, convict_dt, court_disp_date, sent_date,local),offender_key,court_off_desc_1,court_off_desc_2, off_date, convict_dt, court_disp_date, sent_date,local); 
															
ct_Offenders              := dedup(sort(distribute(Offenders(pty_typ ='0' and data_type = '2'),hash(offender_key)),offender_key,local),offender_key,local); //2-crt n aoc



JAOC := JOIN(unq_ct_Offenses, ct_Offenders
	                            ,left.offender_key = right.offender_key
																 ,transform(temp_layout1,
																            self := right, 
                                        self.off_desc    := left.court_off_desc_1 + left.court_off_desc_2; 
                                        self.off_desc_1  := left.court_off_desc_1; 
																						 self.off_desc_2  := left.court_off_desc_2; 
																						 self.off_date    := left.off_date;
																						 self.convict_dt  := left.convict_dt;
																						 self.ct_disp_dt  := left.court_disp_date;
																						 self.stc_dt      := left.sent_date ; 
																						 self.inc_adm_dt  := '';
																						 self.st_start_dt := '';
																	          self.event_date  := map(left.convict_dt <>'' => left.convict_dt ,
																														           left.court_disp_date <>'' => left.court_disp_date ,
																														           left.sent_date       <>'' => left.sent_date ,
																														           left.off_date        <>'' => left.off_date ,
																														          '');
																						 ),local);
IncrimUpdate              := JDOC + JAOC;	

IncrimUpdate_did          := IncrimUpdate((unsigned)did<>0 and event_date<>'' and off_desc<>''); 
IncrimUpdate_off_desc     := IncrimUpdate_did(Event_Date between  ut.getDateOffset(-Mod_MbsContext.TextMinedCrimExpdays) and (STRING8)Std.Date.Today()); 

IncrimUpdate_dedup        := dedup(sort(distribute(IncrimUpdate_off_desc,hash(offender_key)),offender_key,off_desc,event_date,local),offender_key,off_desc,event_date,local);


temp_layout2              := {IncrimUpdate_dedup, string150 charge, string50 fraud_type};
ds_proj                   := project(IncrimUpdate_dedup,transform(temp_layout2,
																					off_desc_upcase     := trim(StringLib.StringToUppercase(left.off_desc),left,right);
																					off_desc_rmSpChar   := regexreplace(Constants().special_characters, off_desc_upcase, ' ');
																					off_desc_rmWordChar := STD.Str.CleanSpaces(regexreplace(Constants().word_characters, ' '+ off_desc_rmSpChar +' ', ' '));
																					off_desc_clean      := trim(regexreplace('^[$0123456789 ]+',off_desc_rmWordChar,' '),left,right);	
																					self.charge         := off_desc_clean;
																					frd_typ             := Functions.fraud_type_fn(off_desc_clean);
																					self.fraud_type     := frd_typ;
																					self                := left;
																					self                := [];
																					));	

ds_frdtype                := ds_proj(fraud_type<>'');

InCrim                    := dedup(sort(distribute(ds_frdtype,hash(did)),did,-off_date,  -convict_dt,  -ct_disp_dt,  -stc_dt,  -inc_adm_dt,  -st_start_dt,  -event_date, -offender_persistent_id,local),did,local);
   
Functions.CleanFields(InCrim ,InCrimupper); 
	 
	
Layouts.Base.TextMinedCrim	tPrep(Layouts.Input.TextMinedCrim	pInput)	:= 
		transform				
				self.process_date                    := (unsigned)pversion, 
				self.Unique_Id                       := 0; 
				self.Source                          := 'CRIM'; 
				self.dt_first_seen                   := (unsigned)pInput.src_upload_date ; 
				self.dt_last_seen                    := (unsigned)pInput.src_upload_date ;
				self.dt_vendor_last_reported         := (unsigned)pversion;
				self.dt_vendor_first_reported        := (unsigned)pversion;
				self.current                         := 'C' ; 
				self.clean_address.prim_range        := pInput.prim_range;
				self.clean_address.predir			       := pInput.predir;
				self.clean_address.prim_name			     := pInput.prim_name;
				self.clean_address.addr_suffix		   := pInput.addr_suffix;				
				self.clean_address.postdir           := pInput.postdir;
				self.clean_address.unit_desig        := pInput.unit_desig;
				self.clean_address.sec_range			     := pInput.sec_range;
				self.clean_address.p_city_name		   := pInput.p_city_name;
				self.clean_address.v_city_name		   := pInput.v_city_name;
				self.clean_address.st                := pInput.st;
				self.clean_address.zip               := pInput.zip5;
				self.clean_address.zip4              := pInput.zip4;
				self.clean_address.cart              := pInput.cart;
				self.clean_address.cr_sort_sz        := pInput.cr_sort_sz;
				self.clean_address.lot               := pInput.lot;
				self.clean_address.lot_order			     := pInput.lot_order;
				self.clean_address.dbpc              := pInput.dpbc;
				self.clean_address.chk_digit			     := pInput.chk_digit;
				self.clean_address.rec_type          := pInput.rec_type;
				self.clean_address.fips_state 		   := pInput.ace_fips_st;
				self.clean_address.fips_county		   := pInput.ace_fips_county;
				self.clean_address.geo_lat           := pInput.geo_lat;
				self.clean_address.geo_long			     := pInput.geo_long;
				self.clean_address.msa			          := pInput.msa;
				self.clean_address.geo_blk			       := pInput.geo_blk;
				self.clean_address.geo_match			     := pInput.geo_match;
				self.clean_address.err_stat			     := pInput.err_stat	;
				self.did                             := (unsigned6)pInput.did; 
				self                                 := pInput; 
				self                                 := []; 
   end; 
		
CrimUpdate	              :=	project(dedup(InCrimupper(orig_lname <> '' and orig_fname <>''),all),tPrep(left));
		
	// Standardize Name 
Standardize_Name(CrimUpdate, orig_fname,orig_mname,orig_lname, orig_name_suffix, CrimNameCleaned); 

Mac_LexidAppend(CrimNameCleaned, CrimUpdatecleaned); 
	
pDataset_Dist           := distribute(CrimUpdatecleaned,   hash(did));	
pBase_dist              := distribute(inBaseTextMinedCrim, hash(did));	
		
Layouts.Base.TextMinedCrim getSrcRid (pDataset_Dist l, pBase_dist r) := transform
		    self.dt_first_seen                   := ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		    self.dt_last_seen                    := max(l.dt_last_seen,r.dt_last_seen);
		    self.dt_vendor_last_reported         := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		    self.dt_vendor_first_reported        := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		    self.source_rec_id                   := r.source_rec_id ;
		    self.current                         := if(l.current = 'C' or r.current = 'C', 'C', 'H');
		    self                                 := l;
	end;
	
	//*** this join assigns the Src_rids for the older records.
	dBase_with_rids := join(pDataset_Dist, pBase_dist, 
														left.offender_key                = right.offender_key  and
														left.pty_nm                      = right.pty_nm        and
														left.lname                       = right.lname         and
														left.fname                       = right.fname         and
														left.mname                       = right.mname         and
														left.ssn                         = right.ssn           and
														left.county_of_origin            = right.county_of_origin and
														left.dob                         = right.dob              and
														left.dob_alias                   = right.dob_alias        and
														left.county_of_birth             = right.county_of_birth  and
														left.place_of_birth              = right.place_of_birth   and
														left.street_address_1            = right.street_address_1 and
														left.street_address_2            = right.street_address_2 ,
														getSrcRid (left,right),
														left outer,
														keep(1),
														local);
	ut.MAC_Append_Rcid (dBase_with_rids, source_rec_id, pDataset_rollup) ;
	tools.mac_WriteFile(Filenames(pversion).Base.TextMinedCrim.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_TextMinedCrim atribute')
	);
	
end;
