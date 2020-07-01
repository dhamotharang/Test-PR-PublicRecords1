import lib_fileservices,lib_thorlib,ut,STD;
EXPORT FileModule(string esp
									,string port = '8010'
									,string targettype = ''
									,string target = ''
									) := module
									
	shared l_esp := if (~regexfind('http://',esp),'http://'+esp, esp);
	shared l_roxiepathprefix := '/var/lib/HPCCSystems/hpcc-data/roxie/';
	shared rParts := record
                string nodeip := '';
                string dirpath := '';
                string partname := '';
                dataset(STD.File.FsFilenameRecord) dFParts;
                //unsigned4 tfileparts;
                
	end;
	
	shared rExceptions := record
		string errormsg{xpath('Exception/Message')}
	end;
	
	export GetFilesInWorkunit(string wuid = WORKUNIT) := function
		
		rWUInfoRequest := record
			string Name{xpath('Wuid')} := wuid;
		end;

		rInputFiles := record
			string100 name {XPATH('Name')} := '';
		end;
		
		rOutputFiles := record
			string100 name {XPATH('FileName')} := '';
		end;

		rWUInfoResponse := record,maxlength(300000)
			string20 Wuid{xpath('Wuid')};
			dataset(rInputFiles) infiles{xpath('SourceFiles/ECLSourceFile')};
			dataset(rOutputFiles) outfiles{xpath('Results/ECLResult')};
		end;
	
		dWUInfoResponse := SOAPCALL(l_esp+':'+port+'/WsWorkunits'
													,'WUInfo' 
													,rWUInfoRequest
													,dataset(rWUInfoResponse)
													,xpath('WUInfoResponse/Workunit')
													,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );

		
		
		rFileNames := record
			string20 wuid := wuid;
			string100 files := '';
			string filetype := '';
			boolean isSuper;
			
		end;
	
		rFileNames xNormInputFileNames(dWUInfoResponse l, rInputFiles r) := transform
			self.files := r.name;
			self.filetype := 'input';
			self.isSuper := if(fileservices.superfileexists('~'+trim(r.name,left,right)),true,false);
			self := l;
		end;
		
		dInputFileNames := normalize(dWUInfoResponse,left.infiles,xNormInputFileNames(left,right));
	
		rFileNames xNormOutputFileNames(dWUInfoResponse l, rOutputFiles r) := transform
			self.files := r.name;
			self.filetype := 'output';
			self.isSuper := if(fileservices.superfileexists('~'+trim(r.name,left,right)),true,false);
			self := l;
		end;
		
		dOutputFileNames := normalize(dWUInfoResponse,left.outfiles,xNormOutputFileNames(left,right));
	
		dFileNames := dedup(sort(dInputFileNames + dOutputFileNames,files),files)(files <> '');
	
		return dFileNames;
	end;
	
	export SetDescForOutFilesInWU(string wuid = WORKUNIT
															,string description = thorlib.jobowner()) := function
		dFilesinWU := GetFilesInWorkunit(wuid)(filetype = 'output');
		
		return nothor
							(
								apply(global(dFilesinWU(~isSuper),few)
											,if(fileservices.fileexists('~'+trim(files,left,right))
														,fileservices.setfiledescription('~'+trim(files,left,right), description)
														
												)
										)
								);
		
	end;
	
	export GetFileDesc(string filename) := fileservices.getfiledescription(if (regexfind('~',filename), filename, '~'+filename));
	
	EXPORT fSoapCopy(
									string pSourceLogical
									,string pDestGroup
									,string pDestLogical
									,string pSourceDali
									,string pSourceUsername = ''
									,string pSourcePassword = ''
									,string pOverwrite = '1'
									,string pReplicate = '1'
									,string pNoSplit = '1'
									,string pNoWrap = '1'
									,string pTransferBuffersize = '1000000'
									,string pCompress = '1'
									
								):= function
		
		
	
		rCopyRequest := record
			string sourceLogicalName{xpath('sourceLogicalName')} := pSourceLogical;
			string destGroup{xpath('destGroup')} := pDestGroup;
			string destLogicalName{xpath('destLogicalName')} := pDestLogical;
			string sourceDali{xpath('sourceDali')} := pSourceDali;
			string srcusername{xpath('srcusername')} := pSourceUsername;
			string srcpassword{xpath('srcpassword')} := pSourcePassword;
			string overwrite{xpath('overwrite')} := pOverwrite;
			string replicate{xpath('replicate')} := pReplicate;
			string nosplit{xpath('nosplit')} := pNoSplit;
			string compress{xpath('compress')} := pCompress;
			string Wrap{xpath('Wrap')} := pNoWrap;
			string transferBufferSize{xpath('transferBufferSize')} := pTransferBuffersize;
		end;

		
		rCopyResponse := record,maxlength(300000)
			string20 result{xpath('result')};
			dataset(rExceptions) exceptions{xpath('Exceptions')};
		end;
	
		dWUInfoResponse := SOAPCALL(l_esp+':'+port+'/FileSpray'
													,'Copy' 
													,rCopyRequest
													,dataset(rCopyResponse)
													,xpath('CopyResponse')
													,LITERAL
													,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );
		return dWUInfoResponse;
	
	end;
	
	export dRoxieTopology := dops.modWsTopology(esp,port).fTpTargetClusterQuery(targettype,target) : independent;
	export dRoxiePackage := dops.GetRoxiePackage(esp,port,target).Keys() : independent;
	
	export fGetPartsFromRoxie(string p_dirpath
                           ,string p_lasttoken
                           ,string filedali = ''
													 ) := FUNCTION

		
		rParts xform(dRoxieTopology l, UNSIGNED2 cntr) := TRANSFORM
			dParts := STD.File.RemoteDirectory(l.netaddress,p_dirpath,p_lasttoken+'._*');
      SELF.nodeip := l.netaddress;
      self.dirpath := p_dirpath;
      self.dFParts := dParts;
    END;
    
		dGetNodesAndParts := project(dRoxieTopology, xform(left,COUNTER));
			rParts - dFParts xNormPath(dGetNodesAndParts l, STD.File.FsFilenameRecord r) := transform
      self.partname := r.name;
      self := l;
    end;
    
		dNormParts := sort(normalize(dGetNodesAndParts,left.dFParts,xNormPath(left,right)),partname,nodeip);
		
		RETURN dNormParts(~regexfind('\\$',partname));
