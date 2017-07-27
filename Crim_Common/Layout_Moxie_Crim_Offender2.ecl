export Layout_Moxie_Crim_Offender2
 := module
  export new := 
  record
    Crim_common.Layout_Common_Crim_Offender2.new;
		string9 	ssn;
		string12 	did;
		string12 	pgid;
  end
  ;
  export previous := 
  record
    Crim_common.Layout_Common_Crim_Offender2.previous;
		string9 	ssn;
		string12 	did;
		string12 	pgid;
  end
  ;
end
 ;
 