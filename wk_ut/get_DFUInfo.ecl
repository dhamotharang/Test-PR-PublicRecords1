/*2014-11-22T03:17:30Z (vern_p bentley)
check-in for S23
*/
import _control,std,ut;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_DFUInfo(string filename = '',string cluster = '',string pesp = _constants.LocalEsp) :=
module

	export DFUInfoRequest :=
	record, maxlength(100)
		string  Name              {xpath('Name'               )} := filename;
		string  Cluster           {xpath('Cluster'            )} := cluster;
		string  UpdateDescription {xpath('UpdateDescription'  )} := '0';
		string  FileName          {xpath('FileName'           )} := '';
		string  FileDesc          {xpath('FileDesc'           )} := '';
	end;
	
	export DFUFileParts_lay :=
	record
		integer  Id         {xpath('Id'           )} ;
		integer  Copy       {xpath('Copy'         )} ;
		string   ActualSize {xpath('ActualSize'   )} ;
		string   Ip         {xpath('Ip'           )} ;
		string   Partsize   {xpath('Partsize'     )} ;
	end;

	export DFUInfoOutRecord :=
	record, maxlength(100000)
	
		string exception_code     {xpath('Exceptions/Exception/Code'   )};
		string exception_source   {xpath('Exceptions/Exception/Source' )};
		string exception_msg      {xpath('Exceptions/Exception/Message')};
		string Name               {xpath('FileDetail/Name'             )};
		string Filename           {xpath('FileDetail/Filename'         )};
		string Description        {xpath('FileDetail/Description'      )};
		string Dir                {xpath('FileDetail/Dir'              )};
		string PathMask           {xpath('FileDetail/PathMask'         )};
		string Filesize           {xpath('FileDetail/Filesize'         )};
		string ActualSize         {xpath('FileDetail/ActualSize'       )};
		string RecordSize         {xpath('FileDetail/RecordSize'       )};
		string RecordCount        {xpath('FileDetail/RecordCount'      )};
		string Wuid               {xpath('FileDetail/Wuid'             )};
		string Owner              {xpath('FileDetail/Owner'            )};
		string Cluster            {xpath('FileDetail/Cluster'          )};
		string JobName            {xpath('FileDetail/JobName'          )};
		string Persistent         {xpath('FileDetail/Persistent'       )};
		string Format             {xpath('FileDetail/Format'           )};
		string MaxRecordSize      {xpath('FileDetail/MaxRecordSize'    )};
		string CsvSeparate        {xpath('FileDetail/CsvSeparate'      )};
		string CsvQuote           {xpath('FileDetail/CsvQuote'         )};
		string CsvTerminate       {xpath('FileDetail/CsvTerminate'     )};
		string CsvEscape          {xpath('FileDetail/CsvEscape'        )};
		string Modified           {xpath('FileDetail/Modified'         )};
		string Ecl                {xpath('FileDetail/Ecl'              )};	
		string MinSkew                {xpath('FileDetail/Stat/MinSkew'              )};	
		string MaxSkew                {xpath('FileDetail/Stat/MaxSkew'              )};	
    integer CompressedFileSize      {xpath('FileDetail/CompressedFileSize'     )};
    boolean IsCompressed            {xpath('FileDetail/IsCompressed'           )};
    dataset(DFUFileParts_lay) DFUFileParts  {xpath('FileDetail/DFUFilePartsOnClusters/DFUFilePartsOnCluster/DFUFileParts/DFUPart')}
  
	end;

	export DFUInfo := 
	function
	
		esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'

		results := SOAPCALL(
			'http://' + esp + '/WsDfu?ver_=1.48'
			,'DFUInfo'
			,DFUInfoRequest
			,dataset(DFUInfoOutRecord)
			,xpath('DFUInfoResponse')
		);
    
		return results;
		
	end;
  
  export layout := DFUInfo()[1].Ecl;
  export wuid   := DFUInfo()[1].wuid;

  export norm_lay := {string name,string owner,string Cluster,string MinSkew, string MaxSkew,DFUFileParts_lay,unsigned PartSize_int,string PartSize_};
  
  export Parts  := normalize(DFUInfo(),left.DFUFileParts(Copy = 1),transform(norm_lay,self := right,self := left
  ,self.PartSize_int := (unsigned)std.str.filterout(right.PartSize,',')
  ,self.PartSize_ := ut.FHumanReadableSpace(self.PartSize_int)));
  
  export avg    := (real8)(sum(Parts,(real8)PartSize_int) / count(Parts));
  export minpart := min(Parts,PartSize_int);
  export maxpart := max(Parts,PartSize_int);
  
  export Parts_Lay := {norm_lay,real8 avg_part_size,string avg_part_size_,real8 diff_avg,string diff_avg_,real8 skew_,unsigned min_part_size,unsigned above_the_min,string min_part_size_,string above_the_min_};
  
  export Parts_ := project(Parts  ,transform(Parts_Lay
    ,self                 := left
    ,self.avg_part_size   := avg
    ,self.avg_part_size_  := ut.FHumanReadableSpace((unsigned)avg)
    ,self.diff_avg        := (real8)left.PartSize_int - avg;
    ,self.diff_avg_       := if(self.diff_avg > 0 ,ut.FHumanReadableSpace((unsigned)self.diff_avg)  ,'-' + ut.FHumanReadableSpace((unsigned)abs(self.diff_avg)));
    ,self.skew_           := (unsigned)left.PartSize_int / avg;
    ,self.min_part_size   := minpart; 
    ,self.above_the_min   := left.PartSize_int - minpart; 
    ,self.min_part_size_   := ut.FHumanReadableSpace(minpart); 
    ,self.above_the_min_   := ut.FHumanReadableSpace(self.above_the_min); 
  ));
  
end;