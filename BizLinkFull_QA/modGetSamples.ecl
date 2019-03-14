IMPORT STD, MDR, BIPV2;
EXPORT modGetSamples := MODULE

	SHARED dBase := modSources.dHeaderSource(rec_type!='Ol');
	
	SHARED modLayouts.lSrcLayout tHeaderSourcesToSample(RECORDOF(dBase) rIn) := TRANSFORM
	  SELF 									:= rIn;
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
		dBatchData									:= ENTH(modSources.dBatch,iNumSamples);

    dOutput00 		 := dSBFESource + dCorteraSource + dDNBSource + dSOSSource + dEBRSource + dEFXSource + dBASource + dJLSource + dRPSource + dBRSource + dDNB_FEIN_Source + dDNB_EN_FEIN_UnRest_Source + dDNB_EN_FEIN_Rest_Source + dSAOTSource + dTopBusiness + dPreFillData + dBatchData;

		RETURN dOutput00;
	END;
		
END;
