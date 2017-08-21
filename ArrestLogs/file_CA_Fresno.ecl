import ut, lib_date;

export file_CA_Fresno := module

export payload :=	dataset(ut.foreign_prod + '~thor_data400::in::arrlog::ca::fresno',	
						ArrestLogs.layout_CA_Fresno.payload,csv(heading(0),terminator('\n'), separator(''), quote('')));


////////////////////////////////////////////////////////////////////////////////////////////	
lf_Bail_Out := payload(stringlib.stringfindcount(unparsedRec,'|')= 26);
ArrestLogs.Layout_CA_Fresno.lfield_remove_date trecs(lf_Bail_Out L) := transform

self.ID 				:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.Book_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];
self.Name				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];
self.DOB				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];
self.Sex				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Race				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Hair				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Eyes				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Height				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Weight				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Age				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Arrest_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Arrest_Time		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Arrest_Agency		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Book_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.Book_Time			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];
self.Housing_Facility	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',17)-1];
self.Floor				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',17)+1..stringlib.stringfind(L.unparsedRec,'|',18)-1];
self.Cell				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',18)+1..stringlib.stringfind(L.unparsedRec,'|',19)-1];
self.Charges			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',19)+1..stringlib.stringfind(L.unparsedRec,'|',20)-1];
self.Description		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',20)+1..stringlib.stringfind(L.unparsedRec,'|',21)-1];
self.Bail_Amount		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',21)+1..stringlib.stringfind(L.unparsedRec,'|',22)-1];
self.Holding_Agency		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',22)+1..stringlib.stringfind(L.unparsedRec,'|',23)-1];
self.Case_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',23)+1..stringlib.stringfind(L.unparsedRec,'|',24)-1];
self.Level				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',24)+1..stringlib.stringfind(L.unparsedRec,'|',25)-1];
self.Court				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',25)+1..stringlib.stringfind(L.unparsedRec,'|',26)-1];
self.Bail_Out			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',26)+1..stringlib.stringfind(L.unparsedRec,'|',26)+50];

self := L;
self := [];
end;

precs1 := project(lf_Bail_Out(regexfind('[0-9]',unparsedRec)), trecs(left));
////////////////////////////////////////////////////////////////////////////////////////////
lf_Release_Date := payload(stringlib.stringfindcount(unparsedRec,'|')= 29);
ArrestLogs.Layout_CA_Fresno.lfield_remove_date trecs2(lf_Release_Date L) := transform

self.ID 				:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.Book_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];
self.Name				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];
self.DOB				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];
self.Sex				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Race				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Hair				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Eyes				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Height				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Weight				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Age				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Arrest_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.Arrest_Time		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Arrest_Agency		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.Book_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.Book_Time			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];
self.Housing_Facility	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',17)-1];
self.Floor				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',17)+1..stringlib.stringfind(L.unparsedRec,'|',18)-1];
self.Cell				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',18)+1..stringlib.stringfind(L.unparsedRec,'|',19)-1];
self.Charges			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',19)+1..stringlib.stringfind(L.unparsedRec,'|',20)-1];
self.Description		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',20)+1..stringlib.stringfind(L.unparsedRec,'|',21)-1];
self.Bail_Amount		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',21)+1..stringlib.stringfind(L.unparsedRec,'|',22)-1];
self.Holding_Agency		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',22)+1..stringlib.stringfind(L.unparsedRec,'|',23)-1];
self.Case_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',23)+1..stringlib.stringfind(L.unparsedRec,'|',24)-1];
self.Level				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',24)+1..stringlib.stringfind(L.unparsedRec,'|',25)-1];
self.Court				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',25)+1..stringlib.stringfind(L.unparsedRec,'|',26)-1];
self.Bail_Out			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',26)+1..stringlib.stringfind(L.unparsedRec,'|',27)-1];			
self.Sentence_Date		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',27)+1..stringlib.stringfind(L.unparsedRec,'|',28)-1]; 
self.Sentence_Days		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',28)+1..stringlib.stringfind(L.unparsedRec,'|',29)-1]; 
self.Release_Date		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',29)+1..stringlib.stringfind(L.unparsedRec,'|',29)+10];
 
self := L;
self := [];
end;

