IMPORT ut;

EXPORT fRollup_nmls := MODULE

EXPORT Regulatory(DATASET(Prof_License_Mari.layouts.Regulatory_Action) int0) := FUNCTION

// Map input layout to base layout
ds := PROJECT(int0,TRANSFORM(Prof_License_Mari.layouts.Regulatory_Action_Base,SELF:=LEFT,SELF:=[]));

ds_dist	:= DISTRIBUTE(ds, HASH(STD_SOURCE_UPD,STATE_ACTION_ID,NMLS_ID, MULTI_STATE_ID));
	 
ds_sort   := SORT(ds_dist,	STD_SOURCE_UPD, STATE_ACTION_ID, NMLS_ID, MULTI_STATE_ID,AFFIL_TYPE_CD, REGULATOR, ACTION_TYPE,URL, 
                              -DATE_FIRST_SEEN, -DATE_LAST_SEEN, -PROCESS_DATE,LOCAL);


 Prof_License_Mari.layouts.Regulatory_Action_Base rollupXform(Prof_License_Mari.layouts.Regulatory_Action_Base l, Prof_License_Mari.layouts.Regulatory_Action_Base r) := transform
			SELF.date_first_seen    := (STRING)ut.EarliestDate(
                                                   ut.EarliestDate((INTEGER)l.date_first_seen,	(INTEGER)r.date_first_seen)
                                                   ,ut.EarliestDate((INTEGER)l.date_last_seen,	(INTEGER)r.date_last_seen)
																														);
      SELF.date_last_seen     := (STRING)MAX((INTEGER)l.date_last_seen,(INTEGER)r.date_last_seen);
			SELF.date_vendor_first_reported := (STRING)ut.EarliestDate(
                                                   ut.EarliestDate((INTEGER)l.date_vendor_first_reported,	(INTEGER)r.date_vendor_first_reported)
                                                   ,ut.EarliestDate((INTEGER)l.date_vendor_first_reported,	(INTEGER)r.date_vendor_first_reported)
																														);
                                                            
      SELF.date_vendor_last_reported := (STRING)MAX((INTEGER)l.date_vendor_last_reported, (INTEGER)r.date_vendor_last_reported);
      SELF.process_date := (STRING)MAX((INTEGER)l.process_date,(INTEGER)r.process_date); 
      SELF.action_dte   := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.action_dte, r.action_dte);
      SELF.docket_nbr   := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.docket_nbr, r.docket_nbr);
      SELF.cln_action_dte := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.cln_action_dte, r.cln_action_dte);
                                                            
      SELF := l;
      SELF := [];
   END;
   
   
dDataset_rollup := ROLLUP( ds_sort,
															TRIM(LEFT.std_source_upd)     = TRIM(RIGHT.std_source_upd)
															AND LEFT.state_action_id      = RIGHT.state_action_id
															AND LEFT.nmls_id              = RIGHT.nmls_id
															AND LEFT.multi_state_id       = RIGHT.multi_state_id
                              AND TRIM(LEFT.affil_type_cd)  = TRIM(RIGHT.affil_type_cd)
                              AND TRIM(LEFT.regulator)      = TRIM(RIGHT.regulator)
                              AND TRIM(LEFT.action_type)    = TRIM(RIGHT.action_type)
                              AND TRIM(LEFT.url)            = TRIM(RIGHT.url),
                            	rollupXFORM(LEFT, RIGHT)
														  );
			 
basefile_rollup_reg := dDataset_rollup;
    
    RETURN basefile_rollup_reg;
    
END;     
     
     
EXPORT Disciplinary(DATASET(Prof_License_Mari.layouts.Disciplinary_Action) int0) := FUNCTION

// Map input layout to base layout
ds := PROJECT(int0,TRANSFORM(Prof_License_Mari.layouts.Disciplinary_Action_Base,SELF:=LEFT,SELF:=[]));

ds_dist_disp	:= DISTRIBUTE(ds, HASH(STD_SOURCE_UPD,INDIVIDUAL_NMLS_ID,STATE_ACTION_ID));
	 
ds_sort_disp   := SORT(ds_dist_disp,	STD_SOURCE_UPD, INDIVIDUAL_NMLS_ID, STATE_ACTION_ID, AUTHORITY_TYPE, AUTHORITY_NAME, URL, 
                      -DATE_FIRST_SEEN, -DATE_LAST_SEEN, -PROCESS_DATE,LOCAL);


 Prof_License_Mari.layouts.Disciplinary_Action_Base rollupXform_discplinary(Prof_License_Mari.layouts.Disciplinary_Action_Base l, Prof_License_Mari.layouts.Disciplinary_Action_Base r) := transform
			 SELF.date_first_seen      := (STRING)ut.EarliestDate(
                                                   ut.EarliestDate((INTEGER)l.date_first_seen,	(INTEGER)r.date_first_seen)
                                                   ,ut.EarliestDate((INTEGER)l.date_last_seen,	(INTEGER)r.date_last_seen)
																														);
      SELF.date_last_seen     := (STRING)MAX((INTEGER)l.date_last_seen,(INTEGER)r.date_last_seen);
			SELF.date_vendor_first_reported := (STRING)ut.EarliestDate(
                                                   ut.EarliestDate((INTEGER)l.date_vendor_first_reported,	(INTEGER)r.date_vendor_first_reported)
                                                   ,ut.EarliestDate((INTEGER)l.date_vendor_first_reported,	(INTEGER)r.date_vendor_first_reported)
																														);
                                                            
      SELF.date_vendor_last_reported := (STRING)MAX((INTEGER)l.date_vendor_last_reported, (INTEGER)r.date_vendor_last_reported);
      SELF.process_date   := (STRING)MAX((INTEGER)l.process_date,(INTEGER)r.process_date); 
      SELF.action_type    := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.action_type, r.action_type);
      SELF.action_dte     := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.action_dte, r.action_dte);
      SELF.action_detail  := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.action_detail, r.action_detail);
      SELF.cln_action_dte := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.cln_action_dte, r.cln_action_dte);
      SELF := l;
   END;
   
   
    dDataset_rollup_disp := ROLLUP( ds_sort_disp,
															TRIM(LEFT.std_source_upd)     = TRIM(RIGHT.std_source_upd)
															AND LEFT.state_action_id      = RIGHT.state_action_id
															AND LEFT.individual_nmls_id   = RIGHT.individual_nmls_id
														  AND TRIM(LEFT.authority_type) = TRIM(RIGHT.authority_type)
                              AND TRIM(LEFT.authority_name) = TRIM(RIGHT.authority_name)
                              AND TRIM(LEFT.url)            = TRIM(RIGHT.url),
                            	rollupXform_discplinary(LEFT, RIGHT)
														  );
			 
