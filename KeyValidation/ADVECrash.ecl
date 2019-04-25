IMPORT STD,ADVFiles,KeyValidation, ECrashADV;

buildVersionSumofSum := ADVFiles.CurrentBuildVersions.File(datasetname='EcrashV2Keys' and envment='Q' and location = 'B' and cluster = 'N')[1].buildversion;

LayoutBuildV := {string10 buildVer};	

buildVDataset :=  Dataset([{''}],LayoutBuildV);
		
LayoutBuildV CreateBuildVTransform(LayoutBuildV L):= TRANSFORM
		
	SELF.buildVer := buildVersionSumofSum;
		
END;
		
OutputDaybuild := OUTPUT(PROJECT(buildVDataset,CreateBuildVTransform(LEFT)),, '~adv::keyvalidaton::ecrash::buildVersion' ,CSV(HEADING(SINGLE)), OVERWRITE);
		
DespraybuildVersion := STD.FILE.DESPRAY( '~adv::keyvalidaton::ecrash::buildVersion', '10.48.72.34', 'C:\\Key\\' + 'Ecrash_buildVersion'  + '.csv',,,,true);

SEQUENTIAL(
OutputDaybuild,
ECrashADV.accnbr1Key,
ECrashADV.accnbrKey,
ECrashADV.autokeyaddressb2Key,
ECrashADV.autokeyaddressKey,
ECrashADV.autokeycitystatenameb2,
ECrashADV.autokeycitystatenameKey,
ECrashADV.autokeynameb2Key,
ECrashADV.autokeynameKey,
ECrashADV.autokeynamewordsKey,
ECrashADV.autokeypayloadKey,
ECrashADV.autokeystnameb2Key,
ECrashADV.autokeystnameKey,
ECrashADV.autokeyzipb2Key,
ECrashADV.autokeyZipKey,
ECrashADV.bdidKey,
ECrashADV.byagencyidKey,
ECrashADV.byhodKey,
ECrashADV.bymoyKey,
EcrashADV.byinterKey,
ECrashADV.collisiontypeKey,
ECrashADV.didKey,
ECrashADV.dlnbrKey,
ECrashADV.dolKey,
ECrashADV.dowKey,
ECrashADV.ecrash0Key,
ECrashADV.ecrash1Key,
ECrashADV.ecrash2Key,
ECrashADV.ecrash3Key,
ECrashADV.ecrash4Key,
ECrashADV.ecrash5Key,
ECrashADV.ecrash6,
ECrashADV.ecrash7,
ECrashADV.lastname_stateKey,
ECrashADV.linkidsKey,
ECrashADV.partialaccnbrKey,
ECrashADV.prefname_stKey,
ECrashADV.reportidKey,
ECrashADV.reportlinkidKey,
ECrashADV.standlocationKey,
ECrashADV.supplementalKey,
ECrashADV.tagnbrKey,
ECrashADV.vin7Key,
ECrashADV.vinKey,
DespraybuildVersion
);






