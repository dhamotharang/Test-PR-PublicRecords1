import ut, _control;
export fRollupSprayedFiles(dataset(Layout_Sprays.infoout) pSprayInformation) :=
function

	///////////////////////////////////////////////////////////////////////////
	// -- Add unique id
	///////////////////////////////////////////////////////////////////////////
	layout_file_counts := 
	record
		unsigned4				numFilesSprayed	;
		unsigned4				numFilesSkipped	;
	end;

	layout_file_counts tcountfiles(Layout_Sprays.infoout l) :=
	transform
		self.numFilesSprayed	:= count(l.dFilesToSpray(willspray));
		self.numFilesSkipped	:= count(l.dFilesToSpray(not willspray));
	end;

	dcountfiles := project(pSprayInformation,tcountfiles(left));

	layout_file_counts tTotalFiles(layout_file_counts l, layout_file_counts r) :=
	transform

		self.numFilesSprayed	:= l.numFilesSprayed + r.numFilesSprayed;
		self.numFilesSkipped	:= l.numFilesSkipped + r.numFilesSkipped;
		self := l;
		
	end;
	
	dTotalFiles := rollup(dcountfiles, true, tTotalFiles(left,right));
	
	return dTotalFiles;

end;
