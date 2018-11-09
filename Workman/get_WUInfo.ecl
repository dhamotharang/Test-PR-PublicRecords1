import _control,std;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_WUInfo(string pWorkunitID = '',string pesp = _Config.LocalEsp) :=
module
	export wuinfoInRecord :=
	record, maxlength(100)
		string  eclWorkunit              {xpath('Wuid'                     )} := pWorkunitID;
		boolean IncludeExceptions        {xpath('IncludeExceptions'        )} := true;
		boolean IncludeGraphs            {xpath('IncludeGraphs'            )} := true;
		boolean IncludeSourceFiles       {xpath('IncludeSourceFiles'       )} := true;
		boolean IncludeResults           {xpath('IncludeResults'           )} := true;
		boolean IncludeVariables         {xpath('IncludeVariables'         )} := true;
		boolean IncludeTimers            {xpath('IncludeTimers'            )} := true;
		boolean IncludeDebugValues       {xpath('IncludeDebugValues'       )} := true;
		boolean IncludeApplicationValues {xpath('IncludeApplicationValues' )} := true;
		boolean IncludeWorkflows         {xpath('IncludeWorkflows'         )} := true;
		boolean SuppressResultSchemas    {xpath('SuppressResultSchemas'    )} := false;
	end;
//javascript:go('/WsWorkunits/WUInfo?Wuid=W20130625-122746&&IncludeExceptions=0&IncludeGraphs=0&IncludeSourceFiles=0&IncludeResults=0&IncludeVariables=0&IncludeTimers=0&IncludeDebugValues=0&IncludeApplicationValues=0&IncludeWorkflows&SuppressResultSchemas=1')
/* not sure how it works in eclwatch with these parameters.  here when I make them false(0), i don't get anything back.
IncludeExceptions           =0
IncludeGraphs               =0
IncludeSourceFiles         =0
IncludeResults             =0
IncludeVariables           =0
IncludeTimers              =0
IncludeDebugValues         =0
IncludeApplicationValues   =0
IncludeWorkflows
SuppressResultSchemas      =1
*/
	
	export eclResultLayout :=
	record, maxlength(500)
	
	// string FileName{xpath('FileName')};
		string Name {xpath('Name')};
		unsigned Sequence{xpath('Sequence')};
		string Value{xpath('Value')};
		string Link{xpath('Link')};
		string FileName{xpath('FileName')};
		boolean IsSupplied{xpath('IsSupplied')};
		boolean ShowFileContent{xpath('ShowFileContent')};
		unsigned Total{xpath('Total')};

      // <Name>Result 1</Name>
      // <Sequence>0</Sequence>
      // <Value>[938517726 rows]</Value>
      // <Link>0</Link>
      // <FileName>thor_data400::key::bipv2::business_header::20140529::contact_linkids</FileName>
      // <IsSupplied>0</IsSupplied>
      // <ShowFileContent>1</ShowFileContent>
      // <Total>938517726</Total>
	
	end;
	
  export SubfileLayout := 
  record
		string   Name {xpath('Name')};
		unsigned Count{xpath('Count')};
  end;
  
	export ECLSourceFileLayout :=
	record, maxlength(500)
	
	// string FileName{xpath('FileName')};
  // <xsd:element minOccurs="0" name="FileCluster" type="xsd:string" /> 
  // <xsd:element minOccurs="0" name="Name" type="xsd:string" /> 
  // <xsd:element minOccurs="0" name="IsSuperFile" type="xsd:boolean" /> 
  // <xsd:element minOccurs="0" name="Subs" type="xsd:int" /> 
  // <xsd:element minOccurs="0" name="Count" type="xsd:int" /> 
  // <xsd:element minOccurs="0" name="ECLSourceFiles" type="tns:ArrayOfECLSourceFile" /> 

		string FileCluster {xpath('FileCluster')};
		string Name{xpath('Name')};
		boolean IsSuperFile{xpath('IsSuperFile')};
		integer Subs {xpath('Subs')};
		integer Count{xpath('Count')};
		dataset(SubfileLayout       ) Subfiles {xpath('ECLSourceFiles/ECLSourceFile')};
		// string ECLSourceFiles{xpath('ECLSourceFiles')};
	
	end;

