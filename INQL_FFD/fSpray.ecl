import Versioncontrol, _Control, fbn_new,lib_thorlib , ut, std, tools;

	pDate := (string8)std.date.today():INDEPENDENT;

	rFileDef := record
		string 	LogicalFile;	
		string5 Separate;
		DATASET(FsLogicalFileNameRecord) SuperFiles;
	end;

	GetFileDetails(string pFileType, boolean fcra = false, boolean encrypted = false) := function
		rgxName 	:= '[0-9-]{4,}';
		pVersion 	:= stringlib.stringfilterout(regexfind(rgxName, pFileType, 0), '-');
		version 	:= if(pVersion = '', pDate, pVersion);
		
		LogicalFile := if(~encrypted,Filenames(,,version).InputFile,Filenames(,,version,true).InputFile);
		Superfile   := if(~encrypted,Filenames().Input, Filenames(,,,true).Input); 
		Separate 		:= '~~';
		
		SuperFiles := dataset([{Superfile}], FsLogicalFileNameRecord);
											
		ds := dataset([{LogicalFile, Separate, SuperFiles}], rFileDef);
		return ds;	
	end;

export fSpray(dataset({FsFilenameRecord}) filelist, boolean fcra = false, boolean encrypted = false) := function
	
	pGroupName	:= INQL_FFD._Constants.GROUPNAME;
	
	tools.Layout_Sprays.Info xForm(filelist L) := transform
			self:=row(
								{	 
								 INQL_FFD._Constants.LZ						
								,if(~encrypted, INQL_FFD._Constants.SPRAYINGDIR,INQL_FFD._Constants.SPRAYINGENCRYPTEDDIR)                          
								,L.name                                      
								,0
								,GetFileDetails(L.name, fcra, encrypted)[1].LogicalFile
								,GetFileDetails(L.name, fcra, encrypted)[1].Superfiles
								,pGroupName                                                
								,''                                                    
								,''                                                            
								,'VARIABLE'                                                         
								,''
								,''
								,GetFileDetails(L.name, fcra)[1].Separate
								,''               //'\\n,\\r\\n'
								,','                     //''
								,true
								}
								,tools.Layout_Sprays.Info);
																
	end;
	
	FilesToSpray:=project(filelist, xForm(left));
	spray := sequential(VersionControl.fSprayInputFiles(FilesToSpray(~regexfind('transaction', thor_filename_template)))
						);
	
	return spray;
	
end;