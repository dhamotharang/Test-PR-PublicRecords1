EXPORT fn_prep_input(string st,string version,string ip,string rootDir,string fname) := function

f:=NAC.Files(st).temp;

seed:=if(nothor(Fileservices.GetSuperFileSubcount(Superfile_List().Base))>0,max(Files().Base,PrepRecSeq),1);
MAC_Sequence_Records(f,PrepRecSeq,f1,seed);

NAC.Layouts.Input_Prepped tr(f1 l) := transform

	self.FileName := fname;
	sub:=stringlib.stringfind(l.fname,'20',1);
	self.ProcessDate := (unsigned)Version;
	self.NCF_FileDate := (unsigned)l.fname[sub..sub+7];
	self:=l;

end;


return project(f1,tr(left))

end;