precs2 := project(lf_Release_Date(regexfind('[0-9]',unparsedRec)), trecs2(left));

////////////////////////////////////////////////////////////////////////////////////////////
lf_Remove_Date := payload(stringlib.stringfindcount(unparsedRec,'|')= 32);
ArrestLogs.Layout_CA_Fresno.lfield_remove_date trecs3(lf_Remove_Date L) := transform

self.ID 				:= L.unparsedRec[1..stringlib.stringfind(L.unparsedRec,'|',1)-1];
self.Book_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',1)+1..stringlib.stringfind(L.unparsedRec,'|',2)-1];
self.Name				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',2)+1..stringlib.stringfind(L.unparsedRec,'|',3)-1];
self.DOB				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',3)+1..stringlib.stringfind(L.unparsedRec,'|',4)-1];
self.Sex				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',4)+1..stringlib.stringfind(L.unparsedRec,'|',5)-1];
self.Race				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',5)+1..stringlib.stringfind(L.unparsedRec,'|',6)-1];
self.Age				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',6)+1..stringlib.stringfind(L.unparsedRec,'|',7)-1];
self.Hair				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',7)+1..stringlib.stringfind(L.unparsedRec,'|',8)-1];
self.Eyes				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',8)+1..stringlib.stringfind(L.unparsedRec,'|',9)-1];
self.Height				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',9)+1..stringlib.stringfind(L.unparsedRec,'|',10)-1];
self.Weight				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',10)+1..stringlib.stringfind(L.unparsedRec,'|',11)-1];
self.Arrest_Dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',11)+1..stringlib.stringfind(L.unparsedRec,'|',12)-1];
self.book_dt			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',12)+1..stringlib.stringfind(L.unparsedRec,'|',13)-1];
self.Arrest_Agency		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',13)+1..stringlib.stringfind(L.unparsedRec,'|',14)-1];
self.arrest_time		:= '';//L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',14)+1..stringlib.stringfind(L.unparsedRec,'|',15)-1];
self.book_time			:= '';//L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',15)+1..stringlib.stringfind(L.unparsedRec,'|',16)-1];
self.Housing_Facility	:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',16)+1..stringlib.stringfind(L.unparsedRec,'|',17)-1];
self.Floor				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',17)+1..stringlib.stringfind(L.unparsedRec,'|',18)-1];
self.Cell				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',18)+1..stringlib.stringfind(L.unparsedRec,'|',19)-1];
self.Charges			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',19)+1..stringlib.stringfind(L.unparsedRec,'|',20)-1];
self.Description		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',20)+1..stringlib.stringfind(L.unparsedRec,'|',21)-1];
self.Bail_Amount		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',21)+1..stringlib.stringfind(L.unparsedRec,'|',22)-1];
self.Holding_Agency		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',22)+1..stringlib.stringfind(L.unparsedRec,'|',23)-1];
self.Case_Num			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',23)+1..stringlib.stringfind(L.unparsedRec,'|',24)-1];
self.Level				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',24)+1..stringlib.stringfind(L.unparsedRec,'|',25)-1];
self.Court				:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',25)+1..stringlib.stringfind(L.unparsedRec,'|',26)-1];
self.Bail_Out			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',26)+1..stringlib.stringfind(L.unparsedRec,'|',27)-1];			
self.Sentence_Date		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',27)+1..stringlib.stringfind(L.unparsedRec,'|',28)-1]; 
self.Sentence_Days		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',28)+1..stringlib.stringfind(L.unparsedRec,'|',29)-1]; 
self.Release_Date		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',29)+1..stringlib.stringfind(L.unparsedRec,'|',30)-1]; 
self.Hold_Type			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',30)+1..stringlib.stringfind(L.unparsedRec,'|',31)-1];  
self.Start_Date			:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',31)+1..stringlib.stringfind(L.unparsedRec,'|',32)-1]; 
self.Remove_Date		:= L.unparsedRec[stringlib.stringfind(L.unparsedRec,'|',32)+1..stringlib.stringfind(L.unparsedRec,'|',32)+10];

self := L;
end;

precs3 := project(lf_Remove_Date(regexfind('[0-9]',unparsedRec)), trecs3(left));

export cmbnd := precs1+precs2+precs3;

end;	
	