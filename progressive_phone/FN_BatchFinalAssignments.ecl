import MDR,progressive_phone,Royalty;
export FN_BatchFinalAssignments(infile, outlayout, callMetronet=false, UsePremiumSource_A=false, scoreModel='\'\'') := functionmacro

//get the running version of waterfall phones / Contact plus
pHF         := progressive_phone.HelperFunctions;
PPC         := progressive_phone.Constants;
version     := pHF.FN_GetVersion(scoreModel,callMetronet,UsePremiumSource_A);
versionName := pHF.FN_GetVersionName(version);
v_enum      := PPC.Running_Version;

outlayout into_out(infile l, integer i) := transform

	formatted_dual_name := trim(l.subj_first) + if(trim(l.subj_middle) != '', ' ' + trim(l.subj_middle), '' )
	                       + ' ' + trim(l.subj_last) + if(trim(l.subj_suffix) != '', ' ' + trim(l.subj_suffix), '');
												 
	self.subj_name_dual := if(l.subj_phone_type_new IN PPC.Premium_Source_Set, formatted_dual_name, l.subj_name_dual);
	
	self.subj_phone_type_new := if(l.subj_phone_type_new IN PPC.Premium_Source_Set, PPC.premium, l.subj_phone_type_new);
	
// Add royalty_type field for batch. Batch is not yet able to handle Royalty_Set.
	self.royalty_type := map(l.subj_phone_type_new = MDR.sourceTools.src_Metronet_Gateway => Royalty.Constants.RoyaltyType.METRONET,
                           l.subj_phone_type_new = MDR.sourceTools.src_Equifax          => Royalty.Constants.RoyaltyType.EFX_DATA_MART,
                           l.vendor in Royalty.Constants.LastResortRoyalty              => Royalty.Constants.RoyaltyType.LAST_RESORT,
                           l.royalty_type);  
														
	//populate integrator code - needs to be set after the phones are sorted.								
	self.subj_phone_integrator_code := if(version in [v_enum.CP_V3,v_enum.WFP_V8]
																				,pHF.FN_GetIntegratorCode(l.dup_phone_flag,i,StringLib.StringToUpperCase(l.subj_phone_relationship))
																				,'');
	self.service_version := versionName; //for internal purposes at ecl layer
  self := l;
end;

outfile := if(version = v_enum.CP_V3,project(pHF.FN_FilterPerScore(infile), into_out(left,counter)),
                                     project(group(ungroup(infile),acctno), into_out(left,counter)));
return outfile;

endmacro;
