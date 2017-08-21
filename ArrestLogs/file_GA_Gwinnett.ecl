import ut;
export file_GA_Gwinnett:= module


d := dataset('~thor_data400::in::arrlog::ga::gwinnett'
				,ArrestLogs.Layout_GA_Gwinnett.payload
				,csv(heading(1),terminator('\n'), separator(''), quote('')));
				
export payload := d(regexfind('Cleared',unparsedrec,NOCASE)=false);

////////////////////////////////////////////////////////////////////////////////////////////	
input1 := payload(stringlib.stringfindcount(unparsedRec,'|')= 14);
ArrestLogs.Layout_GA_Gwinnett.layout1 trecs(input1 L) := transform
self.ID        				:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];						
self.Last_Name	   			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];						
self.First_Name				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];						
self.Middle_Name			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];						
self.Birth_Dt				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Unit					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Photo					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Booking_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Warrant_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Code_Section			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Statute				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Fel_Misd_Traffic_Hold	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Descr					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Bond					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Bond_Type				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',14)+50];

self := L;
self := [];
end;

precs1 := project(input1(regexfind('[0-9]',unparsedRec)), trecs(left));

////////////////////////////////////////////////////////////////////////////////////////////
input2 := payload(stringlib.stringfindcount(unparsedRec,'|')= 15 and 
				  regexfind('[a-zA-Z]',unparsedRec[stringlib.stringfind(unparsedRec,'|',4)+1..stringlib.stringfind(unparsedRec,'|',5)-1])=false) ;

ArrestLogs.Layout_GA_Gwinnett.layout1 trecs2(input2 L) := transform

self.ID        				:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];							
self.Last_Name	   			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];							
self.First_Name				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];						
self.Middle_Name			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];					
self.Birth_Dt				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Unit					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Photo					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Booking_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Warrant_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Code_Section			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Statute				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Fel_Misd_Traffic_Hold	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Descr					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Bond					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Bond_Type				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.Order_Status			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',15)+50];

self := L;
self := [];
end;

precs2 := project(input2(regexfind('[0-9]',unparsedRec)), trecs2(left));

////////////////////////////////////////////////////////////////////////////////////////////
input3 := payload(stringlib.stringfindcount(unparsedRec,'|')= 15 and 
				  regexfind('[a-zA-Z]',unparsedRec[stringlib.stringfind(unparsedRec,'|',4)+1..stringlib.stringfind(unparsedRec,'|',5)-1])) ;

ArrestLogs.Layout_GA_Gwinnett.layout1 trecs3(input3 L) := transform

self.ID        				:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];							
self.Last_Name	   			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];							
self.First_Name				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];						
self.Middle_Name			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];					
self.Unit					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Photo					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Booking_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Warrant_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Code_Section			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Statute				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Fel_Misd_Traffic_Hold	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Descr					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Bond					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Bond_Type				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Order_Status			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];		
self.OTN					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',15)+50];

self := L;
self := [];
end;

precs3 := project(input3(regexfind('[0-9]',unparsedRec)), trecs3(left));

////////////////////////////////////////////////////////////////////////////////////////////
input4 := payload(stringlib.stringfindcount(unparsedRec,'|')= 16);
ArrestLogs.Layout_GA_Gwinnett.layout1 trecs4(input4 L) := transform

self.ID        				:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];						
self.Last_Name	   			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];						
self.First_Name				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];						
self.Middle_Name			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];						
self.Birth_Dt				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Unit					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Photo					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Booking_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Warrant_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Code_Section			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Statute				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Fel_Misd_Traffic_Hold	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Descr					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Bond					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Bond_Type				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.Order_Status			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];
self.OTN					:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',16)+50];


self := L;
end;

precs4:= project(input4(regexfind('[0-9]',unparsedRec)), trecs4(left));

export cmbnd := precs1+precs2+precs3+precs4;

end;