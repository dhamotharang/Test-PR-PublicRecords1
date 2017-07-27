IMPORT TopBusiness_BIPV2, ut, MDR, _Validate, BIPv2;

EXPORT CNLD_Facilities_As_License (DATASET(CNLD_Facilities.layout_Facilities_AID_schd_BIP) pBase = 
                                           CNLD_Facilities.file_Facilities_AID_BIP) := FUNCTION
    
    License_Layout := TopBusiness_BIPV2.Layouts.rec_license_combined_layout;
    
	  //LICENSE MAPPING
		License_Layout trfMAPLicense(CNLD_Facilities.layout_Facilities_AID_schd_BIP l) := TRANSFORM
				SELF.bdid                        := l.bdid;       
				SELF.bdid_score                  := l.bdid_score;       
				SELF.source                      := MDR.sourceTools.src_CNLD_Facilities;       
				SELF.source_docid                := IF(l.st_lic_in <> '', l.st_lic_in, '') + IF(l.st_lic_num <> '', l.st_lic_num, '');     
				SELF.license_state               := l.st_lic_in;
				SELF.license_board               := l.std_prof_desc;
				SELF.license_number              := l.st_lic_num;
				SELF.license_type                := l.st_lic_type;
//				SELF.issue_date                  := IF(_Validate.date.fIsValid(l.rawfields.st_lic_issue_date), l.rawfields.st_lic_issue_date, '');
				SELF.expiration_date             := IF(_Validate.date.fIsValid(l.st_lic_num_exp), l.st_lic_num_exp, '');
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid(l.first_seen_date), (UNSIGNED4)l.first_seen_date, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid(l.last_seen_date), (UNSIGNED4)l.last_seen_date, 0);
				SELF.dt_vendor_first_reported    := IF(_Validate.date.fIsValid(l.first_seen_date), (UNSIGNED4)l.first_seen_date, 0);
				SELF.dt_vendor_last_reported     := IF(_Validate.date.fIsValid(l.last_seen_date), (UNSIGNED4)l.last_seen_date, 0);
//				SELF.record_type 			           := l.record_type;
				SELF.record_date 			           := IF(_Validate.date.fIsValid(l.process_date), (UNSIGNED4)l.process_date, 0);
				SELF 							   						 := l;
				SELF 							   						 := [];
		END;
																										
		from_cnld_proj	:= PROJECT(pBase, trfMAPLicense(LEFT));
																	
	  License_Layout RollupCNLD(License_Layout L, License_Layout R) := TRANSFORM
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
		
    from_cnld_dist   := DISTRIBUTE(from_cnld_proj(dotID != 0 OR empID != 0 OR powid != 0 OR proxid != 0 OR seleid != 0 OR
                                                  orgid != 0 OR ultid != 0),
                                                  HASH(ultID, source_docid, source_rec_id));
    from_cnld_sort   := SORT(from_cnld_dist, ultID, bdid, source_docid, source_rec_id, license_number, license_state,
                            license_board, license_type, dt_first_seen, -dt_last_seen,
                            LOCAL);
		from_cnld_rollup := ROLLUP(from_cnld_sort, 
                             LEFT.ultID                       = RIGHT.ultID AND
                             LEFT.bdid                        = RIGHT.bdid AND
                             LEFT.source_docid                = RIGHT.source_docid AND
                             LEFT.source_rec_id               = RIGHT.source_rec_id AND
                             LEFT.license_number              = RIGHT.license_number AND
                             LEFT.license_state               = RIGHT.license_state AND
                             LEFT.license_board               = RIGHT.license_board AND
                             LEFT.license_type                = RIGHT.license_type,
                             RollupCNLD(LEFT, RIGHT),
                             LOCAL);
   
		RETURN from_cnld_rollup;
END;