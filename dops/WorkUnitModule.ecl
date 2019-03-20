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
	
		dWUInfoResponse := SOAPCALL('http://'+lTargetESPAddress+':'+lTargetESPPort+'/WsWorkunits', 'WUInfo', 
											rWUInfoRequest, dataset(rWUInfoResponse),
											xpath('WUInfoResponse/Workunit')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );

		
		return dWUInfoResponse;
	end;
	
end;