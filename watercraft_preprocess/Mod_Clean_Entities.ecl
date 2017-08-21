export Mod_Clean_Entities := module

//Clean Company Name 

export  cleanCompany(string company)	:= FUNCTION
return  StringLib.StringCleanSpaces((TRIM(company,LEFT,RIGHT)));
END;

export  TrimandUp( string name) := FUNCTION 
return  StringLib.StringToUpperCase(trim(name,left,right)); 
END; 

export  FixSuffix( string name) := FUNCTION 

       v_name0:=StringLib.StringFindReplace(name,',JR',' JR');
       v_name1:=StringLib.StringFindReplace(v_name0,',SR',' SR');
   	   v_name2:=StringLib.StringFindReplace(v_name1,',II',' II');
	   v_name3:=StringLib.StringFindReplace(v_name2,', II',' II');
       v_name4:=StringLib.StringFindReplace(v_name3,', 2ND',' II');
	   v_name5:=StringLib.StringFindReplace(v_name4,',2ND',' II');
       v_name6:=StringLib.StringFindReplace(v_name5,',3RD',' III');
	   v_name7:=StringLib.StringFindReplace(v_name6,', 3RD',' III');
       v_name8:=StringLib.StringFindReplace(v_name7,',III',' III');
	   v_name9:=StringLib.StringFindReplace(v_name8,',4TH',' IV');
       v_name10:=StringLib.StringFindReplace(v_name9,', 4TH',' IV');
	   v_name11:=StringLib.StringFindReplace(v_name10,' 4TH',' IV');
	   v_name12:=StringLib.StringFindReplace(v_name11,' 3RD',' III');
       v_name13:=StringLib.StringFindReplace(v_name12,' 2ND',' II');
 	   v_name14:=StringLib.StringFindReplace(v_name13,',5TH',' V');
       v_name15:=StringLib.StringFindReplace(v_name14,', 5TH',' V');
	   v_name16:=StringLib.StringFindReplace(v_name15,' 5TH',' V');
return v_name16 ; 
end; 	   

export  StrReplace( string name) := FUNCTION 
//x:= regexreplace(' AND | AND/| OR |/OR |.OR|,OR| 0R | FOR | C/O |F/K/A|&w|&W|&|&/| + ',, '!');

out_string1 := StringLib.StringFindReplace(trim(name,left,right) ,' AND ' ,'!') ;
out_string2 := StringLib.StringFindReplace(trim(out_string1,left,right) ,' AND/' ,'!') ;
out_string3 := StringLib.StringFindReplace(trim(out_string2,left,right) ,' OR ' ,'!') ;
out_string4 := StringLib.StringFindReplace(trim(out_string3,left,right) ,'/OR ' ,'!') ;
out_string5 := StringLib.StringFindReplace(trim(out_string4,left,right) ,'.OR' ,'!') ;
out_string6 := StringLib.StringFindReplace(trim(out_string5,left,right) ,',OR ' ,'!') ;
out_string7 := StringLib.StringFindReplace(trim(out_string6,left,right) ,' 0R ' ,'!') ;
out_string8 := StringLib.StringFindReplace(trim(out_string7,left,right) ,' FOR ' ,'!') ;
out_string9 := StringLib.StringFindReplace(trim(out_string8,left,right) ,' C/O ' ,'!') ;
out_string10 := StringLib.StringFindReplace(trim(out_string9,left,right) ,'F/K/A' ,'!') ;
out_string11 := StringLib.StringFindReplace(trim(out_string10,left,right) ,'&w' ,'!') ;
out_string12 := StringLib.StringFindReplace(trim(out_string11,left,right) ,'&W' ,'!') ;
out_string13 := StringLib.StringFindReplace(trim(out_string12,left,right) ,'&' ,'!') ;
out_string14 := StringLib.StringFindReplace(trim(out_string13,left,right) ,'&/' ,'!') ;
out_string15 := StringLib.StringFindReplace(trim(out_string14,left,right) ,',C/O ' ,'!') ;
out_string16 := StringLib.StringFindReplace(trim(out_string15,left,right) ,',AND ' ,'!') ;
out_string17 := StringLib.StringFindReplace(trim(out_string16,left,right) ,' AKA ' ,'!') ;
out_string18 := StringLib.StringFindReplace(trim(out_string17,left,right) ,' A/K/A ' ,'!') ;
out_string19 := StringLib.StringFindReplace(trim(out_string18,left,right) ,'A/K/A' ,'!') ;
out_string20 := StringLib.StringFindReplace(trim(out_string19,left,right) ,' FKA ' ,'!') ;
out_string21 := StringLib.StringFindReplace(trim(out_string20,left,right) ,' FKA/' ,'!') ;
out_string22 := StringLib.StringFindReplace(trim(out_string21,left,right) ,' AKA/' ,'!') ;
return out_string22;
end ;
export  StrReplacedba( string name,boolean is_pct) := FUNCTION 

