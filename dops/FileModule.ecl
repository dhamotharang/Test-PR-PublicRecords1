import lib_fileservices,lib_thorlib,ut,STD,_Control;
EXPORT FileModule(string esp = ''
									,string port = '8010'
									,string targettype = ''
									,string target = ''
									,string roxieabsolutepatch = '/var/lib/HPCCSystems/hpcc-data/roxie/'
									,string location = 'uspr' // <country><business> - uspr, usins, ushc
									,string dopsenv = dops.constants.dopsenvironment
									,string dopsclusterflag = ''
									,integer noofsoapcalls = 30
									) := module
									
	shared getfullesp(string l_esp) := if (~regexfind('http://',l_esp),'http://'+l_esp, l_esp);
	//shared l_roxiepathprefix := roxieabsolutepatch;
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
	
	export rDBLayout := record
			string datasetname{xpath('datasetname')};
			string superkeyname{xpath('superkeyname')};
			string buildversion{xpath('buildversion')};
			string locationflag{xpath('locationflag')};
			string clustername{xpath('clustername')};
			integer copiedparts{xpath('copiedparts')};
			integer expectedparts{xpath('expectedparts')};
			integer pendingpartstocopy{xpath('pendingpartstocopy')};
			integer percentcopied{xpath('percentcopied')};
			string statuscode{xpath('statuscode')};
			string statusdescription {xpath('statusdescription')};
		end;
	
	export rCopyStatus := record
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
			string whenlastupdated := '';
			integer whichbasket := 0;
			integer recordcount := 0;
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
	
		dWUInfoResponse := SOAPCALL(getfullesp(esp)+':'+port+'/WsWorkunits'
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
	
		dWUInfoResponse := SOAPCALL(getfullesp(esp)+':'+port+'/FileSpray'
													,'Copy' 
													,rCopyRequest
													,dataset(rCopyResponse)
													,xpath('CopyResponse')
													,LITERAL
													,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );
		return dWUInfoResponse;
	
	end;
	
	export dRoxieTopology(string l_esp = esp
												,string l_port = port
												,string l_target = target
												,string l_targettype = targettype) := dops.modWsTopology(l_esp,l_port).fTpTargetClusterQuery(l_targettype,l_target);// : independent;
	export dRoxiePackage(string l_esp = esp
												,string l_port = port
												,string l_target = target) := dops.GetRoxiePackage(l_esp,l_port,l_target).Keys();// : independent;
	
	export fGetPartsFromRoxie(string p_dirpath
                           ,string p_lasttoken
                           ,string filedali = ''
													 ,string l_esp = esp
												,string l_port = port
												,string l_target = target
												,string l_targettype = targettype
												
													 ) := FUNCTION

		dTopology := dRoxieTopology(l_esp,l_port,l_target,l_targettype);//: independent;
		
		rParts xform(dTopology l, UNSIGNED2 cntr) := TRANSFORM
			dParts := STD.File.RemoteDirectory(l.netaddress,p_dirpath,p_lasttoken+'._*');
      SELF.nodeip := l.netaddress;
      self.dirpath := p_dirpath;
      self.dFParts := dParts;
    END;
    
		dGetNodesAndParts := project(dTopology(isNodeUp), xform(left,COUNTER));
		rParts - dFParts xNormPath(dGetNodesAndParts l, STD.File.FsFilenameRecord r) := transform
      self.partname := r.name;
      self := l;
    end;
    
		dNormParts := sort(normalize(dGetNodesAndParts,left.dFParts,xNormPath(left,right)),partname,nodeip);
		
		RETURN dNormParts(~regexfind('\\$',partname));
END;

	export rInputParameters := record
		string rxesp; // only ip (no port or http)
		string rxdali; // only ip (no port)
		string rxtargetcluster;
		string rxport := '8010';
		string rxtargettype := 'roxie';
		string rxpath := '/var/lib/HPCCSystems/hpcc-data/roxie/';
	end;
	
	export rFullRecord := record
		rInputParameters;
		rCopyStatus - tokens;
	end;
	
	shared vCopyStatusFileNamePrefix := '~' + location + '::base::roxie::copystatus';
	
	shared vDateTime := (string)STD.Date.Today() + (string)STD.Date.CurrentTime(true) : independent;
	// cannot create a csv with tokens field hence removing it
	export dCopyStatus() := dataset(vCopyStatusFileNamePrefix,rFullRecord,csv,opt);
	
	// file copy status
	export fGetRoxieFileCopyStatus(
																string l_roxiedali
																,string l_esp = esp
																,string l_port = port
																,string l_targettype = targettype
																,string l_target = target
																
																,string l_roxiepathprefix = roxieabsolutepatch
															) := function
	
		dPackage := dRoxiePackage(l_esp,l_port,l_target);// : independent;
		dGetCopyStatusLocal := dCopyStatus();
				
		rCopyStatus xPendingFiles(dPackage l, dGetCopyStatusLocal r) := transform
			self := l
		end;

		dPendingFiles := join(dPackage
													,dGetCopyStatusLocal
													,left.packageid = right.packageid
														and left.superfile = right.superfile
														and left.subfile = right.subfile
														and right.pendingpartstocopy > 0
													,xPendingFiles(left,right)
													,left only
													);
		
		rCopyStatus xCompleted(dGetCopyStatusLocal l, dPackage r) := transform
			self := l
		end;

		dCompleted := join(dGetCopyStatusLocal
													,dPackage
													,left.packageid = right.packageid
														and left.superfile = right.superfile
														and left.subfile = right.subfile
														and left.pendingpartstocopy = 0
													,xCompleted(left,right)
													);
													
		rCopyStatusWithParts := record
			rCopyStatus;
      dataset(rParts - dFParts) dAllParts := dataset([],{rParts - dFParts});
		end;
		
		rCopyStatusWithParts xGetTotalFilePartFromDali(dPendingFiles l) := transform
				l_tokens := STD.Str.SplitWords(l.subfile,'::');
				filenametouse := if (l_roxiedali <> '','~foreign::'+l_roxiedali+'::','~')+l.subfile;
                wordcount := STD.Str.CountWords(l.subfile,'::');
                getlasttoken := STD.Str.GetNthWord(regexreplace('::',l.subfile,' '),wordcount);
                abspath := l_roxiepathprefix+regexreplace(getlasttoken+'$',regexreplace('::',l.subfile,'/'),'');
                self.expectedfileparts := if(STD.File.FileExists(filenametouse)
																							,(unsigned4)STD.File.GetLogicalFileAttribute(filenametouse,'numparts')
																							,0);
								self.filemask := getlasttoken;
                self.directory := abspath;
                //self.dAllParts := dGetParts;
                //self.copiedfileparts := count(dedup(dGetParts,partname));
								self.buildversion := dataset(l_tokens,{string tokens})(regexfind('^[0-9]+$',tokens)
																																				or regexfind('^[0-9]+[a-z]',tokens))[1].tokens;
								self.tokens := l_tokens;
                self := l;
		end;

		dGetTotalFilePartFromDali := project(dPendingFiles,xGetTotalFilePartFromDali(left));
		
		rCopyStatusWithParts xCopyStatus(dGetTotalFilePartFromDali l) := transform
								
                dGetParts := fGetPartsFromRoxie(l.directory,l.filemask
																								,l_esp := l_esp
																								,l_port := l_port
																								,l_target := l_target
																								,l_targettype := targettype);
                self.dAllParts := dGetParts;
                self.copiedfileparts := count(dedup(dGetParts,partname));
								
								self := l;
		end;

		dCopyStatusWithFileParts := project(dGetTotalFilePartFromDali,xCopyStatus(left));
		
		rCopyStatus xGetMissing(dCopyStatusWithFileParts l) := transform
			self.pendingpartstocopy := l.expectedfileparts - l.copiedfileparts;
			self := l;
		end;
		
		dGetMissingParts := project(dCopyStatusWithFileParts(count(dAllParts) = 0),xGetMissing(left));
		
		rCopyStatus xNormRecs(dCopyStatusWithFileParts l, rParts - dFParts r) := transform
			self.pendingpartstocopy := l.expectedfileparts - l.copiedfileparts;
      self.percentcopied := (l.copiedfileparts / l.expectedfileparts) * 100;
			self.wuid := WORKUNIT;
			self := l;
		end;

		dFinalCopyStatus := dedup(sort(normalize(dCopyStatusWithFileParts,left.dAllParts,xNormRecs(left,right)),percentcopied,packageid,superfile,subfile),percentcopied,packageid,superfile,subfile);

		return dedup(sort(dFinalCopyStatus + dCompleted,percentcopied,packageid,superfile,subfile),percentcopied,packageid,superfile,subfile);
		
	end;
	
	export fGetCopyStatusByDataset() := function
		dFullCopy := dCopyStatus();
		
		rOverAll := record
			dFullCopy.rxesp;
			dFullCopy.packageid;
			dFullCopy.buildversion;
			integer pendingpartstocopy := sum(group,dFullCopy.pendingpartstocopy);
		end;

		return sort(table(dFullCopy
	                                  ,rOverAll
									  ,rxesp
										,packageid
										,buildversion
                                      ,few),rxesp,packageid);
	end;
	
	export fUpdateCopyStatus(dataset(rInputParameters) p_inputparams
															,boolean isDespray = false
															,string desprayserver = ''
															,string despraylocation = ''
															) := function
			
			rTemp := record, maxlength(30000)
				rInputParameters;
				dataset(rCopyStatus) dCopyStatus;
			end;
			rTemp xGetCopyStatus(p_inputparams l) := transform
				self.dCopyStatus := fGetRoxieFileCopyStatus(l_roxiedali := l.rxdali
																,l_esp := l.rxesp
																,l_port := l.rxport
																,l_targettype := l.rxtargettype
																,l_target := l.rxtargetcluster
																
																,l_roxiepathprefix := l.rxpath);
																							
				self := l;
			end;
			
			dGetCopyStatus := project(p_inputparams,xGetCopyStatus(left));
			
			rFullRecord xNormalize(dGetCopyStatus l, rCopyStatus r) := transform
				self.whenlastupdated := vDateTime;
				self := l;
				self := r;
			end;
			
			dNormalize := normalize(dGetCopyStatus
															,left.dCopyStatus
															,xNormalize(left,right)
															);
			
			integer vCount := count(dNormalize);
			integer vBaskets := vCount / noofsoapcalls; // total soapcalls
			
			rFullRecord xnumbertherecords(dNormalize l,integer c) := transform
				self.recordcount := c;
				self := l;
			end;
		
			dNumberRecords := project(dNormalize,xnumbertherecords(left,counter));
		
		
			rFullRecord xIterate(dNumberRecords l, dNumberRecords r) := transform
				self.whichbasket := if (r.recordcount > (vBaskets * l.whichbasket) and r.recordcount > (l.whichbasket * noofsoapcalls),l.whichbasket + 1,l.whichbasket);
				self := r;
			end;
		
			dGroupBaskets := iterate(dNumberRecords,xIterate(left,right));
			
			return sequential(
												output(dataset([{WORKUNIT}],{string wuid}),,vCopyStatusFileNamePrefix + '_running',overwrite)
												,if (~STD.File.SuperFileExists(vCopyStatusFileNamePrefix)
													,STD.File.CreateSuperFile(vCopyStatusFileNamePrefix))
												,if (~STD.File.SuperFileExists(vCopyStatusFileNamePrefix + '_delete')
													,STD.File.CreateSuperFile(vCopyStatusFileNamePrefix + '_delete'))
												,output(dGroupBaskets,,vCopyStatusFileNamePrefix + '_' + vDateTime,csv,overwrite)
												,STD.File.ClearSuperFile(vCopyStatusFileNamePrefix + '_delete', true)
												,STD.File.AddSuperFile(vCopyStatusFileNamePrefix + '_delete',vCopyStatusFileNamePrefix,, true)
												,STD.File.ClearSuperFile(vCopyStatusFileNamePrefix)
												,STD.File.AddSuperFile(vCopyStatusFileNamePrefix,vCopyStatusFileNamePrefix + '_' + vDateTime)
												,if (isDespray
													,if (desprayserver <> '' and despraylocation <> ''
														
																,STD.File.DeSpray(vCopyStatusFileNamePrefix
																									,desprayserver
																									,despraylocation
																									,allowoverwrite := true)
																
															,fail(9999,'Despray server or Despray location is empty but isDespray is set to true. Either set isDespray to false or pass despray server and location. Not re-scheduling')
															)
														,output('No Despray')
													)
													,STD.File.DeleteLogicalFile(vCopyStatusFileNamePrefix + '_running')	
												);
	end;
	
	export fUpdateCopyStatusinDOPSDB(dataset(rFullRecord) dGetStatus) := function
		//dGetStatus := dCopyStatus();
		
		rDBLayout xDeriveClusterFromPackageName(dGetStatus l) := transform
			pkgname := STD.Str.SplitWords(l.packagename,'::')[2];
			self.datasetname := l.packageid;
			self.superkeyname := l.superfile;
			self.buildversion := l.buildversion;
			self.locationflag := dops.constants.location;
			self.copiedparts := l.copiedfileparts;
			self.expectedparts := l.expectedfileparts;
			self.clustername := if (pkgname <> '',STD.Str.SplitWords(pkgname,'_')[2],'');
			self.statuscode := '';
			self.statusdescription := '';
			self := l;
		end;
		
		dDeriveClusterFromPackageName := project(dGetStatus,xDeriveClusterFromPackageName(left));
		
		rDBList := record, maxlength(50000)
			dataset(rDBLayout) DBList{xpath('copystatus')};
		end;
		
		rDBList xDBList(dDeriveClusterFromPackageName L) := transform
			self.DBList   := DATASET([{ trim(l.datasetname,left,right)
													,trim(l.superkeyname,left,right)
													,trim(l.buildversion,left,right)
													, trim(l.locationflag,left,right)
													, trim(l.clustername,left,right)
													, l.copiedparts
													, l.expectedparts
													, l.pendingpartstocopy
													, l.percentcopied
													,''
													,''}]
													, rDBLayout);
			self := L;
		end;

		dDBList := project(dDeriveClusterFromPackageName, xDBList(left));

		rDBInfoRequest := record, maxlength(50000)
			dataset(rDBList) ulist{xpath('ulist')} := dDBList;
			
		end;
		
		rSOAPResponse := SOAPCALL(
				
				dops.constants.prboca.serviceurl(dopsenv,environment := dopsclusterflag),
				////////////////////////////////////////////////////
				// to check the soap xml use local machine IP and run soapplus -s -p 4546
				// 'http://10.176.152.60:4546/',
				//'http://10.176.152.26:4546/',
				////////////////////////////////////////////////////
				'UpdateCopyStatus',
				rDBInfoRequest,
				dataset(rDBList),
				xpath('UpdateCopyStatusResponse/UpdateCopyStatusResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/UpdateCopyStatus'));
		
		rGetKey := record
			string l_location;
			dataset(rDBLayout) ulist;
		end;
		
		rGetKey xGetKey(rSOAPResponse l) := transform
			self.ulist := l.DBList;
			self.l_location := location;
			//self := l;
			//self.l_buildversion := l_buildversion;
		end;
		
		dGetKey := project(rSOAPResponse,xGetKey(left));
		
		rDBLayout xNormRecs(dGetKey l,rDBLayout r) := transform
			self := r;
		end;
		
		dNormRecs := normalize(dGetKey, left.ulist, xNormRecs(left,right));
		
		return if (count(dGetStatus) > 0, dNormRecs, dataset([],rDBLayout));
	end;
	
	export fMakeSoapcallstoUpdateDOPSDB(string pThorESP = _Control.IPAddress.Prod_thor_ESP
																,string pThorPort = '8010'
																,string receiveemail = ''
																,string senderemail = '') := function
		dGetStatus := dCopyStatus();
		
		dBaskets := dedup(dGetStatus,whichbasket);

		rRespStatus := record
			integer whichbasket;
			//integer flagforemail := 0;
			dataset(rDBLayout) rstatus;
		end;
		
		rRespStatus xMakeSoapCalls(dBaskets l) := transform
			
			self.rstatus := fUpdateCopyStatusinDOPSDB(dGetStatus(whichbasket = l.whichbasket));
			self := l;
		end;
		
		dSoapResponse := project(dBaskets,xMakeSoapCalls(left));
		
		rWithBasket := record
			integer whichbasket;
			//integer flagforemail := 0;
			rDBLayout;
		end;
		
		rWithBasket xNormalize(dSoapResponse l, rDBLayout r) := transform
			self := r;
			self := l;
		end;
		
		dNorm := normalize(dSoapResponse,left.rstatus,xNormalize(left,right));
		
		dSoapResults := dataset(vCopyStatusFileNamePrefix +'_soapcalls',rWithBasket,thor,opt);
		
		return sequential(
									output(dNorm,,vCopyStatusFileNamePrefix +'_soapcalls',overwrite),
									if(count(dSoapResults(statuscode = '-1')) > 0,
										STD.System.Email.SendEmail
																				(
																					receiveemail
																					,'[RPT]: ' + STD.Str.ToUpperCase(location) + ' CERT COPY STATUS SOAPCALL ERRORS'
																					,'ESP:' + pThorESP
																								+ '; Workunit: ' 
																								+ WORKUNIT 
																								+ '; '
																								+ '\r\n' 
																								+ 'Check ' + vCopyStatusFileNamePrefix +'_soapcalls in WU for soapcall errors'
																					,
																					,
																					,senderemail
																				),
										output('No Soap failures')
											)
									);
	end;
	
	export runCopyStatusUpdate(dataset(rInputParameters) dEnvironments
																,boolean isDespray
																,string desprayserver
																,string despraylocation
																,string pThorESP = 'prod_esp.br.seisint.com'
																,string pThorPort = '8010'
																,string receiveemail = ''
																,string senderemail = ''
																) := if (regexfind('hthor',STD.System.Job.Target())
																				,if (~STD.File.FileExists(vCopyStatusFileNamePrefix + '_running')	
																						,sequential(fUpdateCopyStatus(dEnvironments
																													,isDespray
																													,desprayserver
																													,despraylocation)
																												,fMakeSoapcallstoUpdateDOPSDB(pThorESP
																																										,pThorPort
																																										,receiveemail
																																										,senderemail)
																												)
																						,output('Another job running or ' + vCopyStatusFileNamePrefix + '_running was not deleted after completion or failure')
																					 )
																				,fail(9999,'Run on *hthor* cluster, not re-scheduling')
																		) : failure (
																		sequential(
																		STD.File.DeleteLogicalFile(vCopyStatusFileNamePrefix + '_running')	
																		,STD.System.Email.SendEmail
																				(
																					receiveemail
																					,'[RPT]: ' + STD.Str.ToUpperCase(location) + ' CERT COPY STATUS FAILED'
																					,'ESP:' + pThorESP
																								+ '; Workunit: ' 
																								+ WORKUNIT 
																								+ '; '
																								+ '\r\n' 
																								+ 'ERROR: ' + failmessage + '. Re-scheduled job automatically.'
																					,
																					,
																					,senderemail
																				)
																		
																		,if (failcode <> 9999
																				,output(dops.WorkUnitModule(pThorESP,pThorPort).fSubmitNewWorkunit(
																						dops.WorkUnitModule(pThorESP,pThorPort).GetWUInfo(WORKUNIT)[1].ecltext
																						,STD.System.Job.Target()))
																				,output('not spawning')
																				)
																		));
	
end;