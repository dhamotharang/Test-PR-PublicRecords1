import ut;
export file_WA_Clark := module

export payload :=
dataset('~thor_data400::in::arrlog::wa::clark',
	ArrestLogs.layout_WA_Clark.payload,csv(heading(1),terminator('\n'), separator(''), quote('')));

////////////////////////////////////////////////////////////////////////////////////////////	
parsedName := payload(stringlib.stringfindcount(unparsedRec,'|')= 9);
ArrestLogs.Layout_WA_Clark.parsed_LFM_name trecs(parsedName L) := transform



self.ID 			:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.LastName		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];
self.FirstName		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];
self.MiddleName		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];
self.Suffix		    := L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.FullName		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Book_Date		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Cell			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Release_Date	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Charge			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',9)+75];
self := L;
end;

precs1 := project(parsedName, trecs(left));
////////////////////////////////////////////////////////////////////////////////////////////
unparsedName := payload(stringlib.stringfindcount(unparsedRec,'|')= 4);
ArrestLogs.Layout_WA_Clark.parsed_LFM_name trecs2(unparsedName L) := transform

self.ID 			:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.FullName		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];
self.Book_Date		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];
self.Cell			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];
self.Release_Date	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',4)+10];
self := L;
self := [];
end;

precs2 := project(unparsedName, trecs2(left));

export cmbnd := precs1+
precs2;

end;