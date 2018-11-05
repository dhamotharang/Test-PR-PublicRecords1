EXPORT soapcall_WUQuery(
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
  ,string                    pesp                      = WsWorkunits._Config.LocalEsp
) :=                           
function

	WUQueryRequest_Record :=
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

	ECLSourceFile :=
	record
  	string                      FileCluster         {xpath('FileCluster'          )};
  	string                      Name                {xpath('Name'                 )};
  	boolean                     IsSuperFile         {xpath('IsSuperFile'          )};
  	unsigned                    Subs                {xpath('Subs'                 )};
  	unsigned                    Count1              {xpath('Count'                )};
  end;
  
	WUQueryResponse_Record :=
	record	
  
		string                exception_code     {xpath('Exceptions/Exception/Code'    )};
		string                exception_source   {xpath('Exceptions/Exception/Source'  )};
		string                exception_audience {xpath('Exceptions/Exception/Audience')};
		string                exception_msg      {xpath('Exceptions/Exception/Message' )};
	  dataset(WsWorkunits.Layouts.eclworkunit)  Workunits          {xpath('Workunits/ECLWorkunit'                    )};

	end;


  esp				:= pesp + ':8010';

  dsoap_results := SOAPCALL(
    'http://' + esp + '/WsWorkunits?ver_=1.48'
    // 'http://' + esp + '/WsWorkunits'
    ,'WUQuery'
    ,WUQueryRequest_Record
    ,dataset(WUQueryResponse_Record)
    // ,heading('<WUInfoRequest>','</WUInfoRequest>')
    ,xpath('WUQueryResponse')
  );
  
  return if(WsWorkunits.Is_Valid_Wuid(pWuid)  ,dsoap_results  ,dataset([],WUQueryResponse_Record));

end;