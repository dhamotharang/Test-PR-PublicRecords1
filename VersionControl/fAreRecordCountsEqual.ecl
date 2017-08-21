import lib_fileservices;

export fAreRecordCountsEqual(

	 string pFilename1
	,string pFilename2

) :=
function

	mydataset := dataset([
		 {pfilename1}
		,{pfilename2}
	], layout_names);

	infolay := lib_fileservices.FsLogicalFileInfoRecord;
	
	myrec :=
	record
		string								filename										;
		boolean								issuper							:= false;
		dataset(layout_names) dSuperfilecontents					;
		boolean								fileexists					:= false;
		dataset(infolay)			fileinfo										;
	end;
	
	myrec tGetFileInfo(layout_names l) :=
	transform
		
		self.filename						:= l.name;
		self.issuper						:= fileservices.superfileexists(self.filename);
		self.dSuperfilecontents	:= if(self.issuper
																,fileservices.superfilecontents(self.filename)
																,dataset([],layout_names) 
															);
		self.fileexists					:= fileservices.fileexists(self.filename) ;
		self.fileinfo						:= map(self.issuper and count(self.dSuperfilecontents) > 0	=> fileservices.logicalfilelist(self.dSuperfilecontents[1].name	)
																	,self.fileexists																			=> fileservices.logicalfilelist(self.filename[2..]							)
																	,dataset([],infolay)
															);
	end;

	dFilesInfo := project(mydataset, tGetFileInfo(left));
	
	file1_rowcount := dFilesInfo[1].fileinfo[1].rowcount;
	file2_rowcount := dFilesInfo[2].fileinfo[1].rowcount;
	
	
//	return dFilesInfo;
	
	return file1_rowcount = file2_rowcount and file1_rowcount != 0;
	
end;
