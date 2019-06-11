import ut,std;
EXPORT GetFileParts(

   string pfilename  = ''
  ,string pcluster   = ''
  ,string pesp       = _Config.LocalEsp
  
) :=
function

	DFUFileParts_lay :=
	record
		integer  Id         {xpath('Id'           )} ;
		integer  Copy       {xpath('Copy'         )} ;
		string   ActualSize {xpath('ActualSize'   )} ;
		string   Ip         {xpath('Ip'           )} ;
		string   Partsize   {xpath('Partsize'     )} ;
	end;

  ds_dfuinfo := WsDFU.soapcall_DFUInfo(pfilename ,pcluster ,,,pesp);

  norm_lay := {string name,string owner,string Cluster,string MinSkew, string MaxSkew,DFUFileParts_lay,unsigned PartSize_int,string PartSize_};
  
  Parts  := normalize(ds_dfuinfo,left.DFUFileParts(Copy = 1),transform(norm_lay,self := right,self := left
  ,self.PartSize_int := (unsigned)std.str.filterout(right.PartSize,',')
  ,self.PartSize_ := ut.FHumanReadableSpace(self.PartSize_int)));

  avg     := (real8)(sum(Parts,(real8)PartSize_int) / count(Parts));
  minpart := min(Parts,PartSize_int);
  maxpart := max(Parts,PartSize_int);
  
  Parts_Lay := {norm_lay,real8 avg_part_size,string avg_part_size_,real8 diff_avg,string diff_avg_,real8 skew_,unsigned min_part_size,unsigned above_the_min,string min_part_size_,string above_the_min_};
  
  return project(Parts  ,transform(Parts_Lay
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