out_string0 := StringLib.StringFindReplace(trim(name,left,right) ,' DBA ' ,'!') ;
out_string1 := StringLib.StringFindReplace(trim(out_string0,left,right) ,' D/B/A ' ,'!') ;
out_string2 := StringLib.StringFindReplace(trim(out_string1,left,right) ,'%' ,'!') ;
//out_string2 := StringLib.StringFindReplace(trim(out_string1,left,right) ,' T/A ' ,'!') ;
return if(is_pct = true , out_string2,out_string1) ; 
end; 

export  ReplaceFirst( string name) := FUNCTION  

x_index := if(StringLib.StringFind(name, ',', 1)>0, 
              StringLib.StringFind(name, ',', 1),0); 
rep_first:=if( StringLib.StringFind(name, ',', 1)>0,
            name[1..x_index-1]+ StringLib.StringFindReplace(name[x_index],',','~')+ name[x_index+1..],
		    name);
return rep_first ;
END;

export  IsOneWord(string name)     := FUNCTION 

string175 temp_name := TrimandUp(name);

string1 v_one_word_flag :=if(StringLib.StringFind(temp_name,',',1)=0 and  
                           StringLib.StringFind(temp_name,' & ',1)=0 and   
		 	               temp_name<>''  and 
		  	               length(temp_name) =length(trim(regexreplace(' ',temp_name,'')))
		                   , 'Y' , '');

  out := if(v_one_word_flag='', 0 , 1);
return out; 
END;

export  concat_name (string in_prefix, string in_fname, string in_mname, string in_lname, string in_suffix) := function 

// in_prefix and in_suffix may not always be provided

result  := TrimandUp(
            if(StringLib.StringFilterOut(in_prefix,'.')<>'' , trim(in_prefix,left,right) , '')+
             if(StringLib.StringFilterOut(in_fname,'.') <>'', ' '+ trim(in_fname,left,right)  , '')+
             if(StringLib.StringFilterOut(in_mname,'.') <>'' , ' '+ trim(in_mname,left,right)  , '')+
             if(StringLib.StringFilterOut(in_lname,'.') <>''  , ' '+ trim(in_lname,left,right)  , '')+
             if(StringLib.StringFilterOut(in_suffix,'.') <>'' , ' '+ trim(in_suffix,left,right) , ''));
            
       
return result ; 
end ; 

export filterCompany(string FIRST_NAME,string LAST_NAME ) := function 

