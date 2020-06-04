IMPORT STD AS pkgSTD;
IMPORT BizLinkFull_ELERT;
IMPORT SALT311;

EXPORT modGetSamples2(DATASET(modLayouts.profileRec) dProfile, STRING sVersion, UNSIGNED iNumSamples, UNSIGNED iExpireTime = 30, STRING sSamplesFileName = '', STRING sInPrefix = '', boolean bUseForeign=false, unsigned iCountRecs2Pull=50000) := MODULE
  EXPORT fGetSamples(DATASET(modLayouts.profileRec) dProfile, UNSIGNED iNumSamples, UNSIGNED iBuildDate=0) := MODULE
		baseData := modFiles().fGetBase((integer)sVersion, dProfile, bUseForeign, iCountRecs2Pull) : independent;
        macSourceSampler(dProfile, baseData, samplerOut, false, iNumSamples); 
        EXPORT samplesOut := PROJECT(samplerOut,
                                    TRANSFORM(modLayouts.lSampleLayout, 
                                              self.seleid := 0,
                                              self.proxid := 0,
                                              self.input_seleid := left.seleid,
                                              self.input_proxid := left.proxid,
                                              SELF.uniqueID:=COUNTER,
                                              /*SELF.zip_radius_miles := IF(LEFT.zip5<>'',BizLinkFull_ELERT.modConstants.uZip_radius_miles,0);*/
                                              SELF:=LEFT));
  END;
  
 
  //Load a previously made set of samples, first check to see if there is a ~ or not
  sSampleStringCleaned := IF(sSamplesFileName[1] <> '~', '~' + sSamplesFileName, sSamplesFileName);
  dImportedSamples := DATASET(sSampleStringCleaned,BizLinkFull_ELERT.modLayouts.lSampleLayout,THOR);
  EXPORT dGeneratedSamples := IF(sSamplesFileName = '', fGetSamples(dProfile, iNumSamples, (integer)sVersion).samplesOut, dImportedSamples);
  EXPORT aOutput := OUTPUT(dGeneratedSamples,,modFilenames(sInPrefix).kSamplesLF(sVersion),COMPRESSED,EXPIRE(iExpireTime),OVERWRITE);
  SHARED aPromoteSuperfile := modSuperfiles(sInPrefix).macUpdateSF(modFilenames(sInPrefix).kSamplesLF(sVersion),modFilenames(sInPrefix).kSamplesSF);
  // SHARED aEmailCSV := fEmailAsCSV(dGeneratedSamples, dProfile, 'Healthcare_Provider_Header_ELERT_Stats_'+sVersion+'',modConstants.sEmailNotify,'Healthcare Provider Header ELERT Sample Gathering For '+sVersion+' Has Finished','');
  EXPORT aBuildSamples := SEQUENTIAL(pkgSTD.File.StartSuperFileTransaction(),
                        aOutput,
                        aPromoteSuperfile,
                        pkgSTD.File.FinishSuperFileTransaction());
                        //aEmailCSV);
END;
