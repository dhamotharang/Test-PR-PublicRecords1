EXPORT Layouts :=
module

	export WuidItems :=
	record
	
		string Item{xpath('Item')};
	
	end;

  export WsWorkunitRecord := 
  record  
    string24 wuid; 
    string owner{maxlength(64)}; 
    string cluster{maxlength(64)}; 
    string roxiecluster{maxlength(64)}; 
    string job{maxlength(256)}; 
    string10 state; 
    string7 priority; 
    integer2 priorityvalue; 
    string20 created; 
    string20 modified; 
    boolean online; 
    boolean protected; 
  end;

	export eclworkunit :=
	record
  	string                      Wuid                {xpath('Wuid'                 )};
  	string                      Owner               {xpath('Owner'                )};
  	string                      Cluster             {xpath('Cluster'              )};
  	string                      RoxieCluster        {xpath('RoxieCluster'         )};
  	string                      Jobname             {xpath('Jobname'              )};
  	string                      Queue               {xpath('Queue'                )};
  	integer                     StateID             {xpath('StateID'              )};
  	string                      State               {xpath('State'                )};
  	string                      StateEx             {xpath('StateEx'              )};
  	string                      Description         {xpath('Description'          )};
  	boolean                     Protected           {xpath('Protected'            )};
  	boolean                     Active              {xpath('Active'               )};
  	integer                     Action              {xpath('Action'               )};
  	string                      DateTimeScheduled   {xpath('DateTimeScheduled'    )};
  	integer                     PriorityClass       {xpath('PriorityClass'        )};
  	integer                     PriorityLevel       {xpath('PriorityLevel'        )};
  	string                      Scope               {xpath('Scope'                )};
  	string                      Snapshot            {xpath('Snapshot'             )};
  	integer                     ResultLimit         {xpath('ResultLimit'          )};
  	boolean                     Archived            {xpath('Archived'             )};
  	boolean                     IsPausing           {xpath('IsPausing'            )};
  	boolean                     ThorLCR             {xpath('ThorLCR'              )};
  	integer                     EventSchedule       {xpath('EventSchedule'        )};
  	boolean                     HaveSubGraphTimings {xpath('HaveSubGraphTimings'  )};
  	string                      TotalThorTime       {xpath('TotalThorTime'        )};
//	  dataset(ECLSourceFile)      SourceFiles         {xpath('SourceFiles/ECLSourceFile/ECLSourceFile'                    )}; //doesn't seem to come back anyway
  end;                                                                                              

  export WsFileRead := record  string name{maxlength(256)}; string cluster{maxlength(64)}; boolean isSuper; unsigned4 usage; end;

  EXPORT WsFileWritten := RECORD
    STRING name{MAXLENGTH(256)};
    STRING10 graph;
    STRING cluster{MAXLENGTH(64)};
    UNSIGNED4 kind;
  END;

	export WUWaitCompleteOutRecord :=
	record, maxlength(100000)
	
		string  exception_code    {xpath('Exceptions/Exception/Code'    )};
		string  exception_source  {xpath('Exceptions/Exception/Source'  )};
		string  exception_msg     {xpath('Exceptions/Exception/Message' )};
		integer StateID           {xpath('StateID'                      )};
	
 	end;

  export DebugValues := 
  record
    string Name  {xpath('Name'     )};
    string Value {xpath('Value'    )};
  end;

end;