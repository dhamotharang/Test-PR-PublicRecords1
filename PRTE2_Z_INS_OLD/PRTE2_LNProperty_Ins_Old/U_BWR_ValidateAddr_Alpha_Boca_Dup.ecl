IMPORT PRTE2_LNProperty, PRTE2_Common, ut, PRTE2;

string filedate := ut.GetDate+'';

Boca  := PRTE2_LNProperty.Files.BOCA_BASE_SF_DS_PROD;
Alpha := PRTE2_LNProperty.Get_payload.NEW_LNPROPERTYV2(filedate);

inLayout := PRTE2.Layouts.layout_ln_propertyv2_expanded_payload;
// DS := Boca + Alpha;
// Boca;
// Alpha;

// COUNT(Boca); //2996195
// COUNT(Alpha); //31988
// COUNT(DS); //3028183

	
outLayout := Record
	unsigned6 Alpha_fakeid;
   string10  Alpha_prim_range;
   string2   Alpha_predir;
   string28  Alpha_prim_name;
   string4   Alpha_addr_suffix;
   string2   Alpha_postdir;
   string10  Alpha_unit_desig;
   string8   Alpha_sec_range;
   string25  Alpha_v_city_name;
   string2   Alpha_st;
   string5   Alpha_zip5;	
	 
	unsigned6 Boca_fakeid;
	 string10  Boca_prim_range;
   string2   Boca_predir;
   string28  Boca_prim_name;
   string4   Boca_addr_suffix;
   string2   Boca_postdir;
   string10  Boca_unit_desig;
   string8   Boca_sec_range;
   string25  Boca_v_city_name;
   string2   Boca_st;
   string5   Boca_zip5;
END;

outLayout xDup(inLayout Alpha, inLayout Boca):= Transform
      SELF.Alpha_fakeid       := Alpha.fakeid      ;
      SELF.Alpha_prim_range   := Alpha.person_addr.prim_range  ;
      SELF.Alpha_predir       := Alpha.person_addr.predir      ;
      SELF.Alpha_prim_name    := Alpha.person_addr.prim_name   ;
      SELF.Alpha_addr_suffix  := Alpha.person_addr.addr_suffix ;
      SELF.Alpha_postdir      := Alpha.person_addr.postdir     ;
      SELF.Alpha_unit_desig   := Alpha.person_addr.unit_desig  ;
      SELF.Alpha_sec_range    := Alpha.person_addr.sec_range   ;
      SELF.Alpha_v_city_name  := Alpha.person_addr.v_city_name ;
      SELF.Alpha_st           := Alpha.person_addr.st          ;
      SELF.Alpha_zip5         := Alpha.person_addr.zip5        ;
	  
	  
      SELF.Boca_fakeid       := Boca.fakeid      ;
      SELF.Boca_prim_range   := Boca.person_addr.prim_range  ;
      SELF.Boca_predir       := Boca.person_addr.predir      ;
      SELF.Boca_prim_name    := Boca.person_addr.prim_name   ;
      SELF.Boca_addr_suffix  := Boca.person_addr.addr_suffix ;
      SELF.Boca_postdir      := Boca.person_addr.postdir     ;
      SELF.Boca_unit_desig   := Boca.person_addr.unit_desig  ;
      SELF.Boca_sec_range    := Boca.person_addr.sec_range   ;
      SELF.Boca_v_city_name  := Boca.person_addr.v_city_name ;
      SELF.Boca_st           := Boca.person_addr.st          ;
      SELF.Boca_zip5         := Boca.person_addr.zip5        ;
END;



/*
resultDS :=   join(Alpha, Boca,
                   LEFT.prim_name  = RIGHT.prim_name
                   AND (LEFT.st    = RIGHT.st )
                   // AND (LEFT.city_code    = RIGHT.city_code )
                   AND (LEFT.zip    = RIGHT.zip ),
                   // AND (LEFT.sec_range    = RIGHT.sec_range ),
				           xDup(LEFT, RIGHT));	
*/

resultDS :=   join(Alpha, Boca,
                   LEFT.person_addr.prim_range  = RIGHT.person_addr.prim_range
                   // LEFT.person_addr.prim_range  = RIGHT.person_addr.prim_range
                   // AND (LEFT.person_addr.predir      = RIGHT.person_addr.predir       )
                   AND (LEFT.person_addr.prim_name   = RIGHT.person_addr.prim_name    )
                   // AND (LEFT.person_addr.addr_suffix = RIGHT.person_addr.addr_suffix  )
                   // AND (LEFT.person_addr.postdir     = RIGHT.person_addr.postdir      )
                   // AND (LEFT.person_addr.unit_desig  = RIGHT.person_addr.unit_desig   )
                   // AND (LEFT.person_addr.sec_range   = RIGHT.person_addr.sec_range    )
                   AND (LEFT.person_addr.v_city_name = RIGHT.person_addr.v_city_name  ),
                   // AND (LEFT.person_addr.st          = RIGHT.person_addr.st           ),
                   // AND (LEFT.person_addr.zip5        = RIGHT.person_addr.zip5         ),
				           xDup(LEFT, RIGHT));


resultDS;
COUNT(resultDS);	//0						 