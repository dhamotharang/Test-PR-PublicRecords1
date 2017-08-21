import versioncontrol,lib_fileservices;

export Query_Source_Snapshot(

	boolean pShouldClearSupers = true

) :=
function

	promote2bus := Business_HeaderV2.Source_Promote().all	;
	rollbackbus	:= Business_HeaderV2.Source_Rollback().all;
	
	dBHBuilding := Source_filenames.all;
	
	versioncontrol.layout_names tGetSuperfiles(versioncontrol.layout_versions.builds l) :=
	transform

		oldversions := versioncontrol.mBuildFilenameVersionsOld	(l.templatename, l.logicalversion, l.templatenameNew);
		newversions := versioncontrol.mBuildFilenameVersions		(l.templatename, l.logicalversion										);
		
		bh_version := if(l.IsNewNamingConvention
			,newversions.BusinessHeader
			,oldversions.BusinessHeader
		);
		self.name := bh_version;

	end;
	
	dSnapshotSupers := project(dBHBuilding, tGetSuperfiles(left));

	////////////////////////////////////////////////////////////////////////////////////
	// -- Record Layouts used in process
	////////////////////////////////////////////////////////////////////////////////////
	inforecord := lib_fileservices.FsLogicalFileInfoRecord;
	
	inforecord tgetLogicalSubFiles(versioncontrol.layout_names l, unsigned4 cnt) :=
	transform
		
		allcontents := fileservices.superfilecontents(l.name,true);
		name 				:= allcontents[cnt].name;
		fileinfo 		:= fileservices.LogicalFileList(name)[1];
		
		self.name := name;
		self.superfile	:= fileinfo.superfile																						 ;
		self.size				:= if(fileinfo.size			> 744073709500000, 0, fileinfo.size			);
		self.rowcount		:= if(fileinfo.rowcount > 744073709500000, 0, fileinfo.rowcount	);
		self.modified		:= fileinfo.modified																						 ;
		self.owner			:= fileinfo.owner																								 ;
		self.cluster		:= fileinfo.cluster																							 ;

	end;

	dSnapshotLogicals :=  normalize(dSnapshotSupers, count(fileservices.superfilecontents(left.name,true)), tgetLogicalSubFiles(left, counter));

	return sequential(
		 promote2bus
		,output(dSnapshotLogicals, named('BusinessHeaderSourceSnapshot'),all)
		,if(pShouldClearSupers, rollbackbus)
	);

end;