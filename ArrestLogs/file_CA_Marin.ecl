import ut;
export file_CA_Marin:= module

export payload :=
	dataset('~thor_data400::in::arrlog::ca::marin',
ArrestLogs.Layout_CA_Marin.payload,csv(heading(1),terminator('\n'), separator(''), quote('')));

////////////////////////////////////////////////////////////////////////////////////////////	
input1 := payload(stringlib.stringfindcount(unparsedRec,'|')= 16);
ArrestLogs.Layout_CA_Marin.combined_layout trecs(input1 L) := transform
self.ID        		:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];						
self.Name	   		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];						
self.Book_Dt		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];						
self.Address		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];						
self.Arrest_Dt		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Sex			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Arrest_Agency	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Age			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Charge_Num		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Charge_Desc	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Code			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Bond			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Court_Dt		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Court_Time		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Room			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.Case_num		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];
self.Case_Type		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',16)+50];

self := L;
self := [];
end;

precs1 := project(input1(regexfind('[0-9]',unparsedRec)), trecs(left));
////////////////////////////////////////////////////////////////////////////////////////////
input2 := payload(stringlib.stringfindcount(unparsedRec,'|')= 23);
ArrestLogs.Layout_CA_Marin.combined_layout trecs2(input2 L) := transform

self.ID	 				:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];							
self.Name				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];							
self.Book_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];							
self.Address			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];							
self.Latest_Charge_Dt	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Sex				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Arrest_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.DOB				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Arrest_Agency		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Occupation			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Arrest_Location	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Height				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Hair				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Weight				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Eyes				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.Charge_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];
self.Charge_Desc		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',17)-1];
self.Code				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',17)+1..stringlib.stringfind(L.unparsedRec,'|',18)-1];
self.Bond				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',18)+1..stringlib.stringfind(L.unparsedRec,'|',19)-1];
self.Court_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',19)+1..stringlib.stringfind(L.unparsedRec,'|',20)-1];
self.Court_Time			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',20)+1..stringlib.stringfind(L.unparsedRec,'|',21)-1];
self.Room				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',21)+1..stringlib.stringfind(L.unparsedRec,'|',22)-1];
self.Case_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',22)+1..stringlib.stringfind(L.unparsedRec,'|',23)-1];
self.Case_Type			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',23)+1..stringlib.stringfind(L.unparsedRec,'|',23)+50];


self := L;
self := [];
end;

precs2 := project(input2(regexfind('[0-9]',unparsedRec)), trecs2(left));

input3 := payload(stringlib.stringfindcount(unparsedRec,'|')= 24);
ArrestLogs.Layout_CA_Marin.combined_layout trecs3(input3 L) := transform

self.ID	 				:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];							
self.Name				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];							
self.Book_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];							
self.Address			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];							
self.Latest_Charge_Dt	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Sex				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Arrest_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.DOB				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Arrest_Agency		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Occupation			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Arrest_Location	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Height				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Hair				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Weight				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Eyes				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.Charge_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];
self.Charge_Desc		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',17)-1];
self.Code				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',17)+1..stringlib.stringfind(L.unparsedRec,'|',18)-1];
self.Bond				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',18)+1..stringlib.stringfind(L.unparsedRec,'|',19)-1];
self.Court_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',19)+1..stringlib.stringfind(L.unparsedRec,'|',20)-1];
self.Court_Time			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',20)+1..stringlib.stringfind(L.unparsedRec,'|',21)-1];
self.Room				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',21)+1..stringlib.stringfind(L.unparsedRec,'|',22)-1];
self.Case_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',22)+1..stringlib.stringfind(L.unparsedRec,'|',23)-1];
self.filler             := L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',23)+1..stringlib.stringfind(L.unparsedRec,'|',24)-1];
self.Case_Type			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',24)+1..stringlib.stringfind(L.unparsedRec,'|',24)+50];


self := L;
self := [];
end;

precs3 := project(input3(regexfind('[0-9]',unparsedRec)), trecs3(left));


/////////////////////////////////////////////////////////////////////////

input4 := payload(stringlib.stringfindcount(unparsedRec,'|')= 17);
ArrestLogs.Layout_CA_Marin.combined_layout trecs4(input4 L) := transform

self.ID        		:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];						
self.Name	   		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];						
self.Book_Dt		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];						
self.Address		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];						
self.Arrest_Dt		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Sex			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Arrest_Agency	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Age			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Charge_Num		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Charge_Desc	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Code			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Bond			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Court_Dt		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Court_Time		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Room			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.Case_num		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];
self.filler		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',17)-1];
self.Case_Type		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',17)+1..stringlib.stringfind(L.unparsedRec,'|',17)+50];


self := L;
self := [];
end;

precs4 := project(input4(regexfind('[0-9]',unparsedRec)), trecs4(left));


export cmbnd := precs1+precs2+precs3+precs4;

end;