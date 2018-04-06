import ut;
EXPORT DeleteFiles(string location, string environment) := module
	export rundatetime := ut.GetTimeDate();
	
	export basename := 'yogurt::base::';
	
	export deletepatterns := basename + location + '::' + environment + '::qa::deletepatterns';
	export firstgeneration := regexreplace('::qa::',deletepatterns,'::father::');
	export deletesuper := regexreplace('::qa::',deletepatterns,'::delete::');
	export usingsuper := regexreplace('::qa::',deletepatterns,'::using::');
	export deleted := regexreplace('::qa::',deletepatterns,'::deleted::');
	export deleteddelete := regexreplace('::qa::',deletepatterns,'::deleted::delete::');
	export deletedfile := '~'+deleted+rundatetime;
	export errorqa := regexreplace('::qa::',deletepatterns,'::error::');
	export errordelete := regexreplace('::qa::',deletepatterns,'::error::delete::');
	export errorfile := '~'+errorqa+rundatetime;
	
	export CreateSupers := sequential(
													if (~fileservices.superfileexists('~'+deletepatterns),
														fileservices.createsuperfile('~'+deletepatterns)),
													if (~fileservices.superfileexists('~'+firstgeneration),
														fileservices.createsuperfile('~'+firstgeneration)),
													if (~fileservices.superfileexists('~'+deletesuper),
														fileservices.createsuperfile('~'+deletesuper)),
													if (~fileservices.superfileexists('~'+usingsuper),
														fileservices.createsuperfile('~'+usingsuper)),
													if (~fileservices.superfileexists('~'+deleteddelete),
														fileservices.createsuperfile('~'+deleteddelete)),
													if (~fileservices.superfileexists('~'+deleted),
														fileservices.createsuperfile('~'+deleted)),
													if (~fileservices.superfileexists('~'+errordelete),
														fileservices.createsuperfile('~'+errordelete)),
													if (~fileservices.superfileexists('~'+errorqa),
														fileservices.createsuperfile('~'+errorqa))
														);
	
	export MoveFiles := sequential(
													fileservices.clearsuperfile('~'+deletesuper,true),
													fileservices.addsuperfile('~'+deletesuper,'~'+firstgeneration,,true),
													fileservices.clearsuperfile('~'+firstgeneration),
													fileservices.addsuperfile('~'+firstgeneration,'~'+deletepatterns,,true),
													fileservices.clearsuperfile('~'+deletepatterns),
													fileservices.addsuperfile('~'+deletepatterns,'~'+deletedfile)
													);
	
	export GetDeletePatterns := dataset('~'+deletepatterns,dops.Layout_DeleteFilesInfo,thor,opt);
	
	export filestodelete := fileservices.logicalfilelist(basename + location + '::' + environment + '*filestodelete');
	
	export IsNewList := if (count(filestodelete) > 0, true, false);
	
	export AddToUsing := nothor(apply(filestodelete,
																fileservices.addsuperfile('~'+usingsuper, '~'+name)
														));
	
	export PrepForDelete := output(GetDeletePatterns+dataset('~'+usingsuper,dops.Layout_DeleteFilesInfo,thor),,'~'+deletedfile,overwrite);
	
	export GetPatternstoApply := dedup(sort(GetDeletePatterns(subname <> ''),name,-datetime,hasmultiplesubs),name,keep(1))(~hasmultiplesubs);
	
	export GetFileList(string filepattern) := function
		ds := sort(fileservices.logicalfilelist(filepattern),-modified);
		files_layout := record
			string name;
			integer filecnt;
		end;
		
		files_layout get_names(ds l,integer C) := transform
			self.name := l.name;
			self.filecnt := C;
		end;
		
		return project(ds,get_names(left,counter));
		
	end;
	
	
	export GetFileListToDelete() := function
		files_layout := record
			string name;
			integer filecnt;
		end;
		
		Layout_DeleteFiles := record
			string superfile;
			string deletepattern;
			dataset(files_layout) filematches;
		end;
		
		Layout_DeleteFiles GetMatchedFiles(GetPatternstoApply l) := transform
			self.superfile := l.name;
			self.deletepattern := l.subname;
			self.filematches := GetFileList(l.subname);
		end;
		
		MatchedFiles := project(GetPatternstoApply,GetMatchedFiles(left));
		
		Layout_FilesToDelete := record
			string superfile;
			string name;
			integer filecnt;
		end;	
		
		Layout_FilesToDelete FilesToDelete(MatchedFiles l,files_layout r) := transform
			self.superfile := l.superfile;
			self.name := r.name;
			self.filecnt := r.filecnt;
		end;
		
		GetFilesToDelete := normalize(MatchedFiles,left.filematches,FilesToDelete(left,right));
		
		return GetFilesToDelete(filecnt > dops.constants.yogurt().no_of_files_to_keep);
		
	end;
	
	export ApplyDeletes := apply
																	(
																		GetFileListToDelete(),
																			if(fileservices.fileexists('~'+name),
																					fileservices.deletelogicalfile('~'+name))
																	);
																//);
	
	export run := 	if (thorlib.daliServers() = dops.constants.esp.yogurtthorforboca+':7070',
									sequential
									(
										CreateSupers,
										if (fileservices.GetSuperFileSubCount('~'+usingsuper) > 0
											,output('Another process running or the previous WU failed..Clear ~'+ usingsuper + 'superfile to re-run')
											,if (IsNewList,
												sequential
													(
														AddToUsing,
														PrepForDelete,
														MoveFiles,
														//output(GetFileListToDelete(),named('Delete_List')),
														ApplyDeletes,
														fileservices.clearsuperfile('~'+usingsuper,true)
														),
													output('No New Files to Copy')
													)
												)
										),
										output('Job should be run on http://'+dops.constants.esp.yogurtthorforboca+':8010')
										);
	
end;