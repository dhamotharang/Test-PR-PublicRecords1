/*
  get_GetTargetClusterInfo gets info on clusters
*/
import _control,ut;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_GetTargetClusterInfo(
   string     pTargetClusters         = ''      
  ,string     pAddProcessesToFilter   = ''               
  ,boolean    pApplyProcessFilter     = false
  ,boolean    pGetProcessorInfo       = true //false
  ,boolean    pGetStorageInfo         = true
  ,boolean    pLocalFileSystemsOnly   = true //false    
  ,boolean    pGetSoftwareInfo        = true //false   
  ,integer    pMemThreshold           = 0   
  ,integer    pDiskThreshold          = 0
  ,integer    pCpuThreshold           = 0
  ,integer    pAutoRefresh            = 0
  ,string     pMemThresholdType       = ''
  ,string     pDiskThresholdType      = ''
  ,string     pesp                    = _Config.LocalEsp
) :=                           
module
/*
  <GetTargetClusterInfoRequest>
   <TargetClusters>
    <Item>ThorCluster:thor400_20</Item>
   </TargetClusters>
   <AddProcessesToFilter/>
   <ApplyProcessFilter>0</ApplyProcessFilter>
   <GetProcessorInfo>0</GetProcessorInfo>
   <GetStorageInfo>1</GetStorageInfo>
   <LocalFileSystemsOnly>1</LocalFileSystemsOnly>
   <GetSoftwareInfo>0</GetSoftwareInfo>
   <MemThreshold>0</MemThreshold>
   <DiskThreshold>0</DiskThreshold>
   <CpuThreshold>0</CpuThreshold>
   <AutoRefresh>0</AutoRefresh>
   <MemThresholdType/>
   <DiskThresholdType/>
  </GetTargetClusterInfoRequest>
*/
  export EspStringArray := {string item {xpath('Item')}};

	export GetTargetClusterInfoRequest_record :=
	record

    dataset(EspStringArray)   TargetClusters          {xpath('TargetClusters'             )} := dataset([{'ThorCluster:' + pTargetClusters }],EspStringArray)        ;  
    string                    AddProcessesToFilter    {xpath('AddProcessesToFilter'       )} := pAddProcessesToFilter   ;
    boolean                   ApplyProcessFilter      {xpath('ApplyProcessFilter'         )} := pApplyProcessFilter     ;
    boolean                   GetProcessorInfo        {xpath('GetProcessorInfo'           )} := pGetProcessorInfo       ;
    boolean                   GetStorageInfo          {xpath('GetStorageInfo'             )} := pGetStorageInfo         ;
    boolean                   LocalFileSystemsOnly    {xpath('LocalFileSystemsOnly'       )} := pLocalFileSystemsOnly   ;
    boolean                   GetSoftwareInfo         {xpath('GetSoftwareInfo'            )} := pGetSoftwareInfo        ;
    integer                   MemThreshold            {xpath('MemThreshold'               )} := pMemThreshold           ;
    integer                   DiskThreshold           {xpath('DiskThreshold'              )} := pDiskThreshold          ;
    integer                   CpuThreshold            {xpath('CpuThreshold'               )} := pCpuThreshold           ;
    integer                   AutoRefresh             {xpath('AutoRefresh'                )} := pAutoRefresh            ;
    string                    MemThresholdType        {xpath('MemThresholdType'           )} := pMemThresholdType       ;
    string                    DiskThresholdType       {xpath('DiskThresholdType'          )} := pDiskThresholdType      ;           

  end;

	export RequestInfoStruct := 
  record
    dataset(EspStringArray)   Addresses               {xpath('Addresses'                   )};
    string                    ClusterType             {xpath('ClusterType'                 )};
    string                    Cluster                 {xpath('Cluster'                     )};
    string                    OldIP                   {xpath('OldIP'                       )};
    string                    Path                    {xpath('Path'                        )};
    string                    AddProcessesToFilter    {xpath('AddProcessesToFilter'        )};
    boolean                   ApplyProcessFilter      {xpath('ApplyProcessFilter'          )};
    boolean                   GetProcessorInfo        {xpath('GetProcessorInfo'            )};
    boolean                   GetStorageInfo          {xpath('GetStorageInfo'              )};
    boolean                   LocalFileSystemsOnly    {xpath('LocalFileSystemsOnly'        )};
    boolean                   GetSoftwareInfo         {xpath('GetSoftwareInfo'             )};
    integer                   MemThreshold            {xpath('MemThreshold'                )};
    integer                   DiskThreshold           {xpath('DiskThreshold'               )};
    integer                   CpuThreshold            {xpath('CpuThreshold'                )};
    integer                   AutoRefresh             {xpath('AutoRefresh'                 )};
    string                    MemThresholdType        {xpath('MemThresholdType'            )};
    string                    DiskThresholdType       {xpath('DiskThresholdType'           )};
    string                    SecurityString          {xpath('SecurityString'              )};
    string                    UserName                {xpath('UserName'                    )};
    string                    Password                {xpath('Password'                    )};
    boolean                   EnableSNMP              {xpath('EnableSNMP'                  )};
  end;   
  
  export ProcessorInfo := 
  record
  
    string  Type  {xpath('Type'                 )};
    integer Load  {xpath('Load'                 )};  

  end;
  
  export StorageInfo := 
  record
  
    string  Description   {xpath('Description'          )};
    string  Type          {xpath('Type'                 )};
    integer  Available     {xpath('Available'            )};
    string  PercentAvail  {xpath('PercentAvail'         )};
    integer  Total         {xpath('Total'                )};
    integer Failures      {xpath('Failures'             )};

  end;
  
  export StorageInfos := {dataset(StorageInfo) StorageInfo {xpath('StorageInfo')}};
 
  export SWRunInfo := 
  record
  
    string  Name        {xpath('Name'                )};
    integer Instances   {xpath('Instances'           )};
    integer State       {xpath('State'               )};

  end;
  
  export ComponentInfo := 
  record
  
    integer  Condition  {xpath('Condition'            )};
    integer  State      {xpath('State'                )};
    string   UpTime     {xpath('UpTime'               )};

  end;
  
  export MachineInfoEx := 
  record
    string                  Address          {xpath('Address'                )}; 
    string                  ConfigAddress    {xpath('ConfigAddress'          )}; 
    string                  Name             {xpath('Name'                   )}; 
    string                  ProcessType      {xpath('ProcessType'            )}; 
    string                  DisplayType      {xpath('DisplayType'            )}; 
    string                  Description      {xpath('Description'            )}; 
    string                  AgentVersion     {xpath('AgentVersion'           )}; 
    string                  Contact          {xpath('Contact'                )}; 
    string                  Location         {xpath('Location'               )}; 
    string                  UpTime           {xpath('UpTime'                 )}; 
    string                  ComponentName    {xpath('ComponentName'          )}; 
    string                  ComponentPath    {xpath('ComponentPath'          )}; 
    integer                 OS               {xpath('OS'                     )}; 
    integer                 ProcessNumber    {xpath('ProcessNumber'          )}; 
    dataset(ProcessorInfo ) Processors       {xpath('Processors'             )};
    dataset(StorageInfos  ) Storage          {xpath('Storage'                )};
    dataset(SWRunInfo     ) Running          {xpath('Running'                )}; 
    // dataset(StorageInfo   ) PhysicalMemory   {xpath('PhysicalMemory'         )};
    // dataset(StorageInfo   ) VirtualMemory    {xpath('VirtualMemory'          )};  
    // dataset(ComponentInfo ) ComponentInfo    {xpath('ComponentInfo'          )};      

  end;
  
  export MachineInfoExs := {dataset(MachineInfoEx) MachineInfoEx {xpath('MachineInfoEx')}};

  export TargetClusterInfo := 
  record
  
    string                  Name        {xpath('Name'                 )};
    string                  Type        {xpath('Type'                 )};
    dataset(MachineInfoExs)  Processes   {xpath('Processes'            )};

  end;
  
  export TargetClusterInfos := {dataset(TargetClusterInfo) TargetClusterInfo1 {xpath('TargetClusterInfo')}};
  
	export GetTargetClusterInfoResponse_Record :=      
	record	                                           
                                                     
		string                exception_code     {xpath('Exceptions/Exception/Code'    )};
		string                exception_source   {xpath('Exceptions/Exception/Source'  )};
		string                exception_audience {xpath('Exceptions/Exception/Audience')};
		string                exception_msg      {xpath('Exceptions/Exception/Message' )};

	  // dataset(EspStringArray    )  Columns                {xpath('Columns'              )};
	  // dataset(RequestInfoStruct )  RequestInfo            {xpath('RequestInfo'          )};
	  dataset(TargetClusterInfos )  TargetClusterInfoList  {xpath('TargetClusterInfoList')};
    string                       TimeStamp              {xpath('TimeStamp'            )};
	
  end;

  esp				:= pesp + ':8010';

  dsoap_results := SOAPCALL(
    'http://' + esp + '/ws_machine?ver_=1.52'
    ,'GetTargetClusterInfo'
    ,GetTargetClusterInfoRequest_Record
    ,dataset(GetTargetClusterInfoResponse_Record)
    ,xpath('GetTargetClusterInfoResponse')
    ,timeout(1200)  //max 20 minutes
  );
  
  export results :=  dsoap_results  : independent;
  export normtargetclusters := normalize(results,left.TargetClusterInfoList,transform(TargetClusterInfos,self := right));
  export normtargetcluster  := normalize(normtargetclusters,left.TargetClusterInfo1,transform(TargetClusterInfo,self := right));
  export normmachineinfo    := normalize(normtargetcluster,left.Processes,transform(MachineInfoExs,self := right));
  export normMachineInfoExs := normalize(normmachineinfo,left.MachineInfoEx,transform(MachineInfoEx,self := right));
  export normStorages       := normalize(normMachineInfoExs,left.Storage,transform({string address,string ProcessType,StorageInfos},self := right,self := left));
  export normStorage        := normalize(normStorages      ,left.StorageInfo,transform({string address,string ProcessType,StorageInfo},self := right,self := left));

  export dstorage_dedup := dedup(normStorage(ProcessType = 'ThorSlaveProcess',description = '/mnt/disk1'),address,description,all);

  export total_storage           := ut.FHumanReadableSpace(sum(dstorage_dedup,total    )/*in MB*/ * power(2.0,20));
  export total_available_storage := ut.FHumanReadableSpace(sum(dstorage_dedup,Available)/*in MB*/ * power(2.0,20));
  export total_storage_used      := ut.FHumanReadableSpace((sum(dstorage_dedup,total    ) - sum(dstorage_dedup,Available))/*in MB*/ * power(2.0,20));

/*
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
  */
end;
