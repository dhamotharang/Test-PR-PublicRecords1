import _Control,STD,wk_ut,ut;

EXPORT WorkUnitModule(string esp
									,string port = '8010') := module
									
	shared l_esp := if (~regexfind('http://',esp),'http://'+esp, esp);
	
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

			dWUCreateAndUpdateResult	:=	soapcall(l_esp + ':' + port + '/WsWorkunits',
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

			dWUSubmitResult	:=	soapcall(l_esp + ':' + port + '/WsWorkunits',//http://10.193.211.1:8010/WsWorkunits/',
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
	
		dSOAPResult := SOAPCALL(l_esp+':'+port+'/WsWorkunits', 'WUInfo', 
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
	
		return dWUFilesUsedFlat;
	end;
	
	export GetWUInfo(string wid) := function
		
		rWUInfoRequest := record
			string Name{xpath('Wuid')} := wid;
		end;
	
		rWUInfoResponse := record,maxlength(300000)
			string20 Wuid{xpath('Wuid')};
			string ecltext {XPATH('Query/Text')} := '';
			//dataset(resultnames) resultfiles{xpath('Results/ECLResult')};
		end;
	
		dWUInfoResponse := SOAPCALL(l_esp+':'+port+'/WsWorkunits', 'WUInfo', 
											rWUInfoRequest, dataset(rWUInfoResponse),
											xpath('WUInfoResponse/Workunit')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );

		
		return dWUInfoResponse;
	end;
	
	export GetWUErrors(string wuid
										,boolean getOnlyErrors = false) := function
	
		
		
		rWUInfoRequest := record
			string Name{xpath('Wuid')} := wuid;
		end;

	
		rMessages := record, maxlength(30000)
			string Severity {XPATH('Severity')} := '';
			string message {XPATH('Message')} := '';
		end;

		rErrors := record
			string wuid;
			rMessages;
			
		end;
	
		rFileNames := record
			string100 name {XPATH('FileName')} := '';
		end;

	
		rWUInfoResponse := record,maxlength(300000)
			string20 Wuid{xpath('Wuid')};
			dataset(rMessages) errormessages{xpath('Exceptions/ECLException')};
			//dataset(resultnames) resultfiles{xpath('Results/ECLResult')};
		end;
	
		dWUInfoResponse := SOAPCALL(l_esp + ':' + port + '/WsWorkunits'
											,'WUInfo' 
											,rWUInfoRequest
											,dataset(rWUInfoResponse)
											,xpath('WUInfoResponse/Workunit')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );
										 
		rErrors xErrors(dWUInfoResponse l, rMessages r) := transform
			self.wuid := wuid;
			self := r;
		end;
		
		dErrors := normalize(dWUInfoResponse, left.errormessages,xErrors(left,right));
										 
		return if (getOnlyErrors, dErrors(regexfind('error',Severity,nocase)), dErrors);
		
	end;
	
	export GetWUDetails(string wuid = WORKUNIT) := function
		
		rWUInfoRequest := record
			string Name{xpath('Wuid')} := wuid;
		end;

		rSubFiles := record
			string Name {XPATH('Name')} := '';
			string FileCluster {XPATH('FileCluster')} := '';
			boolean IsSuperFile {XPATH('IsSuperFile')} := false;
			string Count {XPATH('Count')} := '0';
			
		end;
		
		rInputFiles := record
			string Name {XPATH('Name')} := '';
			string FileCluster {XPATH('FileCluster')} := '';
			boolean IsSuperFile {XPATH('IsSuperFile')} := false;
			string Count {XPATH('Count')} := '0';
			dataset(rSubFiles) subfiles{xpath('ECLSourceFiles/ECLSourceFile')};
		end;
		
		rECLHelpFiles := record
			string name {XPATH('Name')} := '';
			string IPAddress {XPATH('IPAddress')} := '';
			string FileSize {XPATH('FileSize')} := '';
			
		end;
		
		rExceptions := record
			string Source {XPATH('Source')} := '';
			string Severity {XPATH('Severity')} := '';
			string Message {XPATH('Message')} := '';
			string FileName {XPATH('FileName')} := '';
		end;
		
		rGraphs := record
			string Name {XPATH('Name')} := '';
			string Label {XPATH('Label')} := '';
			string Complete {XPATH('Complete')} := '';
		end;
		
		rTimers := record
			string Name {XPATH('Name')} := '';
			string Value {XPATH('Value')} := '';
			string count {XPATH('count')} := '';
			string Timestamp {XPATH('Timestamp')} := '';
			string When {XPATH('When')} := '';
		end;
		
		rApplicationValues := record
			string Application {XPATH('Application')} := '';
			string Name {XPATH('Name')} := '';
			string Value {XPATH('Value')} := '';
			
		end;
		
		rOutputFiles := record
			string Name {XPATH('Name')} := '';
			string FileName {XPATH('FileName')} := '';
			string Value {XPATH('Value')} := '';
		end;

		rWUInfoResponse := record,maxlength(300000)
			string Wuid{xpath('Wuid')};
			string Owner{xpath('Owner')};
			string Cluster{xpath('Cluster')};
			string Jobname{xpath('Jobname')};
			string StateID{xpath('StateID')};
			string State{xpath('State')};
			string Scope{xpath('Scope')};
			string TotalClusterTime{xpath('TotalClusterTime')};
			string ErrorCount{xpath('ErrorCount')};
			string WarningCount{xpath('WarningCount')};
			string InfoCount{xpath('InfoCount')};
			string AlertCount{xpath('AlertCount')};
			string GraphCount{xpath('GraphCount')};
			string SourceFileCount{xpath('SourceFileCount')};
			string ResultCount{xpath('ResultCount')};
			string VariableCount{xpath('VariableCount')};
			string TimerCount{xpath('TimerCount')};
			string ApplicationValueCount{xpath('ApplicationValueCount')};
			string ResultViewCount{xpath('ResultViewCount')};
			string HelpersCount{xpath('HelpersCount')};
			dataset(rInputFiles) infiles{xpath('SourceFiles/ECLSourceFile')};
			dataset(rECLHelpFiles) helpfiles{xpath('Helpers/ECLHelpFile')};
			dataset(rOutputFiles) outfiles{xpath('Results/ECLResult')};
			dataset(rExceptions) exceptions{xpath('Exceptions/ECLException')};
			dataset(rGraphs) graphs{xpath('Graphs/ECLGraph')};
			dataset(rTimers) timers{xpath('Timers/ECLTimer')};
			dataset(rApplicationValues) appvalues{xpath('ApplicationValues/ApplicationValue')};
		end;
	
		dWUInfoResponse := SOAPCALL(l_esp+':'+port+'/WsWorkunits?ver_=1.75'
													,'WUInfo' 
													,rWUInfoRequest
													,dataset(rWUInfoResponse)
													,xpath('WUInfoResponse/Workunit')
													,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 ) : independent;
										 
		rWUDetailsWithDatasets := record
			string Wuid := '';
			string Owner := '';
			string Cluster := '';
			string Jobname := '';
			string StateID := '';
			string State := '';
			string Scope := '';
			string TotalClusterTime := '';
			string ErrorCount := '';
			string WarningCount := '';
			string InfoCount := '';
			string AlertCount := '';
			string GraphCount := '';
			string SourceFileCount := '';
			string ResultCount := '';
			string VariableCount := '';
			string TimerCount := '';
			string ApplicationValueCount := '';
			string ResultViewCount := '';
			string HelpersCount := '';
			// input
			string InputName := '';
			string FileCluster := '';
			boolean IsSuperFile := false;
			string Count := '';
			string subInputName := '';
			string subFileCluster := '';
			boolean subIsSuperFile := false;
			string subCount := '';
			unsigned8 logicalfilesize := 0;
			unsigned8 compressedSize := 0;
			// helper
			string helperName := '';
			string helperIPAddress := '';
			string helperFileSize := '';
			// outfiles
			string outputName := '';
			string outputFileName := '';
			string outputValue := '';
			// exceptions
			string exceptionSource := '';
			string exceptionSeverity := '';
			string exceptionMessage := '';
			string exceptionFileName := '';
			// graphs
			string graphName := '';
			string graphLabel := '';
			string graphComplete := '';
			// timers
			string timerName := '';
			string timerValue := '';
			string timerscount := '';
			string timerTimestamp := '';
			string timerWhen := '';
			// appvalues
			string Application := '';
			string appName := '';
			string appValue := '';
			dataset(rInputFiles) infiles;
			dataset(rECLHelpFiles) helpfiles;
			dataset(rOutputFiles) outfiles;
			dataset(rExceptions) exceptions;
			dataset(rGraphs) graphs;
			dataset(rTimers) timers;
			dataset(rApplicationValues) appvalues;
			dataset(rSubFiles) subfiles;
		end;
		
		rWUDetails := record
			rWUDetailsWithDatasets - [infiles, helpfiles, outfiles, exceptions, graphs, timers, appvalues, subfiles];
		end;
		
		rWUDetailsWithDatasets xGetInputFiles(dWUInfoResponse l, rInputFiles r) := transform
			isFileExists := if (~r.IsSuperFile and r.Name <> ''
																	,if (STD.File.FileExists('~'+r.Name)
																			,true
																			,false)
													,false);
			self.InputName := r.Name;
			self.FileCluster := r.FileCluster;
			self.IsSuperFile := r.IsSuperFile;
			self.Count := r.Count;
			self.subfiles := r.subfiles;
			self.logicalfilesize := (unsigned8)if (isFileExists
																			,STD.File.GetLogicalFileAttribute('~'+r.Name,'size')
																			,'0');
			self.compressedSize := (unsigned8)if (isFileExists
																			,STD.File.GetLogicalFileAttribute('~'+r.Name,'compressedSize')
																			,'0');
			self := l;
		end;
		
		dInputFiles := normalize(dWUInfoResponse,left.infiles,xGetInputFiles(left,right));
		
		rWUDetails xGetSubFiles(dInputFiles l, rSubFiles r) := transform
			isFileExists := if (~r.IsSuperFile and r.Name <> ''
																	,if (STD.File.FileExists('~'+r.Name)
																			,true
																			,false)
													,false);
			self.subInputName := r.Name;
			self.subFileCluster := r.FileCluster;
			self.subIsSuperFile := r.IsSuperFile;
			self.subCount := r.Count;
			self.logicalfilesize := (unsigned8)if (isFileExists
																			,STD.File.GetLogicalFileAttribute('~'+r.Name,'size')
																			,'0');
			self.compressedSize := (unsigned8)if (isFileExists
																			,STD.File.GetLogicalFileAttribute('~'+r.Name,'compressedSize')
																			,'0');
			self := l;
		end;
		
		dSubFiles := normalize(dInputFiles,left.subfiles,xGetSubFiles(left,right)) : independent;
		
		rWUDetails xGetHelpFiles(dWUInfoResponse l, rECLHelpFiles r) := transform
			self.helperName := r.name;
			self.helperIPAddress := r.IPAddress;
			self.helperFileSize := r.FileSize;
			
			self := l;
		end;
		
		dHelpFiles := normalize(dWUInfoResponse,left.helpfiles,xGetHelpFiles(left,right));
		
		rWUDetails xGetOutFiles(dWUInfoResponse l, rOutputFiles r) := transform
			isFileExists := if (r.FileName <> ''
																	,if (STD.File.FileExists('~'+r.FileName)
																			,true
																			,false)
													,false);
			self.outputName := r.Name;
			self.outputFileName := r.FileName;
			self.outputValue := r.Value;
			self.logicalfilesize := (unsigned8)if (isFileExists
																			,STD.File.GetLogicalFileAttribute('~'+r.FileName,'size')
																			,'0');
			self.compressedSize := (unsigned8)if (isFileExists
																			,STD.File.GetLogicalFileAttribute('~'+r.FileName,'compressedSize')
																			,'0');
			self := l;
		end;
		
		dOutFiles := normalize(dWUInfoResponse,left.outfiles,xGetOutFiles(left,right)) : independent;
		
		rWUDetails xGetExFiles(dWUInfoResponse l, rExceptions r) := transform
			self.exceptionSource := r.Source;
			self.exceptionSeverity := r.Severity;
			self.exceptionMessage := r.Message;
			self.exceptionFileName := r.FileName;
			self := l;
		end;
		
		dExFiles := normalize(dWUInfoResponse,left.exceptions,xGetExFiles(left,right));
		
		rWUDetails xGetGraphs(dWUInfoResponse l, rGraphs r) := transform
			self.graphName := r.Name;
			self.graphLabel := r.Label;
			self.graphComplete := r.Complete;
			self := l;
		end;
		
		dGraphs := normalize(dWUInfoResponse,left.graphs,xGetGraphs(left,right));
		
		rWUDetails xGetTimers(dWUInfoResponse l, rTimers r) := transform
			self.timerName := r.Name;
			self.timerValue := r.Value;
			self.timerscount := r.count;
			self.timerTimestamp := r.Timestamp;
			self.timerWhen := r.When;
			self := l;
		end;
		
		dTimers := normalize(dWUInfoResponse,left.timers,xGetTimers(left,right));
		
		rWUDetails xGetAppValues(dWUInfoResponse l, rApplicationValues r) := transform
			self.Application := r.Application;
			self.appName := r.Name;
			self.appValue := r.Value;
			self := l;
		end;
		
		dAppValues := normalize(dWUInfoResponse,left.appvalues,xGetAppValues(left,right));
		
		
		return sequential
									(
										output(choosen(dSubFiles,all),named('inputfiles_read'))
										,output(choosen(dOutFiles(outputfilename <> ''),all),named('outputfiles_written'))
										,output(choosen(dHelpFiles,all),named('helpers'))
										,output(choosen(dExFiles,all),named('Exceptions'))
										,output(choosen(dGraphs,all),named('graphs'))
										,output(choosen(dTimers,all),named('timers'))
										,output(choosen(dAppValues,all),named('applicationvalues'))
										,output(count(dSubFiles),named('total_inputfiles_used'))
										,output(sum(dSubFiles,logicalfilesize),named('total_actual_inputfilesize'))
										,output(sum(dSubFiles,compressedSize),named('total_compressed_inputfilesize'))
										,output(count(dOutFiles(outputfilename <> '')),named('total_outputfiles_created'))
										,output(sum(dOutFiles,logicalfilesize),named('total_actual_outputfilesize'))
										,output(sum(dOutFiles,compressedSize),named('total_compressed_outputfilesize'))
										,output(count(dExFiles(exceptionsource = 'fileservices')),named('total_dali_access_fileservices'))
										,output(count(dAppValues(regexfind('spray',application,nocase)
																																and ~regexfind('despray',application,nocase))),named('total_spray'))
										,output(count(dAppValues(regexfind('despray',application,nocase))),named('total_despray'))
									);
	end;
	
end;