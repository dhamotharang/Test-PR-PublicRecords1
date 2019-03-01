IMPORT STD, MDR, BIPV2;
EXPORT modGetSamples := MODULE

	SHARED dBase := modSources.dHeaderSource(rec_type!='Ol');
	
	SHARED modLayouts.lSrcLayout tHeaderSourcesToSample(RECORDOF(dBase) rIn) := TRANSFORM
	  SELF.company_name 		:=rIn.company_name,
	  SELF.prim_range 			:=rIn.prim_range,
	  SELF.prim_name 				:=rIn.prim_name,
	  SELF.sec_range 				:=rIn.sec_range,
	  SELF.city 						:=rIn.p_city_name,
	  SELF.state 						:=rIn.st,
	  SELF.zip5  						:=rIn.zip,
	  SELF.phone10 					:=rIn.company_phone,
	  SELF.fein				  		:=rIn.company_fein,
	  SELF.url				  		:=rIn.company_url,
	  SELF.email						:=rIn.contact_email,
	  SELF.contact_fname 		:=rIn.fname,
	  SELF.contact_mname		:=rIn.mname,
	  SELF.contact_lname 		:=rIn.lname,
	  SELF.contact_ssn 			:=rIn.contact_ssn,
	  SELF.contact_did 			:=rIn.contact_did,
	  SELF.source 					:=rIn.source,
	  SELF.source_record_id :=rIn.source_record_id,
	  SELF.proxid 					:=rIn.proxid,
	  SELF.seleid 					:=rIn.seleid,
	  SELF 									:= [];
	END;
	
	SHARED BIPV2.IdAppendLayouts.AppendInput tRequestID(RECORDOF(modSources.dTopBusiness) rIn, UNSIGNED C) := TRANSFORM
		SELF.request_id				:= C;
	  SELF									:= rIn;
	END;	
	

 EXPORT fGetSamples(UNSIGNED iNumSamples) := FUNCTION
   
    dSBFESource         				:= PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_Business_Credit]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dCorteraSource     				  := PROJECT(ENTH(SORT(dBase(source in [MDR.SourceTools.src_Cortera]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dDNBSource      						:= PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_Dunn_Bradstreet]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dSOSSource      						:= PROJECT(ENTH(SORT(dBase(MDR.sourceTools.sourceisCorpV2(source)),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dEBRSource      						:= PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_EBR]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dEFXSource      						:= PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_Equifax_Business_Data]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dBASource      							:= PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_Bankruptcy]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dJLSource      							:= PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_Liens_v2]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dRPSource      							:= PROJECT(ENTH(SORT(dBase(MDR.sourceTools.SourceIsLnPropertyV2(source)),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dBRSource      							:= PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_Business_Registration]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dDNB_FEIN_Source      			:= PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_Dunn_Bradstreet_Fein]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dDNB_EN_FEIN_UnRest_Source  := PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_Experian_FEIN_Unrest]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
    dDNB_EN_FEIN_Rest_Source    := PROJECT(ENTH(SORT(dBase(source in [MDR.sourceTools.src_Experian_FEIN_rest]),-dt_last_seen,-rcid,skew(1.0)),iNumSamples),tHeaderSourcesToSample(LEFT));
		dSAOTSource									:= modSources.dSAOTData;
    dTopBusiness 								:= ENTH(modSources.dTopBusiness,iNumSamples);
		dPreFillData								:= ENTH(modSources.dPreFill,iNumSamples);		

    dOutput00 		 := dSBFESource + dCorteraSource + dDNBSource + dSOSSource + dEBRSource + dEFXSource + dBASource + dJLSource + dRPSource + dBRSource + dDNB_FEIN_Source + dDNB_EN_FEIN_UnRest_Source + dDNB_EN_FEIN_Rest_Source + dSAOTSource + dTopBusiness + dPreFillData;
		dOutput 			 := PROJECT(dOutput00, tRequestID(LEFT, COUNTER));

		RETURN dOutput;
	END;
		
END;
