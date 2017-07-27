import header;

LN_TU.Layout_In_Header_UID_SRC ReformatOutHeaderAll(LN_TU.File_In_Header_All L,integer c) := Transform
self.src := 'LT';
self.uid := if(c=1,thorlib.node()+1,thorlib.node()+1+c*thorlib.nodes());
self.orig_date_reported_mmddccyy := (L.orig_date_reported_mmddccyy[5..8]+L.orig_date_reported_mmddccyy[1..2]+ '  ');
self := L;
end;

export File_In_Header_UID_SRC := Project(LN_TU.File_In_Header_All,ReformatOutHeaderAll(Left,counter),local);;

//output(File_In_Header_UID_SRC)
   

