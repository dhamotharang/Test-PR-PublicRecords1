import ut;
export file_CA_Kings:= module


export payload :=
	dataset('~thor_data400::in::arrlog::ca::kings',
		ArrestLogs.Layout_CA_Kings.payload,csv(heading(1),terminator('\n'), separator(''), quote('')));

/////////////////////////////////////////////////////////////////////////////////////////////////////////
input1 := payload(stringlib.stringfindcount(unparsedRec,'|')= 28);
ArrestLogs.Layout_CA_Kings.combined_layout trecs(input1 L) := transform


self.ID					:=	L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.Book_Dt			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];		
self.Book_Time			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];		
self.Inmate_ID			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];		
self.Arrest_Dt			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];		
self.Arrest_Time		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];			
self.Arrest_Location	:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];			
self.Release_Dt			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];			
self.Release_Time		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];			
self.Jail_Facility		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];			
self.Arresting_Agency	:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];			
self.StateID			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];		
self.Name				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];	
self.DOB				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];	
self.Sex				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];	
self.Resident_City		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];			
self.Resident_State		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',17)-1];			
self.Race				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',17)+1..stringlib.stringfind(L.unparsedRec,'|',18)-1];	
self.Height				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',18)+1..stringlib.stringfind(L.unparsedRec,'|',19)-1];	
self.Weight				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',19)+1..stringlib.stringfind(L.unparsedRec,'|',20)-1];	
self.Hair				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',20)+1..stringlib.stringfind(L.unparsedRec,'|',21)-1];	
self.Eyes				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',21)+1..stringlib.stringfind(L.unparsedRec,'|',22)-1];	
self.Occupation			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',22)+1..stringlib.stringfind(L.unparsedRec,'|',23)-1];		
self.Book_Num			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',23)+1..stringlib.stringfind(L.unparsedRec,'|',24)-1];		
self.Code_Book_ID		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',24)+1..stringlib.stringfind(L.unparsedRec,'|',25)-1];			
self.Code_Num			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',25)+1..stringlib.stringfind(L.unparsedRec,'|',26)-1];		
self.Alpha_Charge_Desc	:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',26)+1..stringlib.stringfind(L.unparsedRec,'|',27)-1];			
self.Crime_Type	   		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',27)+1..stringlib.stringfind(L.unparsedRec,'|',28)-1];			
self.Bail_Amount		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',28)+1..stringlib.stringfind(L.unparsedRec,'|',28)+20];				

self := L;
self := []; //this layout has no birth city nor birth state
end;

precs1 := project(input1 (regexfind('[0-9]',unparsedRec)), trecs(left));

/////////////////////////////////////////////////////////////////////////////////////////////////////////

input2 := payload(stringlib.stringfindcount(unparsedRec,'|')= 27);
ArrestLogs.Layout_CA_Kings.combined_layout trecs1(input2 L) := transform


self.ID					:=	L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.Book_Dt			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];		
self.Book_Time			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];		
self.Inmate_ID			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];		
self.Arrest_Dt			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];		
self.Arrest_Time		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];			
self.Arrest_Location	:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];			
self.Release_Dt			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];			
self.Release_Time		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];			
self.Jail_Facility		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];			
self.Arresting_Agency	:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];			
self.Name				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];	
self.DOB				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];	
self.Sex				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];	
self.Resident_City		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];			
self.Resident_State		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];			
self.Race				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',17)-1];	
self.Height				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',17)+1..stringlib.stringfind(L.unparsedRec,'|',18)-1];	
self.Weight				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',18)+1..stringlib.stringfind(L.unparsedRec,'|',19)-1];	
self.Hair				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',19)+1..stringlib.stringfind(L.unparsedRec,'|',20)-1];	
self.Eyes				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',20)+1..stringlib.stringfind(L.unparsedRec,'|',21)-1];	
self.Occupation			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',21)+1..stringlib.stringfind(L.unparsedRec,'|',22)-1];		
self.Book_Num			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',22)+1..stringlib.stringfind(L.unparsedRec,'|',23)-1];		
self.Code_Book_ID		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',23)+1..stringlib.stringfind(L.unparsedRec,'|',24)-1];			
self.Code_Num			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',24)+1..stringlib.stringfind(L.unparsedRec,'|',25)-1];		
self.Alpha_Charge_Desc	:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',25)+1..stringlib.stringfind(L.unparsedRec,'|',26)-1];			
self.Crime_Type	   		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',26)+1..stringlib.stringfind(L.unparsedRec,'|',27)-1];			
self.Bail_Amount		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',27)+1..stringlib.stringfind(L.unparsedRec,'|',27)+20];				

self := L;
self := []; //this layout has no stateID, birth city, nor birt state
end;

precs2 := project(input2 (regexfind('[0-9]',unparsedRec)), trecs1(left));
/////////////////////////////////////////////////////////////////////////////////////////////////////////

input3 := payload(stringlib.stringfindcount(unparsedRec,'|')= 30);
ArrestLogs.Layout_CA_Kings.combined_layout trecs2(input3 L) := transform

self.ID					:=	L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.Book_Dt			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];
self.Book_Time			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];
self.Inmate_ID			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];
self.Arrest_Dt			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Arrest_Time		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Arrest_Location	:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Release_Dt			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Release_Time		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Jail_Facility		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Arresting_Agency	:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.StateID			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Name				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.DOB				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Sex				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.Birth_City			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];
self.Birth_State		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',17)-1];
self.Resident_City		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',17)+1..stringlib.stringfind(L.unparsedRec,'|',18)-1];
self.Resident_State		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',18)+1..stringlib.stringfind(L.unparsedRec,'|',19)-1];
self.Race				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',19)+1..stringlib.stringfind(L.unparsedRec,'|',20)-1];
self.Height				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',20)+1..stringlib.stringfind(L.unparsedRec,'|',21)-1];
self.Weight				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',21)+1..stringlib.stringfind(L.unparsedRec,'|',22)-1];
self.Hair				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',22)+1..stringlib.stringfind(L.unparsedRec,'|',23)-1];
self.Eyes				:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',23)+1..stringlib.stringfind(L.unparsedRec,'|',24)-1];
self.Occupation			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',24)+1..stringlib.stringfind(L.unparsedRec,'|',25)-1];
self.Book_Num			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',25)+1..stringlib.stringfind(L.unparsedRec,'|',26)-1];
self.Code_Book_ID		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',26)+1..stringlib.stringfind(L.unparsedRec,'|',27)-1];
self.Code_Num			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',27)+1..stringlib.stringfind(L.unparsedRec,'|',28)-1];
self.Alpha_Charge_Desc	:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',28)+1..stringlib.stringfind(L.unparsedRec,'|',29)-1];
self.Crime_Type			:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',29)+1..stringlib.stringfind(L.unparsedRec,'|',30)-1];
self.Bail_Amount		:=	L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',30)+1..stringlib.stringfind(L.unparsedRec,'|',30)+20];

self := L;

end;

precs3 := project(input3(regexfind('[0-9]',unparsedRec)), trecs2(left));


export cmbnd := precs1+precs2+precs3;

end;