//export WsFileRead := record  string name{maxlength(256)}; string cluster{maxlength(64)}; boolean isSuper; unsigned4 usage; end;

	export eclGraphResultLayout :=
	record, maxlength(500)
	
		string 	Name			{xpath('Name'			)};
		string	Label			{xpath('Label'		)};
		string 	Type			{xpath('Type'			)};
		boolean Running		{xpath('Running'	)};
		boolean Complete	{xpath('Complete'	)};
		boolean Failed		{xpath('Failed'		)};
		string 	RunningId	{xpath('RunningId')};
	
	end;

	export eclWorkflowsResultLayout :=
	record
	
		string 	Name						{xpath('WFID'						)};
		string	EventName				{xpath('EventName'			)};
		string 	EventText				{xpath('EventText'			)};
		string  Cnt							{xpath('Count'					)};
		string  CountRemaining	{xpath('CountRemaining'	)};
	
	end;

	export eclTimerResultLayout :=
	record
	
		string 	Name			  {xpath('Name'			  )};
		string	Value			  {xpath('Value'			)};
		string 	count		    {xpath('count'      )};
		string  GraphName		{xpath('GraphName'	)};
		string  SubGraphId	{xpath('SubGraphId' )};
	
	end;

	export ECLTimingDataLayout :=
	record
	
		string 	Name			  {xpath('Name'			  )};
		string	GraphNum		{xpath('Value'			)};
		string 	SubGraphNum	{xpath('count'      )};
		string  GID		      {xpath('GraphName'	)};
		string  Min	        {xpath('SubGraphId' )};
		string  MS      	  {xpath('SubGraphId' )};
	
	end;
  
	export ThorLogInfoLayout :=
	record
	
		string 	ProcessName			{xpath('ProcessName'	)};
		string	ClusterGroup		{xpath('ClusterGroup'	)};
		string 	LogDate	        {xpath('LogDate'	    )};
		string  NumberSlaves		{xpath('NumberSlaves'	)};
	
	end;

	export ECLExceptionLayout :=
	record
	
		string 	Source  		{xpath('Source'  	)};
		string	Severity		{xpath('Severity'	)};
		integer	Code        {xpath('Code'     )};
		string  Message 		{xpath('Message'	)};
		string  FileName		{xpath('FileName'	)};
		integer LineNo  		{xpath('LineNo'	  )};
		integer Column  		{xpath('Column'	  )};
	
	end;

	export wuinfoOutRecord :=
	record, maxlength(100000)
	
		string exception_code     {xpath('Exceptions/Exception/Code'    )};
		string exception_source   {xpath('Exceptions/Exception/Source'  )};
		string exception_msg      {xpath('Exceptions/Exception/Message' )};
		string Wuid               {xpath('Workunit/Wuid'                )};
		string Owner              {xpath('Workunit/Owner'               )};
		string Cluster            {xpath('Workunit/Cluster'             )};
		string RoxieCluster       {xpath('Workunit/RoxieCluster'        )};
		string Jobname            {xpath('Workunit/Jobname'             )};
		string Queue              {xpath('Workunit/Queue'               )};
		string StateID            {xpath('Workunit/StateID'             )};
		string State              {xpath('Workunit/State'               )};
		string StateEx            {xpath('Workunit/StateEx'             )};
		string Description        {xpath('Workunit/Description'         )};
		string Protected          {xpath('Workunit/Protected'           )};
		string Active             {xpath('Workunit/Active'              )};
		string Action             {xpath('Workunit/Action'              )};
		string ActionEx           {xpath('Workunit/ActionEx'            )};
		string DateTimeScheduled  {xpath('Workunit/DateTimeScheduled'   )};
		string PriorityClass      {xpath('Workunit/PriorityClass'       )};
		string PriorityLevel      {xpath('Workunit/PriorityLevel'       )};
		string Scope              {xpath('Workunit/Scope'               )};
		string Snapshot           {xpath('Workunit/Snapshot'            )};
		string ResultLimit        {xpath('Workunit/ResultLimit'         )};
		string Archived           {xpath('Workunit/Archived'            )};
		string IsPausing          {xpath('Workunit/IsPausing'           )};
		string ThorLCR            {xpath('Workunit/ThorLCR'             )};
		string EventSchedule      {xpath('Workunit/EventSchedule'       )};
		string HaveSubGraphTimings{xpath('Workunit/HaveSubGraphTimings' )};
		string TotalThorTime      {xpath('Workunit/TotalThorTime'       )};
		string Query              {xpath('Workunit/Query/Text'          )};
    
	  dataset(eclResultLayout           ) results     {xpath('Workunit/Results/ECLResult'       )};
		dataset(ECLSourceFileLayout       ) SourceFiles {xpath('Workunit/SourceFiles/ECLSourceFile')};
		dataset(eclGraphResultLayout			) graphs			{xpath('Workunit/Graphs/ECLGraph'         )};
		dataset(eclWorkflowsResultLayout	) Workflows		{xpath('Workunit/Workflows/ECLWorkflow'   )};
		dataset(ECLTimingDataLayout     	) TimingData	{xpath('Workunit/TimingData/ECLTimingData')};
		dataset(eclTimerResultLayout    	) Timers    	{xpath('Workunit/Timers/ECLTimer'         )};
		dataset(ThorLogInfoLayout    	    ) ThorLogInfo {xpath('Workunit/ThorLogList/ThorLogInfo')};
		dataset(ECLExceptionLayout   	    ) Exceptions  {xpath('Workunit/Exceptions/ECLException')};
	
  
	end;

	export WUInfo := 
	function
	
		userid 		:= _control.MyInfo.UserID;
		password	:= _control.MyInfo.Password;

		esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'



		results := SOAPCALL(
			'http://' + esp + '/WsWorkunits?ver_=1.48'
			,'WUInfo'
			,wuinfoInRecord
			,dataset(wuinfoOutRecord)
//		 ,heading('<WUInfoRequest>','</WUInfoRequest>')
			,xpath('WUInfoResponse')
      ,timelimit(600) //5 minutes
		);
		return if(WorkMan.Is_Valid_Wuid(pWorkunitID)  ,results ,dataset([],wuinfoOutRecord));
		
	end;

	export WUInfo_nofail := 
	function
	
		userid 		:= _control.MyInfo.UserID;
		password	:= _control.MyInfo.Password;

		esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'



		results := SOAPCALL(
			'http://' + esp + '/WsWorkunits?ver_=1.48'
			,'WUInfo'
			,wuinfoInRecord
			,dataset(wuinfoOutRecord)
//		 ,heading('<WUInfoRequest>','</WUInfoRequest>')
			,xpath('WUInfoResponse')
      ,onfail(skip)
      ,timelimit(600)
      //,retry(1)
		);
		return if(WorkMan.Is_Valid_Wuid(pWorkunitID)  ,results ,dataset([],wuinfoOutRecord));
		
	end;

  export dnormresults      := normalize(WUInfo(),left.results    ,transform(recordof(left.results    ),self := right));  //i get these
  export dnormSourceFiles  := normalize(WUInfo(),left.SourceFiles,transform(recordof(left.SourceFiles),self := right));  //we'll see...
  export dnormworkflows    := normalize(WUInfo(),left.workflows  ,transform(recordof(left.workflows  ),self := right));  //nothing(well, I guess if there are workflows in the workunit u would get them back)
  export dnormgraphs       := normalize(WUInfo(),left.graphs     ,transform(recordof(left.graphs     ),self := right));  //i get these
  export dnormTimingData   := normalize(WUInfo(),left.TimingData ,transform(recordof(left.TimingData ),self := right));  //nothing(not sure why nothing comes back)
  export dnormTimers       := normalize(WUInfo(),left.Timers     ,transform(recordof(left.Timers     ),self := right));  //i get these
  export dnormThorLogInfo  := normalize(WUInfo(),left.ThorLogInfo,transform(recordof(left.ThorLogInfo),self := right));  //nothing(not sure here either)
  export dnormECLException := normalize(WUInfo(),left.Exceptions ,transform(recordof(left.Exceptions ),self := right));  //

  export dnormresults_nofail      := normalize(WUInfo_nofail(),left.results    ,transform(recordof(left.results    ),self := right));  //i get these
  export dnormSourceFiles_nofail  := normalize(WUInfo_nofail(),left.SourceFiles,transform(recordof(left.SourceFiles),self := right));  //we'll see...
  export dnormworkflows_nofail    := normalize(WUInfo_nofail(),left.workflows  ,transform(recordof(left.workflows  ),self := right));  //nothing(well, I guess if there are workflows in the workunit u would get them back)
  export dnormgraphs_nofail       := normalize(WUInfo_nofail(),left.graphs     ,transform(recordof(left.graphs     ),self := right));  //i get these
  export dnormTimingData_nofail   := normalize(WUInfo_nofail(),left.TimingData ,transform(recordof(left.TimingData ),self := right));  //nothing(not sure why nothing comes back)
  export dnormTimers_nofail       := normalize(WUInfo_nofail(),left.Timers     ,transform(recordof(left.Timers     ),self := right));  //i get these
  export dnormThorLogInfo_nofail  := normalize(WUInfo_nofail(),left.ThorLogInfo,transform(recordof(left.ThorLogInfo),self := right));  //nothing(not sure here either)
  export dnormECLException_nofail := normalize(WUInfo_nofail(),left.Exceptions ,transform(recordof(left.Exceptions ),self := right));  //
  /*
  export SubfileLayout := 
  record
		string   Name {xpath('Name')};
		unsigned Count{xpath('Count')};
  end;

	export ECLSourceFileLayout :=
	record, maxlength(500)
	
	// string FileName{xpath('FileName')};
  // <xsd:element minOccurs="0" name="FileCluster" type="xsd:string" /> 
  // <xsd:element minOccurs="0" name="Name" type="xsd:string" /> 
  // <xsd:element minOccurs="0" name="IsSuperFile" type="xsd:boolean" /> 
  // <xsd:element minOccurs="0" name="Subs" type="xsd:int" /> 
  // <xsd:element minOccurs="0" name="Count" type="xsd:int" /> 
  // <xsd:element minOccurs="0" name="ECLSourceFiles" type="tns:ArrayOfECLSourceFile" /> 

		string FileCluster {xpath('FileCluster')};
		string Name{xpath('Name')};
		boolean IsSuperFile{xpath('IsSuperFile')};
		integer Subs {xpath('Subs')};
		integer Count{xpath('Count')};
		dataset(SubfileLayout       ) Subfiles {xpath('ECLSourceFiles/ECLSourceFile')};
		// string ECLSourceFiles{xpath('ECLSourceFiles')};
	
	end;

*/
  export WsFileRead := record  string name{maxlength(256)}; string cluster{maxlength(64)}; boolean isSuper; unsigned4 usage; end;
  export FilesRead1 := normalize(dnormSourceFiles,count(left.Subfiles) + 1  ,transform(WsFileRead//STD.System.Workunit.WsFileRead
    ,self.name    := if(counter = 1 ,left.name          ,left.Subfiles[counter - 1].Name  )
    ,self.cluster := left.FileCluster
    ,self.isSuper := if(counter = 1 ,left.IsSuperFile   ,false                            )
    ,self.usage   := left.Count 
  ));
  export FilesRead  := project(global(FilesRead1,few),WsFileRead);
  
  //////////
  EXPORT WsFileWritten := RECORD
    STRING name{MAXLENGTH(256)};
    STRING10 graph;
    STRING cluster{MAXLENGTH(64)};
    UNSIGNED4 kind;
  END;

  export FilesWritten1 := project(dnormresults,transform({unsigned rid,WsFileWritten} ,self.rid := counter,self.name := left.filename,self.graph := '',self.cluster := '',self.kind := 0));
  export FilesWritten2 := sort(join(FilesWritten1,FilesRead,left.name = right.name,transform(recordof(left),self.cluster := right.cluster,self := left),left outer),rid); 
  export FilesWritten  := project(global(FilesWritten2,few),WsFileWritten); 
  
  //////////
  shared dexcepfilt := dnormECLException(severity = 'Error');

  shared dexcepttransform := project(dexcepfilt  ,transform({string line},self.line := 
      left.source + ': '
    + trim(left.fileName)  + ' ('
    + left.LineNo + ',' + left.Column + ') : '
    + left.Code + ': '
    + left.Message
    + '\n'
  ));
  shared dexceptrollup := rollup(dexcepttransform,true,transform(recordof(left),self.line := left.line + right.line));

  export totalthortime := WUInfo()[1].TotalThorTime;
  export JobName       := WUInfo()[1].Jobname;
  export Cluster       := WUInfo()[1].Cluster;
  export State         := WUInfo()[1].State;
  export SoapError     := WUInfo()[1].exception_msg;
  export Description   := WUInfo()[1].Description;
  export Query         := WUInfo()[1].Query;
  export Errors        := dexceptrollup[1].line;

  export dnormresults2    := normalize(global(WUInfo(),few),left.results    ,transform(recordof(left.results    ),self := right));  //i get these
  export dnormresults3    := normalize(WUInfo(),left.results    ,transform(recordof(left.results    ),self := right));  //i get these
  export dfiltresults     := global(dnormresults2,few);
  export ScalarResult     (string pNamedOutput)  := dfiltresults(name = pNamedOutput)[1].Value;
  export ScalarResultSeq  (string pNamedOutput)  := dfiltresults(name = pNamedOutput)[1].Sequence;
  export ScalarResultSeq2 (string pNamedOutput)  := dnormresults3(name = pNamedOutput)[1].Sequence;
  export DS_Count     (string pNamedOutput)  := dfiltresults(name = pNamedOutput)[1].Total;
  

  export totalthortime_nofail := WUInfo_nofail()[1].TotalThorTime;
  export JobName_nofail       := WUInfo_nofail()[1].Jobname;
  export Cluster_nofail       := WUInfo_nofail()[1].Cluster;
  export State_nofail         := WUInfo_nofail()[1].State;
  export SoapError_nofail     := WUInfo_nofail()[1].exception_msg;
  export Description_nofail   := WUInfo_nofail()[1].Description;
  // export Errors_nofail        := dexceptrollup[1].line;
  
end;