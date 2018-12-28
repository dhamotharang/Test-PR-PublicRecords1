import dx_BestRecords, Doxie;

EXPORT Functions := MODULE

	EXPORT $.Constants.perm_type get_perm_type(boolean glb_flag = false, boolean nonblank_flag = false, 
		boolean utility_flag = false, boolean pre_glb_flag = false, 
		boolean filter_exp_flag = false, boolean filter_eq_flag = false, 
		boolean marketing_flag = false, boolean cnsmr_flag = false) := FUNCTION

		ptype_val := 
			IF(marketing_flag, 
				IF(pre_glb_flag, $.Constants.perm_type.marketing_preglb, $.Constants.perm_type.marketing),
				IF(cnsmr_flag, 
					$.Constants.perm_type.infutor,
					IF(nonblank_flag,
						IF(glb_flag,
							MAP(utility_flag => $.Constants.perm_type.glb_nonutil_nonblank,
								filter_exp_flag and filter_eq_flag => $.Constants.perm_type.glb_nonexperian_nonequifax_nonblank, 
								filter_exp_flag => $.Constants.perm_type.glb_nonexperian_nonblank,
								filter_eq_flag => $.Constants.perm_type.glb_nonequifax_nonblank,		
								$.Constants.perm_type.glb_nonblank),
							IF(pre_glb_flag,
								$.Constants.perm_type.nonglb_nonblank_preglb,
								$.Constants.perm_type.nonglb_nonblank)
						),
						IF(glb_flag,
							MAP(utility_flag => $.Constants.perm_type.glb_nonutil,
								filter_exp_flag and filter_eq_flag => $.Constants.perm_type.glb_nonexperian_nonequifax,
								filter_exp_flag => $.Constants.perm_type.glb_nonexperian,
								filter_eq_flag => $.Constants.perm_type.glb_nonequifax,
								$.Constants.perm_type.glb),
							IF(pre_glb_flag,
								$.Constants.perm_type.nonglb_preglb,
								$.Constants.perm_type.nonglb)
						)
			)));
		RETURN ptype_val;

	END;

	EXPORT $.Constants.perm_type get_perm_type_idata(doxie.IDataAccess modAccess, boolean checkRNA = false, 
		boolean useNonBlankKey = false, boolean useMarketing = false) := FUNCTION
		
		glb_flag := modAccess.isValidGLB(checkRNA);
		pre_glb_flag := modAccess.isPreGLBRestricted();
		cnsmr_flag := modAccess.isConsumer();
		utility_flag := modAccess.isUtility();
		filter_exp := modAccess.isECHRestricted();
		filter_eq := modAccess.isEQCHRestricted();

		RETURN get_perm_type(glb_flag, useNonBlankKey, utility_flag, pre_glb_flag, 
			filter_exp, filter_eq, useMarketing, cnsmr_flag);

	END;

END;
