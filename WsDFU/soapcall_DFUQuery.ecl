import std;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export soapcall_DFUQuery(
   string   pFileName               = ''
  ,string   pesp                    = _Config.LocalEsp
) :=
function

	DFUQueryRequest := RECORD
    STRING   Prefix                {xpath('Prefix'               )} := '';
    STRING   NodeGroup             {xpath('NodeGroup'            )} := '';
    STRING   ContentType           {xpath('ContentType'          )} := '';
    string   LogicalName           {xpath('LogicalName'          )} := pFilename;
    STRING   Description           {xpath('Description'          )} := '';
    STRING   Owner                 {xpath('Owner'                )} := '';
    STRING   StartDate             {xpath('StartDate'            )} := '';
    STRING   EndDate               {xpath('EndDate'              )} := '';
    STRING   FileType              {xpath('FileType'             )} := '';
    INTEGER  FileSizeFrom          {xpath('FileSizeFrom'         )} := -1;
    INTEGER  FileSizeTo            {xpath('FileSizeTo'           )} := -1;
    INTEGER  FirstN                {xpath('FirstN'               )} := -1;
    UNSIGNED PageSize              {xpath('PageSize'             )} := 0;
    UNSIGNED PageStartFrom         {xpath('PageStartFrom'        )} := 0;
    STRING   Sortby                {xpath('Sortby'               )} := '';
    BOOLEAN  Descending            {xpath('Descending'           )} := false;
    BOOLEAN  OneLevelDirFileReturn {xpath('OneLevelDirFileReturn')} := false;
    UNSIGNED CacheHint             {xpath('CacheHint'            )} := 0;
    UNSIGNED MaxNumberOfFiles      {xpath('MaxNumberOfFiles'     )} := 0;
    BOOLEAN  IncludeSuperOwner     {xpath('IncludeSuperOwner'    )} := false;
  END;
	
  DFULogicalFile:=RECORD
    STRING   Prefix             {xpath('Prefix'            )};
    STRING   ClusterName        {xpath('ClusterName'       )};
    STRING   NodeGroup          {xpath('NodeGroup'         )};
    STRING   Directory          {xpath('Directory'         )};
    STRING   Description        {xpath('Description'       )};
    STRING   Parts              {xpath('Parts'             )};
    STRING   Name               {xpath('Name'              )};
    STRING   Owner              {xpath('Owner'             )};
    STRING   Totalsize          {xpath('Totalsize'         )};
    STRING   RecordCount        {xpath('RecordCount'       )};
    STRING   Modified           {xpath('Modified'          )};
    STRING   LongSize           {xpath('LongSize'          )};
    STRING   LongRecordCount    {xpath('LongRecordCount'   )};
    BOOLEAN  isSuperfile        {xpath('isSuperfile'       )};
    BOOLEAN  isZipfile          {xpath('isZipfile'         )};
    BOOLEAN  isDirectory        {xpath('isDirectory'       )};
    BOOLEAN  Replicate          {xpath('Replicate'         )};
    UNSIGNED IntSize            {xpath('IntSize'           )};
    UNSIGNED IntRecordCount     {xpath('IntRecordCount'    )};
    BOOLEAN  FromRoxieCluster   {xpath('FromRoxieCluster'  )};
    BOOLEAN  BrowseData         {xpath('BrowseData'        )};
    BOOLEAN  IsKeyFile          {xpath('IsKeyFile'         )};
    BOOLEAN  IsCompressed       {xpath('IsCompressed'      )};
    STRING   ContentType        {xpath('ContentType'       )};
    UNSIGNED CompressedFileSize {xpath('CompressedFileSize')};
    STRING   SuperOwners        {xpath('SuperOwners'       )};
    BOOLEAN  Persistent         {xpath('Persistent'        )};
    BOOLEAN  IsProtected        {xpath('IsProtected'       )};
  END;
  
  DFULogicalFiles:=RECORD
    DATASET  (DFULogicalFile)  logical_file  {xpath('DFULogicalFile')};
  END;  
  
  DFUQueryOutRecord:=RECORD
    DATASET  (DFULogicalFiles) logical_files {xpath('DFULogicalFiles')};
    STRING   Prefix              {xpath('Prefix'             )};
    STRING   NodeGroup           {xpath('NodeGroup'          )};
    STRING   LogicalName         {xpath('LogicalName'        )};
    STRING   Description         {xpath('Description'        )};
    STRING   Owner               {xpath('Owner'              )};
    STRING   StartDate           {xpath('StartDate'          )};
    STRING   EndDate             {xpath('EndDate'            )};
    STRING   FileType            {xpath('FileType'           )};
    UNSIGNED FileSizeFrom        {xpath('FileSizeFrom'       )};
    UNSIGNED FileSizeTo          {xpath('FileSizeTo'         )};
    UNSIGNED FirstN              {xpath('FirstN'             )};
    UNSIGNED PageSize            {xpath('PageSize'           )};
    UNSIGNED PageStartFrom       {xpath('PageStartFrom'      )};
    UNSIGNED LastPageFrom        {xpath('LastPageFrom'       )};
    UNSIGNED PageEndAt           {xpath('PageEndAt'          )};
    UNSIGNED PrevPageFrom        {xpath('PrevPageFrom'       )};
    UNSIGNED NextPageFrom        {xpath('NextPageFrom'       )};
    UNSIGNED NumFiles            {xpath('NumFiles'           )};
    STRING   Sortby              {xpath('Sortby'             )};
    BOOLEAN  Descending          {xpath('Descending'         )};
    STRING   BasicQuery          {xpath('BasicQuery'         )};
    STRING   ParametersForPaging {xpath('ParametersForPaging')};
    STRING   Filters             {xpath('Filters'            )};
    UNSIGNED CacheHint           {xpath('CacheHint'          )};
    BOOLEAN  IsSubsetOfFiles     {xpath('IsSubsetOfFiles'    )};
    STRING   Warning             {xpath('Warning'            )};
  END;

  esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'

  soap_results := SOAPCALL(
    'http://' + esp + '/WsDfu?ver_=1.34'
    ,'DFUQuery'
    ,DFUQueryRequest
    ,dataset(DFUQueryOutRecord)
    ,xpath('DFUQueryResponse')
  );
  
  return soap_results;

end;