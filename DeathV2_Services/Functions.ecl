import DeathV2_Services, AutoStandardI, MDR, BatchServices, ut, D2C;

export Functions := module

	EXPORT boolean Restricted(string2 src, string1 glb_flag, boolean glb_ok, DeathV2_Services.IParam.DeathRestrictions in_mod) := function
		return AutoStandardI.DataRestrictionI.val(in_mod).isHeaderSourceRestricted(src, in_mod.DataRestrictionMask)
						or (~glb_ok and glb_flag = 'Y')
						or ((~in_mod.UseDeathMasterSSAUpdates or (in_mod.DeathMasterPurpose = DeathV2_Services.Constants.DeathMasterPurpose.NoPermissibleUse))and src = MDR.sourceTools.src_Death_Restricted)					
						or (in_mod.IsConsumer and src in D2C.Constants.DeathRestrictedSources)										
						or (in_mod.SuppressNonMarketingDeathSources and src in [DeathV2_Services.Constants.src_Death_NonMarketing_Sources]);			
	END;			 		
	
	SHARED csvStr2ds(STRING csvStr) := FUNCTION
   csvDataset:=DATASET([{csvStr}],{STRING5120 line});
   PATTERN alphaNum:=PATTERN('[[:alnum:]]+');
   PATTERN csvAlphaNum:=alphaNum ([',',' ']|LAST);
   RETURN PARSE(csvDataset,line,csvAlphaNum,TRANSFORM({string str},SELF.str:=MATCHTEXT(alphaNum)),SCAN);
	END;
	
	EXPORT GetMatchCodeIncludeStr(STRING mc_include, BOOLEAN partial_name_match_codes) := FUNCTION
		// match code filtering
		BOOLEAN hasPartialNameCodes := EXISTS(JOIN(csvStr2ds(mc_include),csvStr2ds(BatchServices.matchcodes.mc_include_partial_name),LEFT.str=RIGHT.str));
		// append partial name codes to mc_include only when mc_include does not have any partial name codes and is not null
		STRING mc_include_partial_name := IF(hasPartialNameCodes,mc_include,IF(mc_include!='',mc_include+','+BatchServices.matchcodes.mc_include_partial_name,''));
		// only use appended codes mc_include_partial_name when partial_name_match_codes is true		
		RETURN IF(partial_name_match_codes, mc_include_partial_name,mc_include);
	END;
	
end;
