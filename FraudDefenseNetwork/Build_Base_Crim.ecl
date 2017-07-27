Import ut,tools,hygenics_crim,_control,Consumer_DW_Layout; 

EXPORT Build_Base_Crim ( 
   string pversion
	,dataset(Layouts.Base.Crim)  inBaseCrim   = Files().Base.Crim.QA
	//,dataset(Layouts.Input.Crim) inCrimUpdate = Files().Input.Crim.Sprayed
	,boolean                    UpdateCrim    = FraudDefenseNetwork._Flags.Update.Crim
) := 
module 

 // Apply Felony and Incarceration filters
 
  Public_Offenses                   := hygenics_crim.File_Moxie_DOC_Offenses_Dev; //doxie_files.File_Offenses ; DATASET('~thor_data400::base::corrections_offenses_public_w20140605-152618', CrossRisk.Layouts.Layout_DD_offenses_public, THOR);
  Offenders                         := hygenics_crim.File_Moxie_Crim_Offender2_Dev ; //thor_data400::base::corrections_offenders_public

  Unique_Public_Offenses            := DEDUP(SORT(distribute(Public_Offenses(off_typ = 'F'),hash(offender_key)),offender_key,local),offender_key,local);
  Unq_offenders                     := DEDUP(SORT(distribute(Offenders(pty_typ ='0' and data_type = '1' and  curr_incar_flag = 'Y' ),hash(offender_key)),offender_key,local),offender_key,local);

  temp_layout := {Unq_offenders ,string75 off_desc_1; string50 off_desc_2; string8  off_date;string8  arr_date;string8  convict_dt; string8		ct_disp_dt;string8		stc_dt;string8		inc_adm_dt};
  JDOC := JOIN(Unique_Public_Offenses, Unq_offenders
	                               ,left.offender_key = right.offender_key
																 ,transform(temp_layout
																 , Self := right,
                                   self.off_desc_1 := left.off_desc_1; 
																	 self.off_desc_2 := left.off_desc_2; 
																	 self.off_date  := left.off_date;
																	 self.arr_date  := left.arr_date;
																	 self.convict_dt := left.convict_dt;
																	 self.ct_disp_dt := left.ct_disp_dt;
																	 self.stc_dt     := left.stc_dt ; 
																	 self.inc_adm_dt := left.inc_adm_dt)
																 ,local);


	Court_Offenses                          := hygenics_crim.File_Moxie_Court_Offenses_Dev;//392,006,272
  ct_off_felony                           := Court_Offenses(regexfind('FELONY',court_off_lev_mapped)); //39,037,455
  court_offenses_felony_DISMIS            := ct_off_felony(~regexfind('DISM',court_disp_desc_2));
  Court_off_FEL_NOTGUILTY                 := court_offenses_felony_DISMIS(~regexfind('NOT GUILTY',court_disp_desc_2));
  Court_off_FEL_NOTGUILTY_N_U             := Court_off_FEL_NOTGUILTY(fcra_conviction_flag NOT IN['N','U']); // thids flag is set only for FCRA srcs
  Court_felony_dism_notG                  := DEDUP(SORT(distribute(Court_off_FEL_NOTGUILTY_N_U,hash(offender_key)),offender_key,local),offender_key,local); 
  Offenders_ct                            := DEDUP(SORT(distribute(Offenders(pty_typ ='0' and data_type = '2'),hash(offender_key)),offender_key,local),offender_key,local); //2-crt n aoc

  Joffenders := JOIN(Court_felony_dism_notG, Offenders_ct
	                               ,left.offender_key = right.offender_key
																 ,transform(temp_layout,
																   Self := right, 
                                   self.off_desc_1 := left.court_off_desc_1; 
																	 self.off_desc_2 := left.court_off_desc_2; 
																	 self.off_date   := left.off_date;
																	 self.arr_date   := left.arr_date;
																	 self.convict_dt := left.convict_dt;
																	 self.ct_disp_dt := left.court_disp_date;
																	 self.stc_dt     := left.sent_date ; 
																	 self.inc_adm_dt := '')
																 ,local);

   inCrimUpdate := Joffenders + JDOC ; 
   Felony       := distribute(inCrimUpdate( curr_incar_flag<>'Y' and (unsigned) did <>0) ,hash((unsigned)did )); 
	 BocaShell    := dedup(sort(distribute(dataset('~thor::base::cdw::prod::bocashell', Consumer_DW_Layout.Layout_BOCA_DW, THOR)(lexid <>0), hash(LexID)), LexID, -build_period, LOCAL), LexID, LOCAL);

