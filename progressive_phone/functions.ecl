IMPORT iesp, doxie, phonesplus_v2, progressive_phone, risk_indicators, didville, person_models,
  ut, MDR, batchservices, NID, DeathV2_Services, Gateway, Phone_Shell, STD, AutoStandardI;
  

EXPORT functions := MODULE



  SHARED dedupHistPhones(f_phone_hist, f_found_phones, inMod) := FUNCTIONMACRO
            
    //remove the input historical phones			   
    f_found_phones	 flag_hist(f_found_phones l, f_phone_hist r) := transform
      self.dup_phone_flag := if(r.phone10<>'','Y','N');  //need this?
      self := l;
    end;

    f_out_dedup_1 := join(f_found_phones, f_phone_hist, 
                          left.acctno = right.acctno and
                          left.subj_phone10 = right.phone10,
                          flag_hist(left, right), left outer);
                          
    f_out_dedup_1 xForm_blank_phone(f_out_dedup_1 le) := TRANSFORM
      self.subj_phone10:=if(le.dup_phone_flag='Y','',le.subj_phone10);
      self := le;
      self := [];
    END;
    
    f_out_dedup_2 := if(inMod.DedupInputPhones, f_out_dedup_1(dup_phone_flag='N'), 
                     if(inMod.BlankOutDuplicatePhones, project(f_out_dedup_1, xForm_blank_phone(LEFT)), f_out_dedup_1));			
                            
    RETURN f_out_dedup_2;
      
  ENDMACRO;



  // get the input historical phones 

  SHARED histphones_layout := Phone_Shell.Layout_Phone_Shell.Layout_Dedup_Hist_Phone;

  EXPORT GetInputHistPhones (DATASET(progressive_phone.layout_progressive_batch_in) f_input_raw,
                      DATASET(iesp.share.t_StringArrayItem) alt_dedup_phones) := FUNCTION
          
    histphones_layout get_hist_phone(progressive_phone.layout_progressive_batch_in l, unsigned1 cnt) := transform
      self.acctno := l.acctno;
      self.phone10 := map(cnt=1 => l.phoneno_1,
                           cnt=2 => l.phoneno_2,
                           cnt=3 => l.phoneno_3,
                           cnt=4 => l.phoneno_4, 
                           cnt=5 => l.phoneno_5,
                           cnt=6 => l.phoneno_6, 
                           cnt=7 => l.phoneno_7,
                           cnt=8 => l.phoneno_8,
                           cnt=9 => l.phoneno_9,
                           cnt=10 => l.phoneno_10,
                           cnt=11 => l.phoneno_11,
                           cnt=12 => l.phoneno_12,
                           cnt=13 => l.phoneno_13,
                           cnt=14 => l.phoneno_14,
                           cnt=15 => l.phoneno_15,
                           cnt=16 => l.phoneno_16,
                           cnt=17 => l.phoneno_17,
                           cnt=18 => l.phoneno_18,
                           cnt=19 => l.phoneno_19,
                           cnt=20 => l.phoneno_20,
                           cnt=21 => l.phoneno_21,
                           cnt=22 => l.phoneno_22,
                           cnt=23 => l.phoneno_23,
                           cnt=24 => l.phoneno_24,
                           cnt=25 => l.phoneno_25,
                           cnt=26 => l.phoneno_26,
                           cnt=27 => l.phoneno_27,
                           cnt=28 => l.phoneno_28,
                           cnt=29 => l.phoneno_29,
                           cnt=30 => l.phoneno_30,
                           l.phoneno);
    end;

    histphones_layout phone_trans(alt_dedup_phones l) := transform
      self.acctno := '';
      self.phone10 := l.value;
    end;

    // dedupe phones If the dataset of phones is provided then we will use them
    // instead of the separate entries
    dp := project(alt_dedup_phones, phone_trans(left));
    ndp :=	normalize(f_input_raw, 31, get_hist_phone(left, counter))(phone10<>'');
        
    dp_phone_hist := if (exists(dp),dp,ndp);

    f_phone_hist := DEDUP(SORT(dp_phone_hist,RECORD),RECORD);
    return f_phone_hist;
  END;



  ////////////////////////////////////////////////////////////////////////
  // Version 6 (first of two versions currently used, see Version 7 below)
  ////////////////////////////////////////////////////////////////////////

  SHARED prog_layout := progressive_phone.layout_progressive_phones;	

  EXPORT GetPhonesV1(DATASET(progressive_phone.layout_progressive_batch_in) f_in_raw,
                                  progressive_phone.iParam.Batch inMod = progressive_phone.waterfall_phones_options,
                                  DATASET(iesp.share.t_StringArrayItem) f_dedup_phones = DATASET([],iesp.share.t_StringArrayItem),
                                  DATASET(Gateway.Layouts.Config) Gateways_In = DATASET([], Gateway.Layouts.Config),
                                  DATASET(histphones_layout) f_phone_in_hist = DATASET([], histphones_layout),
                                  BOOLEAN type_a_with_did = FALSE,
                                  BOOLEAN useNeustar = TRUE,
                                  BOOLEAN default_sx_match_limit = FALSE,
                                  BOOLEAN isPFR = FALSE
                                  ) := FUNCTION

    //doxie.MAC_Header_Field_Declare()
    doxie.MAC_Selection_Declare()	

    integer sx_match_restriction_limit := if(default_sx_match_limit and inMod.SXMatchRestrictionLimit = '',10,(integer)inMod.SXMatchRestrictionLimit);

    integer order_ES := if(inMod.DynamicOrderFlag, inMod.OrderES, 0);
    integer order_SE := if(inMod.DynamicOrderFlag, inMod.OrderSE, 1);
    integer order_AP := if(inMod.DynamicOrderFlag, inMod.OrderAP, 2);
    integer order_SP := if(inMod.DynamicOrderFlag, inMod.OrderSP, 3);
    integer order_MD := if(inMod.DynamicOrderFlag, inMod.OrderMD, 4);
    integer order_CL := if(inMod.DynamicOrderFlag, inMod.OrderCL, 5);
    integer order_CR := if(inMod.DynamicOrderFlag, inMod.OrderCR, 6);
    integer order_SX := if(inMod.DynamicOrderFlag, inMod.OrderSX, 7);
    integer order_PP := if(inMod.DynamicOrderFlag, inMod.OrderPP, 8);
    integer order_7  := if(inMod.DynamicOrderFlag, inMod.Order7, 9);
    integer order_NE := if(inMod.DynamicOrderFlag, inMod.OrderNE, 10);
    integer order_WK := if(inMod.DynamicOrderFlag, inMod.OrderWK, 11);
    integer order_RL := if(inMod.DynamicOrderFlag, inMod.OrderRL, 12);
    integer order_TH := if(inMod.DynamicOrderFlag, inMod.OrderTH, 13);

    boolean exclude_non_cell_pp := inMod.ExcludeNonCellPPData;
    boolean strict_apsx         := inMod.StrictAPSX;

    boolean use_LR := doxie.DataPermission.Use_LastResort and inMod.IncludeLastResort;
    
    //append did 
    in_batch_rec := record
      string20 acctno;
      integer did;
      didville.Layout_Did_InBatch;
    end;	

    in_batch_rec get_in_batch(f_in_raw l, unsigned cnt) := transform
      self.seq := cnt;
      self.phone10 := l.phoneno;
      self.title := '';
      self.fname := l.name_first;
      self.mname := l.name_middle;
      self.lname := l.name_last;
      self.suffix := l.name_suffix;
      self.addr_suffix := l.suffix;
      self.zip4 := l.z4;
      self := l;
      self := [];
    end;

    f_in_batch := project(f_in_raw, get_in_batch(left, counter));

    f_in_init := project(f_in_batch, didville.Layout_Did_OutBatch);

    // Append DID only for records with no DID
    f_in_init_no_dids := f_in_init(did = 0);

    didville.MAC_DidAppend(f_in_init_no_dids, f_with_did_raw_temp, true, 'true');

    f_with_did_raw := project(f_in_init(did != 0),transform(didville.Layout_Did_OutBatch,self.score := 100,self := left)) + f_with_did_raw_temp;
    f_with_did_all := project(f_with_did_raw, transform(didville.Layout_Did_OutBatch, self.did:=if(left.score>=inMod.DIDConfidenceThreshold, left.did, 0), self:=left));
    f_with_did_rt := project(group(f_with_did_all(did=0)), transform(didville.Layout_Did_OutBatch, self.score:=0, self:=left));

    progressive_phone.mac_re_did_input(f_with_did_rt, f_with_did_rted);

    // if this is the online version load make each instance start with did only
    in_batch_rec keep_orig_did_trans(f_in_batch l, f_with_did_all r) := transform
      self.did         := if(l.did <> 0, l.did, r.did);
      self.lname       := if(l.did <> 0, '',r.lname);
      self.fname       := if(l.did <> 0, '',r.fname);
      self.mname       := if(l.did <> 0, '',r.mname);
      self.ssn         := if(l.did <> 0, '',r.ssn);
      self.dob         := if(l.did <> 0, '',r.dob);
      self.suffix      := if(l.did <> 0, '',r.suffix);
      self.prim_range  := if(l.did <> 0, '',r.prim_range);
      self.predir      := if(l.did <> 0, '',r.predir);
      self.prim_name   := if(l.did <> 0, '',r.prim_name);
      self.addr_suffix := if(l.did <> 0, '',r.addr_suffix);
      self.postdir     := if(l.did <> 0, '',r.postdir);
      self.unit_desig  := if(l.did <> 0, '',r.unit_desig);
      self.sec_range   := if(l.did <> 0, '',r.sec_range);
      self.p_city_name := if(l.did <> 0, '',r.p_city_name);
      self.st          := if(l.did <> 0, '',r.st);
      self.z5          := if(l.did <> 0, '',r.z5);
      self.zip4        := if(l.did <> 0, '',r.zip4);
      self             := r;
      self             := l;
    end;

    // for PFR even if the incoming records have a DID, keep rest of the other information too along with the DID
    in_batch_rec tPFR_FormatDID2BatchIn(f_in_batch l,f_with_did_all r) := transform
      self.did := if (l.did <> 0, l.did, r.did);
      self     := l;
    end;

    f_with_orig_did := join(f_in_batch, f_with_did_all(did<>0) + f_with_did_rted,
                            left.seq = right.seq,
                            keep_orig_did_trans(left,right));

    f_pfr_with_orig_did := join(f_in_batch, f_with_did_all(did<>0) + f_with_did_rted,
                                left.seq = right.seq,
                                tPFR_FormatDID2BatchIn(left,right));

    f_with_did := if(isPFR,f_pfr_with_orig_did,f_with_orig_did);


    // TODO: the order of passing parameters was wrong, it is not clear what it should be. Needs verification.
    // Easier to create a new module rather than read from global: too many defaults
    gmod := AutoStandardI.GlobalModule ();
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (gmod);

    glb_ok := mod_access.isValidGLB ();
    dppa_ok := mod_access.isValidDPPA ();
    did_value := AutoStandardI.InterfaceTranslator.did_value.val(project(gmod,AutoStandardI.InterfaceTranslator.did_value.params));

    did_stream := dataset([{did_value}],{unsigned6 did});

    doxie.mac_best_records(did_stream,did,h_addr, dppa_ok, glb_ok,,mod_access.DataRestrictionMask,,include_DOD:=true);
    h_name := dedup(sort(doxie.Comp_Subject_Addresses(did_stream, , , , mod_access).raw,
                    -lname,-fname,-mname),lname,fname,mname);

    in_batch_rec calc_trans(doxie.layout_best a, doxie.Layout_presentation n) := transform
      self.dob := '';
      self.acctno := '';
      self.seq := 1;
      self.phone10 := '';
      self.addr_suffix := a.suffix;
      self.p_city_name := a.city_name;
      self.z5 := a.zip;
      self.fname := n.fname;
      self.lname := n.lname;
      self.mname := n.mname;
      self.suffix := n.name_suffix;
      self := a;
      self := n;
    end;
    calc_batch_for_a := join(h_addr,h_name,left.did = right.did,
                        calc_trans(left,right));

    // mac_get_type_a to use which dataset 
    f_in_batch_for_a := if(exists(f_in_batch(lname<>'')),
                            f_in_batch,
                            calc_batch_for_a);
                      
    //fetch different type of phones
    progressive_phone.mac_get_type_a(f_in_batch_for_a, f_out_type_a_pre)
    progressive_phone.mac_get_type_b(f_with_did, f_in_batch, f_out_type_b,,mod_access)
    progressive_phone.mac_get_type_c(f_with_did, f_in_batch, f_out_type_c, glb_ok, inMod.IncludeLandlordPhones,, mod_access)
    progressive_phone.mac_get_type_e(f_with_did, f_in_batch, f_out_type_e, inMod.IncludeRelativeCellPhones, mod_access)
    progressive_phone.mac_get_type_f(f_with_did, f_in_batch, f_out_type_f,sx_match_restriction_limit, mod_access)
    progressive_phone.mac_get_type_g(f_with_did, f_in_batch, f_out_type_g, mod_access)
		progressive_phone.mac_get_type_h(f_with_did, f_in_batch, f_out_type_h, mod_access)
    progressive_phone.mac_get_type_r(f_with_did, f_in_batch, f_out_type_r)
    progressive_phone.mac_get_type_v(f_with_did, f_in_batch, f_out_type_v,, mod_access)  // unrated
    progressive_phone.mac_get_type_w(f_with_did, f_in_batch, f_out_type_w)
    progressive_phone.mac_get_type_t(f_with_did, f_in_batch, f_out_type_t, mod_access)

    batch_out_with_did := progressive_phone.layout_progressive_batch_out_with_did;

    dummy_ds := dataset([], batch_out_with_did);

    // append did to type a if needed
    in_batch_rec_x := record
      DidVille.Layout_Did_InBatch.seq;
      DidVille.Layout_Did_OutBatch.did;
      in_batch_rec.acctno;
    end;

    f_in_batch_x := join(f_in_batch, f_with_did,
                         left.seq = right.seq,
                         transform(in_batch_rec_x, self := left, self := right));

    f_out_type_a_with_did := join(f_in_batch_x, f_out_type_a_pre,
                                  left.acctno = right.acctno,
                                  transform(batch_out_with_did, self.did := left.did, self := right));

    f_out_type_a := if(type_a_with_did ,
                           f_out_type_a_with_did,
                          f_out_type_a_pre);						

    f_out_raw_pre := if(inMod.CountES=0, dummy_ds, f_out_type_a) + 
                     if(inMod.CountSE=0, dummy_ds, f_out_type_b) +
                     if(inMod.CountAP=0, dummy_ds, f_out_type_c) +		 
                     if(inMod.CountSP=0, dummy_ds, f_out_type_e(subj_phone_type='41')) +
                     if(inMod.CountMD=0, dummy_ds, f_out_type_e(subj_phone_type='42')) +		 
                     if(inMod.CountCL=0, dummy_ds, f_out_type_e(subj_phone_type='43')) +		 
                     if(inMod.CountCR=0, dummy_ds, f_out_type_e(subj_phone_type='44')) +		 
                     if(inMod.CountSX=0, dummy_ds, f_out_type_f) +		 
                     if(inMod.CountPP=0, dummy_ds, f_out_type_g) +		 
                     if(inMod.CountNE=0, dummy_ds, f_out_type_h) +		 		 
                     if(inMod.CountRL=0, dummy_ds, f_out_type_r) +		 		 		 
                     if(inMod.Count7=0, dummy_ds, f_out_type_v) +		 		 		 
                     if(inMod.CountWK=0, dummy_ds, f_out_type_w) + 
                     if(inMod.CountTH=0, dummy_ds, f_out_type_t);
                     
                     
    //check if phones without area code should be included								 
    f_out_raw := if(inMod.Include7DigitPhones, f_out_raw_pre, f_out_raw_pre((unsigned)subj_phone10>10000000));

    //keep people at work phone if exclude business phone number
    f_out_all := if(inMod.IncludeBusinessPhones, f_out_raw, f_out_raw(subj_phone_type='10' or phpl_phones_plus_type<>'B'));
                       
    unsigned1 phone_type_score(string3 ph_type) := 
           map(ph_type = '1' => order_ES,
               ph_type = '2' => order_SE,
               ph_type = '3' => order_AP,
               ph_type = '4' => order_SP,
               ph_type = '41' => order_SP,
               ph_type = '42' => order_MD,
               ph_type = '43' => order_CL,
               ph_type = '44' => order_CR,
               ph_type = '5' => order_SX,
               ph_type = '6' => order_PP,
               ph_type = '7' => order_7,
               ph_type = '8' => order_NE,					 
               ph_type = '9' => order_RL,
               ph_type = '10' =>order_WK,
               ph_type = '11' => order_TH,
               99);
        
    f_out_srt := sort(f_out_all, acctno,
                      subj_phone10, phone_type_score(subj_phone_type), -subj_date_last, -subj_date_first, -ssn, -prim_name, -p_city_name, -zip5, -subj_last, -subj_first);

    f_pre_death_check := if(inMod.DedupOutputPhones, dedup(f_out_srt, acctno, subj_phone10), f_out_srt);

    //death check														
    deathparams := DeathV2_Services.IParam.GetRestrictions(mod_access);

    f_post_death_filter := join(f_pre_death_check,doxie.key_death_masterV2_ssa_DID,
                              keyed(left.p_did = right.l_did)  and
                              not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
                              transform(left),left only);

    f_out_dep_chk  := if (inMod.ExcludeDeadContacts,
                          f_post_death_filter,
                          f_pre_death_check);

    string2 type_new_cnv(string2 ph_type) := 
           map(ph_type = '1' => 'ES',
               ph_type = '2' => 'SE',
               ph_type = '3' => 'AP',
               ph_type = '41' => 'SP',
               ph_type = '42' => 'MD',
               ph_type = '43' => 'CL',
               ph_type = '44' => 'CR',
               ph_type = '5' => 'SX',
               ph_type = '6' => 'PP',
               ph_type = '7' => '',
               ph_type = '8' => 'NE',
               ph_type = '9' => 'RL',
               ph_type = '10' => 'WK',
               ph_type = '11' => 'TH',
               '');		
               
    string2 map_search_level(string2 ph_type) := 
      map(ph_type = 'EDAFLA' or ph_type = 'EDAFA' or ph_type = 'EDALA' => 'ES', 
          ph_type = 'EDACA' => 'AP',
          ph_type = 'EDADID' or ph_type = 'EDAHistory' => 'SE',
          ph_type = 'PPDID' or ph_type = 'PPFLA' or ph_type = 'PPLFA' or ph_type = 'PPFA' or 
                    ph_type = 'PPLA' or ph_type = 'PPCA'  or ph_type = 'INF' => 'PP',
          ph_type = 'PPTH' => 'TH',
          ph_type = 'MD' => 'MD',
          ph_type = 'SP' => 'SP',
          ph_type = 'REL' => 'RL',
          ph_type = 'CR' => 'CL',
          ph_type = 'RM' => 'CR',
          ph_type = 'PAW' => 'WK',
          ph_type = 'PDE' or ph_type = 'EXP' or ph_type = 'TU' or ph_type = 'TUPlus' => 'PR',
          ph_type = 'PF' or ph_type = 'PFFLA' or ph_type = 'PFLA' => 'PF',
          ph_type = 'UtilDID' => 'UT',
          ph_type = 'SX' => 'SX',
          ph_type = 'NE' => 'NE',
          ph_type = 'INPUT' => 'IN',
          '');		
            
    //get the carrier information			   
    batch_out_with_did get_carrier_info(f_out_dep_chk l,
                                        risk_indicators.key_telcordia_tpm r) := transform
      self.subj_phone_type_new := type_new_cnv(l.subj_phone_type);
      self.subj_phone_type := map(l.subj_phone_type in ['41', '42', '43', '44'] => '4',
                                  l.subj_phone_type = '9' => '5',
                                  l.subj_phone_type in ['8', '10'] => '',
                                  l.subj_phone_type);
      self.subj_name_dual := STD.Str.ToUpperCase(l.subj_name_dual);														
      self.phpl_phone_carrier := r.ocn;
      self.phpl_carrier_city := r.city;
      self.phpl_carrier_state := r.st;
      self.sort_order := phone_type_score(l.subj_phone_type);
      // the sort_order_internal from a Phones Plus source should only be used if the Include flag is true.  Relatives(43) should be oredered by the rank.
      self.sort_order_internal := if (((string)l.sub_rule_number)[1] = '6' and l.subj_phone_type <> '43' and ~inMod.IncludeCellFirstForPP,0,l.sort_order_internal);
      self := l;
    end;						

    f_out_almost_ready := join(f_out_dep_chk, risk_indicators.key_telcordia_tpm,
                               left.subj_phone10[1..3]=right.npa and
                               left.subj_phone10[4..6]=right.nxx and
                               left.subj_phone10[7]=right.tb, 
                               get_carrier_info(left, right),left outer, keep(1),limit(0));			   

    progressive_phone.mac_get_switchtype(f_out_almost_ready, f_out_ready, useNeustar)

    f_out_final_1 := PROJECT(f_out_ready, TRANSFORM(progressive_phone.layout_progressive_phone_common,
                                                    SELF := LEFT,
                                                    SELF := []));
                                                  
     progressive_phone.layout_progressive_batch_in xfm_capitalize_input(progressive_phone.layout_progressive_batch_in l) :=
        TRANSFORM
          SELF.name_first  := STD.Str.ToUpperCase(l.name_first);
          SELF.name_middle := STD.Str.ToUpperCase(l.name_middle);
          SELF.name_last   := STD.Str.ToUpperCase(l.name_last);
          SELF.name_suffix := STD.Str.ToUpperCase(l.name_suffix);			
          SELF.prim_range  := STD.Str.ToUpperCase(l.prim_range);	
          SELF.predir      := STD.Str.ToUpperCase(l.predir);	
          SELF.prim_name   := STD.Str.ToUpperCase(l.prim_name);	
          SELF.suffix      := STD.Str.ToUpperCase(l.suffix);	
          SELF.postdir     := STD.Str.ToUpperCase(l.postdir);	
          SELF.unit_desig  := STD.Str.ToUpperCase(l.unit_desig);	
          SELF.sec_range   := STD.Str.ToUpperCase(l.sec_range);	

          SELF.p_city_name := STD.Str.ToUpperCase(l.p_city_name);	
          SELF.st          := STD.Str.ToUpperCase(l.st);	
          
          SELF             := l;
        END;

    f_in_raw_capitalized := project(f_in_raw, xfm_capitalize_input(left));
          
    final_matched_noScore_nogateway := join(f_out_final_1, f_in_raw_capitalized,
         LEFT.acctno = RIGHT.acctno,													
         TRANSFORM(progressive_phone.layout_progressive_phone_common,
                tmpMatchName := ((LEFT.p_name_first = RIGHT.name_first AND LEFT.p_name_first <> '') OR 
                                 NID.mod_PFirstTools.PFLeqPFR(STD.Str.ToUpperCase(LEFT.p_name_first),RIGHT.name_first)) AND
                                 (LEFT.p_name_last = RIGHT.name_last AND LEFT.p_name_last <> '');
                SELF.match_name  :=  tmpMatchName;									
                tmpMatchStreetAddress :=  (LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_range <> '') AND
                                                 (LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_name <> '') AND
                                                 (LEFT.addr_suffix = RIGHT.suffix AND LEFT.addr_suffix <> '') AND
                                                 (LEFT.predir = RIGHT.predir) AND
                                                 (LEFT.postdir = RIGHT.postdir);		
                SELF.match_street_address := tmpMatchStreetAddress;																			 
                tmpMatchCity := (LEFT.p_city_name = RIGHT.p_city_name AND LEFT.p_city_name <> '');								
                SELF.match_city  := tmpMatchCity;								
                tmpMatchState := (LEFT.st = RIGHT.st AND LEFT.st <> '');
                SELF.match_state := tmpMatchState;
                tmpMatchZip   := (LEFT.zip5 = RIGHT.z5 AND LEFT.zip5 <> '');
                SELF.match_zip   := tmpMatchZip;
                // doesn't really do too much since input for right.ssn is string9 and thus implication is that - are not allowed
                // but keeping code here in case ssn input is at some point uncleaned on way into roxie service.
                tmpMatchSSN   := ((LEFT.ssn = stringlib.stringfilterout(RIGHT.ssn, '-')) AND (LEFT.ssn <> ''));
                SELF.match_ssn   := tmpMatchSSN;							
                tmpMatchDid   :=	LEFT.did = RIGHT.did AND LEFT.did <> 0; 					
                SELF.match_did   :=	tmpMatchDid;
                SELF.acctno      := LEFT.acctno; // sets acctno
                SELF.matches :=  ((~(inMod.NameMatch)) OR (tmpMatchName))
                                AND 
                               ((~(inMod.StreetAddressMatch)) OR (tmpMatchStreetAddress))
                                AND
                                ((~(inMod.CityMatch)) OR (tmpMatchCity))
                                AND
                                ((~(inMod.StateMatch)) OR (tmpMatchState))
                                AND
                                ((~(inMod.ZipMatch)) OR (tmpMatchZip))
                                AND
                                ((~(inMod.SSNMatch)) OR (tmpMatchSSN))														
                                AND
                                ((~(inMod.DIDMatch)) OR (tmpMatchDID));								
                 SELF.matchcodes := batchservices.functions.match_code_result(
                                      tmpMatchName, tmpMatchStreetAddress,
                                      tmpMatchCity, tmpMatchState,
                                      tmpMatchZip, tmpMatchSSN, FALSE,
                                                    tmpMatchDID);	 														
                 SELF.subj_phone_relationship := if (left.subj_phone_relationship <>'',
                                                      left.subj_phone_relationship,
                                                      if(left.phpl_phones_plus_type = 'B',
                                                          Person_Models.constants.str_Business, // 101
                                                      case (left.sub_rule_number, 81 => Person_Models.constants.str_neighbor,  // 81
                                                                         21 => Person_Models.constants.str_subject,//11,12,21,22,23,31 if not business,
                                                                                        //51,52,53,61,62,91
                                                                                        // 41,42,43,44 are rels and assocs and assigned before it gets here		
                                                                         Person_Models.constants.str_subject)));
                                                                         
                 SELF := LEFT;
                 // SELF := [];																			
                ));

    // -----------------------------------------------
    // Run the phone records through the scoring model
    // -----------------------------------------------

    MODEL_DEBUG := Progressive_Phone.Common.Model_Debug;

    f_out_final_scored_temp := progressive_phone.phones_score_model_v1(final_matched_noScore_nogateway, 
                                                                       f_with_did, 
                                                                       mod_access.glb, 
																																																																							Doxie.DataRestriction.fixed_DRM);

        		
    #if(MODEL_DEBUG)
    layout_progressive_phone_common_plus := RECORD
      // Progressive_Phone.layout_progressive_phone_common;
      Progressive_Phone.Common.Layout_Debug_v1; // Keep the attributes around!
    END;
    f_out_final_temp := PROJECT(f_out_final_scored_temp, TRANSFORM(layout_progressive_phone_common_plus, SELF := LEFT));
    #else
    f_out_final_temp := PROJECT(f_out_final_scored_temp, TRANSFORM(Progressive_Phone.layout_progressive_phone_common, SELF := LEFT));
    #end

    // dedup now if we did skipped it earlier.
    f_out_srt_2_legacy := sort(final_matched_noScore_nogateway(matches=TRUE), acctno,
                      subj_phone10, phone_type_score(subj_phone_type), -subj_date_last, -subj_date_first, -ssn, -prim_name, -p_city_name, -zip5, -subj_last, -subj_first);
    f_out_srt_2_scoring := sort(final_matched_noScore_nogateway(matches=TRUE), acctno,
                      subj_phone10, -(STD.Str.ToUpperCase(subj_phone_relationship) = 'SUBJECT'), phone_type_score(subj_phone_type), -subj_date_last, -subj_date_first, -ssn, -prim_name, -p_city_name, -zip5, -subj_last, -subj_first);
    f_out_srt_2 := IF(inMod.SkipPhoneScoring = TRUE, f_out_srt_2_legacy, f_out_srt_2_scoring);
    f_out_final_3 := if(inMod.KeepAllPhones, f_out_srt_2, dedup(f_out_srt_2, acctno, subj_phone10));			    

    f_out_final := topN(group(sort(f_out_final_3(subj_phone_type_new='ES'), acctno), acctno), 
                         if(inMod.CountES>0, inMod.CountES, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+
                    topN(group(sort(f_out_final_3(subj_phone_type_new='SE'), acctno), acctno), 
                         if(inMod.CountSE>0, inMod.CountSE, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 
                    topN(group(sort(f_out_final_3(subj_phone_type_new='AP'), acctno), acctno), 
                         if(inMod.CountAP>0, inMod.CountAP, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 
                    topN(group(sort(f_out_final_3(subj_phone_type_new='SP'), acctno), acctno), 
                         if(inMod.CountSP>0, inMod.CountSP, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		 
                    topN(group(sort(f_out_final_3(subj_phone_type_new='MD'), acctno), acctno), 
                         if(inMod.CountMD>0, inMod.CountMD, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		 
                    topN(group(sort(f_out_final_3(subj_phone_type_new='CL'), acctno), acctno), 
                         if(inMod.CountCL>0, inMod.CountCL, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		 
                    topN(group(sort(f_out_final_3(subj_phone_type_new='CR'), acctno), acctno), 
                         if(inMod.CountCR>0, inMod.CountCR, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		 
                    topN(group(sort(f_out_final_3(subj_phone_type_new='SX'), acctno), acctno), 
                         if(inMod.CountSX>0, inMod.CountSX, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		 
                    topN(group(sort(f_out_final_3(subj_phone_type_new='PP'), acctno), acctno), 
                         if(inMod.CountPP>0, inMod.CountPP, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		
                    topN(group(sort(f_out_final_3(subj_phone_type_new=''), acctno), acctno), 
                         if(inMod.Count7>0, inMod.Count7, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		
                    topN(group(sort(f_out_final_3(subj_phone_type_new='NE'), acctno), acctno), 
                         if(inMod.CountNE>0, inMod.CountNE, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+	
                    topN(group(sort(f_out_final_3(subj_phone_type_new='WK'), acctno), acctno), 
                         if(inMod.CountWK>0, inMod.CountWK, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)	+	
                    topN(group(sort(f_out_final_3(subj_phone_type_new='RL'), acctno), acctno), 
                         if(inMod.CountRL>0, inMod.CountRL, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first)  +
                    topN(group(sort(f_out_final_3(subj_phone_type_new='TH'), acctno), acctno), 
                         if(inMod.CountTH>0, inMod.CountTH, inMod.MaxPhoneCount), acctno, -subj_date_last, subj_phone10,-did, subj_date_first); 
                    
    f_out_legacy := TopN(group(sort(group(f_out_final), acctno), acctno), inMod.MaxPhoneCount, 
                  acctno, sort_order, sort_order_internal, -subj_date_last, subj_name_dual, subj_phone10,-did, subj_date_first);	

    // only keep the records that were in the legacy file and the GW records
    f_out_scored_temp_1 := join(f_out_final_temp, f_out_legacy,
                                left.subj_phone_type_new = right.subj_phone_type_new and	
                                left.subj_phone10 = right.subj_phone10 and
                                left.acctno = right.acctno and
                                left.subj_name_dual = right.subj_name_dual,transform(LEFT),keep(1),all);
														
    f_out_scored_temp_2 := dedupHistPhones(f_phone_in_hist, f_out_scored_temp_1, inMod);
   	f_out_scored := TopN(group(f_out_scored_temp_2, acctno, all), inMod.MaxPhoneCount, 
                  acctno, -phone_score, sort_order, sort_order_internal, -subj_date_last, subj_name_dual, subj_phone10,-did, subj_date_first);

    #if(MODEL_DEBUG)
    f_out_legacy_plus := PROJECT(f_out_legacy, TRANSFORM(layout_progressive_phone_common_plus, SELF := LEFT; SELF := []));
    f_out := IF(inMod.SkipPhoneScoring = TRUE, f_out_legacy_plus, SORT(f_out_scored, -phones_score));
    #else
    f_out := IF(inMod.SkipPhoneScoring = TRUE, f_out_legacy, SORT(f_out_scored, -phone_score));
    #end		
 		   
    RETURN f_out;

  END;



  /////////////////////////////////////////////////////////////
  // Waterfall Phones V8 / Contact Plus V3
  /////////////////////////////////////////////////////////////
v_enum := progressive_phone.Constants.Running_Version;
EXPORT GetPhonesV3(DATASET(progressive_phone.layout_progressive_batch_in) f_in_raw,
                      progressive_phone.iParam.Batch inMod = progressive_phone.waterfall_phones_options,	
                      DATASET(iesp.share.t_StringArrayItem) f_dedup_phones = DATASET([],iesp.share.t_StringArrayItem),
                      DATASET(Gateway.Layouts.Config) Gateways_In = DATASET([], Gateway.Layouts.Config),
                      DATASET(histphones_layout) f_phone_in_hist = DATASET([], histphones_layout),
                      UNSIGNED2 MaxNumAssociate = 0,
                      UNSIGNED2 MaxNumAssociateOther = 0,
                      UNSIGNED2 MaxNumFamilyOther = 0,
                      UNSIGNED2 MaxNumFamilyClose = 0,
                      UNSIGNED2 MaxNumParent = 0,
                      UNSIGNED2 MaxNumSpouse = 0,
                      UNSIGNED2 MaxNumSubject = 0,
                      UNSIGNED2 MaxNumNeighbor = 0,
																						STRING    modelName = '',
																				  BOOLEAN UsePremiumSource_A = FALSE,
                      INTEGER PremiumSource_A_limit = 0,
                      v_enum version = v_enum.WFP_V8, 
																						BOOLEAN RunRelocation = FALSE) := FUNCTION

    doxie.MAC_Header_Field_Declare()
    doxie.MAC_Selection_Declare()	

    Phone_Shell.Layout_Phone_Shell.Input makePhoneShell(progressive_phone.layout_progressive_batch_in le) := transform
      SELF.AcctNo 									:= le.acctno;
      SELF.DID 											:= le.did;
      SELF.FirstName 								:= le.name_first;
      SELF.MiddleName 							:= le.name_middle;
      SELF.LastName 								:= le.name_last;
      SELF.TitleName 								:= le.name_suffix;
      SELF.SuffixName 							:= le.name_suffix;
      SELF.City 										:= le.p_city_name;
      SELF.State 										:= le.st;
      SELF.Prim_Range 							:= le.prim_range;
      SELF.Predir										:= le.predir;
      SELF.Prim_Name 								:= le.prim_name;
      SELF.Addr_Suffix 							:= le.suffix;
      SELF.Postdir 									:= le.postdir;
						SELF.Unit_Desig								:= le.unit_desig;
      SELF.Sec_Range 								:= le.sec_range;
      SELF.zip4											:= le.z4;
      SELF.Zip5 										:= le.z5;
      SELF.SSN 											:= le.ssn;
      SELF.DateOfBirth 							:= le.dob;
      SELF.HomePhone 								:= le.phoneno;
      SELF.TransUnionGatewayEnabled := FALSE;
      SELF.TargusGatewayEnabled := FALSE;
      SELF.InsuranceGatewayEnabled := TRUE; // this is not a GW, its a key, thus it gives a slight scoring boost
    END;

    // phone_shell_in := PROJECT(f_in_raw, makePhoneShell(LEFT, COUNTER));
    phone_shell_in := PROJECT(f_in_raw, makePhoneShell(LEFT));

    Phone_Shell.Layout_Phone_Shell.Input addHistPhones(  Phone_Shell.Layout_Phone_Shell.Input le, 
                                                    DATASET(histphones_layout) ri) := TRANSFORM
      SELF.InputPhoneList := ri;
      SELF := le;
    END;

    // add input phones to dedup experian phones against input
    phone_shell_withphones_in := DENORMALIZE(phone_shell_in, f_phone_in_hist,
                                             LEFT.AcctNo = RIGHT.acctno,
                                             GROUP,
                                             addHistPhones(LEFT,ROWS(RIGHT)));
    
    // Returns the Phone data without the score.		
    phones_with_attrs := Phone_Shell.Phone_Shell_Function(	phone_shell_withphones_in, 
                                                            gateways_in,
                                                            GLB_Purpose,
                                                            DPPA_Purpose,
                                                            Doxie.DataRestriction.fixed_DRM,
                                                            Doxie.DataPermission.permission_mask,
                                                            ,
                                                            ,
                                                            ,
                                                            ,
                                                            ,
                                                            ,
                                                            ,
                                                            ,
                                                            ,
                                                            ,
																														inMod.IncludeLastResort,
                                                            IncludePhonesFeedback, 
																														Batch := COUNT(phone_shell_withphones_in) > 1, //if only called by batch products
																														BlankOutDuplicatePhones := inMod.BlankOutDuplicatePhones,
																														UsePremiumSource_A := UsePremiumSource_A,
																														RunRelocation := RunRelocation);
    
    // SCORE THE PHONES
    model_results  := if(version = v_enum.CP_V3,
															Phone_Shell.PhoneScore_cp3_v3(phones_with_attrs, Phone_Shell.Constants.Default_PhoneScore),
															Phone_Shell.PhoneScore_wf8_v3(phones_with_attrs));//v_enum.WFP_V8

    STRING2 map_source_code_phone_shell(STRING10 ph_type) := MAP
      (ph_type = 'EDAFLA' OR ph_type = 'EDAFA' OR ph_type = 'EDALA' => 'ES', 
          ph_type = 'EDACA' => 'AP',
          ph_type = 'EDADID' OR ph_type = 'EDAHistory' => 'SE',
          ph_type = 'PPDID' OR ph_type = 'PPFLA' OR ph_type = 'PPLFA' OR ph_type = 'PPFA' OR 
              ph_type = 'PPLA' OR ph_type = 'PPCA'  OR ph_type = 'INF' => 'PP',
          ph_type = 'PPTH' => 'TH',
          ph_type = 'MD' => 'MD',
          ph_type = 'SP' => 'SP',
          ph_type = 'REL' => 'RL',
          ph_type = 'CR' => 'CL',
          ph_type = 'RM' => 'CR',
          ph_type = 'PAW' => 'WK',
          //PDE = Targus, EXP = Experian, TU = TransUnion
          ph_type = 'PDE' OR ph_type = 'EXP' OR ph_type = 'TU' OR ph_type = 'EQP' => 'PR',
          ph_type = 'PF' OR ph_type = 'PFFLA' OR ph_type = 'PFLA' => 'PF',
          ph_type = 'UtilDID' => 'UT',
          ph_type = 'SX' => 'SX',
          ph_type = 'NE' => 'NE',
          ph_type = 'INPUT' => 'IN',
          '');		

    STRING map_source_code_order_phone_shell(STRING2 source_code) :=
      MAP(source_code = 'PR' => '1',
          source_code = 'ES' => '2',
          source_code = 'SE' => '3',
          source_code = 'SP' => '4',
          source_code = 'SX' => '5',
          source_code = 'CR' => '6',
          source_code = 'MD' => '7',
          source_code = 'PP' => '8',
          source_code = 'TH' => '9',
          source_code = 'AP' => '10',
          source_code = 'CL' => '11',
          source_code = 'PF' => '12',
          source_code = 'UT' => '13',
          source_code = 'NE' => '14',
          source_code = 'WK' => '15',
          source_code = 'RL' => '16',
          source_code = 'IN' => '17',
          '0');		

    /* Some of the data is returned from Phone Shell as a comma delimited list (eg. source codes and name parts)
       From the list of source codes we need to select the highest ranking one along with the name that was found
       with the source.  Here the comma delimited list are extracted out into a dataset.*/

    getSource(Phone_Shell.Layout_Phone_Shell.Layout_Sources sources) := FUNCTION
      rec := {STRING sField};
      
      SET OF STRING name_prefix_elems := Std.Str.SplitWords(sources.source_owner_name_prefix, ',');
      SET OF STRING name_first_elems := Std.Str.SplitWords(sources.source_owner_name_first, ',');
      SET OF STRING name_middle_elems := Std.Str.SplitWords(sources.source_owner_name_middle, ',');
      SET OF STRING name_last_elems := Std.Str.SplitWords(sources.source_owner_name_last, ',');
      SET OF STRING name_suffix_elems := Std.Str.SplitWords(sources.source_owner_name_suffix, ',');
      SET OF STRING source_code_elems := Std.Str.SplitWords(sources.source_list,',');
      SET OF STRING source_did_elems := Std.Str.SplitWords(sources.Source_Owner_DID,',');
      
      ds_source_code := DATASET(source_code_elems, rec);
      
      recall := RECORD
        STRING name_prefix;
        STRING name_first;
        STRING name_middle; 
        STRING name_last;
        STRING name_suffix; 
        STRING source_code; 
        STRING source_did;
        STRING order;
        INTEGER id;
      END;
        
      recall transall(ds_source_code l, INTEGER cnt) :=	TRANSFORM
        SELF.name_prefix := name_prefix_elems[cnt];
        SELF.name_first := name_first_elems[cnt];
        SELF.name_middle := name_middle_elems[cnt];
        SELF.name_last := name_last_elems[cnt];
        SELF.name_suffix := name_suffix_elems[cnt];
        SELF.source_did := source_did_elems[cnt];
        source_code := l.sField;
        SELF.id := cnt;
        source_code_2 := map_source_code_phone_shell(source_code); 
        SELF.source_code := source_code_2;
        SELF.order := map_source_code_order_phone_shell(source_code_2);
      END;
                          
      ds_temp_1:= project(ds_source_code,transall(LEFT, COUNTER));
      ds_temp_2 := SORT(ds_temp_1, (INTEGER)order);

      RETURN ds_temp_2[1];
    
    END;
    
    getRelationshipCategory(STRING relationship) := FUNCTION
        
        relationship_cap := STD.Str.ToUpperCase(relationship);
        
        rel_cat := MAP(	relationship_cap IN progressive_phone.Constants.Relationship.Associate => progressive_phone.Constants.Associate_Cat,
                    relationship_cap IN progressive_phone.Constants.Relationship.Associate_Other => progressive_phone.Constants.Associate_Other_Cat,
                    relationship_cap IN progressive_phone.Constants.Relationship.Family_Other => progressive_phone.Constants.Family_Other_Cat,
                    relationship_cap IN progressive_phone.Constants.Relationship.Family_Close => progressive_phone.Constants.Family_Close_Cat,
                    relationship_cap IN progressive_phone.Constants.Relationship.Parent => progressive_phone.Constants.Parent_Cat,
                    relationship_cap IN progressive_phone.Constants.Relationship.Spouse => progressive_phone.Constants.Spouse_Cat,
                    relationship_cap IN progressive_phone.Constants.Relationship.Subject => progressive_phone.Constants.Subject_Cat,
                    relationship_cap IN progressive_phone.Constants.Relationship.Neighbor => progressive_phone.Constants.Neighbor_Cat,
                    '');
                                                                            
        RETURN rel_cat;

    END;
    
    recs_with_rel_cat := RECORD
      STRING relationship_cat := '';
      progressive_phone.layout_progressive_phone_common;
    END;

    recs_with_rel_cat x_form_phone_shell(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout le) := TRANSFORM
      SELF.acctno 											:= le.phone_shell.Input_Echo.AcctNo;
    
      rSource 													:= getSource(le.phone_shell.Sources);
                            
      SELF.DID					:= (UNSIGNED6)TRIM(rSource.source_did,LEFT, RIGHT); //IF(rSource.source_did <> '' ,(UNSIGNED6)TRIM(rSource.source_did),le.phone_shell.Input_Echo.LexID);																											
      SELF.subj_first		:= rSource.name_first;
      SELF.subj_middle 	:= rSource.name_middle;
      SELF.subj_last 		:= rSource.name_last;
      SELF.subj_suffix 	:= rSource.name_suffix;
      
      SELF.phone_score	:= le.phone_shell.phone_model_score;
      SELF.subj_phone10 := le.phone_shell.gathered_phone;
      
      SELF.subj_name_dual := IF(le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_listing_name <> '',
                                le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_listing_name,
                                le.phone_shell.EDA_Characteristics.EDA_listing_name);													
      
      STRING relationship := le.phone_shell.Raw_Phone_Characteristics.phone_subject_title;			
      SELF.subj_phone_relationship 	:= relationship;

      SET OF STRING date_first_seen_elems := Std.Str.SplitWords(le.phone_shell.Sources.Source_List_First_Seen, ',');
      SET OF STRING date_last_seen_elems := Std.Str.SplitWords(le.phone_shell.Sources.Source_List_Last_Seen, ',');

      date_first_seen	:= MIN(date_first_seen_elems);
      date_last_seen := MAX(date_last_seen_elems);

      SELF.subj_date_first := date_first_seen;
      SELF.subj_date_last := date_last_seen;		
      
      SELF.phpl_phones_plus_type := MAP(le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_type = 'M' OR 
                                          le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_RP_type = 'M' => 'U',
                                        le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_type <> '' AND
                                          le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_type <> 'M' =>
                                        le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_type,
                                          le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_RP_type <> '' AND
                                        le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_RP_type <> 'M' =>
                                          le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_RP_type,
                                        '');
      
      SELF.phpl_phone_carrier := IF(le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_carrier <> '',
                                    le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_carrier, 
                                    le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_RP_carrier);
                                    
      SELF.phpl_carrier_city := IF(le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_city <> '',
                                    le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_city, 
                                    le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_RP_city);
                                    
      SELF.phpl_carrier_state := IF(le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_state <> '',
                                    le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_state,
                                    le.phone_shell.PhonesPlus_Characteristics.PhonesPlus_RP_state);
      
      SELF.dup_phone_flag := IF(COUNT(f_dedup_phones(f_dedup_phones.value IN [le.phone_shell.gathered_phone])) > 0, 'Y', 'N');
      SELF.switch_type := le.phone_shell.Raw_Phone_Characteristics.Phone_Switch_Type;
      SELF.subj_phone_possible_timezone := le.phone_shell.Raw_Phone_Characteristics.Phone_Timezone;
      SELF.subj_phone_address_zipcode_timezone := le.phone_shell.Raw_Phone_Characteristics.Address_Zipcode_Timezone;
      SELF.subj_phone_seen_freq	:= (STRING)COUNT(date_first_seen_elems); // totally arbitrary; could have used date_last_seen_elems.
      SELF.subj_phone_age := (STRING)ROUND(ut.MonthsApart(date_first_seen, date_last_seen));	
      SELF.matchcodes	:= STD.Str.FilterOut(le.phone_shell.Raw_Phone_Characteristics.Phone_Match_Code, ',');
      SELF.subj_phone_transient_flag := IF((BOOLEAN)le.phone_shell.Raw_Phone_Characteristics.Phone_High_Risk,'Y', 'N');
      SELF.subj_timezone_match_flag := IF((BOOLEAN)le.phone_shell.Raw_Phone_Characteristics.phone_timezone_match, 'Y', 'N');
			
			   //Check for EQUIFAX datasource
      SET OF STRING phone_shell_source_code_elems := Std.Str.SplitWords(le.phone_shell.sources.source_list,',');
						SELF.subj_phone_type_new := IF(le.phone_shell.Royalties.efxdatamart_royalty > 0, MDR.sourceTools.src_Equifax,
																																			rSource.source_code);													 
																
      SELF.vendor := IF(le.phone_shell.Royalties.lastresortphones_royalty > 0, MDR.sourceTools.src_wired_Assets_Royalty, '');              
      // temp field used for filtering recs later			
      SELF.relationship_cat := getRelationshipCategory(relationship);
      SELF := [];
    END;
    
    phones_out_temp := PROJECT(model_results, x_form_phone_shell(LEFT));
    
    phones_out_with_ported_date := JOIN(phones_out_temp, Phonesplus_v2.key_neustar_phone_history,
                                        KEYED(LEFT.subj_phone10 = RIGHT.phone) AND
                                        RIGHT.dt_first_seen <> 0 AND
                                        RIGHT.is_current,
                                        TRANSFORM(recs_with_rel_cat,
                                          SELF.subj_phone_ported_date := (STRING)RIGHT.dt_first_seen, SELF := LEFT),
                                        LIMIT (0), // max is ~10
                                        LEFT OUTER);
                                        
    phones_filt1 := dedupHistPhones(f_phone_in_hist, phones_out_with_ported_date, inMod);
		
		//*******EQUIFAX LOGIC to apply user limit to equifax results 0 to 3**********
		equifax_results := phones_filt1(subj_phone_type_new = MDR.sourceTools.src_Equifax);
		//ensure that equifax limit is no more than 3
		equifax_limit := if(PremiumSource_A_limit > progressive_phone.Constants.max_Equifax_Phones, progressive_phone.Constants.max_Equifax_Phones, PremiumSource_A_limit);
		equifax_srt := TOPN(GROUP(SORT(equifax_results, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10, -did, subj_date_first),acctno),
										equifax_limit, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10, -did, subj_date_first);
		phones_filt2 := if(UsePremiumSource_A, phones_filt1(subj_phone_type_new <> MDR.sourceTools.src_Equifax) + equifax_srt, phones_filt1);
		//******************************

    phones_out1 := TOPN(GROUP(SORT(phones_filt2(relationship_cat = progressive_phone.Constants.Associate_Cat), acctno), acctno), 
                      MaxNumAssociate, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first)	+
                  TOPN(GROUP(SORT(phones_filt2(relationship_cat = progressive_phone.Constants.Associate_Other_Cat), acctno), acctno), 
                       MaxNumAssociateOther, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 
                  TOPN(GROUP(SORT(phones_filt2(relationship_cat = progressive_phone.Constants.Family_Other_Cat), acctno), acctno), 
                       MaxNumFamilyOther, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 
                  TOPN(GROUP(SORT(phones_filt2(relationship_cat = progressive_phone.Constants.Family_Close_Cat), acctno), acctno), 
                       MaxNumFamilyClose, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		 
                  TOPN(GROUP(SORT(phones_filt2(relationship_cat = progressive_phone.Constants.Parent_Cat), acctno), acctno), 
                       MaxNumParent, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		 
                  TOPN(GROUP(SORT(phones_filt2(relationship_cat = progressive_phone.Constants.Spouse_Cat), acctno), acctno), 
                       MaxNumSpouse, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		 
                  TOPN(GROUP(SORT(phones_filt2(relationship_cat = progressive_phone.Constants.Subject_Cat), acctno), acctno), 
                       MaxNumSubject,  acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first)	+		 		 		 
                  TOPN(GROUP(SORT(phones_filt2(relationship_cat = progressive_phone.Constants.Neighbor_Cat), acctno), acctno), 
                       MaxNumNeighbor, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first);		 		 		 
    // select only the top - MaxPhoneCount phones 
												
	  phones_out1_Gr := GROUP(SORT(UNGROUP(phones_out1), acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first), acctno);
    phones_out1_TN := TOPN(phones_out1_Gr,inMod.MaxPhoneCount, acctno, -(INTEGER)phone_score, -subj_date_last, subj_phone10,-did, subj_date_first);
														
		// output(phones_with_attrs,named('Function_PHONE_SHELL_RESULTS')); 
		// output(model_results,named('Function_SCORING_RESULTS')); 
		// output(phones_out1_Gr,named('phones_out1_Gr')); 
		// output(phones_out1_TN,named('phones_out1_TN')); 												
												
		RETURN PROJECT(phones_out1_TN, progressive_phone.layout_progressive_phone_common);

  END;

  // The transform and projection in this function permit the blanking (setting to '')
  // of the phone10 field of each record depending on each record's switch type.
  // Which switch types are blanked is determined at runtime from a set of flags in the service request.
  // The logic is sum of products (OR of ANDs) as per requirements.
  EXPORT conditionallyBlankPhone10(rsUnblankedPhone10, modInput) := FUNCTIONMACRO

      RECORDOF(rsUnblankedPhone10) xformBlankOutByLineType(RECORDOF(rsUnblankedPhone10) le) := TRANSFORM
          SELF.subj_phone10 :=
                  IF ((le.switch_type='C' AND modInput.BlankOutLineTypeCell)
                  OR (le.switch_type='P' AND modInput.BlankOutLineTypePotsLand)
                  OR (le.switch_type='G' AND modInput.BlankOutLineTypePager)
                  OR (le.switch_type='V' AND modInput.BlankOutLineTypeVOIP)
                  OR (le.switch_type='I' AND modInput.BlankOutLineTypeIsland)
                  OR (le.switch_type='8' AND modInput.BlankOutLineTypeTollFree)
                  OR (le.switch_type='U' AND modInput.BlankOutLineTypeUnknown),
              '',
              le.subj_phone10);
          SELF := le;
      END;

      RETURN PROJECT(rsUnblankedPhone10, xformBlankOutByLineType(LEFT));

  ENDMACRO;

END;
