Import SAM,ut,RoxieKeybuild,lib_FileServices;
EXPORT procBuildAll(string filedate) := function

pInFile := dedup(SAM.File_Sam, all);

outfile := SAM.Fn_map_BIP(pInFile);

ut.MAC_SF_BuildProcess(outfile,'~thor_data400::base::sam::bip_linkid',out_base,2,,true)

BuildAll := 
					sequential(out_base, SAM.procBuildKeys(filedate), 
					RoxieKeybuild.updateversion('SAMKeys',filedate,'wenhong.ma@lexisnexis.com, Melanie.Jackson@lexisnexis.com, jason.allerdings@lexisnexis.com',,'N'),
					output(choosen(SAM.key_linkID.key, 100), named('Sample_Records')),
					SAM.STRATA_SAM_Tracking(filedate))
			 :  FAILURE(FileServices.SendEmail('wenhong.ma@lexisnexis.com,Melanie.Jackson@lexisnexis.com,jason.allerdings@lexisnexis.com', 'SAM Keys Failure', thorlib.wuid() + ' on Boca Prod\n' + FAILMESSAGE));		

return buildAll;

end;