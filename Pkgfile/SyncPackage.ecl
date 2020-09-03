import dops, pkgfile;

EXPORT SyncPackage(STRING location = 'B', STRING cluster = 'C') := module

	EXPORT LayoutDataSets := RECORD
		STRING 	id;
		BOOLEAN fcra := false;
		STRING 	build_version := '';
	END;
	
	EXPORT FileRecordExt := RECORD
			pkgfile.layouts.flat_layouts.FileRecord;	
			boolean is_new_version;
			string  previous_version;
	END;

	EXPORT GetBuildDatasets() := FUNCTION

		allDSetsAvailable	:= DEDUP(SORT(DATASET(STRINGLib.SplitWords(REGEXREPLACE('(\\[|\\]|")', dops.GetDataSets(location)[1].datasets, ''), ',', false), {STRING dset;}), dset), dset);
		allDSetsPrep := PROJECT(allDSetsAvailable, TRANSFORM(LayoutDataSets, SELF.fcra := LEFT.dset[1..4]='FCRA', SELF.id := LEFT.dset));
		allDSets := PROJECT(allDSetsPrep, TRANSFORM(LayoutDataSets,
								envflag := IF(LEFT.fcra, 'F', 'N');
								SELF.build_version := dops.GetBuildVersion(LEFT.id, location, envflag, cluster),
								SELF := LEFT));

		RETURN allDSets;
		
	END;
	
	EXPORT UpdatePackageDatasets(DATASET(pkgfile.layouts.flat_layouts.packageid) pkgDS, DATASET(LayoutDataSets) allDSIn = DATASET([], LayoutDataSets)) := FUNCTION
		
		// FileVersionPattern := '\\d{4}\\d{2}\\d{2}[A..Za..z]*';
		FileVersionPattern := '\\d{8}[\\w]*';
		allDS	:= IF(exists(allDSIn), allDSIn, GetBuildDatasets());

		deltaDS := 
			join(pkgDS, allDS, left.id = right.id,
				// TRANSFORM(pkgfile.layouts.flat_layouts.FileRecord,
				TRANSFORM(FileRecordExt,
									SELF.packageid := left.id,
									curr_version := regexfind(FileVersionPattern, left.subfilevalue, 0);							
									same_version :=  curr_version = right.build_version;
									SELF.subfile := if(same_version, left.subfilevalue, regexreplace(FileVersionPattern, left.subfilevalue, right.build_version)),
									SELF.superfile := LEFT.superfileid,
									SELF.is_new_version := ~same_version,
									SELF.previous_version := IF(~same_version, curr_version, ''),
									SELF := LEFT
									));

		return deltaDS;

	END;

/*
	EXPORT Sync() := MACRO
	
		#stored('cluster','dev194');
		//#workunit('name', 'DEV194 Pkg')

		// pkgDs := Pkgfile.files('xml').getxmlpackage;
		pkgDs := Pkgfile.files('flat').getflatpackage(pkgcode='K');

		allDS := Pkgfile.SyncPackage().GetBuildDatasets();
		deltaDS := Pkgfile.SyncPackage().UpdatePackageDatasets(pkgDs, allDS);

		//pkgfile.add.Sfiles(PackageDS)

		output(allDS, nameD('allDS'));
		output(pkgDs, nameD('pkgDs'));
		output(deltaDS(~is_new_version), nameD('deltaDS_same'));
		output(deltaDS(is_new_version), nameD('deltaDS_new'));
	
	ENDMACRO;
	*/

END;