END;

	
	// file copy status
	export fGetRoxieFileCopyStatus(
																string roxiedali
															) := function
	
		rCopyStatus := record
			string packagename := '';
			string packageid := '';
			set of string tokens := [];
			string buildversion := '';
      string superfile := '';
      string subfile := '';
      string directory := '';
      string filemask := '';
			unsigned4 copiedfileparts := 0;
      unsigned4 expectedfileparts := 0;
      unsigned4 pendingpartstocopy := 0;
      unsigned4 percentcopied := 0;
			string wuid := '';
		end;

		rCopyStatus xGetTotalFilePartFromDali(dRoxiePackage l) := transform
                self.expectedfileparts := (unsigned4)STD.File.GetLogicalFileAttribute(if (roxiedali <> '','~foreign::'+roxiedali+'::','~')+l.subfile,'numparts');
                self := l;
		end;

		dGetTotalFilePartFromDali := project(dRoxiePackage,xGetTotalFilePartFromDali(left));
		
		rCopyStatusWithParts := record
			rCopyStatus;
      dataset(rParts - dFParts) dAllParts;
		end;

		rCopyStatusWithParts xCopyStatus(dGetTotalFilePartFromDali l) := transform
                wordcount := STD.Str.CountWords(l.subfile,'::');
                getlasttoken := STD.Str.GetNthWord(regexreplace('::',l.subfile,' '),wordcount);
                abspath := l_roxiepathprefix+regexreplace(getlasttoken,regexreplace('::',l.subfile,'/'),'');
                dGetParts := fGetPartsFromRoxie(abspath,getlasttoken);
                self.filemask := getlasttoken;
                self.directory := abspath;
                self.dAllParts := dGetParts;
                self.copiedfileparts := count(dedup(dGetParts,partname));
                self := l;
		end;

		dCopyStatus := project(dGetTotalFilePartFromDali,xCopyStatus(left));
		rCopyStatus xNormRecs(dCopyStatus l, rParts - dFParts r) := transform
			l_tokens := STD.Str.SplitWords(regexreplace('_',l.subfile,'::'),'::');
			self.tokens := l_tokens;
                //self.partname := r.partname;
                self.pendingpartstocopy := l.expectedfileparts - l.copiedfileparts;
                self.percentcopied := (l.copiedfileparts / l.expectedfileparts) * 100;
								self.buildversion := dataset(l_tokens,{string tokens})(regexfind('^[0-9]+$',tokens)
																																				or regexfind('^[0-9]+[a-z]',tokens))[1].tokens;
								self.wuid := WORKUNIT;
								self := l;
		end;

		dFinalCopyStatus := dedup(sort(normalize(dCopyStatus,left.dAllParts,xNormRecs(left,right)),percentcopied,packageid,superfile,subfile),percentcopied,packageid,superfile,subfile);

		return dFinalCopyStatus;
		
	end;
end;