import _Control,STD,wk_ut,ut;

EXPORT WorkUnitModule(string lTargetESPAddress,string lTargetESPPort) := module
	
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
	
	export	string	fSubmitNewWorkunit(string pECLText, string pCluster)	:=
	function
		string fWUCreateAndUpdate(string pECLText)	:=
		function

			rWUCreateAndUpdateRequest	:=
			record
				string										QueryText{xpath('QueryText'),maxlength(20000)}	:=	pECLText;
			end;

			rESPExceptions	:=
			record
				string		Code{xpath('Code'),maxlength(10)};
				string		Audience{xpath('Audience'),maxlength(50)};
				string		Source{xpath('Source'),maxlength(30)};
				string		Message{xpath('Message'),maxlength(200)};
			end;

			rWUCreateAndUpdateResponse	:=
			record
				string										Wuid{xpath('Workunit/Wuid'),maxlength(20)};
				dataset(rESPExceptions)		Exceptions{xpath('Exceptions/ESPException'),maxcount(110)};
			end;

			dWUCreateAndUpdateResult	:=	soapcall('http://' + lTargetESPAddress + ':' + lTargetESPPort + '/WsWorkunits',
																						 'WUUpdate',
																						 rWUCreateAndUpdateRequest,
																						 rWUCreateAndUpdateResponse,
																						 xpath('WUUpdateResponse')
																						 ,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
																						);

			return	dWUCreateAndUpdateResult.WUID;
			
		end;

		fWUSubmit(string pWUID, string pCluster)	:=
		function
			rWUSubmitRequest	:=
			record
				string										WUID{xpath('Wuid'),maxlength(20)}										:=	pWUID;
				string										Cluster{xpath('Cluster'),maxlength(30)}							:=	pCluster;
				// string										Queue{xpath('Queue'),maxlength(30)}									:=	pQueue;
				string										Snapshot{xpath('Snapshot'),maxlength(10)}						:=	'';
				string										MaxRunTime{xpath('MaxRunTime'),maxlength(10)}				:=	'0';
				string										Block{xpath('BlockTillFinishTimer'),maxlength(10)}	:=	'0';
			end;

			rWUSubmitResponse	:=
			record
				string										Code{xpath('Code'),maxlength(10)};
				string										Audience{xpath('Audience'),maxlength(50)};
				string										Source{xpath('Source'),maxlength(30)};
				string										Message{xpath('Message'),maxlength(200)};
			end;

			dWUSubmitResult	:=	soapcall('http://' + lTargetESPAddress + ':' + lTargetESPPort + '/WsWorkunits',//http://10.193.211.1:8010/WsWorkunits/',
																	 'WUSubmit',
																	 rWUSubmitRequest,
																	 rWUSubmitResponse,
																	 xpath('WUSubmitResponse/Exceptions/Exception')
																	 ,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
																	);

			return	dWUSubmitResult;
		end;

		string	lWUIDCreated	:=	fWUCreateAndUpdate(pECLText);
		dExceptions						:=	fWUSubmit(lWUIDCreated, pCluster);
		string	ReturnValue		:=	if(dExceptions.Code = '',
																 lWUIDCreated,
																 ''
																);
		return	dExceptions.Code;//return	ReturnValue;
	end;
	
	export fGetFilesInWorkunit(string wid) := function
		
		rWUInfoRequest := record
			string Name{xpath('Wuid')} := wid;
		end;

	
		rWUInfoFilesUsed := record
			string100 name {XPATH('Name')} := '';
		end;

	
		rWUInfoFilesCreated := record
			string100 name {XPATH('FileName')} := '';
		end;

	
		rWUInfoResponse := record,maxlength(300000)
			string20 Wuid{xpath('Wuid')};
			dataset(rWUInfoFilesUsed) dWUInfoFilesUsed{xpath('SourceFiles/ECLSourceFile')};
			dataset(rWUInfoFilesCreated) dWUInfoFilesCreated{xpath('Results/ECLResult')};
		end;
	
		dSOAPResult := SOAPCALL('http://'+lTargetESPAddress+':'+lTargetESPPort+'/WsWorkunits', 'WUInfo', 
											rWUInfoRequest, dataset(rWUInfoResponse),
											xpath('WUInfoResponse/Workunit')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );
										 
		rWUFilesFlat := record
			string20 wuid := wid;
			string100 name := '';
			dataset(wk_ut.get_DFUInfo().DFUInfoOutRecord) dfuinfo;
		end;
	
		rWUFilesFlat xWUFilesUsedFlat(dSOAPResult l, rWUInfoFilesUsed r) := transform
			self.name := trim(r.name,left,right);
			self.dfuinfo := wk_ut.get_DFUInfo(trim(r.name,left,right)).DFUInfo();
			self := l;
		end;
	
		dWUFilesUsedFlat := sort(normalize(dSOAPResult,left.dWUInfoFilesUsed,xWUFilesUsedFlat(left,right)),name);
	/*
		getfilelist := sort(fileservices.logicalfilelist(),name);
	
		filenames getmodified(getfilelist l, filesused_premod r) := transform
			self.modified := l.modified;
			self := r;
		end;
		
		filesused := join(getfilelist,filesused_premod,left.name = right.files,getmodified(left,right));
		*/
		/*fulllist := dedup(sort(filesused(~(files = ''
																				or regexfind('hpccinternal',files,nocase)
																				or regexfind('spill',files,nocase)
																				or regexfind('persist',files,nocase)
																				//or regexfind('::key::',files,nocase)
																				or regexfind('yogurt',files,nocase)
																				// or regexfind('foreign',files,nocase)
																				or regexfind(':: ',files,nocase)
																				or regexfind('thor::base::aidtemp',files,nocase)
																				or regexfind('__p[0-9]+$', files,nocase)
																				or regexfind('::temp::', files,nocase)
																				or regexfind('::nid::', files,nocase)
																				or regexfind('[/~()]', files,nocase)
																				or regexfind('10.173.231.12',files,nocase)
																				or regexfind('10.241.20.205',files,nocase)
																				or regexfind('10.241.50.45',files,nocase)
																				or regexfind('thor_data400::in::seq',files,nocase)
																				or regexfind('^file::.*$',files,nocase)
																				)) ,files),record);

		fullset := record
			string100 files;
			string30 modified;
		end;

		final_layout := record
			string20 wuid;
			dataset(fullset) fnames;
		end;

		final_layout proj_recs(fulllist l) := transform
			self.fnames := row(l,fullset);
			self := l;
		end;
	
		proj_out := project(fulllist,proj_recs(left));

		final_layout rolluprecs(proj_out l, proj_out r) := transform
			self.fnames := l.fnames + row({r.fnames[1].files,r.fnames[1].modified},fullset);
			self := l;
		end;
	
		rollout := rollup(proj_out,wuid,rolluprecs(left, right),local);	

		return rollout;*/
		return dWUFilesUsedFlat;
	end;
	/*
	export fGetFilesByUserFromWorktunits(string username) := function
		dGetWorkunitList := STD.system.Workunit.WorkunitList()(owner = username or regexfind(username,job));
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
		
		getpatternswithdfuinfo := project(getnotinsuper,proj_recs(left)) : independent;
		
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
		
		return getpatternswithnocount;
		
	end;*/
	
end;