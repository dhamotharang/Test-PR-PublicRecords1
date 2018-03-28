// This module returns ECL strings replicating the various SALT-generated BWR
// attributes, with optional behavior enabled or disabled as parameterized.
IMPORT SALT311;
EXPORT GenBWR(TYPEOF(SALT311.iGenerationMod) gMod) := MODULE
	EXPORT BWR_Hygiene() := FUNCTION
		RETURN 
			'#OPTION(\'multiplePersistInstances\', FALSE);\n'
			+'#workunit(\'name\',\'' + gMod.spc_MODULE + '.BWR_Hygiene - Hygiene & Stats - SALT ' + gMod.salt_VERSION + '\');\n'
			+'IMPORT ' + gMod.spc_MODULE + ',' + gMod.salt_MODULE + ';\n'
			+'infile := ' + gMod.spc_MODULE + '.' + gMod.spc_FILEPREFIX + gMod.spc_FILENAME + ';\n'
			+'ip := DISTRIBUTE(infile, SKEW(0.1));\n'
			+'h := ' + gMod.spc_MODULE + '.Hygiene(ip);\n'
			+'p := h.AllProfiles; // Detailed profile of every field\n'		
			+'OUTPUT(h.Summary(\'SummaryReport\'),ALL);\n'
			
			+IF(gMod.spc_SOURCEFIELD<>'',
				'OUTPUT(h.SourceCounts,ALL,NAMED(\'SourceCounts\'));\n'
				+'OUTPUT(h.CrossLinkingPotential,ALL,NAMED(\'CrossLinkingPotential\'));\n'
				,'')
			
			+'OUTPUT(h.invSummary,NAMED(\'InvertedSummary\'),ALL);\n'
			+'OUTPUT(p,NAMED(\'AllProfiles\'),ALL); // Detailed profile of every field\n'
			+'OUTPUT(h.Correlations,NAMED(\'Correlations\'),ALL); // Which fields are related to which other fields\n'
			
			+IF(gMod.spc_HAS_FIELDTYPES,
				'OUTPUT(h.ValidityErrors,NAMED(\'ValidityErrors\'),ALL); // Violations of FieldType statements\n'
				,'')
			
			+IF(gMod.spc_HAS_CONSISTENT,
				'PARALLEL(OUTPUT(h.AllUnusuallyFrequentOutliers,NAMED(\'SrcOutliers_UnusuallyFrequent\'),ALL),OUTPUT(h.AllUniqueOutliers,NAMED(\'SrcOutliers_Unique\'),ALL),OUTPUT(h.AllUniqueOutlierSources, NAMED(\'UniqueOutlier_sources\')), OUTPUT(h.AllDistinctOutliers,NAMED(\'SrcOutliers_Distinct\'),ALL),OUTPUT(h.AllDistinctOutlierSources, NAMED(\'DistinctOutlier_sources\')), OUTPUT(h.AllTop5Outliers,NAMED(\'SrcOutliers_Top5\'),ALL),OUTPUT(h.AllTop5OutlierSources, NAMED(\'Top5Outlier_sources\'))); // One source behaves differently to the others\n'
				,'')
			
			+IF(gMod.spc_IDNAME<>'',
				'OUTPUT(h.ClusterCounts,NAMED(\'ClusterCounts\'),ALL); // Breakdown by size of clusters\n'
				,'')
			
			+IF(gMod.spc_IDNAME<>'' AND gMod.spc_SOURCEFIELD<>'',
				'OUTPUT(h.ClusterSrc,NAMED(\'ClusterSrc\'),ALL); // Breakdown of source distribution in clusters\n'
				+'OUTPUT(h.SrcProfiles,NAMED(\'SrcProfiles\'),ALL); // Which sources contribute values to a cluster\n'
				,'')
			
			+'OUTPUT(' + gMod.salt_MODULE + '.MAC_Character_Counts.EclRecord(p,\'Layout_' + gMod.spc_FILENAME + '\'),NAMED(\'OptimizedLayout\'));// File layout suggested by data\n'
			+'OUTPUT(' + gMod.salt_MODULE + '.MAC_Character_Counts.FieldTypes(p,99.9),NAMED(\'Types\'));\n'
			
			+IF(gMod.spc_IDNAME<>'',
				'CM := ' + gMod.spc_MODULE + '.Fields.UIDConsistency(' + gMod.spc_MODULE + '.' + gMod.spc_FILEPREFIX + gMod.spc_FILENAME+');\n'
				+'OUTPUT(CM.IdCounts,NAMED(\'IDCounts\'));\n'
				,'')
			
			+IF(gMod.spc_IDNAME<>'' AND gMod.spc_IDFIELD<>'' AND gMod.spc_RIDFIELD<>'',
			  'OUTPUT(CM.Advanced0,NAMED(\'IDErrors0\'));\n'
			  ,'')
			;
			
			// TODO - Add Crosstabs (which will need a FIELD list)
	END;
	
	EXPORT BWR_Specificities(BOOLEAN doBuild=FALSE,BOOLEAN doProfiles=FALSE,BOOLEAN doPatch=FALSE) := FUNCTION
		s_base :=
			'//This is the code to execute in a builder window\n'
			+'#OPTION(\'multiplePersistInstances\', FALSE);\n'
			+'#workunit(\'name\',\'' + gMod.spc_MODULE + '.BWR_Specificities - Specificities - SALT ' + gMod.salt_VERSION + '\');\n'
			+'IMPORT ' + gMod.spc_MODULE + ',' + gMod.salt_MODULE + ';\n'
			+'SpecMod := ' + gMod.spc_MODULE + '.specificities(' + gMod.spc_MODULE + '.'+gMod.spc_FILEPREFIX+gMod.spc_FILENAME+');\n';
			
		s_build :=
			IF(gMod.spc_HAS_TWOSTEP,
				'// Use the build command to actually build the specificity indexes\n'
				+'SpecMod.Build;\n'
				,'');
			
		s_nobuild :=
			IF(gMod.spc_HAS_PARTITION,
				'// This gives statistics on records counts per partition\n'
				+'OUTPUT(SpecMod.PartitionCounts,NAMED(\'Partitions\'));\n'
				,'')
		
			+'// Display the specificities and the specificity shifts\n'
			+'// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build\n'
			+'OUTPUT(SpecMod.Specificities,NAMED(\'Specificities\'));\n'
			+'OUTPUT(SpecMod.SpcShift,NAMED(\'SpcShift\'));\n'
			
			+IF (doProfiles,
				'// Uncommenting the line below gives a detailed profile of the specificities of each field\n'
				+'OUTPUT(SpecMod.AllProfiles,NAMED(\'SpcProfiles\'));\n'
				,'')
			
			+IF (doPatch,
				'// The following macro OUTPUTs your SPC file patched with the latest POPULATION count and\n'
				+'// specificity/switch values.  See comments in the macro for more options!\n'
				+'IMPORT '+gMod.salt_TOOLSMODULE+';\n'
				+'SpcPatch := '+gMod.salt_TOOLSMODULE+'.mac_Patch_spcString(SpecMod.Specificities,' + gMod.spc_MODULE + '.'+gMod.spc_FILEPREFIX+gMod.spc_FILENAME+',' + gMod.spc_MODULE + '.GenerationMod.spcString);\n'
				+'OUTPUT(SpcPatch,NAMED(\'SpcPatch\'));\n'
				,'');
		
		// Unlike the static BWR_Specificities, this generates the build code _or_ the stats, not both.
		RETURN s_base + IF(doBuild,s_build,s_nobuild);
	END;
	
	// pIter = Iteration Number
	// doMP  = Whether to generate MatchPatterns output
	// doRS  = Whether to generate Review Samples
	EXPORT BWR_Iterate(UNSIGNED pIter=1, BOOLEAN doMP=FALSE, BOOLEAN doRS=FALSE) := FUNCTION
		fOut(UNSIGNED n) := '~temp::' + gMod.spc_IDFIELD + '::' + gMod.spc_MODULE + '::it'+(STRING)n;
		dsIn(UNSIGNED n) := IF(n>1, 'In_DS', gMod.spc_MODULE+'.In_'+gMod.spc_FILENAME);
		
		Head := 
			'#WORKUNIT(\'name\',\'' + gMod.spc_MODULE + '.BWR_Iterate - Internal Linking - SALT ' + gMod.salt_VERSION + '\');\n'
			+'IMPORT ' + gMod.spc_MODULE + ',' + gMod.salt_MODULE + ';\n'
			+IF(pIter>1,'In_DS := DATASET(\''+fOut(pIter-1)+'\','+gMod.spc_MODULE+'.Layout_'+gMod.spc_FILENAME+',THOR);\n', '');
		
		Proc1 := 'P := ' + gMod.spc_MODULE + '.Proc_Iterate(\'1\');\n';
		ProcN := 'P := ' + gMod.spc_MODULE + '.Proc_Iterate(\'' + (STRING)pIter + '\',' + dsIn(pIter) + ');\n';
		Iter := IF(pIter>1, ProcN, Proc1);
		
		// TODO - Add InputValidityStats
		
		Keys := gMod.spc_MODULE+'.Keys';
		OutMatchPatterns := IF(doMP,
			'\n'
			+'ConfThreshold := '+gMod.spc_MODULE+'.Config.MatchThreshold;\n'
			+'ThrRange := (STRING)(ConfThreshold-3) + \'-\' + (STRING)(ConfThreshold+3);\n'
			+''+gMod.salt_MODULE+'.MAC_MatchSamplePatterns('+Keys+'('+dsIn(pIter)+').MatchSample,MatchPatterns,'+gMod.spc_IDFIELD+'1,'+gMod.spc_IDFIELD+'2,8,ThrRange);\n'
			+'OutMatchPatterns := OUTPUT(MatchPatterns,named(\'match_patterns\'));\n'
			,'');
		
		// TODO - Make this work for any pIter (fails on >1 because MAC_GetSALTReviewSamples expects pInFile to have a module name)
		ReviewSamples := IF(doRS AND pIter=1,
			'\n'
			+'IMPORT '+gMod.salt_TOOLSMODULE+';\n'
			+'Reviewers:=[\'Reviewer1\',\'Reviewer2\'];\n'
			+'NumSamplesPerReviewer:=20;\n'
			+IF(doMP,'','ConfThreshold:='+gMod.spc_MODULE+'.Config.MatchThreshold;\n')
			+'ReviewSamples:='+gMod.salt_TOOLSMODULE+'.MAC_GetSALTReviewSamples('+Keys+'('+dsIn(pIter)+').MatchSample,'+Keys+'('+dsIn(pIter)+').Candidates,'+dsIn(pIter)+','+gMod.spc_IDFIELD+',ConfThreshold,NumSamplesPerReviewer,Reviewers);\n'
			,'');
		
		Action := '\n' + IF(doMP OR (doRS AND pIter=1),'SEQUENTIAL(P.DoAllAgain'+IF(doMP,',OutMatchPatterns','')+IF(doRS AND pIter=1,',ReviewSamples','')+')', 'P.DoAllAgain') + ';\n';
		
		RETURN Head + Iter + OutMatchPatterns + ReviewSamples + Action;
	END;
	
	EXPORT ExtMode := ENUM(Standard,EFRBuild,EFRStats);
	EXPORT BWR_GoExternal(extMode mode=ExtMode.Standard,BOOLEAN isIncremental=FALSE) := FUNCTION
		s_base :=
			'//This is the code to execute in a builder window\n'
			+'#OPTION(\'multiplePersistInstances\', FALSE);\n'
			+'#WORKUNIT(\'name\',\'' + gMod.spc_MODULE + '.BWR_GoExternal - External Linking Keybuild - SALT ' + gMod.salt_VERSION + '\');\n'
			+'IMPORT ' + gMod.spc_MODULE + ',' + gMod.salt_MODULE + ';\n';
		
		s_standard := 
			IF(gMod.spc_HAS_INCREMENTAL, 'BOOLEAN incrementalkeyBuild := '+IF(isIncremental,'TRUE','FALSE')+';\n', '')
			+IF(gMod.spc_CONFIGPARAM, 'myInputConfig := ' + gMod.spc_MODULE + '.' + gMod.spc_CONFIG + ';\n', '')
			+IF(mode=ExtMode.Standard,'','// ')
			+gMod.spc_MODULE+'.Proc_GoExternal'
			+IF(gMod.spc_HAS_INCREMENTAL OR gMod.spc_CONFIGPARAM,
				'('
				+IF(gMod.spc_HAS_INCREMENTAL,'incrementalkeyBuild','')
				+IF(gMod.spc_HAS_INCREMENTAL AND gMod.spc_CONFIGPARAM,',','')
				+IF(gMod.spc_CONFIGPARAM,'myInputConfig','')
				+')'
				,'')
			+';\n';
		
		s_efr := 
			IF(gMod.spc_HAS_EXTERNAL,
				'// If you wish to index all of the external files in one go - use the below AFTER the above\n'
				+IF(mode=ExtMode.EFRBuild,'','// ')
				+gMod.spc_MODULE+'.Externals.buildall;\n'
				+'// The below gives a global view of the numbers of linked records for each of the external files\n'
				+IF(mode=ExtMode.EFRStats,'','// ')
				+gMod.spc_MODULE+'.Externals.EFRStats;\n'
				,'');
				
		// TODO - optionally add shrinkage
		
		RETURN s_base + s_standard + s_efr;
	END;
	
	EXPORT BWR_TestExternal() := FUNCTION
		RETURN
			'//This is the code to execute in a builder window\n'
			+'#OPTION(\'multiplePersistInstances\', FALSE);\n'
			+'#WORKUNIT(\'name\',\'' + gMod.spc_MODULE + '.BWR_TestExternal - Precision and Recall - SALT ' + gMod.salt_VERSION + '\');\n'
			+'IMPORT ' + gMod.spc_MODULE + ',' + gMod.salt_MODULE + ';\n'
	
			+'// This is the \'thor only\' version (no roxie)\n'
			+'SmallJob := FALSE;\n'
			+'InUpdateIDs := FALSE;\n'
			+IF(gMod.spc_HAS_PARENTS, 'GetAllScores := TRUE;\n','')
			+IF(gMod.spc_HAS_FORCE, 'DisableForce := FALSE;\n','')
			+IF(gMod.spc_HAS_BLOCKLINK, 'DisableBlocklink := FALSE;\n','')
			+'DoClean := TRUE;\n'
			+IF(gMod.spc_CONFIGPARAM, 'myInputConfig := ' + gMod.spc_MODULE + '.' + gMod.spc_CONFIG + ';\n', '')
			+'Infile := '+gMod.spc_MODULE+'.'+gMod.spc_FILEPREFIX+gMod.spc_FILENAME+'; // You can make this a different file - but must be in \'as header\' format\n'
			+'Mapping := \''+gMod.spc_EXTERNAL_MAPPING+'\';\n'
			+'MyInfile := '+gMod.salt_MODULE+'.FromFlat(InFile,'+gMod.spc_MODULE+'.'+gMod.spc_PROCLAYOUTS+'.InputLayout,Mapping);\n'
			
			+gMod.spc_MODULE+'.MAC_Meow_'+gMod.spc_PROCESS+'_Batch(myinfile,UniqueId'
				+gMod.spc_EXTERNAL_BATCH_PARAM
				+',MyOutFile,SmallJob,InUpdateIDs,Stats'
				+IF(gMod.spc_HAS_PARENTS,',GetAllScores','')
				+IF(gMod.spc_HAS_FORCE,',DisableForce','')
				+IF(gMod.spc_HAS_BLOCKLINK,',DisableBlocklink','')
				+',DoClean'
				+IF(gMod.spc_CONFIGPARAM,',myInputConfig','')
				+');\n'
			
			+'Rec := { BOOLEAN Present; BOOLEAN Equal; BOOLEAN Resolved };\n'
			+'Rec note(Infile le,MyOutFile ri) := TRANSFORM\n'
			+'  SELF.Present := ri.Results[1].'+gMod.spc_IDNAME+' <> 0;\n'
			+'  SELF.Resolved := ri.Resolved;\n'
			+'  SELF.Equal := le.'+gMod.spc_IDNAME+'=ri.Results[1].'+gMod.spc_IDNAME+';\n'
			+'END;\n'
			+'J := JOIN(infile,myoutfile,LEFT.'+gMod.spc_RIDFIELD+'=RIGHT.Reference,note(LEFT,RIGHT),LEFT OUTER);\n'
			
			+'TABLE(J,{ Recall := AVE(GROUP, IF (Present,100,0) ), AvailableTrueRecall := AVE( GROUP,IF (Present AND Equal, 100, 0 ) ), TrueRecall := AVE( GROUP,IF (Present AND Equal AND Resolved, 100, 0 ) ) });\n'
			+'Errors := JOIN(infile,myoutfile,LEFT.'+gMod.spc_RIDFIELD+'=RIGHT.Reference AND LEFT.'+gMod.spc_IDNAME+'<>RIGHT.Results[1].'+gMod.spc_IDNAME+');\n'
			// +'Errors;\n'
			// +'MyOutFile;\n'
			// +'Stats;\n';
			+'CHOOSEN(Errors,500);\n'
			+'CHOOSEN(MyOutFile,500);\n'
			+'CHOOSEN(Stats,500);\n';
	END;
	// EXPORT BWR_Ingest
	
	// EXPORT BWR_Best - may have to save this for a 2nd iteration	
	
END;
