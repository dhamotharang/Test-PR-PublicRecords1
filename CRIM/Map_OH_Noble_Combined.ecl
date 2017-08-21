import Crim_Common, Address;

// d1		:= Crim.File_OH_Noble_Old(regexfind('Name|#',name,0)='' and length(name)>=2);

Layout_OH_Noble_Adj := record
string First_Name;
string Last_Name;
string DOB;
string Sex;
string Race;
string Case_Num;
string Filed_Dt;
string Section_Num;
string Descr;
string Degree;
string Sent_Info;
string Sent_Dt;
string Street;
string City_State_Zip;
string Name;
end;

// Layout_OH_Noble_Adj tOHLayout1(d1 input) := Transform
// self.First_Name					:= '';
// self.Last_Name					:= '';
// self.Street						:= '';
// self.City_State_Zip				:= '';
// self							:= input;
// end;

// pOHLayout1 := project(d1, tOHLayout1(left));
//output(pOHLayout1);


// d2 		:= Crim.File_OH_Noble_Old_2(regexfind('Name|#',name,0)='' and length(name)>=2);

// Layout_OH_Noble_Adj tOHLayout2(d2 input) := Transform
// self.First_Name					:= '';
// self.Last_Name					:= '';
// self.Sex						:= '';
// self.Race						:= '';
// self							:=input;
// end;

// pOHLayout2 := project(d2, tOHLayout2(left));
//output(pOHLayout2);


d3		:= Crim.File_OH_Noble_(regexfind('Name|#',last_name,0)='' and length(last_name)>=2);

Layout_OH_Noble_Adj tOHLayout3(d3 input) := Transform
self.Name						:=input.First_Name+' '+input.Last_Name;
self.Street						:= '';
self.City_State_Zip				:= '';
self							:=input;
end;

pOHLayout3 := project(d3, tOHLayout3(left));
//output(pOHLayout3);

//ds_concat := pOHLayout1+pOHLayout2+pOHLayout3;

export Map_OH_Noble_Combined := pOHLayout3(City_State_Zip<>'City State Zip');