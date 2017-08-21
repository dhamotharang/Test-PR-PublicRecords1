export fn_concat_name_MS( infile , outfile) := macro

#uniquename(r)
   %r%:= { infile;
         string60 v_slashname ; 
         string60 v_slashname2;
		 string60 v_firstname;
		 string60 v_firstname2; 
		 string60   v_secondname; 
		 string60   v_secondname2;
		 string100  temp_name}; 
		 
#uniquename(outfile0)
	 
%outfile0% := project(infile, transform({ %r%}, 
	 
  string60 tmp_ws_p :=watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.FIRST_NAME);
  string60 tmp_ws_p2 :=watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.FIRST_NAME);
  string60 tmp_ws_p3 :=watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.FIRST_NAME);

 //string60 v_slashname :=tmp_ws_p3;
 integer2 tmp_slash := StringLib.StringFind(tmp_ws_p3,'/',1);
 t_v_slashname:=tmp_ws_p3[1..tmp_slash-1];
 t_v_slashname2:=tmp_ws_p3[tmp_slash+1..60];
 
 //v_firstname=tmp_ws_p;
 integer2 tmp_ind := StringLib.StringFind(tmp_ws_p,' OR ',1);


//  v_secondname =tmp_ws_p2;
 integer2 tmp_ind1 := StringLib.StringFind(tmp_ws_p2,' AND ',1);
    t_v_secondname:=tmp_ws_p2[1..tmp_ind1];
    t_v_secondname2:=tmp_ws_p2[tmp_ind1+5 ..60];
    t_v_firstname :=tmp_ws_p[1..tmp_ind];
    t_v_firstname2 :=tmp_ws_p[tmp_ind+4..60];
    string100  temp_concat_name := trim(t_v_secondname,left,right)+' '+ trim(left.LAST_NAME,left,right)+' AND '+ trim(t_v_secondname2,left,right)+' '+trim(left.LAST_NAME,left,right);

 #uniquename(temp_name0)

  %temp_name0% := if( StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), ' AND ',1)=0 AND
	                StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), ' OR ',1)=0 AND
	                StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '/',1)=0 AND
             ( StringLib.StringFind(left.FIRST_NAME,'& SONS',1)!=0 OR
	           StringLib.StringFind(left.FIRST_NAME,'SONS INC',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'AUTO SALES',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'AVIATION',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'AMERICA',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'ABERDEEN ',1)!=0 OR
              trim(left.FIRST_NAME,left,right)[1..4]='AND ' OR
              trim(left.FIRST_NAME,left,right)[1..3]='OR ' OR
              StringLib.StringFind(left.FIRST_NAME,'ASSOCIATES',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'ASSOC INC',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'ASSOC ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'AGRICUL ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'ARCHAEOLGY',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'CORP',1)!=0 OR
              left.FIRST_NAME[1..6] ='CONSV ' OR
              left.FIRST_NAME[1..5] ='CONS ' OR
              length(trim(left.FIRST_NAME,left,right))=5 AND StringLib.StringFind(left.FIRST_NAME,'SALES ',1)!=0 OR
              length(trim(left.FIRST_NAME,left,right))=4 AND StringLib.StringFind(left.FIRST_NAME,'SALE ',1)!=0 OR
              trim(left.FIRST_NAME,left,right)[1..1] ='&' OR
              StringLib.StringFind(left.FIRST_NAME,'BOAT CLUB ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'BRANCH',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'CARPET ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'CAMPGROUND ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'CONTRACTORS',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'CONSTRUCTION',1)!=0 OR
	          left.FIRST_NAME[1..6]='CONST ' OR
              StringLib.StringFind(left.FIRST_NAME,'COUNCIL',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'COURT ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'COMPANY ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'COLD STRG ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'CREDIT UNION ',1)!=0 OR
              length(trim(left.FIRST_NAME,left,right))=2 AND StringLib.StringFind(left.FIRST_NAME,'CO ',1)!=0 OR
	          StringLib.StringFind(left.FIRST_NAME,' CO ',1)!=0 OR
	          StringLib.StringFind(left.FIRST_NAME,'CLEARANCE',1)!=0 OR
	          left.FIRST_NAME[1..4] = 'CLU ' OR
              StringLib.StringFind(left.FIRST_NAME,'DEVELOPMENT CO ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'EQUIP CO ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'EQUIPMENT ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'EQ DIV',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'ELECTRIC COY IN',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'ELECTRIC CO ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'ENTERPRISE',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'FAMILY LP',1)!=0 OR 
              StringLib.StringFind(left.FIRST_NAME,'FISH CLUB',1)!=0 OR 
              StringLib.StringFind(left.FIRST_NAME,'FOSS MOTOR CO ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'GARDEN ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'HWY DEPT ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'& LAND SURVEYOR',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'INCORP',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'INC ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'INC, ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,', INC.',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'INC. ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'INSURANCE AGENY ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'INSURANCE AGECNY ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'ILLINOIS',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'HOLDING CO',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'LIFE & PARKS',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'LEXINGTON',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'MACHINE',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'MOTOR CO.',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'MOTOR CO ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'METALS',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'MEMPHIS',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'MAGNOLIA',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'MENDENHALL',1)!=0 OR
              trim(left.FIRST_NAME,left,right)[1..3] ='OF ' OR
              StringLib.StringFind(left.FIRST_NAME,'OFFICE',1)!=0 OR 
              StringLib.StringFind(left.FIRST_NAME,'OUTDOOR REC',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'OIL CO ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'OPTIMIST ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'& PAINT INC',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'PARKS DEPT',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'PARKS ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'P TABOR FAM TRU',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'PLUMBING ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'PRINTING',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'PIPELINE CO ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'PREFERRED AUTO',1)=0 AND StringLib.StringFind(left.FIRST_NAME,'AUTO ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'PROPERTIES LLC',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'REV TRST ',1)!=0 OR  
              StringLib.StringFind(left.FIRST_NAME,'RESEARCH ',1)!=0 OR  
              StringLib.StringFind(left.FIRST_NAME,'RESOURCES ',1)!=0 OR  
              StringLib.StringFind(left.FIRST_NAME,'ROAD & TRACK',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'ROOT ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SPACE ADMN ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SUPPLY ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'TRACTOR',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'TRUCKS & EQ INC',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'TRUCKS & EQUIP',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'TRUCK SALVAGE',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'TRST DTD',1)!=0 OR  
              StringLib.StringFind(left.FIRST_NAME,'TRUST',1)!=0 OR  
              StringLib.StringFind(left.FIRST_NAME,'TOWN',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'& PAINT',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'& PAINT INC',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'& TRAILERS',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'RAILROAD CO.',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'RANCH LLC',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'L.L.C. ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'LLC ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'L.L.P. ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'LLP ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'^LLC ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'LTD ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SAILING ACCOC',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SKI ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SESSIONS',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SERVICES',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SERVICE',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SERV DIV',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SCIENCE',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'SPORTS',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'YAMAHA',1)!=0 OR
              left.FIRST_NAME[1..5]='WILD ' OR
              StringLib.StringFind(left.FIRST_NAME,'WAY DIST ',1)!=0 OR
              StringLib.StringFind(left.FIRST_NAME,'WELFARE ',1)!=0 OR
	          left.FIRST_NAME[1..9] ='WILDLIFE ' OR
              StringLib.StringFind(left.FIRST_NAME,'NORTON & ASSOC. ',1)!=0 ) , StringLib.StringToUpperCase(trim(trim(left.LAST_NAME,left,right)+' '+trim(left.mid,left,right)+' '+trim(left.FIRST_NAME,left,right),left,right)), 
             if(StringLib.StringFind(left.LAST_NAME,'CARTER TEN OR',1)!=0 , StringLib.StringToUpperCase(trim(trim(left.LAST_NAME,left,right)+' '+trim(left.mid,left,right)+' '+trim(left.FIRST_NAME,left,right),left,right)), 
             if((StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), ' AND ',1)=0 AND StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), ' OR ',1)=0 AND StringLib.StringFind(left.FIRST_NAME,'/',1)=0 ) AND StringLib.StringFind(left.LAST_NAME,' AND ',1)!=0 , StringLib.StringToUpperCase(trim(trim(left.LAST_NAME,left,right)+' '+trim(left.FIRST_NAME,left,right))) ,
             if((StringLib.StringFind(left.FIRST_NAME,' AND ',1)=0 AND StringLib.StringFind(left.FIRST_NAME,'/',1) =0) AND StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1) !=0 AND StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), ' OR ',1)!=0 , StringLib.StringToUpperCase(trim(trim(left.FIRST_NAME,left,right)+' '+trim(left.LAST_NAME,left,right))) ,
	         if(( StringLib.StringFind(left.FIRST_NAME,' AND ',1)=0 AND StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1)=0 AND StringLib.StringFind(left.FIRST_NAME,'/',1) = 0) AND StringLib.StringFind(left.FIRST_NAME,' OR ',1)!=0 , trim(t_v_firstname,left,right)+' '+trim(left.LAST_NAME)+' OR '+ trim(t_v_firstname2)+' '+trim(left.LAST_NAME) , 
	         if(( StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1)=0 AND StringLib.StringFind(left.FIRST_NAME,' OR ',1)=0 AND StringLib.StringFind(left.FIRST_NAME,'/',1)  = 0)  AND StringLib.StringFind(left.FIRST_NAME,' AND ',1)!=0 , temp_concat_name , 
	         if(( StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1)=0 AND StringLib.StringFind(left.FIRST_NAME,' OR ',1)=0 AND StringLib.StringFind(left.FIRST_NAME,' AND ',1) = 0) AND StringLib.StringFind(left.FIRST_NAME,'/',1)!=0 ,  trim(t_v_slashname,left,right)+' '+ trim(left.LAST_NAME,left,right)+'/'+ trim(t_v_slashname2,left,right)+' '+trim(left.LAST_NAME,left,right) , 
             if((StringLib.StringFind(left.FIRST_NAME,' AND ',1)=0 AND StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), ' OR ',1)=0) AND trim(left.LAST_NAME,left,right)[1..1]='&' ,  StringLib.StringToUpperCase(trim(trim(left.FIRST_NAME)+' '+trim(left.LAST_NAME))) , 
              StringLib.StringToUpperCase(trim(trim(left.FIRST_NAME)+' '+trim(left.mid,left,right)+' '+trim(left.LAST_NAME)))))))))));
  
  
   self.temp_name := StringLib.StringFindreplace(%temp_name0%,'S ERVICE', 'SERVICE');
   self.v_secondname:=t_v_secondname;
   self.v_secondname2:=t_v_secondname2;
    self.v_firstname :=t_v_firstname;
    self.v_firstname2 :=t_v_firstname2;
	self.v_slashname := t_v_slashname; 
	self.v_slashname2 := t_v_slashname2; 
	
   self:= left ));
   
   outfile := %outfile0%;
 ENDmacro; 