import arrestlogs;

ds := arrestlogs.file_TX_Montgomery_old;

arrestlogs.Layout_TX_Montgomery tMontgomery(ds input) := Transform

self.ID				:= input.ID;
self.Name			:= input.Name;
self.Sex			:= input.Sex;
self.Race			:= input.Race;
self.DOB			:= input.DOB;
self.Book_Dt		:= input.Book_Dt;
self.Book_Time		:= input.Book_Time;
self.Address		:= input.Address;
self.City_State_Zip := input.City_State_Zip;
self.Agency			:= input.Agency;
self.Warrant		:= input.Warrant;
self.Court			:= input.Court;
self.Charge			:= input.Charge;
self.Disp			:= input.Disp;
self.Disp_Dt		:= input.Disp_Dt;
self.Bond_Amt		:= input.Bond_Amt;
self.Alias			:= input.Alias;

end;

pMontgomery := project(ds,tMontgomery(left));

export file_reformat_TX_Montgomery := pMontgomery;