import Civ_court, ak_comm_fish_vessels;

ds1 := Civ_Court.File_In_TX_Collin_Case;
ds2 := Civ_Court.File_In_TX_Collin_Court;
ds3 := Civ_Court.File_In_TX_Collin_Defendant(last_name ~in['DBA','D/B/A','A/K/A','AKA','AND','&','VOID'] and attorney_last_name ~in['UNKNOWN']);
ds4 := Civ_Court.File_In_TX_Collin_Plaintiff;
ds5 := ds3+ds4;

civ_party := ds5;
					
outRec := RECORD
string curcrt;	
string nature;	
string file_date;	
string disp_date;	
string disp_code;	
string disp_desc;
Civ_Court.Layout_TX_Collin_Party;
END;

outRec req_Output2(ds1 l, civ_party r) := TRANSFORM
string curcrt	:= '';	
string nature	:= '';	
string file_date:= '';	
string disp_date:= '';	
string disp_code:= '';
string disp_desc:= '';
self := l;
self := r;
self := [];
END;

civ_case := JOIN(ds1,civ_party,
					LEFT.court=RIGHT.court and
					LEFT.cause=RIGHT.cause and
					LEFT.year=RIGHT.year,
					req_Output2(LEFT,RIGHT));
					
outRec2 := RECORD
string curcrt;	
string nature;	
string file_date;	
string disp_date;	
string disp_code;	
string disp_desc;
Civ_Court.File_In_TX_Collin_Court;
Civ_Court.Layout_TX_Collin_Party;
END;

outRec2 req_Output3(ds2 l, civ_case r) := TRANSFORM
string case_num := trim(l.case_num,left,right);
string curcrt	:= '';	
string nature	:= '';	
string file_date:= '';	
string disp_date:= '';	
string disp_code:= '';
string disp_desc:= '';
self := l;
self := r;
self := [];
END;

civ_ct := JOIN(ds2,civ_case,
					trim(LEFT.case_num,left,right)=
					trim(RIGHT.court,left,right)+
					trim(RIGHT.cause,left,right)+
					trim(RIGHT.year,left,right),
					req_Output3(LEFT,RIGHT));
					
outRec3 := RECORD
outrec2;
string cname;
string partytype;
END;

outRec3 search_mapping_format_temp(civ_ct L, integer1 C) :=transform
self.cname    		:= choose(C,l.last_name+' '+l.first_name+' '+l.middle_name,l.attorney_last_name+' '+l.attorney_first_name+' '+l.attorney_middle_name);
self.partytype		:= if(self.cname = l.attorney_last_name+' '+l.attorney_first_name+' '+l.attorney_middle_name and l.party_type='DE',
						'40',
						if(self.cname = l.attorney_last_name+' '+l.attorney_first_name+' '+l.attorney_middle_name and l.party_type='PL',
						'20',
						if(self.cname = l.last_name+' '+l.first_name+' '+l.middle_name and l.party_type='DE',
						'30',
						if(self.cname = l.last_name+' '+l.first_name+' '+l.middle_name and l.party_type='PL',
						'10',
						''))));	
self                := L;
end;

MultiAddrNorm := normalize(civ_ct,2,search_mapping_format_temp(left,counter));
					
export Map_TX_Collin_Combined := MultiAddrNorm : PERSIST('~thor_dell400::persist::Civil_Court_TX_Collin_Combined');