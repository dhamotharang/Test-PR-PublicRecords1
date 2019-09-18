import lib_fileservices,lib_thorlib,ut,STD;
EXPORT FileModule(string esp
									,string port = '8010'
									) := module
									
	shared l_esp := if (~regexfind('http://',esp),'http://'+esp, esp);
	
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
	
	
end;