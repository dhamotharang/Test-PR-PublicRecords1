import _control,std,ut;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export soapcall_DFUInfo(
   string   pfilename           = ''
  ,string   pcluster            = ''
  ,boolean  pUpdateDescription  = false
  ,string   pDescription        = ''
  ,string   pesp                = _Config.LocalEsp
) :=
function

	DFUInfoRequest :=
	record, maxlength(100)
		string  Name              {xpath('Name'               )} := pfilename         ;
		string  Cluster           {xpath('Cluster'            )} := pcluster          ;
		boolean UpdateDescription {xpath('UpdateDescription'  )} := pUpdateDescription;
		string  FileName          {xpath('FileName'           )} := pFileName         ;
		string  FileDesc          {xpath('FileDesc'           )} := pDescription      ;
	end;
	
	DFUFileParts_lay :=
	record
		integer  Id         {xpath('Id'           )} ;
		integer  Copy       {xpath('Copy'         )} ;
		string   ActualSize {xpath('ActualSize'   )} ;
		string   Ip         {xpath('Ip'           )} ;
		string   Partsize   {xpath('Partsize'     )} ;
	end;
  
	lay_DFULogicalFiles :=
	record
    string    Prefix                  {xpath('Prefix'                 )};
    string    ClusterName             {xpath('NodeGroup'              )};
    string    Directory               {xpath('Directory'              )};
    string    Description             {xpath('Description'            )};
    string    Parts                   {xpath('Parts'                  )};
    string    Name                    {xpath('Name'                   )};
    string    Owner                   {xpath('Owner'                  )};
    string    Totalsize               {xpath('Totalsize'              )};
    string    RecordCount             {xpath('RecordCount'            )};
    string    Modified                {xpath('Modified'               )};
    unsigned8 LongSize                {xpath('LongSize'               )};
    unsigned8 LongRecordCount         {xpath('LongRecordCount'        )};
    boolean   isSuperfile             {xpath('isSuperfile'            )};
    boolean   isZipfile               {xpath('isZipfile'              )};
    boolean   isDirectory             {xpath('isDirectory'            )};
    string    Replicate               {xpath('Replicate'              )};
    unsigned8 IntSize                 {xpath('IntSize'                )};
    unsigned8 IntRecordCount          {xpath('IntRecordCount'         )};
    boolean   FromRoxieCluster        {xpath('FromRoxieCluster'       )};
    boolean   BrowseData              {xpath('BrowseData'             )};
    boolean   IsKeyFile               {xpath('IsKeyFile'              )};
    boolean   IsCompressed            {xpath('IsCompressed'           )};
    integer   CompressedFileSize      {xpath('CompressedFileSize'     )};
  end;

	DFUInfoOutRecord :=
	record, maxlength(100000)
	
		string                        exception_code      {xpath('Exceptions/Exception/Code'                                                    )};
		string                        exception_source    {xpath('Exceptions/Exception/Source'                                                  )};
		string                        exception_msg       {xpath('Exceptions/Exception/Message'                                                 )};
		string                        Name                {xpath('FileDetail/Name'                                                              )};
		string                        Filename            {xpath('FileDetail/Filename'                                                          )};
		string                        Description         {xpath('FileDetail/Description'                                                       )};
		string                        Dir                 {xpath('FileDetail/Dir'                                                               )};
		string                        PathMask            {xpath('FileDetail/PathMask'                                                          )};
		string                        Filesize            {xpath('FileDetail/Filesize'                                                          )};
		string                        ActualSize          {xpath('FileDetail/ActualSize'                                                        )};
		string                        RecordSize          {xpath('FileDetail/RecordSize'                                                        )};
		string                        RecordCount         {xpath('FileDetail/RecordCount'                                                       )};
		string                        Wuid                {xpath('FileDetail/Wuid'                                                              )};
		string                        Owner               {xpath('FileDetail/Owner'                                                             )};
		string                        Cluster             {xpath('FileDetail/Cluster'                                                           )};
		string                        JobName             {xpath('FileDetail/JobName'                                                           )};
		string                        Persistent          {xpath('FileDetail/Persistent'                                                        )};
		string                        Format              {xpath('FileDetail/Format'                                                            )};
		string                        MaxRecordSize       {xpath('FileDetail/MaxRecordSize'                                                     )};
		string                        CsvSeparate         {xpath('FileDetail/CsvSeparate'                                                       )};
		string                        CsvQuote            {xpath('FileDetail/CsvQuote'                                                          )};
		string                        CsvTerminate        {xpath('FileDetail/CsvTerminate'                                                      )};
		string                        CsvEscape           {xpath('FileDetail/CsvEscape'                                                         )};
		string                        Modified            {xpath('FileDetail/Modified'                                                          )};
		string                        Ecl                 {xpath('FileDetail/Ecl'                                                               )};	
		string                        MinSkew             {xpath('FileDetail/Stat/MinSkew'                                                      )};	
		string                        MaxSkew             {xpath('FileDetail/Stat/MaxSkew'                                                      )};	
    integer                       CompressedFileSize  {xpath('FileDetail/CompressedFileSize'                                                )};
    boolean                       IsCompressed        {xpath('FileDetail/IsCompressed'                                                      )};
    dataset(DFUFileParts_lay    ) DFUFileParts        {xpath('FileDetail/DFUFilePartsOnClusters/DFUFilePartsOnCluster/DFUFileParts/DFUPart' )};
    dataset(lay_DFULogicalFiles ) Superfiles          {xpath('FileDetail/Superfiles/DFULogicalFile'                                         )};
  
	end;

  esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'

  import ut,Workman;

  #UNIQUENAME(SOAPCALLCREDENTIALS)
  #SET(SOAPCALLCREDENTIALS  ,ut.Credentials().mac_add2Soapcall())

  soap_results := SOAPCALL(
    'http://' + esp + '/WsDfu?ver_=1.48'
    ,'DFUInfo'
    ,DFUInfoRequest
    ,dataset(DFUInfoOutRecord)
    ,xpath('DFUInfoResponse')
  );
  
  soap_results_remote := SOAPCALL(
    'http://' + esp + '/WsDfu?ver_=1.48'
    ,'DFUInfo'
    ,DFUInfoRequest
    ,dataset(DFUInfoOutRecord)
    ,xpath('DFUInfoResponse')
    %SOAPCALLCREDENTIALS%
  );

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,soap_results  ,soap_results_remote);

  return returnresult;
		
/*  
  export layout := DFUInfo()[1].Ecl;
  export wuid   := DFUInfo()[1].wuid;

*/  
end;