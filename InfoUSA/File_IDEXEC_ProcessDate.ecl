Layout_Processdate := record
string8 processdate;
InfoUSA.Layout_IDEXEC_In;
end;

Layout_Processdate xform(InfoUSA.File_IDEXEC_In l) := Transform
self.processdate := '20050708';
self := l;
end;

export File_IDEXEC_ProcessDate := Project(InfoUSA.File_IDEXEC_In,xform(left)) ;