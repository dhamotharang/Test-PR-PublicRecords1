import STD;
EXPORT ManualDeleteFiles(string filesowner) := module

	export GetFileList(string filepattern, integer l_cnt) := function
		lds := sort(fileservices.logicalfilelist(filepattern),-modified);
		sds := fileservices.logicalfilesupersublist();
		files_layout := record
			string name;
			integer filecnt := 0;
		end;
		
		files_layout join_recs(lds l, sds r) := transform
			self.name := l.name;
			self := l;
		end;
		
		ds := join(lds, sds, left.name = right.subname, join_recs(left,right), left only);
		
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

	export GetFilestoDelete() := function
		ds := sort(fileservices.logicalfilelist()(owner = filesowner),-size);

		string_rec := record
			string filename;
			string fpattern;
		end;

		string_rec xRecords(ds l) := transform
			self.filename := l.name;
			self.fpattern := regexreplace('[*]+',regexreplace('[-_]',regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',l.name,'*',nocase),'*',nocase),'*'),'*');
			////self := l;
		end;

		GetPatternstoApply := project(ds,xRecords(left));

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
			
												
			self.superfile := l.filename;
			self.deletepattern := l.fpattern;
			self.filematches := GetFileList(trim(l.fpattern,left,right),2);
		end;
		
		MatchedFiles := project(GetPatternstoApply,GetMatchedFiles(left));

		Layout_FilesToDelete := record
			//string superfile;
			string name;
			integer filecnt;
		end;	
		
		Layout_FilesToDelete FilesToDelete(MatchedFiles l,files_layout r) := transform
			//self.superfile := l.superfile;
			self.name := r.name;
			// if filecnt > threshold set it to 0
			self.filecnt := r.filecnt;
		end;
		
		normrecs := dedup(normalize(MatchedFiles,left.filematches,FilesToDelete(left,right)),name) : independent;
		
		return normrecs;
		// Users will manually set files to delete in UI, compile the list and consider
		// for deletion
		
	end;
	
	export run() := function
		return if (thorlib.daliServers() = thorbackup.constants.esp.yogurtthorforboca+':7070',
									if (regexfind('hthor', thorlib.cluster())
										,sequential
											(
												output(GetFilesToDelete(),,'~yogurt::files::todelete',overwrite)
												,apply(GetFilesToDelete(),
											if (fileservices.fileexists('~'+name)
												,fileservices.deletelogicalfile('~'+name)
											))
											),
										fail('Run on 	hthor')),
									fail('Job should be run on http://'+thorbackup.constants.esp.yogurtthorforboca+':8010')
							);
	
	end;
end;