import Crim_Common, Address;

d1 		:= Crim.File_OH_Hardin_Old(Last_Name<>'');

Layout_OH_Hardin_Adj := record
string Defendant;
string Birth_Date;
string Sex;
string Race;
string Case_Number;
string Filed_Date;
string Section_Number;
string Description;
string Degree;
string Sentencing_Information;
string Sentencing_Date;
string Street;
string City_State_Zip;
end;

Layout_OH_Hardin_Adj tOHLayout1(d1 input) := Transform
self.Defendant					:=trim(input.last_name,left,right)+', '+trim(input.first_name,left,right);
self.Street						:='';
self.City_State_Zip				:='';
self							:= input;
end;

pOHLayout1 := project(d1, tOHLayout1(left));
//output(pOHLayout1);

d2 		:= Crim.File_OH_Hardin.File_OH_Hardin_200910;

Layout_OH_Hardin_Adj tOHLayout2(d2 input) := Transform
self.Defendant					:=input.Defendant;
self.Birth_Date					:=input.Birth_Date;
self.Sex						:='';
self.Race						:='';
self.Case_Number				:=input.Case_Number;
self.Filed_Date					:=input.Filed_Date;
self.Section_Number				:=input.Section_Number;
self.Description				:=input.Description;
self.Degree						:=input.Degree;
self.Sentencing_Information		:=input.Sentencing_Info;
self.Sentencing_Date			:=input.Sentencing_Date;
self.Street						:=input.Street;
self.City_State_Zip				:=input.City_State_Zip;
self							:= input;
end;

pOHLayout2 := project(d2, tOHLayout2(left));

d3 		:= Crim.File_OH_Hardin.File_OH_Hardin_Current;

Layout_OH_Hardin_Adj tOHLayout3(d3 input) := Transform
self.Defendant					:=input.Defendant;
self.Birth_Date					:=input.Birth_Date;
self.Sex						:='';
self.Race						:='';
self.Case_Number				:=input.Case_Number;
self.Filed_Date					:=input.Filed_Date;
self.Section_Number				:=input.Section_Number;
self.Description				:=input.Description;
self.Degree						:=input.Degree;
self.Sentencing_Information		:=input.Sentencing_Info;
self.Sentencing_Date			:=input.Sentencing_Date;
self.Street						:=input.Street;
self.City_State_Zip				:=input.City_State_Zip;
self							:= input;
end;

pOHLayout3 := project(d3, tOHLayout3(left));


export Map_OH_Hardin_Combined := pOHLayout1+pOHLayout2+pOHLayout3;