boolean result := StringLib.StringFind(FIRST_NAME, ' AND ',1) >0  AND 
	      ( StringLib.StringFind(LAST_NAME,'INC ',1) != 0  OR
	          StringLib.StringFind(LAST_NAME,'INC.',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'ASSOCIATES',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'BENTON',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'CORP ',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'SALES ',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'AUTO SALES ',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'BOAT CLUB ',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'BEACH CLU',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'CONTRACTORS',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'CONSTRUCTION',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'COMPANY ',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'INC, ',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'SERVICES',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'MARINE',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'SPORTS',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'WILDLIFE',1)!= 0 ) OR

		StringLib.StringFind(LAST_NAME, ' AND ',1)!= 0 AND
 	      ( StringLib.StringFind(FIRST_NAME,'INC ',1) != 0  OR
	       StringLib.StringFind(FIRST_NAME,'INC.',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'ASSOCIATES',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'BENTON',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'CORP ',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'SALES ',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'SALE',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'AUTO SALES ',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'BOAT CLUB ',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'BEACH CLU',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'CONTRACTORS',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'CONSTRUCTION',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'COMPANY ',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'INC, ',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'SERVICE',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'MARINE',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'SPORTS',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'WILDLIFE',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'FARMS',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'SUPPLY',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'PRINTING',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'RENTALS',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'CHARTERS',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'CAMPGROUND',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'SPACEADMN',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'RESEARCH',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'WELFARE',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,' CO ',1)!= 0 OR
			   StringLib.StringFind(FIRST_NAME,'LLC',1)!= 0 OR 
			  StringLib.StringFind(FIRST_NAME,'FAMILY',1)!= 0 OR 
			  StringLib.StringFind(FIRST_NAME,'CONSULTING',1)!= 0 OR
			  StringLib.StringFind(FIRST_NAME,'ORTHOPEDIC',1)!= 0 OR 
			  StringLib.StringFind(FIRST_NAME,'RENTALS',1)!= 0 OR 
			  StringLib.StringFind(FIRST_NAME,'CONSTRUCTION',1)!= 0 OR 
			  StringLib.StringFind(FIRST_NAME,'ENTERPRISES',1)!= 0 OR 
              StringLib.StringFind(FIRST_NAME,'SOUTHERN',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'MISSISSIPPI',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'AVIATION',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'CLERANCE',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'FARM',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'RESCUE',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'OIL DOCK',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'CONST CO',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'GARDEN',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'TIMBER',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'COLD STRG',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'WASHING',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'WILD',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'WATER SPTS',1)!= 0 OR
              StringLib.StringFind(FIRST_NAME,'SESSIONS',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'CASUALTY',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'WATER SPTS',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'DEV.',1)!= 0 OR
              StringLib.StringFind(LAST_NAME,'WILD',1)!= 0 OR
			  StringLib.StringFind(LAST_NAME,'LLC',1)!= 0 OR 
			  StringLib.StringFind(LAST_NAME,'FAMILY',1)!= 0 OR 
			  StringLib.StringFind(LAST_NAME,'CONSULTING',1)!= 0 OR
			  StringLib.StringFind(LAST_NAME,'ORTHOPEDIC',1)!= 0 OR 
			  StringLib.StringFind(LAST_NAME,'RENTALS',1)!= 0 OR 
			  StringLib.StringFind(LAST_NAME,'CONSTRUCTION',1)!= 0 OR 
			  StringLib.StringFind(LAST_NAME,'ENTERPRISES',1)!= 0 OR 
              StringLib.StringFind(LAST_NAME,'CONST ',1)!= 0);

return result ; 
end; 

export fixsuffix_initial(string name ) := function 

string_last_index := StringLib.StringFind(trim(NAME,left,right), ' ',StringLib.StringFindCount(trim(NAME,left,right), ' ')); 
boolean  is_suffix := if(trim(NAME,left,right)[string_last_index+1] in ['J','S','1','2','3','4','5'], true ,false); 
string suff_initial := trim(NAME,left,right)[string_last_index+1] ; 
 
       result:=map(is_suffix and suff_initial ='J' => StringLib.StringFindReplace(suff_initial,'J','JR'), 
                    is_suffix and suff_initial ='S' =>   StringLib.StringFindReplace(suff_initial,'S','SR'),
   	   is_suffix and suff_initial ='1' =>StringLib.StringFindReplace(suff_initial,'1','I'),
	   is_suffix and suff_initial ='2' => StringLib.StringFindReplace(suff_initial,'2','II'),
       is_suffix and suff_initial ='3' => StringLib.StringFindReplace(suff_initial,'3','III'),
       is_suffix and suff_initial ='4' => StringLib.StringFindReplace(suff_initial,'4','IV'),
	   is_suffix and suff_initial ='5' =>StringLib.StringFindReplace(suff_initial,'5','V'),''); 
return result; 
end; 

END;