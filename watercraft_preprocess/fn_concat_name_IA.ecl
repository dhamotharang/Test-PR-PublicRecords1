export fn_concat_name_IA(string first_name , string mid , string last_name):= function 

  
    string60 tmp_ws_p2 :=StringLib.StringToUpperCase(first_name);
    string60 tmp_ws_p3 :=StringLib.StringToUpperCase(first_name);
    string60 tmp_ws_p_0:=StringLib.StringFindReplace(StringLib.StringToUpperCase(first_name), ' &/OR ', ' OR ');
       		 tmp_ws_p  :=StringLib.StringFindReplace(tmp_ws_p_0, ' AND/OR ', ' OR ');
	         integer2 tmp_ind := StringLib.stringfind(tmp_ws_p,' OR ',1);
//if ? 
     v_firstname:=tmp_ws_p[1..tmp_ind];
     v_firstname2:=tmp_ws_p[tmp_ind+4..60];

  // v_ampname :=tmp_ws_p3;
  
    boolean  is_true:=     if( trim(first_name)[1] !='&' OR
              StringLib.stringfind(first_name,'& SON',1)=0 OR
              StringLib.stringfind(first_name,'COUNTY WATER & SEWER',1)=0 OR
              StringLib.stringfind(first_name,'CANOE & KAYAK CLUB',1)=0 OR
              StringLib.stringfind(first_name,'CREEK LODGE & ',1)=0 OR
              StringLib.stringfind(first_name,'FORD & MERCURY',1)=0 OR
              StringLib.stringfind(first_name,'FIRE& EMERG. SERV.',1)=0 OR
              StringLib.stringfind(first_name,'FARM & LAWN EQPMT',1)=0 OR
              StringLib.stringfind(first_name,'& PAINT INC',1)=0 OR
              StringLib.stringfind(first_name,'& CO',1)=0 OR
	          StringLib.stringfind(first_name,'COLLEGE OF ART & DES',1)=0 OR
              StringLib.stringfind(first_name,'EQUIPMENT & SUPPLY',1)=0 OR
              StringLib.stringfind(first_name,'INC.,',1)=0 OR
	          StringLib.stringfind(first_name,'LAKE MARINA & RESORT',1)=0 OR
	          StringLib.stringfind(first_name,'LOAN & INSURANCE',1)=0 OR
              StringLib.stringfind(first_name,'LIFE & PARKS',1)=0 OR
              StringLib.stringfind(first_name,'& LAND SURVEYOR',1)=0 OR
              StringLib.stringfind(first_name,'TRANSFER & STORAGE C',1)=0 OR  
              StringLib.stringfind(first_name,'TRANSFER & STORAGE CO ',1)=0 OR  
              StringLib.stringfind(first_name,'ROAD & TRACK',1)=0 OR
              StringLib.stringfind(first_name,'TRUCKS & EQ INC',1)=0 OR
              StringLib.stringfind(first_name,'TRUCKS & EQUIP',1)=0 OR
              StringLib.stringfind(first_name,'& PAINT INC',1)=0 OR
              StringLib.stringfind(first_name,'& TRAILERS',1)=0 OR
              StringLib.stringfind(first_name,'MARINE & SPORTS',1)=0 OR
              StringLib.stringfind(first_name,'MARINE & GUN ',1)=0 OR
              StringLib.stringfind(first_name,'MAINTENANCE & REP',1)=0 OR
              StringLib.stringfind(first_name,'SVC & EQUIPMENT',1)=0 OR
              StringLib.stringfind(first_name,'SURVEYORS & ENGINEERS',1)=0 OR
              StringLib.stringfind(first_name,'NORTON & ASSOC. ',1)=0 ,true,false); 
      
        tmp_amp := if(is_true, StringLib.stringfind(tmp_ws_p3,' & ',1),0); 
	    v_ampname:= if(is_true, tmp_ws_p3[1..tmp_amp],'');
        v_ampname2:=if(is_true,tmp_ws_p3[tmp_amp+2..60],'');

 //  v_secondname =tmp_ws_p2; // if? 
     tmp_ind1 := StringLib.stringfind(tmp_ws_p2,' AND ',1);
     v_secondname:=tmp_ws_p2[1..tmp_ind1];
     v_secondname2:=tmp_ws_p2[tmp_ind1+5..60];

  temp_name := IF( StringLib.stringfind(StringLib.StringToUpperCase(first_name), ' OR ',1)=0 AND
	         StringLib.stringfind(StringLib.StringToUpperCase(first_name), ' AND ',1)=0 AND
	         StringLib.stringfind(StringLib.StringToUpperCase(first_name), ' &/OR ',1)=0 AND
	         StringLib.stringfind(StringLib.StringToUpperCase(first_name), ' AND/OR ',1)=0 AND
	         StringLib.stringfind(StringLib.StringToUpperCase(first_name), ' & ',1)=0 AND
             ( trim(first_name)[1]='&' OR
              StringLib.stringfind(first_name,'AUTO SALES',1)!=0 OR
              StringLib.stringfind(first_name,'ASSOC INC',1)!=0 OR
              StringLib.stringfind(first_name,' ASSOC ',1)!=0 OR
	          StringLib.stringfind(first_name,'ASSOC ',1)!=0 OR
              StringLib.stringfind(first_name,'AND HUBBELL ENT',1)!=0 OR
              StringLib.stringfind(first_name,'AND SONS',1)!=0 OR
              StringLib.stringfind(first_name,'& SON',1)!=0 OR
              length(trim(first_name))=3 AND StringLib.stringfind(first_name,'AND ',1)!=0 OR
              StringLib.stringfind(first_name,'AMER. YACHT SALE',1)!=0 OR
              StringLib.stringfind(first_name,'AMER YACHT SALE',1)!=0 OR
              StringLib.stringfind(first_name,'PREFERRED AUTO',1)=0 AND StringLib.stringfind(first_name,'AUTO ',1)!=0 OR
              StringLib.stringfind(first_name,'BARBARA A PRINC',1)=0 AND StringLib.stringfind(first_name,'INC ',1)!=0 OR
              StringLib.stringfind(first_name,'ASSOCIATES',1)!=0 OR
              StringLib.stringfind(first_name,'BOAT HOUSES AND DOCKS',1)!=0 OR
              StringLib.stringfind(first_name,' BANK ',1)!=0 OR
              StringLib.stringfind(first_name,'BOARD ',1)!=0 OR
              StringLib.stringfind(first_name,'COMPANY ',1)!=0 OR
	          StringLib.stringfind(first_name,' COMPANY ',1)!=0 OR
              StringLib.stringfind(first_name,'CARPET ',1)!=0 OR
              StringLib.stringfind(first_name,'CENTER',1)!=0 OR
              StringLib.stringfind(first_name,'CORP',1)!=0 OR
              StringLib.stringfind(first_name,' CITY ',1)!=0 OR
              StringLib.stringfind(first_name,'CITY ',1)!=0 OR
              StringLib.stringfind(first_name,'COUNCIL',1)!=0 OR
              StringLib.stringfind(first_name,'CONSULTING INC',1)!=0 OR
              StringLib.stringfind(first_name,'CONSERVATION',1)!=0 OR
              StringLib.stringfind(first_name,'CO INC.',1)!=0 OR
              StringLib.stringfind(first_name,'CO INC',1)!=0 OR
              StringLib.stringfind(first_name,'COUNTY WATER & SEWER',1)!=0 OR
              StringLib.stringfind(first_name,'COUNTY ',1)!=0 OR
              StringLib.stringfind(first_name,'CORROSION IND.INC.,',1)!=0 OR
              StringLib.stringfind(first_name,'CANOE & KAYAK CLUB',1)!=0 OR
              StringLib.stringfind(first_name,'CREEK LODGE & ',1)!=0 OR
              StringLib.stringfind(first_name,' CLUB ',1)!=0 OR
	          StringLib.stringfind(first_name,'CLUB ',1)!=0 OR
              StringLib.stringfind(first_name,'DEVELOPMENT CO ',1)!=0 OR
              StringLib.stringfind(first_name,'DEPT ANIMAL ECOLOGY',1)!=0 OR
              StringLib.stringfind(first_name,'ES W SMITH TRST',1)!=0 OR
              StringLib.stringfind(first_name,'FORD & MERCURY',1)!=0 OR
              StringLib.stringfind(first_name,'first_nameTRUST ',1)!=0 OR
              StringLib.stringfind(first_name,'FOSS MOTOR CO ',1)!=0 OR
              StringLib.stringfind(first_name,'GIRL SCOUTS',1)!=0 OR
              StringLib.stringfind(first_name,'MACHINE',1)!=0 OR
              StringLib.stringfind(first_name,'FORD SALES INC',1)!=0 OR
              StringLib.stringfind(first_name,'FIRE& EMERG. SERV.',1)!=0 OR
              StringLib.stringfind(first_name,'FARM & LAWN EQPMT',1)!=0 OR
              length(trim(first_name))=5 AND StringLib.stringfind(first_name,'SALES ',1)!=0 OR
              StringLib.stringfind(first_name,'METALS',1)!=0 OR
              StringLib.stringfind(first_name,'& PAINT INC',1)!=0 OR
              StringLib.stringfind(first_name,'OF SDA',1)!=0 OR
              StringLib.stringfind(first_name,'OF ROME GEORGIA',1)!=0 OR
              StringLib.stringfind(first_name,'CONTRACTORS',1)!=0 OR
              StringLib.stringfind(first_name,'CONSTRUCTION',1)!=0 OR
              StringLib.stringfind(first_name,'COMMUNITY REC DIV',1)!=0 OR
              StringLib.stringfind(first_name,'COUNCIL BOY SCO',1)!=0 OR
              StringLib.stringfind(first_name,'CREDIT UNION ',1)!=0 OR
              StringLib.stringfind(first_name,'CHURCH ',1)!=0 OR
	          StringLib.stringfind(first_name,'COLLEGE OF ART & DES',1)!=0 OR
              length(trim(first_name))=2 AND StringLib.stringfind(first_name,'CO ',1)!=0 OR
              StringLib.stringfind(first_name,'ELECTRIC COY IN',1)!=0 OR
              StringLib.stringfind(first_name,'ELECTRIC CO ',1)!=0 OR
              StringLib.stringfind(first_name,'EQUIPMENT & SUPPLY',1)!=0 OR
              StringLib.stringfind(first_name,'EQUIPMENT & SUP',1)!=0 OR
              StringLib.stringfind(first_name,' EQPMT ',1)!=0 OR
              StringLib.stringfind(first_name,'GOLDEN ISL CR LINE',1)!=0 OR
              StringLib.stringfind(first_name,' CO ',1)!=0 OR
              StringLib.stringfind(first_name,'INC.',1)!=0 OR
              StringLib.stringfind(first_name,'INC, ',1)!=0 OR
              StringLib.stringfind(first_name,'INC.,',1)!=0 OR
              length(trim(first_name))=3 AND StringLib.stringfind(first_name,'INC ',1)!=0 OR
              StringLib.stringfind(first_name,'INSURANCE AGENY ',1)!=0 OR
              StringLib.stringfind(first_name,'INSURANCE AGECNY ',1)!=0 OR
              StringLib.stringfind(first_name,'DANIEL IRRIGATION CO',1)!=0 OR
              StringLib.stringfind(first_name,'L.L.C. ',1)!=0 OR
              StringLib.stringfind(first_name,'^LLC ',1)!=0 OR
              StringLib.stringfind(first_name,' LLC ',1)!=0 OR
              StringLib.stringfind(first_name,'LLC ',1)!=0 OR
              StringLib.stringfind(first_name,' LTD ',1)!=0 OR
              StringLib.stringfind(first_name,'^LTD ',1)!=0 OR
              StringLib.stringfind(first_name,' LTD$ ',1)!=0 OR
	          StringLib.stringfind(first_name,'LTD ',1)!=0 OR
	          StringLib.stringfind(first_name,' LLLP ',1)!=0 OR
	          StringLib.stringfind(first_name,'LAKE MARINA & RESORT',1)!=0 OR
	          StringLib.stringfind(first_name,'LOAN & INSURANCE',1)!=0 OR
	          StringLib.stringfind(first_name,' RESORT ',1)!=0 OR
	          StringLib.stringfind(first_name,' MARINA ',1)!=0 OR
              length(trim(first_name))=3 AND StringLib.stringfind(first_name,'LTD',1)!=0 OR
              StringLib.stringfind(first_name,'LIFE & PARKS',1)!=0 OR
              StringLib.stringfind(first_name,'& LAND SURVEYOR',1)!=0 OR
              StringLib.stringfind(first_name,'PIPELINE CO ',1)!=0 OR
              StringLib.stringfind(first_name,'TRUST',1)!=0 OR
	          StringLib.stringfind(first_name,'THE WEST',1)!=0 OR
              StringLib.stringfind(first_name,'TRSTUAT',1)!=0 OR
              StringLib.stringfind(first_name,'TRUCK SALVAGE',1)!=0 OR
              StringLib.stringfind(first_name,'TRST DTD',1)!=0 OR  
              StringLib.stringfind(first_name,'TRANSFER & STORAGE C',1)!=0 OR  
              StringLib.stringfind(first_name,'TRANSFER & STORAGE CO ',1)!=0 OR  
              StringLib.stringfind(first_name,'REV TRST ',1)!=0 OR  
              StringLib.stringfind(first_name,'ROAD & TRACK',1)!=0 OR
              StringLib.stringfind(first_name,'BOAT CLUB ',1)!=0 OR
              StringLib.stringfind(first_name,'TRUCKS & EQ INC',1)!=0 OR
              StringLib.stringfind(first_name,'TRUCKS & EQUIP',1)!=0 OR
              StringLib.stringfind(first_name,'& PAINT INC',1)!=0 OR
              StringLib.stringfind(first_name,'& TRAILERS',1)!=0 OR
              StringLib.stringfind(first_name,'OUTDOOR REC',1)!=0 OR
              StringLib.stringfind(first_name,'OPTOMETRISTS P C',1)!=0 OR
              StringLib.stringfind(first_name,'OPTOMETRISTS',1)!=0 OR
              StringLib.stringfind(first_name,'P TABOR FAM TRU',1)!=0 OR
              StringLib.stringfind(first_name,'MARINE & SPORTS',1)!=0 OR
              StringLib.stringfind(first_name,'MARINE & GUN ',1)!=0 OR
              StringLib.stringfind(first_name,'MARINA LLC ',1)!=0 OR
              StringLib.stringfind(first_name,'MAINTENANCE & REP',1)!=0 OR
              StringLib.stringfind(first_name,'CORPORATION',1)!=0 OR
              StringLib.stringfind(first_name,'MOTORS ',1)!=0 OR
              StringLib.stringfind(first_name,'MOTOR CO.',1)!=0 OR
              StringLib.stringfind(first_name,'MOTOR CO ',1)!=0 OR
              StringLib.stringfind(first_name,'MOTOR ',1)!=0 OR
              StringLib.stringfind(first_name,'OIL CO ',1)!=0 OR
              StringLib.stringfind(first_name,'HOLDING CO',1)!=0 OR
              StringLib.stringfind(first_name,'RAILROAD CO.',1)!=0 OR
              StringLib.stringfind(first_name,'RANCH LLC',1)!=0 OR
              StringLib.stringfind(first_name,'PROPERTIES LLC',1)!=0 OR
              StringLib.stringfind(first_name,'PLUMBING ',1)!=0 OR
              StringLib.stringfind(first_name,'MFG INC',1)!=0 OR
              StringLib.stringfind(first_name,'PARKS DEPT',1)!=0 OR
              StringLib.stringfind(first_name,'PARK ',1)!=0 OR
              StringLib.stringfind(first_name,'PARKS ',1)!=0 OR
              StringLib.stringfind(first_name,'REC AND PARK',1)!=0 OR
              length(trim(first_name))=3 AND StringLib.stringfind(first_name,'REC ',1)!=0 OR
              StringLib.stringfind(first_name,'RECREATIONAL SERVICE',1)!=0 OR
              StringLib.stringfind(first_name,'RECREATION ',1)!=0 OR
 	          StringLib.stringfind(first_name,'RECREATIONAL ',1)!=0 OR
              StringLib.stringfind(first_name,'RECREATION AREA',1)!=0 OR
	          StringLib.stringfind(first_name,'USED CARS',1)!=0 OR
	          StringLib.stringfind(first_name,'SONS INC',1)!=0 OR
              StringLib.stringfind(first_name,'SAILING ACCOC',1)!=0 OR
              StringLib.stringfind(first_name,'SAILING ASSOC',1)!=0 OR
              StringLib.stringfind(first_name,'SCOUT OF AMERICA',1)!=0 OR
              StringLib.stringfind(first_name,'STARLAND',1)!=0 OR
              StringLib.stringfind(first_name,'SOUTHERN',1)!=0 OR
              StringLib.stringfind(first_name,'SVC & EQUIPMENT',1)!=0 OR
              StringLib.stringfind(first_name,' SERVICES ',1)!=0 OR
	          StringLib.stringfind(first_name,'SERVICES ',1)!=0 OR
              StringLib.stringfind(first_name,'SURVEYORS & ENGINEERS',1)!=0 OR
	          StringLib.stringfind(first_name,' SURVEYORS ',1)!=0 OR
              StringLib.stringfind(first_name,' EQUIPMENT ',1)!=0 OR
              StringLib.stringfind(first_name,'NORTON & ASSOC. ',1)!=0  ) , 

       StringLib.StringToUpperCase(trim(trim(last_name)+','+trim(MID)+' '+trim(first_name))) , 
   
   if(( first_name<>'' AND StringLib.stringfind(StringLib.StringToUpperCase(first_name), ' OR ',1)!=0 OR 
     first_name<>'' AND StringLib.stringfind(StringLib.StringToUpperCase(first_name), ' &/OR ',1)!=0 OR 
     first_name<>'' AND StringLib.stringfind(StringLib.StringToUpperCase(first_name), ' AND/OR ',1)!=0 ) , 
     trim(v_firstname)+' '+trim(MID)+' '+ trim(last_name)+' OR '+ trim(v_firstname2)+' '+trim(last_name) , 

   if(first_name<>'' AND StringLib.stringfind(StringLib.StringToUpperCase(first_name), ' AND ',1)!=0 , 
   trim(v_secondname)+' '+trim(MID)+' '+ trim(last_name)+' AND '+ trim(v_secondname2)+' '+trim(last_name) , 

   if(first_name<>'' AND StringLib.stringfind(first_name,' & ',1)!=0  ,
   trim(v_ampname)+' '+trim(MID)+' '+ trim(last_name)+' & '+ trim(v_ampname2)+' '+trim(last_name) , 
   StringLib.StringToUpperCase(trim(trim(first_name)+' '+trim(MID)+' '+trim(last_name)))))));


              temp_name0 := StringLib.StringFindReplace(temp_name,'DTD11-7-95','');
	          temp_name1 := StringLib.StringFindReplace(temp_name0,'DATED 5-13-99','');
              temp_name2 := StringLib.StringFindReplace(temp_name1,'2-3-00','');
              temp_name3 := StringLib.StringFindReplace(temp_name2,'4-13-04','');
              temp_name4 := StringLib.StringFindReplace(temp_name3,'5/14/1993','');
              temp_name5 := StringLib.StringFindReplace(temp_name4,'DT 8-6-03','');
	          temp_name6 := StringLib.StringFindReplace(temp_name5,'11-13-92','');
	          temp_name7 := StringLib.StringFindReplace(temp_name6,'--','');
              temp_name8 := StringLib.StringFindReplace(temp_name7,'C/O','');
	          temp_name9 := StringLib.StringFindReplace(temp_name8,'ATTN:','');

return temp_name9 ; 
                 
end; 
