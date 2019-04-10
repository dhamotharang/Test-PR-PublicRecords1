IMPORT STD, BizLinkFull_QA;
EXPORT TestSettings() := FUNCTION

dSAOTData := BizLinkFull_QA.saotDataSample();
dData 		:= BizLinkFull_QA.modGetSamples.fGetSamples(50000);
filename 	:= '~thor::bipheader::validation::xlink_samples_' + WORKUNIT;	

RETURN SEQUENTIAL(
					 dSAOTData,
					 OUTPUT(dData,,filename, COMPRESSED, OVERWRITE, EXPIRE(180)), 
					 STD.file.PromoteSuperFileList(['~thor::bipheader::validation::xlink_samples'],filename)
					);

END;
					
