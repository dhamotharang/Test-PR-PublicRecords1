import lib_fileservices;
export fun_AreRecordCountsEqual(
	 string pFilename1
	,string pFilename2
) :=
function
	mydataset := dataset([
		 {pfilename1}
		,{pfilename2}
	], Layout_Names);
	infolay := lib_fileservices.FsLogicalFileInfoRecord;
	
	myrec :=
	record
		string								filename										;
		boolean								issuper							:= false;
		dataset(Layout_Names) dSuperfilecontents					;
		boolean								fileexists					:= false;
		dataset(infolay)			fileinfo										;
	end;
	
	myrec tGetFileInfo(Layout_Names l) :=
	transform
		
		self.filename						:= l.name;
		self.issuper						:= fileservices.superfileexists(self.filename);
		self.dSuperfilecontents	:= if(self.issuper
																,fileservices.superfilecontents(self.filename)
																,dataset([],Layout_Names) 
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
