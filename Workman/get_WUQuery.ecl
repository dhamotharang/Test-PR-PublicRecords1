/*
  WUQuery gets workunits, archived & not archived
       <Type>archived workunits</Type>
*/
import _control;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_WUQuery(
   string                    pWuid                     = ''      
  ,string                    pType                     = ''    //archived workunits, non-archived workunits           
  ,string                    pCluster                  = ''
  ,string                    pOwner                    = ''
  ,string                    pState                    = ''    
  ,string                    pStartDate                = ''   //2014-06-24T09:39:29Z
  ,string                    pEndDate                  = ''   //2014-06-24T09:39:29Z
  ,unsigned                  pLastNDays                = 0
  ,string                    pJobname                  = ''
  ,string                    pECL                      = ''
  ,string                    pLogicalFile              = ''
  ,string                    pLogicalFileSearchType    = ''
  ,unsigned                  pPageSize                 = 1000 //max count of workunits coming back
  ,unsigned                  pPageStartFrom            = 0    //start from beginning?

  ,string                    pAfter                    = ''
  ,string                    pBefore                   = ''
  ,unsigned                  pCount                    = 0
  ,string                    pSortby                   = ''
  ,boolean                   pDescending               = false
  ,string                    pRoxieCluster             = ''
  ,string                    pApplicationName          = ''
  ,string                    pApplicationKey           = ''
  ,string                    pApplicationData          = ''
  ,string                    pesp                      = _Config.LocalEsp
) :=                           
module

	export WUQueryRequest_Record :=
	record
  	string                      Wuid                  {xpath('Wuid'                  )} := pWuid                    ;
		string                      Type                  {xpath('Type'                  )} := pType                    ; //archived workunits, non-archived workunits
		string                      Cluster               {xpath('Cluster'               )} := pCluster                 ;
		string                      RoxieCluster          {xpath('RoxieCluster'          )} := pRoxieCluster            ;
		string                      Owner                 {xpath('Owner'                 )} := pOwner                   ;
		string                      State                 {xpath('State'                 )} := pState                   ;
		string                      StartDate             {xpath('StartDate'             )} := pStartDate               ;
		string                      EndDate               {xpath('EndDate'               )} := pEndDate                 ;
		string                      ECL                   {xpath('ECL'                   )} := pECL                     ;
		string                      Jobname               {xpath('Jobname'               )} := pJobname                 ;
		string                      LogicalFile           {xpath('LogicalFile'           )} := pLogicalFile             ;
		string                      LogicalFileSearchType {xpath('LogicalFileSearchType' )} := pLogicalFileSearchType   ;
		string                      ApplicationName       {xpath('ApplicationName'       )} := pApplicationName         ;
		string                      ApplicationKey        {xpath('ApplicationKey'        )} := pApplicationKey          ;
		string                      ApplicationData       {xpath('ApplicationData'       )} := pApplicationData         ;
		string                      After                 {xpath('After'                 )} := pAfter                   ;
		string                      Before                {xpath('Before'                )} := pBefore                  ;
		unsigned                    Count                 {xpath('Count'                 )} := pCount                   ;
		unsigned                    LastNDays             {xpath('LastNDays'             )} := pLastNDays               ;
		string                      Sortby                {xpath('Sortby'                )} := pSortby                  ;
		boolean                     Descending            {xpath('Descending'            )} := pDescending              ;

		unsigned                    PageSize              {xpath('PageSize'              )} := pPageSize                ;
		unsigned                    PageStartFrom         {xpath('PageStartFrom'         )} := pPageStartFrom           ;  
    
	end;

	export ECLSourceFile :=
	record
  	string                      FileCluster         {xpath('FileCluster'          )};
  	string                      Name                {xpath('Name'                 )};
  	boolean                     IsSuperFile         {xpath('IsSuperFile'          )};
  	unsigned                    Subs                {xpath('Subs'                 )};
  	unsigned                    Count1              {xpath('Count'                )};
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
  
	export WUQueryResponse_Record :=
	record	
  
		string                exception_code     {xpath('Exceptions/Exception/Code'    )};
		string                exception_source   {xpath('Exceptions/Exception/Source'  )};
		string                exception_audience {xpath('Exceptions/Exception/Audience')};
		string                exception_msg      {xpath('Exceptions/Exception/Message' )};
	  dataset(eclworkunit)  Workunits          {xpath('Workunits/ECLWorkunit'                    )};

	end;


  esp				:= pesp + ':8010';

  export dsoap_results := SOAPCALL(
    'http://' + esp + '/WsWorkunits?ver_=1.48'
    // 'http://' + esp + '/WsWorkunits'
    ,'WUQuery'
    ,WUQueryRequest_Record
    ,dataset(WUQueryResponse_Record)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('WUQueryResponse')
  );
  
  export results :=  if(WorkMan.Is_Valid_Wuid(pWuid)  ,dsoap_results  ,dataset([],WUQueryResponse_Record));

export dnorm := normalize(results,left.Workunits,transform(eclworkunit,self := right));

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

export WuidList := project(global(dnorm,few),transform(WsWorkunitRecord,
  self.wuid           := left.wuid;
  self.owner          := left.owner;
  self.cluster        := left.cluster;
  self.roxiecluster   := left.roxiecluster;
  self.job            := left.jobname;
  self.state          := left.state;
  self.priority       := '';//not sure yet how this maps
  self.priorityvalue  := 0;//not sure how this maps
  self.created        := '';
  self.modified       := '';
  self.online         := ~left.Archived;
  self.protected      := left.protected;
  
));
  
end;
