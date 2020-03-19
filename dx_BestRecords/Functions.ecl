import $.^.dx_BestRecords, $.^.Doxie;

EXPORT Functions := MODULE

	EXPORT dx_BestRecords.Constants.perm_type get_perm_type(boolean glb_flag = false, boolean nonblank_flag = false, 
		boolean utility_flag = false, boolean pre_glb_flag = false, 
		boolean filter_exp_flag = false, boolean filter_eq_flag = false, 
		boolean marketing_flag = false, boolean cnsmr_flag = false) := FUNCTION

		ptype_val := 
			IF(marketing_flag, 
				IF(pre_glb_flag, dx_BestRecords.Constants.perm_type.marketing_preglb, dx_BestRecords.Constants.perm_type.marketing),
				IF(cnsmr_flag, 
					dx_BestRecords.Constants.perm_type.infutor,
					IF(nonblank_flag,
						IF(glb_flag,
							MAP(utility_flag => dx_BestRecords.Constants.perm_type.glb_nonutil_nonblank,
								filter_exp_flag and filter_eq_flag => dx_BestRecords.Constants.perm_type.glb_nonen_noneq_nonblank, 
								filter_exp_flag => dx_BestRecords.Constants.perm_type.glb_nonen_nonblank,
								filter_eq_flag => dx_BestRecords.Constants.perm_type.glb_noneq_nonblank,		
								dx_BestRecords.Constants.perm_type.glb_nonblank),
							IF(pre_glb_flag,
								dx_BestRecords.Constants.perm_type.NONGLB_NONEQ_NONBLANK,
								dx_BestRecords.Constants.perm_type.nonglb_nonblank)
							),
						IF(glb_flag,
							MAP(utility_flag => dx_BestRecords.Constants.perm_type.glb_nonutil,
								filter_exp_flag and filter_eq_flag => dx_BestRecords.Constants.perm_type.glb_nonen_noneq,
								filter_exp_flag => dx_BestRecords.Constants.perm_type.glb_nonen,
								filter_eq_flag => dx_BestRecords.Constants.perm_type.glb_noneq,
								dx_BestRecords.Constants.perm_type.glb),
							IF(pre_glb_flag,
								dx_BestRecords.Constants.perm_type.NONGLB_NONEQ,
								dx_BestRecords.Constants.perm_type.nonglb)
							)
						)));
		RETURN ptype_val;

	END;

	// EXPORT dx_BestRecords.Constants.perm_type get_perm_type_idata(doxie.IDataAccess modAccess, boolean checkRNA = false, 
		// boolean useNonBlankKey = false, boolean useMarketing = false) := FUNCTION
		
		// glb_flag := modAccess.isValidGLB(checkRNA);
		// pre_glb_flag := modAccess.isPreGLBRestricted();
		// cnsmr_flag := modAccess.isConsumer();
		// utility_flag := modAccess.isUtility();
		// filter_exp := modAccess.isECHRestricted();
		// filter_eq := modAccess.isEQCHRestricted();

		// RETURN get_perm_type(glb_flag, useNonBlankKey, utility_flag, pre_glb_flag, 
			// filter_exp, filter_eq, useMarketing, cnsmr_flag);

	// END;

END;
