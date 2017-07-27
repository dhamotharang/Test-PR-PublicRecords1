tmp_layout := record
	Layouts.BatchIn.acctno;
	Layouts.BatchIn.SSN;
	Layouts.BatchIn.DOB;
   unsigned6 did;		
	Layouts.BatchIn.name_last;
	Layouts.BatchIn.name_first;
	Layouts.BatchIn.name_MIDDLE;
	Layouts.BatchIn.addr;
	Layouts.BatchIn.prim_range;
	Layouts.BatchIn.predir;
	Layouts.BatchIn.prim_name;
	Layouts.BatchIn.addr_suffix;
	Layouts.BatchIn.sec_range;
	Layouts.BatchIn.p_city_name;
	Layouts.BatchIn.st;
	Layouts.BatchIn.z5;
	   STRING Filler1 ;  //customer input value to return in output unchanged.
     STRING Gender  ;
     STRING DL_Number;
     STRING DL_State ;
     STRING VEH_Plate ;
     STRING VEH_State ;
     STRING FBI_Num   ;
     STRING State_Crim_Num ;
     STRING Relative_Last_Name ;
     STRING Relative_First_Name;
     STRING LexID_Suppression_1;
     STRING LexID_Suppression_2;
     STRING Dedupe_Address_1;
     STRING Dedupe_City_1   ;
     STRING Dedupe_State_1  ;
     STRING Dedupe_Zip_1     ;
     STRING Dedupe_Address_2 ;
     STRING Dedupe_City_2    ;
     STRING Dedupe_State_2  ;
     STRING Dedupe_Zip_2 :=''   ;
	end;
//SINGLETARI
_canned_recs := dataset([{'11','617723334','19880328',0,'CHUNG                   ','KOU CHUL             ', '                         ', '1213 SE 179TH AVE      	','','','','','','VANCOUVER             ', 'WA','98683','72343860','','','','','','','','','','','','','','','','','','',''}], tmp_layout);

//MARIA DE LOURDES POSADA DE PADUA
EXPORT BatchCannedInput := project(_canned_recs, transform(ERO_Services.Layouts.BatchIn, self := left, self :=[]));				