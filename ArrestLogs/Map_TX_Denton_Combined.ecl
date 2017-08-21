import arrestlogs;

//FORMAT I///////////////////////////////////////////////////////
d1 := arrestlogs.File_TX_Denton_Alias;
d2 := arrestlogs.File_TX_Denton_Charges;
d3 := arrestlogs.File_TX_Denton_Individuals;

outRec := record
string alias;
arrestlogs.Layout_TX_Denton_Charges;
end;

outRec req_Output(d1 l, d2 r) := TRANSFORM
self := l;
self := r;
self := [];
END;

arrLog1 := JOIN(d1,d2,
			LEFT.id=RIGHT.id,
			req_Output(LEFT,RIGHT));

outRec2 := record
outRec;
string Location :='';
string Confined_Dt :='';
string Release_Dt :='';
string Name :='';
string Address :='';
string City_State :='';
string Phy_Desc :='';
string Hair :='';
string Eyes :='';
string DL :='';
string SO_num :='';
end;

outRec2 req_Output2(arrLog1 l, d3 r) := TRANSFORM
self := l;
self := r;
self := [];
END;

arrLog2 := JOIN(arrLog1,d3,
			LEFT.id=RIGHT.id,
			req_Output2(LEFT,RIGHT));
		
arrestlogs.Layout_TX_Denton.old_format RecTran(arrLog2 l):= transform

self.Arrest_Agency 		:= l.location;
self.Dt_Confined 		:= l.confined_dt;
self.Dt_Released 		:= l.release_dt;
self.City 				:= regexreplace('\\,',StringLib.StringToUpperCase(l.city_state[1..(length(l.city_state)-DataLib.StringFind(l.city_state,',',1)-2)]),'');
self.State 				:= if(length(trim(StringLib.StringToUpperCase(l.city_state[DataLib.StringFind(l.city_state,',',1)+1..DataLib.StringFind(l.city_state,',',1)+3]),left,right))=2,
							StringLib.StringToUpperCase(l.city_state[DataLib.StringFind(l.city_state,',',1)+1..DataLib.StringFind(l.city_state,',',1)+3]),
							if(length(trim(StringLib.StringToUpperCase(l.city_state[DataLib.StringFind(l.city_state,',',1)+2..DataLib.StringFind(l.city_state,',',1)+3]),left,right))=2,
							StringLib.StringToUpperCase(l.city_state[DataLib.StringFind(l.city_state,',',1)+2..DataLib.StringFind(l.city_state,',',1)+3]),
							''));
self.Zipcode 			:= l.city_state[(length(l.city_state)-5)..length(l.city_state)];
self.Race 				:= if(regexfind('White',l.phy_desc,0)<>'',
							'White',
							if(regexfind('Black',l.phy_desc,0)<>'',
							'Black',
							if(regexfind('Asian',l.phy_desc,0)<>'',
							'Asian',
							'')));
self.Sex 				:= if(regexfind('Female',l.phy_desc,0)<>'',
							'F',
							if(regexfind('Male',l.phy_desc,0)<>'',
							'M',
							''));
self.Height 			:= (string)((integer)l.phy_desc[(integer)DataLib.StringFind(l.phy_desc,'\'',1)-1]*12+
							if(regexfind('\"',l.phy_desc,0)<>'',
							(integer)(l.phy_desc[(integer)DataLib.StringFind(l.phy_desc,'\"',1)-1]+l.phy_desc[(integer)DataLib.StringFind(l.phy_desc,'\"',1)-2]),
							0));
self.Weight 			:= l.phy_desc[(DataLib.StringFind(l.phy_desc,'\"',1)+2)..(DataLib.StringFind(l.phy_desc,'\"',1)+5)];
self.DOB 				:= l.phy_desc[(DataLib.StringFind(l.phy_desc,'/',1)-2)..(DataLib.StringFind(l.phy_desc,'/',1)+10)];
self.DL_Num 			:= l.dl;
self.Issuing_Authority 	:= '';
self.bond 				:= regexreplace('\\,',StringLib.StringToUpperCase(l.bond[1..(length(l.bond)-DataLib.StringFind(l.bond,',',1)-2)]),'');
self.bond_type 			:= '';
self 					:= l;

end;

ds1 := project(arrLog2, RecTran(left));

//FORMAT II//////////////////////////////////////////////////////
d := arrestlogs.File_TX_Denton_old;

arrestlogs.Layout_TX_Denton.old_format req_Out(d l) := TRANSFORM
SELF := l;
END;

ds2 := project(d,req_out(left));

ds_temp := ds1 + ds2 + arrestlogs.File_TX_Denton.old;

arrestlogs.Layout_TX_Denton.new_format req_Out_new(ds_temp l) := TRANSFORM
SELF := l;
self.photo := '';
END;

ds3 := project(ds_temp,req_Out_new(left));

//CONCAT FORMATS I-III//////////////////////////////////////////
pTXComb := ds3 + arrestlogs.File_TX_Denton.new;

export Map_TX_Denton_Combined := pTXComb;