basefile_rollup_disp := dDataset_rollup_disp; 

RETURN  basefile_rollup_disp;

END;    
      
      
EXPORT indv_detail(DATASET(Prof_License_Mari.layouts.Individual_Reg) int0) := FUNCTION

// Map input layout to base layout
ds := PROJECT(int0,TRANSFORM(Prof_License_Mari.layouts.Individual_Reg_Base,SELF:=LEFT,SELF:=[]));

ds_dist_indv	 := DISTRIBUTE(ds, HASH(STD_SOURCE_UPD,RECORD_TYPE_IND,INDIVIDUAL_NMLS_ID, COMPANY_NMLS_ID,INSTIT_NMLS_ID,LICENSE_ID));
	 
ds_sort_indv   := SORT(ds_dist_indv,	STD_SOURCE_UPD,RECORD_TYPE_IND,INDIVIDUAL_NMLS_ID, COMPANY_NMLS_ID,INSTIT_NMLS_ID,LICENSE_ID,RAW_LICENSE_TYPE, 
                              -DATE_FIRST_SEEN, -DATE_LAST_SEEN, -PROCESS_DATE,LOCAL);


 Prof_License_Mari.layouts.Individual_Reg_Base rollupXform_detail(Prof_License_Mari.layouts.Individual_Reg_Base l, Prof_License_Mari.layouts.Individual_Reg_Base r) := transform
			SELF.date_first_seen      := (STRING)ut.EarliestDate(
                                                   ut.EarliestDate((INTEGER)l.date_first_seen,	(INTEGER)r.date_first_seen)
                                                   ,ut.EarliestDate((INTEGER)l.date_last_seen,	(INTEGER)r.date_last_seen)
																														);
      SELF.date_last_seen     := (STRING)MAX((INTEGER)l.date_last_seen,(INTEGER)r.date_last_seen);
			SELF.date_vendor_first_reported := (STRING)ut.EarliestDate(
                                                   ut.EarliestDate((INTEGER)l.date_vendor_first_reported,	(INTEGER)r.date_vendor_first_reported)
                                                   ,ut.EarliestDate((INTEGER)l.date_vendor_first_reported,	(INTEGER)r.date_vendor_first_reported)
																														);
                                                            
      SELF.date_vendor_last_reported := (STRING)MAX((INTEGER)l.date_vendor_last_reported, (INTEGER)r.date_vendor_last_reported);
      SELF.process_date           := (STRING)MAX((INTEGER)l.process_date,(INTEGER)r.process_date); 
      SELF.name_registration      := IF(l.date_vendor_first_reported > r.date_vendor_first_reported,l.name_registration,r.name_registration);
      SELF.reg_status             := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.reg_status, r.reg_status);
      SELF.is_Authorized_Conduct  := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.is_Authorized_Conduct, r.is_Authorized_Conduct);
      SELF.name_employer          := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.name_employer, r.name_employer);
      SELF.name_company           := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.name_company, r.name_company);
      SELF.std_license_desc       := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.std_license_desc, r.std_license_desc);
      SELF.start_dte              := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.start_dte, r.start_dte);
      SELF.end_dte                := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.end_dte, r.end_dte);
      SELF.cln_start_dte          := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.cln_start_dte, r.cln_start_dte);
      SELF.cln_end_dte            := IF(l.date_vendor_first_reported > r.date_vendor_first_reported, l.cln_end_dte, r.cln_end_dte);
                                                            
SELF := l;
   END;
   
   
dDataset_rollup_reg := ROLLUP( ds_sort_indv,
															TRIM(LEFT.std_source_upd)         = TRIM(RIGHT.std_source_upd)
                              AND LEFT.record_type_ind          = RIGHT.record_type_ind
															AND LEFT.individual_nmls_id       = RIGHT.individual_nmls_id
                              AND LEFT.company_nmls_id          = RIGHT.company_nmls_id
                              AND LEFT.instit_nmls_id           = RIGHT.instit_nmls_id
															AND LEFT.license_id               = RIGHT.license_id
                              AND TRIM(LEFT.raw_license_type)   = TRIM(RIGHT.raw_license_type)
                              AND TRIM(LEFT.regulator)          = TRIM(RIGHT.regulator),
                            	rollupXFORM_detail(LEFT, RIGHT)
														  );
			 
basefile_rollup_reg := dDataset_rollup_reg;  

   
   
   RETURN basefile_rollup_reg; 
END;

END;