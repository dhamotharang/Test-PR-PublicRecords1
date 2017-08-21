
export header.layout_relatives_v2.main Tra_Roll_Relatives(header.layout_relatives_v2.main lef, header.layout_relatives_v2.main rig) := transform
  
  self.Match_by_zip_score   := lef.match_by_zip_score + MAP ( lef.zip=rig.zip or lef.zip<=0 or rig.zip<=0 => 0,
                                     lef.zip div 100 =rig.zip div 100=>1,
                                     lef.zip div 10000 = rig.zip div 10000=>2,
                                    3 );
  self.shared_addr_score    := lef.shared_addr_score +rig.shared_addr_score;				 
								
  self.same_lname           := lef.same_lname or rig.same_lname;
  self.number_cohabits      := lef.number_cohabits+rig.number_cohabits +
                               MAP ( lef.zip=rig.zip or lef.zip<=0 or rig.zip<=0 => 0,
                                     lef.zip div 100 =rig.zip div 100=>1,
                                     lef.zip div 10000 = rig.zip div 10000=>2,
                                    3 );
									
  self.recent_cohabit         := if( lef.recent_cohabit > rig.recent_cohabit, lef.recent_cohabit, rig.recent_cohabit );
  //self.relative_matches       := if(length(trim(lef.relative_matches,left,right))>length(trim(rig.relative_matches,left,right)),lef.relative_matches,rig.relative_matches ); 
  //self.relatives_match_score  := if(length(trim(lef.relatives_match_score,left,right))>length(trim(rig.relatives_match_score,left,right)),lef.relatives_match_score,rig.relatives_match_score); 
  self.relative_matches       := trim(lef.relative_matches,left,right)+ trim(rig.relative_matches,left,right);
  self.relatives_match_score  := trim(lef.relatives_match_score,left,right)+ trim(rig.relatives_match_score,left,right);
  self.nbr_of_addresses       := if(rig.nbr_of_addresses> lef.nbr_of_addresses, rig.nbr_of_addresses,lef.nbr_of_addresses); 
  self.shared_addresses       := lef.shared_addresses(recent_address <> '')+ rig.shared_addresses(recent_address <> '');
  self.shared_property        := Lef.shared_property(ln_fares_id <> '') + Rig.shared_property(ln_fares_id <> '');
  self.shared_ssn             := lef.shared_ssn(shared_ssn <>'')+ rig.shared_ssn(shared_ssn<>''); 
  self.shared_vehicle         := lef.shared_vehicle (Vehicle_Key <>'')+rig.shared_vehicle(Vehicle_Key<>''); 
  self.shared_pin             := lef.shared_pin(experian_pin <>'')+rig.shared_pin(experian_pin <>''); 
  self.shared_third_person    := lef.shared_third_person(shared_relative <>0) +rig.shared_third_person(shared_relative <>0); 
  self.shared_company         := lef.shared_company(bdid <>0) + rig.shared_company(bdid<>0) ; 
  self                        := lef;
  end;