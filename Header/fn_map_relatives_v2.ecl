export fn_map_relatives_v2(dataset(recordof({header.layout_relatives_v2.temp,string1 dummy:=''})) in_file) := function;

gj := group(in_file,person1,person2,all);
sg := sort(gj,prim_range,IF(same_lname,0,1),-number_cohabits,zip,record);
ds := dedup(sg,prim_range,keep 5);

temp_rec := { header.layout_relatives_v2.temp, boolean is_addr,integer2 temp_no_of_prop := 0 
          ,integer2 temp_no_of_sp:= 0 ,integer2 temp_no_of_ssn:= 0, integer2 temp_no_of_rel:=0
		  ,integer2 temp_no_of_veh:= 0  ,integer2 temp_no_of_comp:= 0} ;
		  
iterate_prep :=sort( project(ds,transform({temp_rec}, 
          
		  self.is_addr := StringLib.StringFind((string) left.prim_range, '-', 1)=0 or left.prim_range=-3 or length(trim((string) left.prim_range,left,right))>2;
		  self.relative_matches := if(self.is_addr, '',(string) left.prim_range);
		  self.relatives_match_score := if(self.is_addr, '',(string) left.number_cohabits);
		  self.shared_addr_score := if(self.is_addr, left.number_cohabits,0);
		  self.recent_address := if(self.is_addr,left.recent_address ,''); 
		  self.recent_addr_last_seen := if(self.is_addr,left.recent_cohabit,0); 
		  self:= left )),-recent_cohabit);
			 
  
temp_rec t_addflag(temp_rec le, temp_rec ri) := transform

// making scores to zero so that dont have to double count the scores in the rollup. 
  self.temp_no_of_ssn := if(ri.prim_range = -1 , le.temp_no_of_ssn+1 , le.temp_no_of_ssn); 
  self.temp_no_of_rel := if(ri.prim_range = -2 , le.temp_no_of_rel+1,le.temp_no_of_rel); 
  self.temp_no_of_comp:=if(ri.prim_range = -4 , le.temp_no_of_comp+1, le.temp_no_of_comp); 
  self.temp_no_of_prop := if(ri.prim_range = -5 , le.temp_no_of_prop+1 ,  le.temp_no_of_prop);
  self.temp_no_of_veh := if(ri.prim_range = -6 , le.temp_no_of_veh+1, le.temp_no_of_veh); 
  self.temp_no_of_sp := if(ri.prim_range = -7 , le.temp_no_of_sp +1 ,le.temp_no_of_sp); 

 self.number_cohabits := map(ri.prim_range = -1 and self.temp_no_of_ssn >1 =>0 , 
                             ri.prim_range = -2 and self.temp_no_of_rel >1 =>0, 
							 ri.prim_range = -4 and self.temp_no_of_comp >1 =>0, 
                             ri.prim_range = -5 and self.temp_no_of_prop>1 => 0,
                             ri.prim_range = -6 and self.temp_no_of_veh >1 =>0, 
                             ri.prim_range = -7 and self.temp_no_of_sp>1 => 0,
							 ri.number_cohabits);
 //self.relative_matches := le.relative_matches + ri.relative_matches;
 //self.relatives_match_score := le.relatives_match_score +if(ri.relatives_match_score <>'','+'+ri.relatives_match_score,'') ; 
 self.relative_matches := if(~ri.is_addr and self.number_cohabits <> 0,(string)ri.prim_range,''); 
 self.relatives_match_score :=if(~ri.is_addr and self.number_cohabits <> 0 ,'+'+(string)self.number_cohabits,'');
 self.nbr_of_addresses := if(ri.is_addr , le.nbr_of_addresses+1 ,  le.nbr_of_addresses); 
 self.recent_addr_last_seen := if(self.nbr_of_addresses <6 ,ri.recent_addr_last_seen,0);
 self.recent_address := if(self.nbr_of_addresses <6 ,ri.recent_address,'');
 self           := ri;
end;

rollup1 := iterate(iterate_prep,t_addflag(left,right));

header.layout_relatives_v2.main taddssn(rollup1 L) := TRANSFORM
   self:=l ;
   self.shared_ssn          := DATASET([{ l.ssn }], header.Layout_Relatives_v2.shared_ssns_rec);
   self.shared_vehicle      := DATASET([{ l.Vehicle_Key,l.Iteration_Key,l.Sequence_Key }], header.Layout_Relatives_v2.shared_vehicle);
   self.shared_pin          := DATASET([{ l.experian_pin }], header.Layout_Relatives_v2.shared_PIN);
   self.shared_addresses    := DATASET([{ l.recent_address,l.recent_addr_last_seen }],header.layout_relatives_v2.shared_addresses);
   self.shared_property     := DATASET([{ l.ln_fares_id }], header.layout_relatives_v2.shared_property);
   self.shared_third_person := DATASET([{ l.shared_relative }],header.Layout_Relatives_v2.shared_third_person);
   self.shared_company      := DATASET([{ l.bdid }],header.Layout_Relatives_v2.shared_company);
end;
js_p := PROJECT(rollup1 , taddssn(LEFT));

return js_p; 
end;