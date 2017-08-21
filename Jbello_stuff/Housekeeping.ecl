import lib_FileServices,ut;

export Housekeeping():=function

lClusterFilter  :=  'thor40';
lCount          :=  1000;

FsLogicalSuperSubRecordBig := record
   string supername{maxlength(4096)};
   string subname{maxlength(4096)};
end;

MyFileServices := SERVICE
  dataset(FsLogicalSuperSubRecordBig) LogicalFileSuperSubListBig() :  library='plugins/libfileservices', c,context,entrypoint='fsLogicalFileSuperSubList';
END;

dSuperSubList     :=  MyFileServices.LogicalFileSuperSubListBig();
dLogicalFileList  :=  lib_FileServices.FileServices.LogicalFileList(unknownszero := true);// (cluster = lClusterFilter);

dList				      :=  join(dLogicalFileList, dSuperSubList,
                           left.Name = right.SubName,
													 left outer
                          );

days:=0;
dt:=ut.date_math(ut.getDate,days);

l1:=dList(
					// regexreplace('-',modified[..10],'')<dt
					// and
					// ~regexfind('backup|intermediate|building|built',supername,nocase)
					// and
					// supername<>'thor400_data::base::composite_public_safety_data_delta_temp'
					// and
					// (
					regexfind('history$|delete$|::delete::',supername,nocase)
					// or
					// ~regexfind('2.*w',name,nocase)
					// or
					// supername=''
					// )
					);

s1:=output(count(l1),named('candidates_for_deletion_count'));
s2:=output(sum(l1,size),named('candidates_for_deletion_space'));
s3:=output(sort(l1,supername,modified),{supername,name,size,mod:=regexreplace('-',modified[1..10],''),owner},all);
r:= SEQUENTIAL(s1,s2,s3,
// NOTHOR(APPLY(l1,FileServices.RemoveSuperFile('~'+trim(supername),'~'+trim(name),true))),
// NOTHOR(APPLY(l1,FileServices.DeleteLogicalFile('~'+trim(name)))),
// NOTHOR(APPLY(l1,FileServices.RemoveOwnedSubFiles(name,true))),
NOTHOR(APPLY(l1,FileServices.clearsuperfile('~'+trim(name)))),
			);
// 1,315,160,218,017
return r;
end;