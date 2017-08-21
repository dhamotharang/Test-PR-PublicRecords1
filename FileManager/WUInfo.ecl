import _control;

export WUInfo(string pWUID)
 :=
  module

	shared	lSoapVersion	:=	'ver_=1.12';

	shared	rWUInfo_Input
	 :=
	  record,maxlength(256)
		string WUID{xpath('Wuid')}	:=	pWUID;
		string Type{xpath('Type')}	:= 	'';
	  end
	 ;

	export	rExceptions
	 :=
	  record,maxlength(1024)
		string		Code{xpath('Code')};							//	<Code>String</Code> 
		string		Audience{xpath('Audience')};					//	<Audience>String</Audience> 
		string		Source{xpath('Source')};						//	<Source>String</Source> 
		string		Message{xpath('Message')};						//	<Message>String</Message> 
	  end
	 ;

	export	rECLExceptions
	 :=
	  record,maxlength(2048)
		string		Code{xpath('Code')};							//	<Code>0</Code> 
		string		Source{xpath('Source')};
		string		Message{xpath('Message')};
		string		Severity{xpath('Severity')};
		string		FileName{xpath('FileName')};
		unsigned4	LineNo{xpath('LineNo')};						//	<LineNo>0</LineNo>
		unsigned4	Column{xpath('Column')};						//	<Column>0</Column> 
	  end
	 ;

	export	rWUInfo_Workunit
	 :=
	  record,maxlength(16384)
		string		Wuid{xpath('Wuid')};
		string		Owner{xpath('Owner')};
		string		Cluster{xpath('Cluster')};
		string		RoxieCluster{xpath('RoxieCluster')};
		string		JobName{xpath('Jobname')};
		string		Queue{xpath('Queue')};
		string		StateID{xpath('StateID')};						//	<StateID>0</StateID> 
		string		State{xpath('State')};
		string		StateEx{xpath('StateEx')};
		string		Description{xpath('Description')};
		boolean		AddDrilldownFields{xpath('AddDrilldownFields')};//	<AddDrilldownFields>false</AddDrilldownFields>
		boolean		Protected{xpath('Protected')};					//	<Protected>false</Protected>
		boolean		Active{xpath('Active')};						//	<Active>false</Active>
		string		Action{xpath('Action')};						//	<Action>0</Action>	
		string		DateTimeScheduled{xpath('DateTimeScheduled')};	//	<DateTimeScheduled>dateTime value</DateTimeScheduled>
		string		PriorityClass{xpath('PriorityClass')};			//	<PriorityClass>0</PriorityClass>
		string		PriorityLevel{xpath('PriorityLevel')};			//	<PriorityLevel>0</PriorityLevel>
		string		Scope{xpath('Scope')};
		string		Snapshot{xpath('Snapshot')};
		string		ResultLimit{xpath('ResultLimit')};				//	<ResultLimit>0</ResultLimit>
		boolean		Archived{xpath('Archived')};					//	<Archived>false</Archived>
		string		EventSchedule{xpath('EventSchedule')};			//	<EventSchedule>0</EventSchedule> 
		boolean		HaveSubGraphTimings{xpath('HaveSubGraphTimings')};	//	<HaveSubGraphTimings>false</HaveSubGraphTimings>
	  end
	 ;

	export	rWUInfo_SourceFile
	 :=
	  record,maxlength(1024)
		string		FileCluster{xpath('FileCluster')};
		string		Name{xpath('Name')};
		boolean		IsSuperFile{xpath('IsSuperFile')};
		unsigned4	UseCount{xpath('Count')};
	  end
	 ;

	export	rWUInfo_OutputFile
	 :=
	  record,maxlength(1024)
		// string		Name{xpath('Name')};
		string		Sequence{xpath('Sequence')};
		// string		Value{xpath('Value')};
		// string		Link{xpath('Link')};
		string		FileName{xpath('FileName')};
		// string		IsSupplied{xpath('IsSupplied')};
		// string		ShowFileContent{xpath('ShowFileContent')};
		unsigned8	Total{xpath('Total')};
	  end
	 ;

	shared	rWUInfo_Response
	 :=
	  record,maxlength(65536)
		dataset(rExceptions)						Exceptions{xpath('Exceptions/Exception')};
		rWUInfo_Workunit							FileDetail{xpath('Workunit')};
	  end
	 ;

	shared	lWUInfoSingleResult
			 :=
			  soapcall('http://' + _control.ThisEnvironment.ESP_IPAddress + ':8010/WsWorkunits?' + lSOAPVersion,
					   'WUInfo',
					   rWUInfo_Input,
					   rWUInfo_Workunit,
					   xpath('WUInfoResponse/Workunit')
					  );

	export	string	fJobName
	 :=
	  function
		return	lWUInfoSingleresult.JobName;
	  end
	 ;

	export	string	fOwner
	 :=
	  function
		return	lWUInfoSingleresult.Owner;
	  end
	 ;

	shared	lWUInfoSourceFiles
			 :=
			  soapcall('http://' + _control.ThisEnvironment.ESP_IPAddress + ':8010/WsWorkunits?' + lSOAPVersion,
					   'WUInfo',
					   rWUInfo_Input,
					   dataset(rWUInfo_SourceFile),
					   xpath('WUInfoResponse/Workunit/SourceFiles/ECLSourceFile')
					  );

	export	dataset(rWUInfo_SourceFile)	fSourceFiles
	 :=
	  function
		return	lWUInfoSourceFiles;
	  end
	 ;

	shared	lWUInfoOutputFiles
			 :=
			  soapcall('http://' + _control.ThisEnvironment.ESP_IPAddress + ':8010/WsWorkunits?' + lSOAPVersion,
					   'WUInfo',
					   rWUInfo_Input,
					   dataset(rWUInfo_OutputFile),
					   xpath('WUInfoResponse/Workunit/Results/ECLResult')
					  );

	export	dataset(rWUInfo_OutputFile)	fOutputFiles
	 :=
	  function
		return	lWUInfoOutputFiles(FileName<>'');
	  end
	 ;

	shared	lWUInfoECLExceptions
			 :=
			  soapcall('http://' + _control.ThisEnvironment.ESP_IPAddress + ':8010/WsWorkunits?' + lSOAPVersion,
					   'WUInfo',
					   rWUInfo_Input,
					   dataset(rECLExceptions),
					   xpath('WUInfoResponse/Workunit/Exceptions/ECLException')
					  );

	export	dataset(rECLExceptions)	fECLExceptions
	 :=
	  function
		return	lWUInfoECLExceptions;
	  end
	 ;
	  
	export	rWUInfo_Workunit	fWUInfo
	 :=
	  function
		return	lWUInfoSingleResult;
	  end
	 ;

  end
 ;

