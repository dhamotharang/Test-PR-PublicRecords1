export fn_rollup_prep(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function

recordof(int0)  rollup_prep(recordof(int0) le) := transform
 
 self.party1_race := if(regexfind('UNKNOWN',le.party1_race),'',le.party1_race);
 self.party2_race := if(regexfind('UNKNOWN',le.party2_race),'',le.party2_race);
 
 self.party1_csz := stringlib.stringfindreplace(le.party1_csz,' , ',', ');
 self.party2_csz := stringlib.stringfindreplace(le.party2_csz,' , ',', ');
 
 self.party1_county := regexreplace(' COUNTY',le.party1_county,'');
 self.party2_county := regexreplace(' COUNTY',le.party2_county,'');
 
 self.marriage_county := regexreplace(' COUNTY',le.marriage_county,'');
 self.divorce_county  := regexreplace(' COUNTY',le.divorce_county,''); 
 
 self             := le;
 
end;

clean_it_up := project(int0,rollup_prep(left));

return clean_it_up;

end;