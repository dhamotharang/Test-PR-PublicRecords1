import doxie;

export Layout_Relatives_v2 := module 

export shared_ssns_rec := {STRING9 shared_ssn};

export shared_vehicle := {string30  Vehicle_Key ,
  string15  Iteration_Key ,
  string15  Sequence_Key } ; 

export shared_property := {string12  ln_fares_id}; 

export shared_PIN := { String15  experian_pin}; 
export shared_third_person := { unsigned5 shared_relative} ; 
export shared_addresses := { string110 recent_address , unsigned3 recent_addr_last_seen} ; 
export shared_company :=  { unsigned6  bdid} ; 
export temp := record

  doxie.layout_relative_dids.person1;
  doxie.layout_relative_dids.person2;
  doxie.layout_relative_dids.recent_cohabit;
  doxie.layout_relative_dids.same_lname;
  doxie.layout_relative_dids.number_cohabits;
  integer3  zip;
  integer2  prim_range;
  string  relative_matches:='';
  string  relatives_match_score := ''; 
  integer3  shared_addr_score  :=0;
  integer3  shared_zip_score := 0 ; 
  integer3  nbr_of_addresses := 0 ; 
  string110  recent_address := '' ; 
  unsigned3 recent_addr_last_seen := 0 ; 
  string30  Vehicle_Key := '';
  string15  Iteration_Key := '';
  string15  Sequence_Key := '' ;
  string9   ssn := '';
  string12  ln_fares_id := '';
  String15  experian_pin := '';
  unsigned5 shared_relative := 0 ;
  unsigned6 bdid :=0;
  unsigned3 dt_last_relative := 0 ; 
  boolean   current_relatives := true;  
  
 end;
 
 export main := record

  doxie.layout_relative_dids.person1;
  doxie.layout_relative_dids.person2;
  doxie.layout_relative_dids.recent_cohabit;
  doxie.layout_relative_dids.same_lname;
  doxie.layout_relative_dids.number_cohabits;
  integer3  zip;
  integer2  prim_range;
  string100  relative_matches:= '';
  string100  relatives_match_score := ''; 
  integer3  shared_addr_score  :=0;
  integer3  Match_by_zip_score := 0 ; 
  integer3  nbr_of_addresses := 0 ; 
  unsigned3 dt_last_relative := 0 ; 
  boolean   current_relatives := true; 
  DATASET(shared_ssns_rec) shared_ssn;
  DATASET(shared_vehicle) shared_vehicle  ;
  DATASET(shared_property) shared_property ;
  DATASET(shared_PIN) shared_PIN ;
  DATASET(shared_third_person) shared_third_person ;
  DATASET(shared_addresses) shared_addresses ;
  DATASET(shared_company) shared_company ;
 end;
 
 export slim := record
  doxie.layout_relative_dids.person1;
  doxie.layout_relative_dids.person2;
  doxie.layout_relative_dids.recent_cohabit;
  doxie.layout_relative_dids.same_lname;
  doxie.layout_relative_dids.number_cohabits;
  integer3 zip;
  integer2 prim_range;
  end;
	
 export rel_title_layout := RECORD
 unsigned1 title := 0;
 unsigned permissions := 0;
 end;

 export main_rel_title := record
 main;
 DATASET(rel_title_layout) rel_title;
 end;
 end;