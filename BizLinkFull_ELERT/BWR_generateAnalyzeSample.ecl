  
sVersion  := '20190530223501';
// iNumSamples  := 9999999; //set high to take all
iNumSamples  := 10000; 
iExpireTime := 30;
sSamplesFileName := '';

#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT('name','BizLinkFull_ELERT Generate Samples ' + sVersion);

// Set Profile Dataset
profileDs  := BizLinkFull_ELERT.modProfiles.dProfileAll;
// profileDs  := BizLinkFull_ELERT.modProfiles.IARProfile;
// profileDs := DATASET([
											// {'TOPBUSINESS', ['T'],	44, 0,	75, 1, 2, 'Inquiry', []}
											// ], BizLinkFull_ELERT.modLayouts.profileRec);

// Get Sample		
baseData := BizLinkFull_ELERT.modFiles.fGetBase((integer)sVersion);   //Use full set of data to sample from
// baseData := PROJECT(DATASET('~foreign::prod_dali.br.seisint.com::thor::bip::qa::topBusiness', BIzLinkFull_ELERT.modLayouts.lSrcLayout, THOR),
		                         // TRANSFORM(recordof(left), SELF.SRC_CATEGORY:='T'; SELF := LEFT));
														 
														 
BizLinkFull_ELERT.macSourceSampler(profileDs, baseData, dSamples, false, iNumSamples);   //take the sample

// Use Existing Sample
// dSamples := dataset('~thor::bizlinkfull::elert::samples::20190527084800',BizLinkFull_ELERT.modLayouts.lSampleLayout,thor);
// dSamples := dataset('~thor::bizlinkfull::elert::samples::20190530223501',BizLinkFull_ELERT.modLayouts.lSampleLayout,thor); //use existing sample


//Analyze Sample
BizLinkFull_ELERT.macAnalyzeSamples(dSamples, profileDs, sVersion);

output(fieldStats, named('field_stats'),all); //output field stats
output(recordStats, named('record_stats'),all); //output record stats
output(csvStats, named('csv_stats'),all);

//Email it
BizLinkFull_ELERT.modCsv.EmailAsCSV(csvStats,'BizLinkFull_ELERT_Stats_'+sVersion+'',BizLinkFull_ELERT.modConstants.sEmailNotify,'BIP ELERT Sample Gathering For '+sVersion+' Has Finished','');
