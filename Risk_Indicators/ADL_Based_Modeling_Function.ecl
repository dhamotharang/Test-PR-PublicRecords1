import gong, riskwise, address, ut, Gateway;

export ADL_Based_Modeling_Function(DATASET (risk_indicators.layout_input) indata,
																		DATASET (Gateway.Layouts.Config) gateways,
																		unsigned1 dppa_purpose, unsigned1 glb_purpose, 
																		boolean isFCRA = false,
																		integer1 bsversion=1,
																		boolean isUtility = false,
																		boolean ln_branded = false,
																		boolean ofac_only = true,
																		boolean suppressNearDups = false,
																		boolean require2ele = false,
																		boolean from_biid = false,
																		boolean excludeWatchlists = false,
																		boolean from_IT1O = false,
																		unsigned1 ofac_version = 1,
																		boolean include_ofac = true,
																		boolean include_additional_watchlists = false,
																		real watchlist_threshold = 0.84,
																		integer2 dob_radius = -1,
																		boolean includeRelativeInfo=true, 
																		boolean includeDLInfo=true,
																		boolean includeVehInfo=true, 
																		boolean includeDerogInfo=true, 
																		boolean doScore = false, 
																		boolean nugen = false,
																		string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
																		string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
                                    string100 IntendedPurpose=''
																		) := function										
										

// ====================================================================
// step 1.  call the adl based IID
// ====================================================================
unsigned8 BSOptions:=0;
iid_results_with_flags := risk_indicators.ADL_Based_Modeling_IID_function(indata,
																		gateways, 
																		dppa_purpose, 
																		glb_purpose, 
																		isFCRA,
																		bsversion, 
																		isUtility,
																		ln_branded,
																		ofac_only,
																		suppressNearDups,
																		require2ele,
																		from_biid,
																		excludeWatchLists,
																		from_IT1O,
																		ofac_version,
																		include_ofac,
																		include_additional_watchlists,
																		watchlist_threshold,
																		dob_radius, 
																		DataRestriction,
																		BSOptions,
																		DataPermission,
                                    IntendedPurpose);

// ====================================================================
// step 2.  trim off the flags to pass just layout output into shell
// ====================================================================
iid_results := project(iid_results_with_flags, transform(risk_indicators.Layout_Output, self := left));
																		

// ====================================================================
// step 3.  call the bocashell with the modified IID results
// ====================================================================

bs_ret := risk_indicators.Boca_Shell_Function(iid_results, 
																						gateways, 
																						DPPA_Purpose, 
																						GLB_Purpose, 
																						isUtility,
																						ln_branded,
																						includeRelativeInfo, 
																						includeDLInfo, 
																						includeVehInfo, 
																						includeDerogInfo, 
																						bsversion, 
																						doScore, 
																						nugen,
																						datarestriction:=datarestriction,
																						datapermission:=datapermission);

// ====================================================================
// step 4.  append adl_based_modeling fields to bocashell results
// ====================================================================											

j := group( join(bs_ret, iid_results_with_flags, left.seq = right.seq, transform(risk_indicators.Layout_Boca_Shell, 
						self.adl_shell_flags.in_addrpop	 := right.in_addrpop	 ;
						self.adl_shell_flags.in_hphnpop	 := right.in_hphnpop	 ;
						self.adl_shell_flags.in_ssnpop	 := right.in_ssnpop	 ;
						self.adl_shell_flags.in_dobpop	 := right.in_dobpop	 ;
						self.adl_shell_flags.adl_addr	 := right.adl_addr	 ;
						self.adl_shell_flags.adl_hphn	 := right.adl_hphn	 ;
						self.adl_shell_flags.adl_ssn	 := right.adl_ssn	 ;
						self.adl_shell_flags.adl_dob	 := right.adl_dob	 ;
						self.adl_shell_flags.in_addrpop_found	 := right.in_addrpop_found	 ;
						self.adl_shell_flags.in_hphnpop_found	 := right.in_hphnpop_found	 ;
						self := left	)), seq);
																								
return j;

end;
