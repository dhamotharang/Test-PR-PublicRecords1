  
		
    sVersion := '';
	  profileDs  := BizLinkFull_ELERT.modProfiles.dProfileAll;
		dSamples := dataset('~thor::bizlinkfull::elert::samples::current',BizLinkFull_ELERT.modLayouts.lSampleLayout,thor);

	  // profileDs  := BizLinkFull_ELERT.modProfiles.IARProfile;
		// dSamples := dataset('~thor::bizlinkfull::elert::samples::20190530223501',BizLinkFull_ELERT.modLayouts.lSampleLayout,thor);
		
	  BizLinkFull_ELERT.macAnalyzeSamples(dSamples, profileDs, sVersion);
		fieldStats;
		recordStats;
		csvStats;
		
    BizLinkFull_ELERT.modCsv.EmailAsCSV(csvStats,'BizLinkFull_ELERT_Stats_'+sVersion+'',BizLinkFull_ELERT.modConstants.sEmailNotify,'BIP ELERT Sample Gathering For '+sVersion+' Has Finished','');
