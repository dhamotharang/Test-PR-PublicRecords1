//This Function Macro accepts any DS of DIDs and sources and in_params
//with all restrictions and suppression fields see SSNBest_Services.IParams
//It then removes any record containing SRC that should be restricted per the in_params
EXPORT MAC_ApplyRestrictions(in_ds,in_params,_pSSN = 'ssn',_pDID = 'did',_pDateFS = 'dt_first_seen'):= FUNCTIONMACRO
	IMPORT doxie,ut,Drivers,mdr,Suppress,AutoStandardI;

  //No Global Module - this will use our defined in_params and not make any calls to the 
	//global module to access functions in both AutoStandardI.PermissionI_Tools & AutoStandardI.DataRestrictionI
	tempMod   := ut.PopulateDRI_Mod(in_params);
	NO_GM_PT  := AutoStandardI.PermissionI_Tools.val(tempMod);
	NO_GM_DR  := AutoStandardI.DataRestrictionI.val(tempMod);
	
	//FILTERS
	is_glb_preGlb_safe := (NO_GM_PT.glb.ok(in_params.GLBPurpose)
														AND NOT (NO_GM_PT.glb.restrictRNA(in_params.GLBPurpose) AND in_params.check_RNA_))
							           OR NO_GM_PT.glb.HeaderIsPreGLB(0, in_ds._pDateFS, in_ds.src); //date YYYYMM unsigned3
												 
	is_dppa_safe := ~mdr.Source_is_DPPA(in_ds.src)
							    OR ((NO_GM_PT.dppa.ok(in_params.DPPAPurpose)
									       AND NOT (NO_GM_PT.dppa.restrictRNA(in_params.DPPAPurpose) AND in_params.check_RNA_))
									    AND Drivers.state_dppa_ok(mdr.sourceTools.DPPAOriginState(in_ds.src),in_params.DPPAPurpose,in_ds.src));
											
	is_DRM_safe := ~NO_GM_DR.isHeaderSourceRestricted(in_ds.src, in_params.DataRestrictionMask);
	
	is_industry_class_safe := ~(in_ds.src in MDR.sourceTools.set_Utilities 
	                             AND in_params.industry_class = ut.IndustryClass.UTILI_IC); //'UTILI'

	// apply restrictions for GLB,DPPA,RNA,DRM,INDUSTRY_CLASS
	glb_dppa_DRM_IC_safe_ds := in_ds(is_glb_preGlb_safe AND is_dppa_safe
					                         AND is_DRM_safe AND is_industry_class_safe);

	//MINORS - we suppress all minor (age 0-18) records unless glb purpose is 2 (law enforcement) or IncludeMinors flag is TRUE.
	NO_GM_PT.glb.mac_FilterOutMinors(glb_dppa_DRM_IC_safe_ds,minor_safe_ds,,tempMod);

	//SUPPRESSION - we suppress all records found in our suppression keys
	Suppress.MAC_Suppress(minor_safe_ds,supp_DID_safe_ds,in_params.ApplicationType,Suppress.Constants.LinkTypes.DID,_pDID);
  Suppress.MAC_Suppress(supp_DID_safe_ds,supp_SSN_safe_ds,in_params.ApplicationType,Suppress.Constants.LinkTypes.SSN,_pSSN);
	//SSN PRUNING
	doxie.MAC_PruneOldSSNs(supp_SSN_safe_ds,recs_pruned,_pSSN,_pDID);
	//SSN MASKING
	Suppress.MAC_Mask(recs_pruned,recs_masked,_pSSN,none,true,false,,,,in_params.ssn_mask);

	out_final := IF(in_params.suppress_and_mask,recs_masked,minor_safe_ds);

	RETURN out_final;
ENDMACRO;