/*
- <WUInfoResponse>
- <Workunit>
- <Query>
  <Text>String</Text> 
  <Cpp>String</Cpp> 
  <ResTxt>String</ResTxt> 
  <Dll>String</Dll> 
  <ThorLog>String</ThorLog> 
  </Query>
- <Helpers>
- <ECLHelpFile>
  <Name>String</Name> 
  <Type>String</Type> 
  </ECLHelpFile>
- <ECLHelpFile>
  <Name>String</Name> 
  <Type>String</Type> 
  </ECLHelpFile>
  </Helpers>
- <Exceptions>
- <ECLException>
  <Source>String</Source> 
  <Severity>String</Severity> 
  <Code>0</Code> 
  <Message>String</Message> 
  <FileName>String</FileName> 
  <LineNo>0</LineNo> 
  <Column>0</Column> 
  </ECLException>
- <ECLException>
  <Source>String</Source> 
  <Severity>String</Severity> 
  <Code>0</Code> 
  <Message>String</Message> 
  <FileName>String</FileName> 
  <LineNo>0</LineNo> 
  <Column>0</Column> 
  </ECLException>
  </Exceptions>
- <Graphs>
- <ECLGraph>
  <Name>String</Name> 
  <Label>String</Label> 
  <Type>String</Type> 
  <Running>false</Running> 
  <Complete>false</Complete> 
  <RunningId>2147483647</RunningId> 
  </ECLGraph>
- <ECLGraph>
  <Name>String</Name> 
  <Label>String</Label> 
  <Type>String</Type> 
  <Running>false</Running> 
  <Complete>false</Complete> 
  <RunningId>2147483647</RunningId> 
  </ECLGraph>
  </Graphs>
- <SourceFiles>
- <ECLSourceFile>
  <FileCluster>String</FileCluster> 
  <Name>String</Name> 
  <IsSuperFile>false</IsSuperFile> 
  <Count>0</Count> 
  </ECLSourceFile>
- <ECLSourceFile>
  <FileCluster>String</FileCluster> 
  <Name>String</Name> 
  <IsSuperFile>false</IsSuperFile> 
  <Count>0</Count> 
  </ECLSourceFile>
  </SourceFiles>
- <Results>
- <ECLResult>
  <Name>String</Name> 
  <Sequence>0</Sequence> 
  <Value>String</Value> 
  <Link>String</Link> 
  <FileName>String</FileName> 
  <IsSupplied>false</IsSupplied> 
  <ShowFileContent>true</ShowFileContent> 
  <Total>2147483647</Total> 
- <ECLSchemas>
- <ECLSchemaItem>
  <ColumnName>String</ColumnName> 
  <ColumnType>String</ColumnType> 
  <ColumnTypeCode>0</ColumnTypeCode> 
  <isConditional>false</isConditional> 
  </ECLSchemaItem>
- <ECLSchemaItem>
  <ColumnName>String</ColumnName> 
  <ColumnType>String</ColumnType> 
  <ColumnTypeCode>0</ColumnTypeCode> 
  <isConditional>false</isConditional> 
  </ECLSchemaItem>
  </ECLSchemas>
  </ECLResult>
- <ECLResult>
  <Name>String</Name> 
  <Sequence>0</Sequence> 
  <Value>String</Value> 
  <Link>String</Link> 
  <FileName>String</FileName> 
  <IsSupplied>false</IsSupplied> 
  <ShowFileContent>true</ShowFileContent> 
  <Total>2147483647</Total> 
- <ECLSchemas>
- <ECLSchemaItem>
  <ColumnName>String</ColumnName> 
  <ColumnType>String</ColumnType> 
  <ColumnTypeCode>0</ColumnTypeCode> 
  <isConditional>false</isConditional> 
  </ECLSchemaItem>
- <ECLSchemaItem>
  <ColumnName>String</ColumnName> 
  <ColumnType>String</ColumnType> 
  <ColumnTypeCode>0</ColumnTypeCode> 
  <isConditional>false</isConditional> 
  </ECLSchemaItem>
  </ECLSchemas>
  </ECLResult>
  </Results>
- <Variables>
- <ECLResult>
  <Name>String</Name> 
  <Sequence>0</Sequence> 
  <Value>String</Value> 
  <Link>String</Link> 
  <FileName>String</FileName> 
  <IsSupplied>false</IsSupplied> 
  <ShowFileContent>true</ShowFileContent> 
  <Total>2147483647</Total> 
- <ECLSchemas>
- <ECLSchemaItem>
  <ColumnName>String</ColumnName> 
  <ColumnType>String</ColumnType> 
  <ColumnTypeCode>0</ColumnTypeCode> 
  <isConditional>false</isConditional> 
  </ECLSchemaItem>
- <ECLSchemaItem>
  <ColumnName>String</ColumnName> 
  <ColumnType>String</ColumnType> 
  <ColumnTypeCode>0</ColumnTypeCode> 
  <isConditional>false</isConditional> 
  </ECLSchemaItem>
  </ECLSchemas>
  </ECLResult>
- <ECLResult>
  <Name>String</Name> 
  <Sequence>0</Sequence> 
  <Value>String</Value> 
  <Link>String</Link> 
  <FileName>String</FileName> 
  <IsSupplied>false</IsSupplied> 
  <ShowFileContent>true</ShowFileContent> 
  <Total>2147483647</Total> 
- <ECLSchemas>
- <ECLSchemaItem>
  <ColumnName>String</ColumnName> 
  <ColumnType>String</ColumnType> 
  <ColumnTypeCode>0</ColumnTypeCode> 
  <isConditional>false</isConditional> 
  </ECLSchemaItem>
- <ECLSchemaItem>
  <ColumnName>String</ColumnName> 
  <ColumnType>String</ColumnType> 
  <ColumnTypeCode>0</ColumnTypeCode> 
  <isConditional>false</isConditional> 
  </ECLSchemaItem>
  </ECLSchemas>
  </ECLResult>
  </Variables>
- <Timers>
- <ECLTimer>
  <Name>String</Name> 
  <Value>String</Value> 
  <count>0</count> 
  </ECLTimer>
- <ECLTimer>
  <Name>String</Name> 
  <Value>String</Value> 
  <count>0</count> 
  </ECLTimer>
  </Timers>
- <DebugValues>
- <DebugValue>
  <Name>String</Name> 
  <Value>String</Value> 
  </DebugValue>
- <DebugValue>
  <Name>String</Name> 
  <Value>String</Value> 
  </DebugValue>
  </DebugValues>
- <ApplicationValues>
- <ApplicationValue>
  <Application>String</Application> 
  <Name>String</Name> 
  <Value>String</Value> 
  </ApplicationValue>
- <ApplicationValue>
  <Application>String</Application> 
  <Name>String</Name> 
  <Value>String</Value> 
  </ApplicationValue>
  </ApplicationValues>
- <Workflows>
- <ECLWorkflow>
  <WFID>String</WFID> 
  <EventName /> 
  <EventText /> 
  <Count>-1</Count> 
  <CountRemaining>-1</CountRemaining> 
  </ECLWorkflow>
- <ECLWorkflow>
  <WFID>String</WFID> 
  <EventName /> 
  <EventText /> 
  <Count>-1</Count> 
  <CountRemaining>-1</CountRemaining> 
  </ECLWorkflow>
  </Workflows>
- <TimingData>
- <ECLTimingData>
  <Name>String</Name> 
  <GraphNum>0</GraphNum> 
  <SubGraphNum>0</SubGraphNum> 
  <GID>0</GID> 
  <Min>0</Min> 
  <MS>0</MS> 
  </ECLTimingData>
- <ECLTimingData>
  <Name>String</Name> 
  <GraphNum>0</GraphNum> 
  <SubGraphNum>0</SubGraphNum> 
  <GID>0</GID> 
  <Min>0</Min> 
  <MS>0</MS> 
  </ECLTimingData>
  </TimingData>
- <AllowedClusters>
  <AllowedCluster>String</AllowedCluster> 
  <AllowedCluster>String</AllowedCluster> 
  </AllowedClusters>
  </Workunit>
  <AutoRefresh>0</AutoRefresh> 
  <CanCompile>false</CanCompile> 
  </WUInfoResponse>
*/