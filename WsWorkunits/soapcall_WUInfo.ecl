import _control,std;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export soapcall_WUInfo(
   string pWorkunitID = ''
  ,string pesp        = _Config.localEsp
) :=
function

	wuinfoInRecord :=
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
	
	eclResultLayout :=
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
	
  SubfileLayout := 
  record
		string   Name {xpath('Name')};
		unsigned Count{xpath('Count')};
  end;
  
	ECLSourceFileLayout :=
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

	eclGraphResultLayout :=
	record, maxlength(500)
	
		string 	Name			{xpath('Name'			)};
		string	Label			{xpath('Label'		)};
		string 	Type			{xpath('Type'			)};
		boolean Running		{xpath('Running'	)};
		boolean Complete	{xpath('Complete'	)};
		boolean Failed		{xpath('Failed'		)};
		string 	RunningId	{xpath('RunningId')};
	
	end;

	eclWorkflowsResultLayout :=
	record
	
		string 	Name						{xpath('WFID'						)};
		string	EventName				{xpath('EventName'			)};
		string 	EventText				{xpath('EventText'			)};
		string  Cnt							{xpath('Count'					)};
		string  CountRemaining	{xpath('CountRemaining'	)};
	
	end;

	eclTimerResultLayout :=
	record
	
		string 	Name			  {xpath('Name'			  )};
		string	Value			  {xpath('Value'			)};
		string 	count		    {xpath('count'      )};
		string  GraphName		{xpath('GraphName'	)};
		string  SubGraphId	{xpath('SubGraphId' )};
	
	end;

	ECLTimingDataLayout :=
	record
	
		string 	Name			  {xpath('Name'			  )};
		string	GraphNum		{xpath('Value'			)};
		string 	SubGraphNum	{xpath('count'      )};
		string  GID		      {xpath('GraphName'	)};
		string  Min	        {xpath('SubGraphId' )};
		string  MS      	  {xpath('SubGraphId' )};
	
	end;
  
	ThorLogInfoLayout :=
	record
	
		string 	ProcessName			{xpath('ProcessName'	)};
		string	ClusterGroup		{xpath('ClusterGroup'	)};
		string 	LogDate	        {xpath('LogDate'	    )};
		string  NumberSlaves		{xpath('NumberSlaves'	)};
	
	end;

	ECLExceptionLayout :=
	record
	
		string 	Source  		{xpath('Source'  	)};
		string	Severity		{xpath('Severity'	)};
		integer	Code        {xpath('Code'     )};
		string  Message 		{xpath('Message'	)};
		string  FileName		{xpath('FileName'	)};
		integer LineNo  		{xpath('LineNo'	  )};
		integer Column  		{xpath('Column'	  )};
	
	end;

	DebugValueLayout :=
	record
	
		string 	Name			{xpath('Name'	  )};
		string	Value		  {xpath('Value'	)};
	
	end;

	wuinfoOutRecord :=
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
    
	  dataset(eclResultLayout           ) results     {xpath('Workunit/Results/ECLResult'         )};
	  dataset(DebugValueLayout          ) DebugValues {xpath('Workunit/DebugValues/DebugValue'    )};
		dataset(ECLSourceFileLayout       ) SourceFiles {xpath('Workunit/SourceFiles/ECLSourceFile' )};
		dataset(eclGraphResultLayout			) graphs			{xpath('Workunit/Graphs/ECLGraph'           )};
		dataset(eclWorkflowsResultLayout	) Workflows		{xpath('Workunit/Workflows/ECLWorkflow'     )};
		dataset(ECLTimingDataLayout     	) TimingData	{xpath('Workunit/TimingData/ECLTimingData'  )};
		dataset(eclTimerResultLayout    	) Timers    	{xpath('Workunit/Timers/ECLTimer'           )};
		dataset(ThorLogInfoLayout    	    ) ThorLogInfo {xpath('Workunit/ThorLogList/ThorLogInfo'   )};
		dataset(ECLExceptionLayout   	    ) Exceptions  {xpath('Workunit/Exceptions/ECLException'   )};
	  dataset(eclResultLayout           ) Variables   {xpath('Workunit/Variables/ECLResult'       )};
	
  
	end;
	
		userid 		:= _control.MyInfo.UserID;
		password	:= _control.MyInfo.Password;

		esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'



    import ut,Workman;
    
		results := SOAPCALL(
			'http://' + esp + '/WsWorkunits'//?ver_=1.48'
			,'WUInfo'
			,wuinfoInRecord
			,dataset(wuinfoOutRecord)
//		 ,heading('<WUInfoRequest>','</WUInfoRequest>')
			,xpath('WUInfoResponse')
      ,timelimit(600) //5 minutes
		);

		results_remote := SOAPCALL(
			'http://' + esp + '/WsWorkunits'//?ver_=1.48'
			,'WUInfo'
			,wuinfoInRecord
			,dataset(wuinfoOutRecord)
//		 ,heading('<WUInfoRequest>','</WUInfoRequest>')
			,xpath('WUInfoResponse')
      ,timelimit(600) //5 minutes
      ,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
		);

    returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,results  ,results_remote);
    
    // returnresult := results_remote;

		return if(Is_Valid_Wuid(pWorkunitID)  ,returnresult ,dataset([],wuinfoOutRecord));
		
end;