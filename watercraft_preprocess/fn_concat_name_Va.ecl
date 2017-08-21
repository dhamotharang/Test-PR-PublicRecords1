export fn_concat_name_Va( string FIRST_NAME , string LAST_NAME, string MID)  := function 

   string100 temp_name := 

             if(( StringLib.stringfind(FIRST_NAME,'C/O ',1) !=0 AND FIRST_NAME[1..4]='C/O ' OR
	      StringLib.stringfind(FIRST_NAME,'T/A ',1)!=0  AND FIRST_NAME[1..4]='T/A ' OR
	      StringLib.stringfind(FIRST_NAME,'DBA ',1)!=0  AND FIRST_NAME[1..4]='DBA ' OR
	      StringLib.stringfind(FIRST_NAME,'D/B/A/ ',1)!=0  AND FIRST_NAME[1..7]='D/B/A/ ' OR
	      StringLib.stringfind(FIRST_NAME,'D/B/A ',1)!=0  AND FIRST_NAME[1..6]='D/B/A ' ) , StringLib.StringToUpperCase(trim(trim(LAST_NAME,left,right)+' '+trim(FIRST_NAME,left,right)+' '+trim(MID,left,right))) ,
 	      if(regexfind( 'T/A |D/B/A/ |D/B/A |C/O |DBA ',FIRST_NAME) = true , StringLib.StringToUpperCase(trim(trim(FIRST_NAME,left,right)+' '+trim(MID,left,right)+' '+trim(LAST_NAME,left,right))) ,

             if( (StringLib.stringfind(LAST_NAME,'C/O ',1)!=0  AND LAST_NAME[1..4]='C/O ' OR
	      StringLib.stringfind(LAST_NAME,'T/A ',1)!=0  AND LAST_NAME[1..4]='T/A ' OR
	      StringLib.stringfind(LAST_NAME,'DBA ',1)!=0  AND LAST_NAME[1..4]='DBA ' OR
	      StringLib.stringfind(LAST_NAME,'D/B/A/ ',1)!=0  AND LAST_NAME[1..7]='D/B/A/ ' OR
	      StringLib.stringfind(LAST_NAME,'D/B/A ',1)!=0  AND LAST_NAME[1..6]='D/B/A ' ) , StringLib.StringToUpperCase(trim(FIRST_NAME,left,right)+' '+trim(MID,left,right)+' '+trim(LAST_NAME,left,right)) ,
	      if(regexfind( 'T/A |D/B/A/ |D/B/A |C/O |DBA ',LAST_NAME) =true , StringLib.StringToUpperCase(trim(trim(LAST_NAME,left,right)+' '+trim(FIRST_NAME,left,right)+' '+trim(MID,left,right))) ,

	     if((trim(FIRST_NAME)[1]='&' OR
	          StringLib.stringfind(FIRST_NAME,'AUTO SALES',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'ASSOC INC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' ASSOC ',1)!=0 OR
	          StringLib.stringfind(FIRST_NAME,'ASSOC ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'ASSOCIATES',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'ASSOCIATN',1)!=0 OR
	      StringLib.stringfind(FIRST_NAME,'AFFECTIVE ',1)!=0 OR
	      StringLib.stringfind(FIRST_NAME,'ADVENTURES',1)!=0 OR
	      StringLib.stringfind(FIRST_NAME,'ADVENTURE',1)!=0 OR
	      StringLib.stringfind(FIRST_NAME,'AUTHORITY',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'AND SONS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'& SON',1)!=0 OR
              trim(FIRST_NAME,left,right)='SONS' OR
              length(trim(FIRST_NAME,left,right))=3 AND StringLib.stringfind(FIRST_NAME,'AND ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'AMER. YACHT SALE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'AMER YACHT SALE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'PREFERRED AUTO',1)=0 AND StringLib.stringfind(FIRST_NAME,'AUTO ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BARBARA A PRINC',1)=0 AND StringLib.stringfind(FIRST_NAME,'INC ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BOAT HOUSES AND DOCKS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BOAT CLUB ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BOATS ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BOAT',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BOARD OF ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BOARD/SUPERVISOR',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BRD OF ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' BANK ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BOARD ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BODY & RV',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'BUILDERS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'COMPANY ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,' COMPANY ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CARPET ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CENTER',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CORP',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'COUNCIL',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CONSULTING INC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CONSERVATION',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CO INC.',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CO INC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'COUNTY WATER & SEWER',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'COTTAGE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CORROSION IND.INC.,',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CANOE & KAYAK CLUB',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CREEK LODGE & ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CONTRACTORS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CONSTRUCTION',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CONSTRUCT ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CONST CO',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'& CONST',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'COMMUNITY REC DIV',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'COMMONWEALTH OF VA',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'COMMON OF VA',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'COASTAL ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'COUNCIL BOY SCO',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CREDIT UNION ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CHURCH ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'COLLEGE OF ART & DES',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' CLUB ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'CLUB ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'DEVELOPMENT CO ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'DEPT ANIMAL ECOLOGY',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'DANIEL IRRIGATION CO',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'DIVISION OF FIRE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'DEPT OF GEN SVC ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'DOWNEAST ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'DUKE ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' SALES ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SALES ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RV SALES',1)!=0 OR
              length(trim(FIRST_NAME))=2 AND StringLib.stringfind(FIRST_NAME,'CO ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'ES W SMITH TRST',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'ELECTRIC COY IN',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'ELECTRIC CO ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'ELECTRONIC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'EQUIPMENT & SUPPLY',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'EQUIPMENT & SUP',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' EQPMT ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FORD & MERCURY',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FIRSTTRUST ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FOSS MOTOR CO ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FORD SALES INC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FORESTRY',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FIRE& EMERG. SERV.',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FARM & LAWN EQPMT',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FARM REAL',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FISH DIV ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'FISH DIV-',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'GIRL SCOUTS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'GUIDE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'GOLDEN ISL CR LINE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'GOV. HILL',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' CO ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'INC.',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'INC, ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'INC.,',1)!=0 OR
              length(trim(FIRST_NAME,left,right))=3 AND StringLib.stringfind(FIRST_NAME,'INC ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'INSURANCE AGENY ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'INSURANCE AGECNY ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'INSURANCE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'ISURANCE ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'INS ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'INTERNATIONAL',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'INTERNATI ',1)!=0 OR
	          StringLib.stringfind(FIRST_NAME,'LAW DIV ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'LAW DIV-',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'LODGE ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'L.L.C. ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'^LLC ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' LLC ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'LLC ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' LTD ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'^LTD ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' LTD$ ',1)!=0 OR
	          StringLib.stringfind(FIRST_NAME,'LTD ',1)!=0 OR
	          StringLib.stringfind(FIRST_NAME,' LLLP ',1)!=0 OR
	          StringLib.stringfind(FIRST_NAME,'LAKE MARINA & RESORT',1)!=0 OR
	          StringLib.stringfind(FIRST_NAME,'LOAN & INSURANCE',1)!=0 OR
	          StringLib.stringfind(FIRST_NAME,'LOBSTER',1)!=0 OR
	          StringLib.stringfind(FIRST_NAME,'RESORT ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,' RESEACH ',1)!=0 OR
              length(trim(FIRST_NAME,left,right))=3 AND StringLib.stringfind(FIRST_NAME,'LTD',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'LIFE & PARKS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'LIABILITY',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'& LAND SURVEYOR',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'PIPELINE CO ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'TRUST',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'THE WEST',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'TRSTUAT',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'TRUCK SALVAGE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'TRST DTD',1)!=0 OR  
              StringLib.stringfind(FIRST_NAME,'TRANSFER & STORAGE C',1)!=0 OR  
              StringLib.stringfind(FIRST_NAME,'TRANSFER & STORAGE CO ',1)!=0 OR  
              StringLib.stringfind(FIRST_NAME,'TRANSPORTATION',1)!=0 OR 
              StringLib.stringfind(FIRST_NAME,'REV TRST ',1)!=0 OR  
              StringLib.stringfind(FIRST_NAME,'ROAD & TRACK',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'TRUCKS & EQ INC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'TRUCKS & EQUIP',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'TRAILER',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'& PAINT INC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'& TRAILERS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'& SEAFOOD',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'& SPORTS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'& PAINT INC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'OF SDA',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'OF ROME GEORGIA',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'OUTDOOR REC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'OUTDOORS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'OUT REC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'OUND ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'ORGAN',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'OPTOMETRISTS P C',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'OPTOMETRISTS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'P TABOR FAM TRU',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'POINT ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'PROPERTY',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MACHINE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MARINE & SPORTS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MARINE & GUN ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MARINE & SPORTS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MARINE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MARINA LLC ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,' MARINA ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MAINTENANCE & REP',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MAINTENAN ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'METALS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'CORPORATION',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MOTORS ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MOTOR CO.',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MOTOR CO ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MOTOR ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'OIL CO ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'HOLDING CO',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RAILROAD CO.',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RANCH LLC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RENTALS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RENTAL',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'PROPERTIES LLC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'PLUMBING ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'MFG INC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'PARKS DEPT',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'PARK ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'PARKS ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'POLICE DEPT',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'POLICE ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'REC AND PARK',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'REALTY',1)!=0 OR
              length(trim(FIRST_NAME,left,right))=3 AND StringLib.stringfind(FIRST_NAME,'REC ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RECREATIONAL SERVICE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RECREATION ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'RECREATIONAL ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RECREATION AREA',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'REG ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'REG.',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RESOURCES',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'RESOURCE',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'USED CARS',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'SONS INC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SAILING ACCOC',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SAILING ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SAIL ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SCOUT OF AMERICA',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'STARLAND',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SOUTHERN',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SVC & EQUIPMENT',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,' SERVICES ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'SERVICES ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'SERVICE',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'SEASONS ',1)!=0 OR
			  StringLib.stringfind(FIRST_NAME,'SHERIFFS OFFICE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'STRUCTURE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SURVEYORS & ENGINEERS',1)!=0 OR
 	          StringLib.stringfind(FIRST_NAME,'SURVEYORS ',1)!=0 OR
 	          StringLib.stringfind(FIRST_NAME,'SURVEY',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SUPPORT',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SPORTS',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'SPORTING',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'TOWN OF',1)!=0 OR
              trim(FIRST_NAME,left,right)='TS' OR
              StringLib.stringfind(FIRST_NAME,' EQUIPMENT ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'YACHT',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'VA DIV OF',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'VPI & SU ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'WATERSHED ',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'WATER AUTHORITY',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'WILDLIFE',1)!=0 OR
              StringLib.stringfind(FIRST_NAME,'NORTON & ASSOC. ',1)!=0 ) ,
	          StringLib.StringToUpperCase(trim(trim(LAST_NAME,left,right)+' '+trim(FIRST_NAME,left,right)+' '+trim(MID,left,right))) ,
      	      StringLib.StringToUpperCase(trim(trim(FIRST_NAME,left,right)+' '+trim(MID,left,right)+' '+trim(LAST_NAME,left,right))))))));

          temp_name0 := StringLib.StringFindReplace(temp_name,'--','');
	      temp_name1 := StringLib.StringFindReplace(temp_name0,'  ',' ');
	      temp_name2 := StringLib.StringFindReplace(temp_name1,'ATTN:','');
     	  temp_name3 := StringLib.StringFindReplace(temp_name2,'(WROS)','');
	      temp_name4 := StringLib.StringFindReplace(temp_name3,' WROS ','');
	      temp_name5 := StringLib.StringFindReplace(temp_name4,'& &','&');
	      temp_name6 := StringLib.StringFindReplace(temp_name5,'08/01/2000','');
	      temp_name7 := StringLib.StringFindReplace(temp_name6,'#54-1037996','');
	      temp_name8 := StringLib.StringFindReplace(temp_name7,' OR SURVIVOR ','');
	      temp_name9 := StringLib.StringFindReplace(temp_name8,' OR SURV ','');
	      temp_name10 := StringLib.StringFindReplace(temp_name9,'JOHN P LUCKAM  CAROL M LUCKAM', 'JOHN P LUCKAM & CAROL M LUCKAM');
	      temp_name11 := StringLib.StringFindReplace(temp_name10,'DONALD R SQUYRES  RUIZ FILIPE', 'DONALD R SQUYRES & RUIZ FILIPE');
	      temp_name12 := StringLib.StringFindReplace(temp_name11,'THOMAS HUGHES IV  JILL F NEVVILE','THOMAS HUGHES IV & JILL F NEVVILE');
	      temp_name13 := StringLib.StringFindReplace(temp_name12,'MARTIN SHEILA  MCMASTERS KEITH','MARTIN SHEILA & MCMASTERS KEITH');
	      temp_name14 := StringLib.StringFindReplace(temp_name13,'WILLIAM 0 WEAKLEY & SHANNON C','WILLIAM O WEAKLEY & SHANNON C');
	      temp_name15 := StringLib.StringFindReplace(temp_name14,'WILLAM & NOLA W00D','WILLAM & NOLA WOOD');
	      temp_name16 := StringLib.StringFindReplace(temp_name15,'RICHARD W M0ON ','RICHARD W MOON');
	      temp_name17 := StringLib.StringFindReplace(temp_name16,'THOMPSON JR & III','THOMPSON III JR');
	      temp_name18 := StringLib.StringFindReplace(temp_name17,'MARK F #9','MARK F');
		
return temp_name18; 

end; 