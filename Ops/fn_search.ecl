import ut,STD;
EXPORT fn_search(string lClusterFilter='thor400_30') := function

lCount          :=  1000;

FsLogicalSuperSubRecordBig := record
   string supername{maxlength(4096)};
   string subname{maxlength(4096)};
end;

MyFileServices := SERVICE
  dataset(FsLogicalSuperSubRecordBig) LogicalFileSuperSubListBig() :  library='plugins/libfileservices', c,context,entrypoint='fsLogicalFileSuperSubList';
END;

dSuperSubList     :=  MyFileServices.LogicalFileSuperSubListBig();
dLogicalFileList  :=  FileServices.LogicalFileList(unknownszero := true) (cluster = lClusterFilter);

dNotInSuper       :=  join(dLogicalFileList, dSuperSubList,
                           left.Name = right.SubName,
                           left only
                          );

s:=choosen(
							sort(dNotInSuper(
																	(
																	ut.DaysApart(ut.GetDate,regexreplace('-',modified[1..10],''))>75
																	and ~regexfind('::in::',name)
																	and ~regexfind('prte',name)
																	and ~regexfind('nac::',name)
																	)
																	or
																	(
																	ut.DaysApart(ut.GetDate,regexreplace('-',modified[1..10],''))>30
																	and regexfind('::keydiff::',name)
																	)
															)
												, -Size)
											, lCount)
											// :persist('~'+lClusterFilter+'::persist::top1000',cluster(lClusterFilter))
											;

d1:=join(s,_Constants(lClusterFilter).dname,StringLib.StringToLowerCase(left.owner)=StringLib.StringToLowerCase(right.owner),lookup,left outer);
d2:=table(d1,{d1,spaceUsed:=sum(group,(unsigned8)size)},email,few);
d:=join(d1,d2,StringLib.StringToLowerCase(left.owner)=StringLib.StringToLowerCase(right.owner),lookup,left outer);
rcmd:={string email{maxlength(512000)}, string spaceUsed{maxlength(255)}, string cmd{maxlength(512000)}};

rcmd tr(d l) := transform
fp:=length(trim((string)l.spaceUsed));
peta:=l.spaceUsed[fp-17..fp-15];
tril:=l.spaceUsed[fp-14..fp-12];
bil:=l.spaceUsed[fp-11..fp-9];
mil:=l.spaceUsed[fp-8..fp-6];
thou:=l.spaceUsed[fp-5..fp-3];
hnd:=l.spaceUsed[fp-2..fp];

self.cmd:='fileservices.deletelogicalfile(\'~'+l.name+'\');//size='+l.size+' rowcount='+l.rowcount+' modified='+l.modified;
self.spaceUsed:=map(
		 length(trim((string)l.spaceUsed))>15 => peta+','+tril+','+bil+','+mil+','+thou+','+hnd
		,length(trim((string)l.spaceUsed))>12 =>          tril+','+bil+','+mil+','+thou+','+hnd
		,length(trim((string)l.spaceUsed))>9  =>                   bil+','+mil+','+thou+','+hnd
		,length(trim((string)l.spaceUsed))>6  =>                           mil+','+thou+','+hnd
		,length(trim((string)l.spaceUsed))>3  =>                                   thou+','+hnd
		,                                        													                  hnd
		);
self.email:=trim(l.email)+_Constants().ccList;
self:=l;
end;

p:=project(d,tr(left));

r:=rollup(sort(p,email)
						,transform(rcmd
								,self.cmd:=trim(left.cmd)+'\n'+trim(right.cmd)
								,self:=right
								),email);

return r;
end;