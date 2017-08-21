import ut;
export file_AL_Calhoun := module

export payload :=
dataset('~thor_data400::in::arrlog::al::calhoun',
	ArrestLogs.layout_AL_Calhoun.payload,csv(heading(1),terminator('\n'), separator(''), quote('')));

////////////////////////////////////////////////////////////////////////////////////////////	
parsedName := payload(stringlib.stringfindcount(unparsedRec,'|')= 5);
ArrestLogs.Layout_AL_Calhoun.unparsed_LFM_name trecs(parsedName L) := transform

Last_Name			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];
First_Name			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];
Middle_Name			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];

self.ID 			:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.Name			:= Last_Name +' '+ First_Name +' '+ Middle_Name;
self.Booking_Dt		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Charge_Descr	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',5)+75];
self := L;
end;

precs1 := project(parsedName, trecs(left));
////////////////////////////////////////////////////////////////////////////////////////////
unparsedName := payload(stringlib.stringfindcount(unparsedRec,'|')= 3);
ArrestLogs.Layout_AL_Calhoun.unparsed_LFM_name trecs2(unparsedName L) := transform

self.ID 			:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.Name			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];
self.Booking_Dt		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];
self.Charge_Descr	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',3)+75];
self := L;
end;

precs2 := project(unparsedName, trecs2(left));

export cmbnd := precs1+
precs2;

end;