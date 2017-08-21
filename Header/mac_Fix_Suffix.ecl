export mac_Fix_Suffix(file_in_,file_out_,mname='mname',name_suffix='name_suffix') := macro 

file_in_ t_fix_suffix (file_in_ le) := TRANSFORM
integer Pos_RD := stringlib.stringfind(le.mname,'RD',1);
integer Pos_2 := stringlib.stringfind(le.mname,'2',1);
integer Pos_2nd := stringlib.stringfind(le.mname,'2ND',1);
integer Pos_3 := stringlib.stringfind(le.mname,'3',1);
integer Pos_3rd := stringlib.stringfind(le.mname,'3RD',1);
integer Pos_4 := stringlib.stringfind(le.mname,'4',1);

integer Pos_4th := stringlib.stringfind(le.mname,'4TH',1);
integer Pos_5 := stringlib.stringfind(le.mname,'5',1);
integer Pos_5th := stringlib.stringfind(le.mname,'5TH',1);
integer Pos_6 := stringlib.stringfind(le.mname,'6',1);
integer Pos_7 := stringlib.stringfind(le.mname,'7',1);
integer Pos_7th := stringlib.stringfind(le.mname,'7TH',1);
integer Pos_8 := stringlib.stringfind(le.mname,'8',1);
integer Pos_9 := stringlib.stringfind(le.mname,'9',1);

integer Pos_II := stringlib.stringfind(le.mname,'II',1);
integer Pos_III := stringlib.stringfind(le.mname,'III',1);
integer Pos_IV := stringlib.stringfind(le.mname,'IV',1);
integer Pos_V := stringlib.stringfind(le.mname,'V',1);
integer Pos_VI := stringlib.stringfind(le.mname,'VI',1);
integer Pos_VII := stringlib.stringfind(le.mname,'VII',1);
integer Pos_VIII := stringlib.stringfind(le.mname,'VIII',1);
integer Pos_JR := stringlib.stringfind(le.mname,'JR',1);
integer Pos_SR := stringlib.stringfind(le.mname,'SR',1);

boolean is_RD  := if(Pos_RD>1,trim(le.mname[Pos_RD-1 .. Pos_RD+2],left,right)='RD',false);
boolean is_2   := if(Pos_2>1,trim(le.mname[Pos_2-1 .. Pos_2+1],left,right)='2',false);
boolean is_2nd := if(Pos_2nd>1,trim(le.mname[Pos_2nd-1 .. Pos_2nd+1],left,right)='2ND',false);
boolean is_3   := if(Pos_3>1,trim(le.mname[Pos_3-1 .. Pos_3+1],left,right)='3',false);
boolean is_3rd := if(Pos_3rd>1,trim(le.mname[Pos_3rd-1 .. Pos_3rd+1],left,right)='3RD',false);
boolean is_4   := if(Pos_4>1,trim(le.mname[Pos_4-1 .. Pos_4+1],left,right)='4',false);

boolean is_4th := if(Pos_4th>1,trim(le.mname[Pos_4th-1 .. Pos_4th+3],left,right)='4TH',false);
boolean is_5 := if(Pos_5>1,trim(le.mname[Pos_5-1 .. Pos_5+3],left,right)='5',false);
boolean is_5th := if(Pos_5th>1,trim(le.mname[Pos_5th-1 .. Pos_5th+3],left,right)='5TH',false);
boolean is_6 := if(Pos_6>1,trim(le.mname[Pos_6-1 .. Pos_6+3],left,right)='6',false);
boolean is_7 := if(Pos_7>1,trim(le.mname[Pos_7-1 .. Pos_7+3],left,right)='7',false);
boolean is_7th := if(Pos_7th>1,trim(le.mname[Pos_7th-1 .. Pos_7th+3],left,right)='7TH',false);
boolean is_8 := if(Pos_8>1,trim(le.mname[Pos_8-1 .. Pos_8+3],left,right)='8',false);
boolean is_9 := if(Pos_9>1,trim(le.mname[Pos_9-1 .. Pos_9+3],left,right)='9',false);

boolean is_II  := if(Pos_II>1,trim(le.mname[Pos_II-1 .. Pos_II+2],left,right)='II',false);
boolean is_III := if(Pos_III>1,trim(le.mname[Pos_III-1 .. Pos_III+3],left,right)='III',false);
boolean is_IV  := if(Pos_IV>1,trim(le.mname[Pos_IV-1 .. Pos_IV+2],left,right)='IV',false);
boolean is_V  := if(Pos_V>1,trim(le.mname[Pos_V-1 .. Pos_V+1],left,right)='V',false);
boolean is_VI  := if(Pos_VI>1,trim(le.mname[Pos_VI-1 .. Pos_VI+2],left,right)='VI',false);
boolean is_VII := if(Pos_VII>1,trim(le.mname[Pos_VII-1 .. Pos_VII+2],left,right)='VII',false);
boolean is_VIII:= if(Pos_VIII>1,trim(le.mname[Pos_VIII-1 .. Pos_VIII+2],left,right)='VIII',false);
boolean is_JR  := if(Pos_JR>1,trim(le.mname[Pos_JR-1 .. Pos_JR+2],left,right)='JR',false);
boolean is_SR  := if(Pos_SR>1,trim(le.mname[Pos_SR-1 .. Pos_SR+2],left,right)='SR',false); 

integer suffix_pos:= if(is_RD,Pos_RD,
if(is_2,Pos_2,
if(is_2nd,Pos_2nd,
if(is_3,Pos_3,
if(is_3rd,Pos_3rd,
if(is_4,Pos_4,

if(is_4th,Pos_4th,
if(is_5,Pos_5,
if(is_5th,Pos_5th,
if(is_6,Pos_6,
if(is_7,Pos_7,
if(is_7th,Pos_7th,
if(is_8,Pos_8,
if(is_9,Pos_9,

if(is_II,Pos_II,
if(is_III,Pos_III,
if(is_IV,Pos_IV,
if(is_V,Pos_V,
if(is_VI,Pos_VI,
if(is_VII,Pos_VII,
if(is_VIII,Pos_VIII,
if(is_JR,Pos_JR,
if(is_SR,Pos_SR,0)))))))))))))))))))))));


string suffix := if(trim(le.name_suffix,left,right)='',
								 if(is_RD,'RD',
								 if(is_2,'2',
								 if(is_2nd,'2ND',
								 if(is_3,'3',
								 if(is_3rd,'3RD',
								 if(is_4,'4',
								 
								 if(is_4th,'4TH',
								 if(is_5,'5',
								 if(is_5th,'5TH',
								 if(is_6,'6',
								 if(is_7,'7',
								 if(is_7th,'7TH',
								 if(is_8,'8',
								 if(is_9,'9',
								 
								 if(is_II,'II',
								 if(is_III,'III',
								 if(is_IV,'IV',
								 if(is_V,'V',
								 if(is_VI,'VI',
								 if(is_VII,'VII',
								 if(is_VIII,'VIII',
								 if(is_JR,'JR',
								 if(is_SR,'SR',
								 ''))))))))))))))))))))))),le.name_suffix);
self.name_suffix := if(le.mname[1..length(suffix)]=suffix,le.name_suffix,suffix);
self.mname := if(suffix_pos>0,le.mname[1..suffix_pos-1],le.mname);
self := le;

end;

p_file_in := project(file_in_,t_fix_suffix(left));

file_out_ := p_file_in;

endmacro;