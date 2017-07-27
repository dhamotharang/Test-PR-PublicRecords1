IMPORT TopBusiness_BIPV2, ut, MDR, _Validate, BIPv2;

EXPORT AMS_As_License (DATASET(AMS.Layouts.Base.StateLicense) pBase = AMS.Files().Base.StateLicense.QA) := FUNCTION
    
    License_Layout := TopBusiness_BIPV2.Layouts.rec_license_combined_layout;
    
	  //LICENSE MAPPING
		License_Layout trfMAPLicense(AMS.Layouts.Base.StateLicense l) := TRANSFORM
				SELF.source                      := mdr.sourceTools.src_AMS;       
				SELF.source_docid                := TRIM(l.ams_id);       
				SELF.license_state               := l.rawfields.st_lic_state;
				SELF.license_board               := l.rawfields.st_lic_brd_cd;
				SELF.license_number              := l.rawfields.st_lic_num;
				SELF.license_type                := l.rawfields.st_lic_type;
				SELF.issue_date                  := IF(_Validate.date.fIsValid(l.rawfields.st_lic_issue_date), l.rawfields.st_lic_issue_date, '');
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
																										
		from_ams_proj	:= PROJECT(pBase, trfMAPLicense(LEFT));
																	
		from_ams_dedp  := DEDUP(SORT(DISTRIBUTE(from_ams_proj,HASH(source_docid, license_number)),RECORD, LOCAL),RECORD, LOCAL);

		BdidSlim := RECORD
			STRING8 ams_id;
			UNSIGNED6 bdid := 0;
			UNSIGNED1 bdid_score := 0;
			BIPv2.IDlayouts.l_xlink_ids;
			UNSIGNED8 source_rec_id;
		END;
  	
    slim_ams_main := PROJECT(AMS.Files().Base.Main.QA, BdidSlim);
    
    // Join the association file to the parent to pick bdids and linkids
	  from_ams_join := JOIN(from_ams_dedp, slim_ams_main,
			                    LEFT.source_docid = RIGHT.ams_id,
			                    TRANSFORM(RECORDOF(from_ams_dedp),
				                    SELF.source_rec_id := (STRING)RIGHT.source_rec_id,
				                    SELF := RIGHT,
                            SELF := LEFT));

	  License_Layout RollupAMS(License_Layout L, License_Layout R) := TRANSFORM
		  SELF.issue_date               := (STRING)ut.LatestDate((INTEGER)L.issue_date,(INTEGER)R.issue_date);
		  SELF.expiration_date          := (STRING)ut.LatestDate((INTEGER)L.expiration_date,(INTEGER)R.expiration_date);
		  SELF.dt_first_seen            := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
					                             ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
		  SELF.dt_last_seen             := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
		  SELF.dt_vendor_first_reported := ut.EarliestDate(ut.EarliestDate(L.dt_vendor_first_reported,R.dt_vendor_first_reported),
					                             ut.EarliestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported));
		  SELF.dt_vendor_last_reported  := ut.LatestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
		  SELF.record_date              := ut.LatestDate(L.record_date,R.record_date);
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