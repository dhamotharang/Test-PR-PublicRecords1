d := Fictitious_Business_Names.File_Out_AllFlat;

layout_stats := record
string6 flag;
recordof(Fictitious_Business_Names.File_Out_AllFlat) ;
end;

layout_stats tf_re(d l) := Transform
self.flag := if(StringLib.StringFind(l.cct_firstname,'&',1)=0,'true','false');
self := l;
end;

file_out := Project(d,tf_re(left));

output(file_out(flag='false'));