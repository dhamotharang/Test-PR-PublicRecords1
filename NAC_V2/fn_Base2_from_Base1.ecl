#stored('did_add_force', 'thor');
IMPORT NAC,std,ut,dops;


export fn_Base2_from_Base1(string version) := FUNCTION
	rawbase2 := Nac_V2.Files2.dsNCF2Base;

	contacts := nac_v2.fn_ProcessContactRecord(Nac_V2.Files2.dsProcessing);
	exceptions := nac_v2.fn_ProcessExceptionRecord(Nac_V2.Files2.dsProcessing);
	newdata := nac_v2.fn_constructBase2FromNCFEx(Nac_V2.Files2.dsProcessing, version);
	
	boolean newhead := NAC_V2.HVersion.NewHeader;
	base2a := 	IF(EXISTS(newdata),
									NAC_V2.fn_MergeWithBase(newdata, rawbase2, newhead) , // update base2 (don't like here if new header)
								rawbase2);
	base2 := IF(newhead, NAC_V2.proc_link(base2a), base2a) : INDEPENDENT;	// relink entire file
	
	// Filter out base1 records that may be in base2, and then
	//  convert base1 to baes2 format
	base1 := nac_v2.fn_Base1ToBase2(NAC_V2.fn_filterBase1(nac_V2.Files.Base, base2)) : INDEPENDENT;
	newbase := base1 + base2;
	
	lfn_base := Nac_V2.Superfile_List.sfBase2 + '::' + workunit;  		// includes base 1
	lfn_base2 := Nac_V2.Superfile_List.sfNCF2Base + '::' + workunit;	// just ncf2 data
	 
	collisions := NAC_V2.Mod_Collisions2(newbase).AllCollisions;
	lfn_collisions := Nac_V2.Superfile_List.sfCollisions + '::' + workunit;

	c1 := DATASET('~nac::out::collisions2::father', nac_v2.Layout_Collisions2.Layout_Collisions, thor);
	c2 :=DATASET(lfn_collisions, nac_v2.Layout_Collisions2.Layout_Collisions, thor);
	alertList := Nac_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('Alert','');

	version1 := NAC_V2.fn_Base1_Version;
	newcol := DATASET('~nac::v2::newcollisions::' + version, $.Layout_Collisions2.Layout_Collisions, thor);

	doit := SEQUENTIAL(
		OUTPUT(IF(version=version1, 'Versions Match', 'Outdated Base1: ' + version1)),
		nac_v2.Superfile_List.MoveReadyToProcessing,
		
		exceptions,
		contacts,			// process contacts before building base
		IF(EXISTS(newdata), OUTPUT(CHOOSEN(newdata,200), named('new_samples'))),
		
		OUTPUT(newbase,,lfn_base, COMPRESSED),
		nac_V2.Promote_Superfiles(Nac_V2.Superfile_List.sfBase2, lfn_base),
		OUTPUT(base2,,lfn_base2, COMPRESSED),
		nac_V2.Promote_Superfiles(Nac_V2.Superfile_List.sfNCF2Base, lfn_base2),
		OUTPUT(PROJECT(NOTHOR(STD.File.SuperFileContents(nac_V2.superfile_list.sfProcessing)),
							TRANSFORM(FsLogicalFileNameRecord,
								self.name := Std.Str.FindReplace(Std.Str.SplitWords(left.name, '::')[4], 'ncfx', 'ncf2');
							)), named('ncf2_processed')),
		nac_v2.Superfile_List.MoveProcessingToProcessed,
		
		nac_V2.BuildPayload(newbase, version),
		nac_v2.Build_keys(version),
		OUTPUT(collisions,,lfn_collisions,COMPRESSED,OVERWRITE, named('collisions')),
		nac_V2.Promote_Superfiles(Nac_V2.Superfile_List.sfCollisions, lfn_collisions),
		OUTPUT(Nac_V2.NewCollisions(c2, c1),,'~nac::v2::newcollisions::' + version, COMPRESSED, OVERWRITE,
											named('new_collisions')),
		Nac_V2.Promote_Superfiles(Nac_V2.superfile_list.sfNewCollisions, '~nac::v2::newcollisions::' + version),
		OUTPUT(NAC_V2.GetSampleRecords(version), named('v2_samples')),
		//RoxieKeybuild.updateversion('Nac2Keys',version,alertList,,'N'),
		if (ut.Weekday((integer)version[1..8]) = 'SATURDAY'
											,dops.updateversion( 'Nac2Keys', version[1..8], alertList,'Y','N',l_isprodready:='Y')
											,dops.updateversion( 'Nac2Keys', version[1..8], alertList,'N','N')
				),
		if (ut.Weekday((integer)version[1..8]) <> 'SATURDAY',
								Nac_v2.CreateOrbitEntry(version)),
		Nac.fn_Strata(version),
		NAC_V2.ProcessCollisions(newcol, version),
		IF(newhead, NAC_V2.HVersion.updateVersion)
	);

	return doit;
END;