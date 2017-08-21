IMPORT TopBusiness_BIPV2, ut, MDR, _Validate, BIPv2;

EXPORT AMS_As_License (DATASET(AMS.Layouts.Base.StateLicense) pBase = AMS.Files().Base.StateLicense.QA) := FUNCTION
    
    License_Layout := TopBusiness_BIPV2.Layouts.rec_license_combined_layout;

    //LICENSE MAPPING    
    layout_brd_code := RECORD
      STRING2 state;
      STRING  degree;
      STRING  board_code;
      STRING  board_desc;
      STRING  board_name;
    END;

    brd_code_lookup := DATASET('~thor_data400::ams::lookup::brd_codes_names_trans_table',
                               layout_brd_code,CSV(HEADING(1),SEPARATOR(','),QUOTE('"')));
    
    layout_brdname_base := RECORD
      AMS.Layouts.Base.StateLicense;
      STRING60 board_name;
    END;

	  layout_brdname_base findBrdName(AMS.Layouts.Base.StateLicense input, layout_brd_code r) := TRANSFORM
      SELF.board_name   := StringLib.StringToUpperCase(TRIM(r.board_name,LEFT,RIGHT));
      SELF         			:= input; 		
    END; 
    
    from_brd_code_join := JOIN(pBase, brd_code_lookup,
      									       TRIM(LEFT.rawfields.st_lic_state,LEFT,RIGHT)  = TRIM(RIGHT.state,LEFT,RIGHT) AND
                               TRIM(LEFT.rawfields.st_lic_degree,LEFT,RIGHT) = TRIM(RIGHT.degree,LEFT,RIGHT) AND
                               TRIM(LEFT.rawfields.st_lic_brd_cd,LEFT,RIGHT) = TRIM(RIGHT.board_code,LEFT,RIGHT),
      									       findBrdName(LEFT,RIGHT),
      									       LEFT OUTER,LOOKUP
      										     );
    
	  //LICENSE MAPPING
		License_Layout trfMAPLicense(layout_brdname_base l) := TRANSFORM
				SELF.source                      := mdr.sourceTools.src_AMS;           
				SELF.source_docid                := TRIM(l.ams_id,RIGHT,LEFT) + '|' + TRIM(l.rawfields.st_lic_state) + '|' + TRIM(l.rawfields.st_lic_num);       
				SELF.license_state               := l.rawfields.st_lic_state;
        SELF.license_board               := IF(l.board_name = '', l.rawfields.st_lic_brd_cd, l.board_name);
				SELF.license_number              := l.rawfields.st_lic_num;
				SELF.license_type                := StringLib.StringToUpperCase(l.st_lic_type_desc);
				SELF.issue_date                  := IF(_Validate.date.fIsValid(l.rawfields.st_lic_issue_date) 
                                               AND (UNSIGNED)l.rawfields.st_lic_issue_date != 0, l.rawfields.st_lic_issue_date, '');
				SELF.expiration_date             := IF(_Validate.date.fIsValid(l.rawfields.st_lic_exp_date), l.rawfields.st_lic_exp_date, '');
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid((STRING)l.dt_first_seen), l.dt_first_seen, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid((STRING)l.dt_last_seen), l.dt_last_seen, 0);
				SELF.dt_vendor_first_reported    := IF(_Validate.date.fIsValid((STRING)l.dt_vendor_first_reported), l.dt_vendor_first_reported, 0);
				SELF.dt_vendor_last_reported     := IF(_Validate.date.fIsValid((STRING)l.dt_vendor_last_reported), l.dt_vendor_last_reported, 0);
				SELF.record_type 			           := l.record_type;
				SELF.record_date 			           := IF(_Validate.date.fIsValid(l.rawfields.update_date), (UNSIGNED4)l.rawfields.update_date, 0);
				SELF 							   						 := l;
				SELF 							   						 := [];
		END;
																										
		from_ams_proj	:= PROJECT(from_brd_code_join, trfMAPLicense(LEFT));
																	
		from_ams_dedp  := DEDUP(SORT(DISTRIBUTE(from_ams_proj,HASH(source_docid, license_number)),RECORD, LOCAL),RECORD, LOCAL);

		BdidSlim := RECORD
			STRING8 ams_id;
			UNSIGNED6 bdid := 0;
			UNSIGNED1 bdid_score := 0;
			BIPv2.IDlayouts.l_xlink_ids;
			UNSIGNED8 source_rec_id;
		END;
  	
    slim_ams_main := PROJECT(AMS.Files().Base.Main.QA, BdidSlim);

    from_ams_dedp_dist        := DISTRIBUTE(from_ams_dedp, HASH(TRIM(REGEXREPLACE('\\|.*', source_docid, ''))));
    from_slim_ams_main_dist   := DISTRIBUTE(slim_ams_main, HASH(TRIM(ams_id)));
    
    // Join the association file to the parent to pick bdids and linkids
	  from_ams_join := JOIN(from_ams_dedp_dist, from_slim_ams_main_dist,
			                    TRIM(REGEXREPLACE('\\|.*', LEFT.source_docid, ''),RIGHT,LEFT) = TRIM(RIGHT.ams_id,RIGHT,LEFT),
			                    TRANSFORM(RECORDOF(from_ams_dedp),
				                    SELF.source_rec_id := RIGHT.source_rec_id,
				                    SELF := RIGHT,
                            SELF := LEFT),
                            LOCAL);
    
    LatestDateStr(STRING pStr1, STRING pStr2) := FUNCTION
      tmpdate   := ut.LatestDate((INTEGER)pStr1,(INTEGER)pStr2);
      
      finaldate := MAP(TRIM(pStr1,LEFT,RIGHT) = ''                   => TRIM(pStr2,LEFT,RIGHT),
                       TRIM(pStr2,LEFT,RIGHT) = ''                   => TRIM(pStr1,LEFT,RIGHT),
                       tmpdate                = (INTEGER)pStr1       => TRIM(pStr1,LEFT,RIGHT),
                       tmpdate                = (INTEGER)pStr2       => TRIM(pStr2,LEFT,RIGHT),
                       '');
       
      RETURN finaldate; 
    END;

    EarliestDateInt(UNSIGNED pInt1, UNSIGNED pInt2) := FUNCTION
      tmpdate   := ut.EarliestDate(pInt1,pInt2);
      
      finaldate := MAP(pInt1 = 0   => pInt2,
                       pInt2 = 0   => pInt1,
                       tmpdate);
       
      RETURN finaldate; 
    END;

    LatestDateInt(UNSIGNED pInt1, UNSIGNED pInt2) := FUNCTION
      tmpdate   := ut.LatestDate(pInt1,pInt2);
      
      finaldate := MAP(pInt1 = 0   => pInt2,
                       pInt2 = 0   => pInt1,
                       tmpdate);
       
      RETURN finaldate; 
    END;

	  License_Layout RollupAMS(License_Layout L, License_Layout R) := TRANSFORM
		  SELF.issue_date               := LatestDateStr(L.issue_date,R.issue_date);
		  SELF.expiration_date          := LatestDateStr(L.expiration_date,R.expiration_date);
		  SELF.dt_first_seen            := EarliestDateInt(EarliestDateInt(L.dt_first_seen,R.dt_first_seen),
					                             EarliestDateInt(L.dt_last_seen,R.dt_last_seen));
		  SELF.dt_last_seen             := LatestDateInt(L.dt_last_seen,R.dt_last_seen);
		  SELF.dt_vendor_first_reported := EarliestDateInt(EarliestDateInt(L.dt_vendor_first_reported,R.dt_vendor_first_reported),
					                             EarliestDateInt(L.dt_vendor_last_reported,R.dt_vendor_last_reported));
		  SELF.dt_vendor_last_reported  := LatestDateInt(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
		  SELF.record_date              := LatestDateInt(L.record_date,R.record_date);
		  SELF                          := L;
	  END;
		
    from_ams_dist   := DISTRIBUTE(from_ams_join(DotID != 0 OR EmpID != 0 OR POWID != 0 OR ProxID != 0 OR SELEID != 0 OR
                                                OrgID != 0 OR UltID != 0),
                                                HASH(source_docid,source_rec_id));
    from_ams_sort   := SORT(from_ams_dist, bdid, source_docid, source_rec_id, license_number, license_state,
                            license_board, license_type, dt_first_seen, -dt_last_seen,
                            LOCAL);
		from_ams_rollup := ROLLUP(from_ams_sort, 
                             LEFT.bdid                        = RIGHT.bdid AND
                             LEFT.source_docid                = RIGHT.source_docid AND
                             LEFT.source_rec_id               = RIGHT.source_rec_id AND
                             LEFT.license_number              = RIGHT.license_number AND
                             LEFT.license_state               = RIGHT.license_state AND
                             LEFT.license_board               = RIGHT.license_board AND
                             LEFT.license_type                = RIGHT.license_type,
                             RollupAMS(LEFT, RIGHT),
                             LOCAL);
   
		RETURN from_ams_rollup;
END;