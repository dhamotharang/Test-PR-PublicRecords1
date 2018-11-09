import ut,dops,lib_fileservices,wk_ut,STD;
EXPORT GetOldFiles(string environment,integer noofdays = 0, string in_cluster = ''
,string dopsenv = dops.constants.dopsenvironment) := module

	export FullList := thorbackup.Constants.Fulllist(environment);
	
	export TodaysDate := (STRING8)Std.Date.Today() : independent;
	
	export GetFullListWithPattern() := function
		fulllogicallist := fileservices.logicalfilelist();
		
		rWithPattern	:=
		record
			unsigned4		Age;
			string255		FilePattern;
			recordof(fulllogicallist);
		end;
		
		rWithPattern	tWithPattern(fulllogicallist pInput) :=
		transform
			self.FilePattern	:=	regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',pInput.name,'*',nocase),'*',nocase);
			self.Age					:=	ut.DaysApart(TodaysDate, pInput.Modified[1..4] + pInput.Modified[6..7] + pInput.Modified[9..10]);
			self							:=	pInput;
		end;
		
		fullds	:=	sort(project(fulllogicallist, tWithPattern(left)),filepattern) : independent;
		
		return fullds;
		
	end;
		
	export layout_filelist := record
			integer whichbasket := 0;
			integer cnt := 0;
			string filename;
			string filepattern;
			string modified;
			integer size;
			string owner;
			string cluster;
			integer totalmatchedfiles;// := 0;
			string daliip;
		end;

	export getlist() := function
		//preds := sort(fileservices.logicalfilelist()(ut.DaysApart(regexreplace('-',modified,'')[1..8],ut.GetDate) > thorbackup.constants.getthreshold(noofdays).ndays and cluster not in thorbackup.ignoreclusters),-name);
		
		
		//preds := sort(GetFullListWithPattern()(Age > thorbackup.constants.getthreshold(noofdays).ndays and cluster not in thorbackup.ignoreclusters),-name);
		preds := sort(GetFullListWithPattern()(cluster not in thorbackup.ignoreclusters),-name);
		
		ds := if (in_cluster <> '' , preds(cluster = in_cluster), preds(cluster in thorbackup.Constants.allowedclusters(environment).clusterset))(~regexfind('[	]',name));
		
		dsfromdb := sort(thorbackup.GetDeleteFilesFromDB(),-filename);
		
		typeof(ds) getfilesnotindb(ds l, dsfromdb r) := transform
			self := l;
		end;
		
		filesnotindb := sort(join(ds,dsfromdb(daliip = environment),
													left.name = right.filename and
													left.cluster = right.cluster and  
													left.modified[1..10] = right.modified[1..10],
													getfilesnotindb(left,right),
													left only
													),name);// : independent;
		
		//supers := sort(fileservices.Logicalfilesupersublist(),-subname);
		notinsuper_recs := record
			ds;
			boolean insuper;
		end;
		
		/*
		notinsuper_recs notinsuper(filesnotindb l) := transform
			self.insuper := if (trim(l.name,left,right) in set(Fulllist,trim(subname,left,right)), true, false);//thorbackup.hasSupers(l.name);
			self := l;
		end;
		
		getnotinsuper := project(filesnotindb,
																	notinsuper(left))(~insuper);
		*/
		
		notinsuper_recs notinsuper(filesnotindb l, Fulllist r) := transform
			self.insuper := false;
			self := l;
		end;
		
		getnotinsuper := join(filesnotindb, Fulllist,
													trim(left.name,left,right) = trim(right.subname,left,right),
													notinsuper(left,right),
													left only
													);
		
		dGetWUDetails := dops.WorkunitTimingDetails(thorbackup.Constants.esp.bocaprodthor,'','',false).GetDetails() : independent;
		
		rlayout_filelist := record
			layout_filelist;
			dataset(wk_ut.get_DFUInfo().DFUInfoOutRecord) dfuinfo;
		end;	
		
		
		rlayout_filelist proj_recs(getnotinsuper l) := transform
			//getpattern := regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',l.name,'*',nocase),'*',nocase);
			self.filename := l.name;
			self.filepattern := l.FilePattern;
			self.modified := if (l.modified <> '',l.modified,'_blank_');
			self.size := l.size;
			
			self.cluster := if(l.cluster <> '',l.cluster,'_blank_');
			self.totalmatchedfiles := 0;//count(GetFileList(getpattern));
			self.daliip := environment;
			self.dfuinfo := wk_ut.get_DFUInfo(trim(l.name)).DFUInfo();
			self.owner := l.owner;
		end;
		
		getpatternswithdfuinfo := project(getnotinsuper,proj_recs(left))(size >= thorbackup.Constants.deletethresholdsize) : independent;
		
		layout_filelist xGetPatternsWithnoCount(getpatternswithdfuinfo l) := transform
			// DUS-314
			jname := if (l.dfuinfo[1].wuid[1..1] = 'W'
										,l.dfuinfo[1].JobName
										,dGetWUDetails(regexfind(l.dfuinfo[1].wuid,dfujobid,nocase))[1].job
										); // DUS-314
			self.owner := if (l.owner <> ''
												,if (regexfind('dataopsowner',jname)
														,STD.Str.GetNthWord(STD.Str.SplitWords(jname,':')[2],1)
														,l.owner)
											,'_blank_');
			// end DUS-314
			self := l;
		end;
	
		getpatternswithnocount := project(getpatternswithdfuinfo,xGetPatternsWithnoCount(left));
		
		rPatternCounts2	:=
		record
			GetFullListWithPattern().FilePattern;
			//unsigned4		AgeOlderThanCutoff	:=	count(group, dWithPattern.Age > gCutoff);
			unsigned4		Total					:=	count(group);
		end;

		dPatternCounts2	:=	table(GetFullListWithPattern(), rPatternCounts2, FilePattern, few) : independent;
		
		layout_filelist populatecountinoriginal(getpatternswithnocount l, dPatternCounts2 r) := transform
			self.totalmatchedfiles := r.total;
			self := l;
		end;
		
		
		olderfileswithpatterns := join(getpatternswithnocount
																				,dPatternCounts2
																					,left.filepattern = right.filepattern
																				,populatecountinoriginal(left,right));
		
		integer totcount := count(filesnotindb) : independent;
		integer baskets := totcount / thorbackup.Constants.getnooffiles().nfiles; // total soapcalls
		
		layout_filelist numbertherecords(olderfileswithpatterns l,integer c) := transform
			self.cnt := c;
			self := l;
		end;
		
		numberedrecords := project(olderfileswithpatterns,numbertherecords(left,counter));
		
		//integer l_basket := 1;
		layout_filelist itr_recs(numberedrecords l, numberedrecords r) := transform
			self.whichbasket := if (r.cnt > (baskets * l.whichbasket) and r.cnt > (l.whichbasket * thorbackup.Constants.getnooffiles().nfiles),l.whichbasket + 1,l.whichbasket);
			self := r;
			
		end;
		
		groupbaskets := iterate(numberedrecords,itr_recs(left,right));
		
		return groupbaskets;
		
	end;
	
	export updatedb(dataset(layout_filelist) ds) := function
	
		l_filelist := record
			string filename{xpath('filename')};
			string filepattern{xpath('filepattern')};
			string modified{xpath('modified')};
			integer size{xpath('size')};
			string owner{xpath('owner')};
			string cluster{xpath('cluster')};
			integer totalmatchedfiles{xpath('totalmatchedfiles')};
			string daliip{xpath('daliip')};
			string issetfordelete{xpath('issetfordelete')} := '';
			string statuscode{xpath('statuscode')} := '';
			string statusdescription{xpath('statusdescription')} := '';
			integer noofdays{xpath('noofdays')};
			string emailid{xpath('emailid')} := '';
			string excludeme{xpath('excludeme')} := '0';
		end;
		
		l_filelist proj_recs(ds l) := transform
			self.noofdays  := if (noofdays > 0, noofdays, thorbackup.constants.getthreshold(noofdays).ndays);
			self := l;
		end;
		
		proj_out := project(ds,proj_recs(left));
		
		
		filelist := record, maxlength(50000)
			
			dataset(l_filelist) r_filelist{xpath('filelist')};
		end;
		
		filelist tmakefatrecord(proj_out L) := transform
			self.r_filelist   := DATASET([{ l.filename, l.filepattern, l.modified, l.size, l.owner, l.cluster, l.totalmatchedfiles, l.daliip, l.issetfordelete, l.statuscode, l.statusdescription, l.noofdays,'','0' }], l_filelist);
			self := L;
		end;

		file_flat := project(proj_out, tmakefatrecord(left));
		
		
		InputRec := record, maxlength(50000)
			dataset(filelist) d_filelist{xpath('flist')} := file_flat;
			
		end;
	
		
		outrec := record
			string Code{xpath('status/statuscode')};
			string description{xpath('status/statusdescription')};
		end;
	
		soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv),
				'UpdateThorFileList',
				InputRec,
				outrec,
				xpath('UpdateThorFileListResponse/UpdateThorFileListResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/UpdateThorFileList'));
	
		respstatus := record
			string Code;
			string description;
		
		end;
		
		resp := dataset([{soapresults.Code,soapresults.description}],respstatus);
		
		return resp;
	end;
	
	export updatethorfilelist() := function
		ds := getlist() : independent;
		
		basketsds := dedup(ds,whichbasket);

		respstatus := record
			string Code;
			string description;
		
		end;
		
		soap_recs := record
			integer whichbasket;
			//integer flagforemail := 0;
			dataset(respstatus) rstatus;
		end;
		
		soap_recs make_soap_calls(basketsds l) := transform
			
			self.rstatus := updatedb(ds(whichbasket = l.whichbasket));
			self := l;
		end;
		
		soap_response := project(basketsds,make_soap_calls(left));
		
		soapds := dataset('~yogurt::soapcalls::toupdatedb',soap_recs,thor,opt);
		
		return sequential(
									//output(choosen(ds,100)),
									output(soap_response,,'~yogurt::soapcalls::toupdatedb',overwrite),
									if(count(soapds(rstatus[1].Code = '-1')) > 0,
									sequential(
										//output(choosen(soapds(rstatus[1].Code = '-1'),100)),
										fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			'Yogurt Delete Soap Calls failed on ' + environment + ' - ' + Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),
			'workunit: ' + workunit
																	,
																	,
																	,thorbackup.constants.yogurt().senderemail)),
										output('No Soap failures')
											)
									);
									
			
	end;
	
	export run :=  updatethorfilelist() : failure(fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			'Yogurt DOPS DB Update failed on ' + environment + ' - ' + Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),
			'workunit: ' + workunit+ '\r\n' + failmessage
																	,
																	,
																	,thorbackup.constants.yogurt().senderemail));
	
end;