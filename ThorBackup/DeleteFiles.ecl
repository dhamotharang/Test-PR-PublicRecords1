import ut,lib_fileservices,STD;
EXPORT DeleteFiles(string location, string environment, string deleteenv,boolean onlydbfiles = false) := module
	export rundatetime := ut.GetTimeDate() : independent;
	
	export FullList := thorbackup.Constants.Fulllist(deleteenv);

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
	
	export GetDeletePatterns := dataset('~'+deletepatterns,thorbackup.Layout_DeleteFilesInfo,thor,opt);
	
	export filestodelete := fileservices.logicalfilelist(basename + location + '::' + environment + '*filestodelete');
	
	export IsNewList := if (count(filestodelete) > 0, true, false);
	
	export AddToUsing := nothor(apply(filestodelete,
																fileservices.addsuperfile('~'+usingsuper, '~'+name)
														));
	
	
	
	//export GetPatternstoApply := dedup(sort(GetDeletePatterns(subname <> ''),name,-datetime,hasmultiplesubs),name,keep(1));
	
	export GetPatternstoApply := function
	
		thorbackup.Layout_DeleteFilesInfo massagePatterns(GetDeletePatterns l) := transform
			self.subname := regexreplace('[*]+',regexreplace('[-_]',regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',l.subname,'*',nocase),'*',nocase),'*'),'*');
			self := l;
		end;
		
		CleanerPatterns := project(GetDeletePatterns,massagePatterns(left));
		
		return dedup(sort(CleanerPatterns(subname <> ''),subname,-datetime,hasmultiplesubs),subname);
	
	end;
	
	export PrepForDelete := output(GetPatternstoApply+dataset('~'+usingsuper,thorbackup.Layout_DeleteFilesInfo,thor,opt),,'~'+deletedfile,overwrite);
	
	export GetFileList(string filepattern, integer l_cnt) := function
		ds := sort(fileservices.logicalfilelist(filepattern),-modified);
		files_layout := record
			string name;
			integer filecnt := 0;
		end;
		
		files_layout get_matchingfiles(ds l) := transform
			l_pattern := regexreplace('[*]+',regexreplace('[-_]',regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',l.name,'*',nocase),'*',nocase),'*'),'*');
			self.name := if (l_pattern = filepattern,l.name,'');
			self := l;
		end;

		get_matched_files := project(ds,get_matchingfiles(left))(name <> '');
		
		files_layout_tok := record
			string name;
			string tokens;
			integer filecnt := 0;
		end;		
		
		files_layout_tok get_tokens(get_matched_files l, integer c) := transform
			self.tokens := regexreplace(Std.Str.SplitWords(l.name,':')[1]+'::',l.name,'');
			self.filecnt := c;
			self := l;
		end;
		
		get_tokens_out := sort(project(get_matched_files,get_tokens(left,counter)),name,tokens);
		
		get_tokens_grp := group(get_tokens_out, tokens);
		
		get_tokens_grp get_names(get_tokens_grp l,get_tokens_grp r) := transform
			
			self.filecnt := if (l.tokens <> r.tokens, r.filecnt, 9999);
			self.name := if(l.name <> r.name,r.name,l.name);
			self.tokens := r.tokens;
		end;
		
		iterate_it := ungroup(iterate(get_tokens_grp,get_names(left,right)));
		
		files_layout proj_it(iterate_it l) := transform
			self.filecnt := if (l.filecnt > l_cnt, 0, l.filecnt);
			self := l;
		end;
		
		proj_out := project(iterate_it,proj_it(left));
		
		return proj_out(filecnt = 0);
		
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
			counttocompare := if (count(thorbackup.SetDeleteFileCount(trim(superfile,left,right)=trim(l.name,left,right))) > 0, // check if the superfile exists in the threshold setup list
														thorbackup.constants.yogurt(l.name).no_of_files_to_keep, // if yes get the filecnt to keep from list
															thorbackup.constants.yogurt().no_of_files_to_keep);
												
			self.superfile := l.name;
			self.deletepattern := l.subname;
			self.filematches := GetFileList(trim(l.subname,left,right),counttocompare);
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
			// if filecnt > threshold set it to 0
			self.filecnt := r.filecnt;
		end;
		
		GetFilesToDelete := normalize(MatchedFiles,left.filematches,FilesToDelete(left,right));
		// Users will manually set files to delete in UI, compile the list and consider
		// for deletion
		getfilesfromdbtodelete := thorbackup.GetDeleteFilesFromDB(,deleteenv)(issetfordelete = '1' and trim(filename,left,right) <> '' and excludeme <> 1);
		
		Layout_FilesToDelete proj_to_comm_layout(getfilesfromdbtodelete l) := transform
			self.superfile := '';
			self.name := l.filename;
			self.filecnt := 0;
		end;
		
		filessetfordeletionindb := projecT(getfilesfromdbtodelete,proj_to_comm_layout(left));
		
		Filelist := sort(if(~onlydbfiles,GetFilesToDelete + filessetfordeletionindb,filessetfordeletionindb),name);
		// Check if the file was moved into super after the first poll
		
		Layout_FilesToDelete Get_NonSuperFiles(FullList l, Filelist r) := transform
			self := r;
		end;
		
		NonSuperFiles := join(FullList, Filelist,
															left.subname = right.name,
															Get_NonSuperFiles(left,right),
															right only
															);
		
		return NonSuperFiles;//(filecnt = 0); // get only files that have filecnt = 0 meaning > threshold
		
	end;
	
	
	// will not consider files in "using" super
	export ApplyDeletes(boolean isrun = false) := if (onlydbfiles or thorlib.daliServers() = thorbackup.constants.esp.yogurtthorforboca+':7070',
															sequential
															(
																if (~isrun and ~onlydbfiles,sequential(
																				PrepForDelete
																				,MoveFiles
																			)
																		)
																,apply
																	(
																		GetFileListToDelete(),
																			if(fileservices.fileexists('~'+name),
																					fileservices.deletelogicalfile('~'+name))
																	)),
																	output('All environments except yogurt thor should have onlydbfiles set to true')
																): failure(fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			'Delete Files failed on ' + environment + ' - ' + ut.GetTimeDate(),
			'workunit: ' + workunit+ '\r\n' + failmessage
																	,
																	,
																	,thorbackup.constants.yogurt().senderemail));
																//);
	// will consider files in "using" super
	export run := 	if (thorlib.daliServers() = thorbackup.constants.esp.yogurtthorforboca+':7070',
									sequential
									(
										CreateSupers,
										if (fileservices.GetSuperFileSubCount('~'+usingsuper) > 0
											,output('Another process running or the previous WU failed..Clear ~'+ usingsuper + 'superfile to re-run')
											//,if (IsNewList,
												,sequential
													(
														AddToUsing,
														PrepForDelete,
														MoveFiles,
														//output(GetFileListToDelete(),named('Delete_List')),
														ApplyDeletes(true),
														fileservices.clearsuperfile('~'+usingsuper,true)
														)/*,
													output('No New Files to Copy')
													)*/
												)
										),
										output('Job should be run on http://'+thorbackup.constants.esp.yogurtthorforboca+':8010')
										): failure(
																sequential(
																		fileservices.clearsuperfile('~'+usingsuper)
																	,fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			'Delete Files failed on ' + environment + ' - ' + ut.GetTimeDate(),
			'workunit: ' + workunit+ '\r\n' + failmessage
																	,
																	,
																	,thorbackup.constants.yogurt().senderemail)
																	)
																	
																	);
	
end;