/*
  DFUQuery gets files
*/
import _control,ut;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_DFUQuery(
   string                   pPrefix                   = ''      
  ,string                   pClusterName              = ''               
  ,string                   pLogicalName              = ''
  ,string                   pCompressed               = 'U|C'
  ,string                   pDescription              = ''
  ,string                   pOwner                    = ''    
  ,string                   pStartDate                = ''   //2014-06-24T09:39:29Z
  ,string                   pEndDate                  = ''   //2014-06-24T09:39:29Z
  ,string                   pFileType                 = ''
  ,integer                  pFileSizeFrom             = -1
  ,integer                  pFileSizeTo               = -1
  ,integer                  pFirstN                   = -1
  ,string                   pFirstNType               = ''
  ,integer                  pPageSize                 = 0  
  ,integer                  pPageStartFrom            = 0    
  ,string                   pSortby                   = ''        
  ,boolean                  pDescending               = false
  ,boolean                  pOneLevelDirFileReturn    = false
  ,string                   pesp                      = _constants.LocalEsp
) :=                           
module

	export DFUQueryRequest_Record :=
	record

    string    Prefix                    {xpath('Prefix'                 )} := pPrefix               ;
    string    ClusterName               {xpath('ClusterName'            )} := pClusterName          ;
    string    LogicalName               {xpath('LogicalName'            )} := ''          ;
    string    Description               {xpath('Description'            )} := pDescription          ;
    string    Owner                     {xpath('Owner'                  )} := pOwner                ;
    string    StartDate                 {xpath('StartDate'              )} := pStartDate            ;
    string    EndDate                   {xpath('EndDate'                )} := pEndDate              ;
    string    FileType                  {xpath('FileType'               )} := pFileType             ;
    integer   FileSizeFrom              {xpath('FileSizeFrom'           )} := pFileSizeFrom         ;
    integer   FileSizeTo                {xpath('FileSizeTo'             )} := pFileSizeTo           ;
    integer   FirstN                    {xpath('FirstN'                 )} := pFirstN               ;
    string    FirstNType                {xpath('FirstNType'             )} := pFirstNType           ;
    integer   PageSize                  {xpath('PageSize'               )} := pPageSize             ;
    integer   PageStartFrom             {xpath('PageStartFrom'          )} := pPageStartFrom        ;
    string    Sortby                    {xpath('Sortby'                 )} := pSortby               ;
    boolean   Descending                {xpath('Descending'             )} := pDescending           ;
    boolean   OneLevelDirFileReturn     {xpath('OneLevelDirFileReturn'  )} := pOneLevelDirFileReturn;

  end;

	export lay_DFULogicalFiles :=
	record
    string    Prefix                  {xpath('Prefix'                 )};
    string    ClusterName             {xpath('ClusterName'            )};
    string    Directory               {xpath('Directory'              )};
    string    Description             {xpath('Description'            )};
    string    Parts                   {xpath('Parts'                  )};
    string    Name                    {xpath('Name'                   )};
    string    Owner                   {xpath('Owner'                  )};
    string    Totalsize               {xpath('Totalsize'              )};
    string    RecordCount             {xpath('RecordCount'            )};
    string    Modified                {xpath('Modified'               )};
    integer   LongSize                {xpath('LongSize'               )};
    integer   LongRecordCount         {xpath('LongRecordCount'        )};
    boolean   isSuperfile             {xpath('isSuperfile'            )};
    boolean   isZipfile               {xpath('isZipfile'              )};
    boolean   isDirectory             {xpath('isDirectory'            )};
    boolean   Replicate               {xpath('Replicate'              )};
    unsigned8 IntSize                 {xpath('IntSize'                )};
    unsigned8 IntRecordCount          {xpath('IntRecordCount'         )};
    boolean   FromRoxieCluster        {xpath('FromRoxieCluster'       )};
    boolean   BrowseData              {xpath('BrowseData'             )};
    boolean   IsKeyFile               {xpath('IsKeyFile'              )};
    boolean   IsCompressed            {xpath('IsCompressed'           )};
    integer    CompressedFileSize      {xpath('CompressedFileSize'     )};
  end;
    
	export DFUQueryResponse_Record :=
	record	
  
		string                exception_code     {xpath('Exceptions/Exception/Code'    )};
		string                exception_source   {xpath('Exceptions/Exception/Source'  )};
		string                exception_audience {xpath('Exceptions/Exception/Audience')};
		string                exception_msg      {xpath('Exceptions/Exception/Message' )};
	  dataset(lay_DFULogicalFiles)  DFULogicalFiles    {xpath('DFULogicalFiles/DFULogicalFile'                    )};
    
	end;
  

  esp				:= pesp + ':8010';

  dsoap_results := SOAPCALL(
    'http://' + esp + '/WsDfu?ver_=1.52'
    ,'DFUQuery'
    ,DFUQueryRequest_Record
    ,dataset(DFUQueryResponse_Record)
    ,xpath('DFUQueryResponse')
    ,timeout(1200)  //max 20 minutes
  );
  
  export results :=  dsoap_results  ;