// Append Fraud Point Score 
   FelonyFraudscore := join ( BocaShell, Felony,
																													 LEFT.LexID = (unsigned)RIGHT.did,
																													 TRANSFORM({ Felony,string3 fd_scores__fraudpointV2},
																													 SELF.fd_scores__fraudpointV2 := LEFT.fd_scores__fraudpointV2,
																													 SELF                        := RIGHT,
																													 ), RIGHT OUTER, LOCAL);

   InCrim := FelonyFraudscore(fd_scores__fraudpointV2 between '300' and '500' ) + project(inCrimUpdate (curr_incar_flag='Y' and (unsigned) did <>0),transform(Layouts.Input.Crim , self:= left , self.fd_scores__fraudpointV2 := '')); 
   
	 FraudDefenseNetwork.Functions.CleanFields(InCrim ,InCrimupper); 
	 
   unsigned	CrimMaxRecordID	:=	if(UpdateCrim, max(inBaseCrim,source_rec_id), 0)	:	global; // For full initial load as its not update
	
		FraudDefenseNetwork.Layouts.Base.Crim	tPrep(Layouts.Input.Crim	pInput,integer	cnt)	:=
	transform
				
				    self.process_date                    := (unsigned) pversion, 
						self.Unique_Id                       := 0; 
						self.Source                          := 'Crim'; 
						self.dt_first_seen                   := (unsigned)pInput.src_upload_date ; 
						self.dt_last_seen                    := (unsigned)pInput.src_upload_date ;
						self.dt_vendor_last_reported         := (unsigned) pversion;
						self.dt_vendor_first_reported        := (unsigned) pversion;
					  //self.source_rec_id							     :=	 CrimMaxRecordID + cnt ;																			
						// add  address and name prep 
					  self.current                         := 'C' ; 
						self                                 := pInput; 
						
						self                                 := []; 
   end; 
		
	CrimUpdate	:=	project(dedup(InCrimupper(orig_lname <> '' and orig_fname <>'')  ,all),tPrep(left,counter));
		
	// Standardize Name 
	FraudDefenseNetwork.Standardize_Name(CrimUpdate, orig_fname,orig_mname,orig_lname, orig_name_suffix, CrimUpdatecleaned); 
	
		// Rollup Update and previous base This is not used as Crim is full refresh each build. 
	//Pcombined     := CrimUpdatecleaned;//If(UpdateCrim , inBaseCrim + CrimUpdatecleaned , CrimUpdatecleaned); 	
	//*** this join assigns the Src_rids for the older records.
	pDataset_Dist := distribute(CrimUpdatecleaned, hash(offender_key));	
  pBase_dist    := distribute(inBaseCrim      , hash(offender_key));	
		
		FraudDefenseNetwork.Layouts.Base.Crim getSrcRid (pDataset_Dist l, pBase_dist r) := transform
		self.dt_first_seen 													:= ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		self.dt_last_seen 					        	      := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 								:= ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported               := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id						              := r.source_rec_id ;
		self.current							                  := if(l.current = 'C' or r.current = 'C', 'C', 'H');

		self 					:= l;
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
	tools.mac_WriteFile(Filenames(pversion).Base.Crim.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_Crim atribute')
	);
	
end;
