IMPORT ut,strata;

EXPORT strata_phonemart(string filedate) := FUNCTION

	basefile 			:= PhoneMart.Files.base;
	dPopulationStats_Base    :=  strata.macf_pops(basefile, 'RECORD_TYPE',,,,,TRUE,['scrubsbits1','scrubsbits2']); 
	// Call the STRATA function to generate the XML stats 
	strata.createXMLStats(dPopulationStats_Base ,'PhoneMart','data',filedate,'',stata_out,'view','population');

  RETURN parallel(stata_out);

END;