export dnorm := normalize(results,left.DFULogicalFiles,transform({lay_DFULogicalFiles,integer realsize}
  ,self.longsize            := if(right.longsize            = -1,0,right.longsize           )
  ,self.CompressedFileSize  := if(right.CompressedFileSize  = -1,0,right.CompressedFileSize )
  ,self.realsize := if(self.CompressedFileSize != 0,self.CompressedFileSize,self.longsize  )
  ,self.IsCompressed := right.IsCompressed or right.IsKeyFile
  ,self := right))
  ((pCompressed = 'U|C' or (pCompressed = 'U' and IsCompressed = false) or (pCompressed = 'C' and IsCompressed = true))
  and (pLogicalName = '' or regexfind(pLogicalName,name,nocase))
  
  ) : independent;
  

export total_size                     := sum(dnorm,realsize);
export total_size_compressed          := sum(dnorm(IsCompressed = true),realsize);
export total_size_compressed_percent  := sum(dnorm(IsCompressed = true),realsize) / sum(dnorm(IsCompressed = true),longsize) * 100.0;
export total_size_uncompressed        := sum(dnorm(IsCompressed = false),realsize);

export total_size_readable                := ut.FHumanReadableSpace(total_size);
export total_size_readable_compressed    := ut.FHumanReadableSpace(total_size_compressed);
export total_size_readable_uncompressed  := ut.FHumanReadableSpace(total_size_uncompressed);

export largest  := iterate(project(sort(dnorm, -realsize),transform({string name,string sizepretty,real8 percent,unsigned8 running_total_size,string running_total_sizepretty,real8 running_total_percent,recordof(left) - name}
            ,self.sizepretty := ut.FHumanReadableSpace(left.realsize)
            ,self := left
            ,self.percent := self.realsize / total_size * 100.0;
            ,self.running_total_size := left.realsize
            ,self.running_total_sizepretty := ''
            ,self.running_total_percent := 0
            ,self := left
         )) 
         ,transform(recordof(left),self.running_total_size := left.running_total_size + right.running_total_size,self.running_total_sizepretty := ut.FHumanReadableSpace(self.running_total_size),self.running_total_percent := self.running_total_size / total_size * 100.0,self := right))
         
         ;


export FsLogicalFileInfoRecord := 
record  
 string name;
 boolean superfile; 
 integer8 size;
 integer8 rowcount;
 string19 modified;
 string owner;
 string cluster; 
end;

export WuidList := project(global(dnorm,few),transform(FsLogicalFileInfoRecord,
  self.size           := (integer8)left.totalsize;
  self.rowcount       := (integer8)left.RecordCount;
  self.cluster        := left.ClusterName;
  self.superfile      := left.isSuperfile;
  self                := left;
));
  
end;
