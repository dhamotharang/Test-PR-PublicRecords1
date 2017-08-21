export fn_concat_name_GA( string FIRST_NAME , string LAST_NAME, string MID, string Suffix) := function 

 string100  temp_name := if( trim(FIRST_NAME,left,right)[1]='&' OR
              StringLib.StringFind(FIRST_NAME,'AUTO SALES',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'ASSOC INC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,' ASSOC ',1)!=0 OR
	          StringLib.StringFind(FIRST_NAME,'ASSOC ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'AND HUBBELL ENT',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'AND SONS',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'& SON',1)!=0 OR
              length(trim(FIRST_NAME,left,right))=3 AND StringLib.StringFind(FIRST_NAME,'AND ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'AMER. YACHT SALE',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'AMER YACHT SALE',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'PREFERRED AUTO',1)=0 AND StringLib.StringFind(FIRST_NAME,'AUTO ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'BARBARA A PRINC',1)=0 AND StringLib.StringFind(FIRST_NAME,'INC ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'ASSOCIATES',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'BOAT HOUSES AND DOCKS',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'COMPANY ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CARPET ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CENTER',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CORP',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'COUNCIL',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CONSULTING INC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CO INC.',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CO INC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'COUNTY WATER & SEWER',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CORROSION IND.INC.,',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CANOE & KAYAK CLUB',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CREEK LODGE & ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,' CLUB ',1)!=0 OR
	          StringLib.StringFind(FIRST_NAME,'CLUB ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'DEVELOPMENT CO ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'ES W SMITH TRST',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'FORD & MERCURY',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'FIRSTTRUST ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'FOSS MOTOR CO ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MACHINE',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'FORD SALES INC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'FIRE& EMERG. SERV.',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'FARM & LAWN EQPMT',1)!=0 OR
              length(trim(FIRST_NAME,left,right))=5 AND StringLib.StringFind(FIRST_NAME,'SALES ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'METALS',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'& PAINT INC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'OF SDA',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'OF ROME GEORGIA',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CONTRACTORS',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CONSTRUCTION',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'COMMUNITY REC DIV',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'COUNCIl BOY SCO',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CREDIT UNION ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CHURCH ',1)!=0 OR
	          StringLib.StringFind(FIRST_NAME,'COLLEGE OF ART & DES',1)!=0 OR
              length(trim(FIRST_NAME,left,right))=2 AND StringLib.StringFind(FIRST_NAME,'CO ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'ELECTRIC COY IN',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'ELECTRIC CO ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'EQUIPMENT & SUPPLY',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'EQUIPMENT & SUP',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,' EQPMT ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'GOLDEN ISL CR LINE',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'HOME & TIMBER',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,' CO ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'INC.',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'INC, ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'INC.,',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'INSPECTION & REPAIR',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'INSURANCE AGENY ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'INSURANCE AGECNY ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'DANIEL IRRIGATION CO',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'L.L.C. ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'^LLC ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,' LLC ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'LLC ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,' LTD ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'^LTD ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,' LTD$ ',1)!=0 OR
	      StringLib.StringFind(FIRST_NAME,'LTD ',1)!=0 OR
	      StringLib.StringFind(FIRST_NAME,' LLLP ',1)!=0 OR
	      StringLib.StringFind(FIRST_NAME,'LAKE MARINA & RESORT',1)!=0 OR
	      StringLib.StringFind(FIRST_NAME,'LOAN & INSURANCE',1)!=0 OR
	      StringLib.StringFind(FIRST_NAME,' RESORT ',1)!=0 OR
	      StringLib.StringFind(FIRST_NAME,' MARINA ',1)!=0 OR
              length(trim(FIRST_NAME,left,right))=3 AND StringLib.StringFind(FIRST_NAME,'LTD',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'LIFE & PARKS',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'& LAND SURVEYOR',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'PIPELINE CO ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'TRUST',1)!=0 OR
	          StringLib.StringFind(FIRST_NAME,'THE WEST',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'TRSTUAT',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'TRUCK SALVAGE',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'TRST DTD',1)!=0 OR  
              StringLib.StringFind(FIRST_NAME,'TRANSFER & STORAGE C',1)!=0 OR  
              StringLib.StringFind(FIRST_NAME,'TRANSFER & STORAGE CO ',1)!=0 OR  
              StringLib.StringFind(FIRST_NAME,'REV TRST ',1)!=0 OR  
              StringLib.StringFind(FIRST_NAME,'ROAD & TRACK',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'RENTALS',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'RENTAL',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'BOAT CLUB ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'TRUCKS & EQ INC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'TRUCKS & EQUIP',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'& PAINT INC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'& TRAILERS',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'OUTDOOR REC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'OPTOMETRISTS P C',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'OPTOMETRISTS',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'P TABOR FAM TRU',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MARINE & SPORTS',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MARINE & GUN ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MARINE',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MARINA LLC ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MAINTENANCE & REP',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MOVING & STORAGE',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MOVING & STORAG',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,' STORAGE',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'CORPORATION',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MOTORS ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MOTOR CO.',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MOTOR CO ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MOTOR ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'OIL CO ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'HOLDING CO',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'RAILROAD CO.',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'RANCH LLC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'PROPERTIES LLC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'PLUMBING ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'MFG INC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'PARKS DEPT',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'PARK ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'PARKS ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'REC AND PARK',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'RECREATIONAL SERVICE',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'RECREATION ',1)!=0 OR
 	          StringLib.StringFind(FIRST_NAME,'RECREATIONAL ',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'RECREATION AREA',1)!=0 OR
	          StringLib.StringFind(FIRST_NAME,'USED CARS',1)!=0 OR
	          StringLib.StringFind(FIRST_NAME,'SONS INC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'SAILING ACCOC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'SAILING ASSOC',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'STARLAND',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'SOUTHERN',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,'SVC & EQUIPMENT',1)!=0 OR
              StringLib.StringFind(FIRST_NAME,' EQUIPMENT ',1)!=0 OR

              StringLib.StringFind(FIRST_NAME,'NORTON & ASSOC. ',1)!=0 , StringLib.StringToUpperCase(trim(trim(LAST_NAME,left,right)+' '+trim(FIRST_NAME,left,right),left,right)) , 
            
	          if(StringLib.StringFind(FIRST_NAME,' JR ',1)!= 0 ,  StringLib.StringToUpperCase(trim(trim(StringLib.StringFindReplace(FIRST_NAME,' JR ',''),left,right)+' '+regexreplace('1|2|3|4|5|6|7|8|9',trim(MID,left,right),'')+' '+trim(LAST_NAME,left,right)+' '+'JR')) ,
              if(StringLib.StringFind(FIRST_NAME,' SR ',1)!= 0 , StringLib.StringToUpperCase(trim(trim(StringLib.StringFindReplace(FIRST_NAME,' SR ',''),left,right)+' '+regexreplace('1|2|3|4|5|6|7|8|9',trim(MID,left,right),'')+' '+trim(LAST_NAME,left,right)+' '+'SR')) ,
              if(StringLib.StringFind(FIRST_NAME,' I ',1)!= 0  ,  StringLib.StringToUpperCase(trim(trim(StringLib.StringFindReplace(FIRST_NAME,' I ',''),left,right)+' '+regexreplace('1|2|3|4|5|6|7|8|9',trim(MID,left,right),'')+' '+trim(LAST_NAME,left,right)+' '+'I')) ,
              if(StringLib.StringFind(FIRST_NAME,' II ',1)!= 0  , StringLib.StringToUpperCase(trim(trim(StringLib.StringFindReplace(FIRST_NAME,' II ',''),left,right)+' '+regexreplace('1|2|3|4|5|6|7|8|9',trim(MID,left,right),'')+' '+trim(LAST_NAME,left,right)+' '+'II')) ,
              if(StringLib.StringFind(FIRST_NAME,' III ',1)!= 0 , StringLib.StringToUpperCase(trim(trim(StringLib.StringFindReplace(FIRST_NAME,' III ',''),left,right)+' '+regexreplace('1|2|3|4|5|6|7|8|9',trim(MID,left,right),'')+' '+trim(LAST_NAME,left,right)+' '+'III')) ,
               StringLib.StringToUpperCase(trim(trim(FIRST_NAME,left,right)+' '+regexreplace('1|2|3|4|5|6|7|8|9',trim(MID,left,right),'')+' '+trim(LAST_NAME,left,right)+' '+StringLib.StringFindReplace(trim(suffix,left,right), 'MR.','MR')))))))));
 						                        
              temp_name1 := StringLib.StringFindReplace(temp_name,'DTD11-7-95','');
	          temp_name2 := StringLib.StringFindReplace(temp_name1,'DATED 5-13-99','');
              temp_name3 := StringLib.StringFindReplace(temp_name2,'2-3-00','');
              temp_name4 := StringLib.StringFindReplace(temp_name3,'4-13-04','');
              temp_name5 := StringLib.StringFindReplace(temp_name4,'5/14/1993','');
              temp_name6 := StringLib.StringFindReplace(temp_name5,'DT 8-6-03','');
	          temp_name7 := StringLib.StringFindReplace(temp_name6,'11-13-92','');
	          temp_name8 := StringLib.StringFindReplace(temp_name7,'--','');
              temp_name9 := StringLib.StringFindReplace(temp_name8,'C/O','');
	          temp_name10 := StringLib.StringFindReplace(temp_name9,'ATTN:','');
		  
		  
return temp_name10; 
end; 