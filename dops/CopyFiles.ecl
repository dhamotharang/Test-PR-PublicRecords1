import wk_ut, STD, lib_fileservices;
EXPORT CopyFiles(string srcesp
								,string destesp
								,string srcdali
								,string destdali
								,string destcluster
								,set of string insrccluster = []
								,string filepattern = ''
								,dataset(dops.Layout_filelist) ds = dataset([],dops.Layout_filelist)
								,string dstSubNameSuffix = ''
								,string uniquearbitrarystring = 'uniquenameforthisjob' // this string will be used in filename
																																	// to uniquely represent the filename CopyFileList_FileName
								):= module

	// File names 
	export mFileList_LogicalNames := '~copyfiles::'+thorlib.jobowner()+'::missinglogicals::'+uniquearbitrarystring;
	export cFileList_LogicalNames := '~copyfiles::'+thorlib.jobowner()+'::copiedlogicals::'+uniquearbitrarystring;
	export aFileList_LogicalNames := '~copyfiles::'+thorlib.jobowner()+'::alllogicals::'+uniquearbitrarystring;
	export CopyFileList_SuperNames := '~copyfiles::'+thorlib.jobowner()+'::supers::'+uniquearbitrarystring;
	export FlagFile := '~copyfiles::'+uniquearbitrarystring+'::copyinprogress';

	// Record set with logical file names and command to copy
	export rFileList := record
			string name;
			string newlogicalname;
			string cmd;
	end;
	
	// Record set with logical file names, command to copy, counter and boolean field to tell
	// whether the file exists on destination
	export rCopyFiles := record
			rFileList;
			integer cnt := 0;
			boolean existsondest;
	end;
	
	// rCopyFiles + superfile name if the logical name is within a super
	export rSuperFileList := RECORD
			rCopyFiles;
			string255 supername;
  end;
	
	// Get the default source cluster if the input parameter is empty 
	export srccluster := if (count(insrccluster) > 0, insrccluster, dops.constants.allowedclusters);
	
	// Layout of file list from soapcall
	export CommonLayout := record
			wk_ut.get_DFUQuery().lay_DFULogicalFiles;
			integer realsize;
	end;

	// Function to get the list of all files in a cluster or set of clusters
	export GetFullList() := function
		getallclusterrecs := record
			integer dummy := 1;
			dataset({wk_ut.get_DFUQuery().lay_DFULogicalFiles,integer realsize}) dfulayout;
		end;
		
		dummylayout := record
			string cname;
		end;
		
		// makes a soapcall to DFUQuery for each cluster on the source ESP
		getallclusterrecs getAllClustersxform(dummylayout l) := transform
			self.dummy := 1;
			self.dfulayout :=  if (filepattern <> '',
										wk_ut.get_DFUQuery(,l.cname,,,,,,,,,,,,,,,,,srcesp).dnorm(regexfind(filepattern,name,nocase)),
										wk_ut.get_DFUQuery(,l.cname,,,,,,,,,,,,,,,,,srcesp).dnorm
										);
		end;
		
		GetFilesinClusters := project(dataset(srccluster,dummylayout),getAllClustersxform(left));
		
		getallclusterrecs getFileIndosxform(ds l) := transform
			self.dummy := 1;
			self.dfulayout :=  if (filepattern <> '',
										wk_ut.get_DFUQuery(,,l.name,,,,,,,,,,,,,,,,srcesp).dnorm(regexfind(filepattern,name,nocase)),
										wk_ut.get_DFUQuery(,,l.name,,,,,,,,,,,,,,,,srcesp).dnorm
										);
		end;
		
		dGetFileInfo := project(ds,getFileIndosxform(left));
		
		GetAllClusters := if (count(ds) > 0, dGetFileInfo, GetFilesinClusters);
		
		CommonLayout norm_recs(GetAllClusters l, CommonLayout r) := transform
			self := r;
		end;
		
		inPatternds := normalize(GetAllClusters,left.dfulayout,norm_recs(left,right));
		
		return inPatternds;
	end;

	

	// Prep the copy command for each file
	export GetSourceList := function
		
		// inPatternds := GetFullList();
		
		// CommonLayout converTocommonlay(inPatternds l, ds r) := transform
			// self := l;
			// // self := [];
		// end;
		
		// convertTonewLayout := join(inPatternds,sort(ds,name),
														// left.name = right.name,
														// converTocommonlay(left,right));
	
		srclist := 	GetFullList();

		rFileList proj_recs(srclist l) := transform
			self.name := l.name;
			self.newlogicalname := if ( dstSubNameSuffix = ''
											,if (srcdali = destdali,l.name+'::copyfrom'+l.ClusterName, l.name)
											,l.name+'_'+dstSubNameSuffix
											);
			self.cmd := 'server=http://'+ destesp + ':8010 ' 
									+ 'overwrite=1 ' 
									+ 'replicate=1 ' 
									+ 'action=copy ' 
									+ 'dstcluster=' + destcluster +' ' 
									// Choose the filename suffix
									+ if ( dstSubNameSuffix = ''
											,if (srcdali = destdali,'dstname=~'+l.name+'::copyfrom'+l.ClusterName, 'dstname=~'+l.name)
											,'dstname=~'+l.name+'_'+dstSubNameSuffix
											)
									+ ' srcname=~'+l.name 
									+ ' nosplit=1 '
									+ 'wrap=1 '
									+ 'srcdali=' + srcdali + ' '
									+ if (l.iscompressed,' compress=1',' compress=0');

			self := l;
		end;

		preplist := sort(project(srclist,proj_recs(left)),name);
	
		return preplist;
	
	end;
	
	// Get the list of files to migrate
	export FilesToMigrate() := function
	
		preplist := sort(GetSourceList, name);
	
	/*	// Get file list in destination cluster/esp
		indest_full := if (filepattern <> '',
									wk_ut.get_DFUQuery(,destcluster,,,,,,,,,,,,,,,,,destesp).dnorm(regexfind(filepattern,name,nocase)),
									wk_ut.get_DFUQuery(,destcluster,,,,,,,,,,,,,,,,,destesp).dnorm
									);

		
		indest_slim :=  if (srcdali = destdali,
													sort(indest_full(regexfind('::copyfrom[0-9a-zA-Z]+',name,nocase)),name),
													sort(indest_full,name)
												);*/

		rCopyFiles get_recs(preplist l) := transform
			self.existsondest := if (srcdali = destdali
																	,if (STD.File.FileExists('~'+l.newlogicalname), true, false)
																	,if (STD.File.FileExists('~foreign::'+destdali+'::'+l.newlogicalname),true, false)
																	);
			self := l;
		end;

		
		noncopiedrecs := projecT(preplist,get_recs(left));/*if (srcdali = destdali,
												// use join based on parameters passed
												join(preplist, indest_slim,
														if ( dstSubNameSuffix = ''
															,left.name = regexreplace('::copyfrom[0-9a-zA-Z]+',right.name,'')
															,left.name = regexreplace('_'+dstSubNameSuffix,right.name,'')
															),
														get_recs(left,right),
														left outer),
												join(preplist, indest_slim, 
														if ( dstSubNameSuffix = ''
																,left.name = right.name
																,left.name = regexreplace('_'+dstSubNameSuffix,right.name,'')
																),
														get_recs(left,right),
														left outer)
														
												);*/
														
		
		return noncopiedrecs;
		
	end;
	
	// Files to Migrate/Copy
	export GetFilesToMigrate := FilesToMigrate() : independent;
	
	// Populate the file count based on p_getfiles = 'all'; 'missing'; 'copied'
	export PopulateCtr(string p_getfiles = 'all') := function
		
		dGetSetForCtr := MAP(p_getfiles = 'missing' => GetFilesToMigrate(~existsondest),
												p_getfiles = 'copied' => GetFilesToMigrate(existsondest),		
												GetFilesToMigrate);
		
		rCopyFiles getcnt(dGetSetForCtr l, integer ctr) := transform
			self.cnt := ctr;
			self := l;
		end;

		dProjectForCtr := project(dGetSetForCtr,getcnt(left,counter));

		return dProjectForCtr;
	end;
	
	// output files
	export WriteFiles(string p_getfiles = 'all') := function
		FileNameToWrite := MAP(p_getfiles = 'missing' => mFileList_LogicalNames,
												p_getfiles = 'copied' => cFileList_LogicalNames,		
												aFileList_LogicalNames);
		return output(PopulateCtr(p_getfiles),,FileNameToWrite,overwrite);
	end; 

	// dataset of files
	export GetFilesDataset(string p_getfiles = 'all') := function
		FileNameToUse := MAP(p_getfiles = 'missing' => mFileList_LogicalNames,
												p_getfiles = 'copied' => cFileList_LogicalNames,		
												aFileList_LogicalNames);
		return dataset(FileNameToUse,rCopyFiles,thor,opt);
	end; 
	
	// count of files
	export GetCount(string p_getfiles = 'all') := count(GetFilesDataset(p_getfiles)) : independent;
	
	// list of superfiles
	export dSuperFileList := fileservices.LogicalFileSuperSubList(); // this will take a while depending on the number of files
																													// this list has to be refreshed during each run
	
	// Populate super for each logical, if the logical is in super
	export isSuperFileList() := function
		dCopySorted := if (~fileservices.fileexists(aFileList_LogicalNames)
														,sort(PopulateCtr(), name) // only time this will be used is whwn this 
																									// function is run as stand-alone
														,sort (GetFilesDataset(), name)
													);
    dSuperSorted := sort (dSuperFileList, subname);

		rSuperFileList AddSuperToList (dCopySorted l, dSuperSorted r) := transform
			self.name := l.name;
      self.cmd := l.cmd;
      self.cnt := l.cnt;
      self.existsondest := l.existsondest;
      self.supername := r.supername;
			self := l;
    end;

    dJoinSuper :=	join(dCopySorted
										,dSuperSorted
										,left.name = right.subname
										,AddSuperToList(left,right)
										,left outer);

                                                                                                                                
		return dJoinSuper;

	end;
	
	// write the filelist to a logical
	export WriteAllFiles := sequential
														(
																WriteFiles()
																,WriteFiles('missing')
																,WriteFiles('copied')
														);
	
	// tasks to be run upon success or failure during automated copy run
	export PostTasks(string wid = WORKUNIT
									,string senderemail
									,string toemaillist) := function
			return sequential
									(
											fileservices.deletelogicalfile(FlagFile)
											,dops.GetWUErrorMessages(WORKUNIT
																							,srcesp
																							,
																							,senderemail
																							,toemaillist)
									);
	end;
	
	
	// Run copy
	export Run := if (regexfind('hthor', thorlib.cluster())
									,sequential
										(
										WriteAllFiles
										// copy only missing files in dest
										,if (GetCount('missing') > 0
											,apply(GetFilesDataset('missing')
												,sequential(
														output('Copying file ' + (string)cnt + ' of ' + (string)GetCount('missing') + ' from ' + srcdali + ' to ' + destdali + ':' + destcluster,named('Copy_Status'))
														,STD.File.DfuPlusExec(cmd)
															)
													)
												,output('nothing to copy')
												)
											)
										,fail('run on a hthor cluster')
									);
	
	
	
		// Automated Run
		// will automatically try to restart the job upon failure
		// will avoid any overlaps
	export AutomatedCopy(string senderemail
											,string toemaillist) := if (regexfind('hthor', thorlib.cluster())
														,if (~fileservices.fileexists(FlagFile)
																,sequential
																(
																	output(dataset([{thorlib.jobowner()}],{string owner}),,FlagFile,overwrite)
																	,WriteAllFiles
																	// copy only missing files in dest
																	,apply(GetFilesDataset('missing')
																	,sequential(
																		output('Copying file ' + (string)cnt + ' of ' + (string)GetCount('missing') + ' from ' + srcdali + ' to ' + destdali + ':' + destcluster,named('Copy_Status'))
																			,STD.File.DfuPlusExec(cmd)
																			)
																		)
																)
																,output('Either copy in progress or process was aborted, check '+Flagfile+' for owner')
															)
														,fail('run on a hthor cluster')
													) : success(PostTasks(,senderemail,toemaillist))
															,failure(PostTasks(,senderemail,toemaillist));
	
end;