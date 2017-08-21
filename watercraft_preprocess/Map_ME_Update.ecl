import watercraft,ut,address,AID,header,idl_header,watercraft_preprocess;

// translates me_phase01.mp Ab intio graph into ECL

export fn_temp_bname(string temp_business_name) := function 

          temp_business_name0 := StringLib.StringFindReplace(temp_business_name,'--','');
          temp_business_name1 := StringLib.StringFindReplace(temp_business_name0,'C/O','');
	      temp_business_name2 := StringLib.StringFindReplace(temp_business_name1,'ATTN:','');
	      temp_business_name3 := StringLib.StringFindReplace(temp_business_name2,'C HRIS','CHRIS');
	      temp_business_name4 := StringLib.StringFindReplace(temp_business_name3,'M ICHAEL','MICHAEL');
	      temp_business_name5 := StringLib.StringFindReplace(temp_business_name4,'S ONS','SONS');
	      temp_business_name6 := StringLib.StringFindReplace(temp_business_name5,'INVESTMEN TS','INVESTMENTS');
	      temp_business_name7 := trim(StringLib.StringFindReplace(temp_business_name6,'I F & W','DEPARTMENT OF INLAND FISHERIES & WILDLIFE '),left,right);
	      temp_business_name8 := trim(StringLib.StringFindReplace(temp_business_name7,'I F&W','DEPARTMENT OF INLAND FISHERIES & WILDLIFE '),left,right);
	      temp_business_name9 := trim(StringLib.StringFindReplace(temp_business_name8,'IF & W','DEPARTMENT OF INLAND FISHERIES & WILDLIFE '),left,right);
	      temp_business_name_res := trim(StringLib.StringFindReplace(temp_business_name9,'IF&W ','DEPARTMENT OF INLAND FISHERIES & WILDLIFE '),left,right);             
  
  return temp_business_name_res; 
  end ; 
fIn_raw := watercraft_preprocess.Files_raw.ME ; 

temp_rec := {Watercraft.layout_ME,string1 name_format,
             string100	   concat_name;
			 string73      clean_secondary_pname;
			 string100     clean_secondary_cname;
			 string73      clean_business_contact_pname;
			 string100     clean_business_cname};  

fprecelan := project(fIn_raw , transform({ temp_rec} , 
 
			temp_FIRST_NAME  := if(StringLib.StringFind(left.FIRST_NAME, ' JR ',1)!=0  , StringLib.StringFindReplace(left.FIRST_NAME, ' JR ', ' ') ,
								if(trim(left.FIRST_NAME,left,right)='JR'  , StringLib.StringFindReplace(left.FIRST_NAME, 'JR', ' ') ,
								if(StringLib.StringFind(left.FIRST_NAME, ' SR ',1)!=0  ,  StringLib.StringFindReplace(left.FIRST_NAME, ' SR ', ' ') ,
								if(trim(left.FIRST_NAME,left,right)='SR'  , StringLib.StringFindReplace(left.FIRST_NAME, 'SR', '') ,
								if(StringLib.StringFind(left.FIRST_NAME, ' II ',1)!=0  , StringLib.StringFindReplace(left.FIRST_NAME, ' II ', ' ') ,
								if(StringLib.StringFind(left.FIRST_NAME, ' III ',1)!=0  , StringLib.StringFindReplace(left.FIRST_NAME, ' III ', ' ') ,
								if(StringLib.StringFind(left.FIRST_NAME, ' IV ',1)!=0  ,  StringLib.StringFindReplace(left.FIRST_NAME, ' IV ', ' ') , left.FIRST_NAME)))))));

			temp_MID  := 	    if(StringLib.StringFind(left.MID, ' JR ',1)!=0  ,  StringLib.StringFindReplace(left.MID, ' JR ', ' ') ,
								if(trim(left.MID,left,right)='JR'  , StringLib.StringFindReplace(left.MID, 'JR', ' ') ,
								if(left.MID[1..3]='JR '  , StringLib.StringFindReplace(left.MID, 'JR ', ' ') ,
								if(StringLib.StringFind(left.MID, ' SR ',1)!=0  ,  StringLib.StringFindReplace(left.MID, ' SR ', ' ') ,
								if(trim(left.MID,left,right)='SR'  , StringLib.StringFindReplace(left.MID, 'SR', '') ,
								if(left.MID[1..3]='SR '  , StringLib.StringFindReplace(left.MID, 'SR ', ' ') ,
								if(StringLib.StringFind(left.MID, ' II ',1)!=0  ,  StringLib.StringFindReplace(left.MID, ' II ', ' ') ,
								if(trim(left.MID,left,right)='II'  , StringLib.StringFindReplace(left.MID, 'II ', ' ') ,
								if(StringLib.StringFind(left.MID, ' III ',1)!=0  ,  StringLib.StringFindReplace(left.MID, ' III ', ' ') ,
								if(trim(left.MID,left,right)='III'  , StringLib.StringFindReplace(left.MID, 'III ', ' ') ,
								if(StringLib.StringFind(left.MID, ' IV ',1)!=0  ,  StringLib.StringFindReplace(left.MID, ' IV ', ' ') ,
								if(trim(left.MID,left,right)='IV'  , StringLib.StringFindReplace(left.MID, 'IV ', ' ') , left.MID))))))))))));

			temp_LAST_NAME :=  
								if(( StringLib.StringFind(left.MID, ' JR ',1)!=0  OR trim(left.MID,left,right)='JR' OR left.MID[1..3]='JR ' ) OR 
								( StringLib.StringFind(left.FIRST_NAME, ' JR ',1)!=0  OR trim(left.FIRST_NAME,left,right)='JR' )  , trim(left.LAST_NAME,left,right)+ ' JR ' , 
								if(( StringLib.StringFind(left.MID, ' SR ',1)!=0  OR  trim(left.MID,left,right)='SR' OR left.MID[1..3]='SR ') OR
								( StringLib.StringFind(left.FIRST_NAME, ' SR ',1)!=0  OR trim(left.FIRST_NAME,left,right)='SR' )  , trim(left.LAST_NAME,left,right)+ ' SR ' , 
								if(( StringLib.StringFind(left.MID, ' II ',1)!=0  OR  trim(left.MID,left,right)='II' OR StringLib.StringFind(left.FIRST_NAME, ' II ',1)!=0 )  ,trim(left.LAST_NAME,left,right)+ ' II ' ,
								if(( StringLib.StringFind(left.MID, ' III ',1)!=0  OR trim(left.MID,left,right)='III' OR StringLib.StringFind(left.FIRST_NAME, ' III ',1)!=0 )  ,trim(left.LAST_NAME,left,right)+ ' III ' ,
								if(( StringLib.StringFind(left.MID, ' IV ',1)!=0  OR  trim(left.MID,left,right)='IV' OR StringLib.StringFind(left.FIRST_NAME, ' IV ',1)!=0  ) , trim(left.LAST_NAME,left,right)+ ' IV ' , left.LAST_NAME)))));


            temp_business_name := if(StringLib.StringFind(left.BUSINESS_NAME, '11-',1) != 0 ,left.BUSINESS_NAME[ 1.. StringLib.StringFind(left.BUSINESS_NAME, '11-',1) -1],
                                  if(StringLib.StringFind(left.BUSINESS_NAME, '12-',1) != 0 , left.BUSINESS_NAME[1.. StringLib.StringFind(left.BUSINESS_NAME, '12-',1) -1],left.BUSINESS_NAME));
              
    
   self.concat_name := watercraft_preprocess.Mod_Clean_Entities.TrimandUp(watercraft_preprocess.fn_concat_name_ME(temp_FIRST_NAME,temp_MID,temp_LAST_NAME,left.suffix));  
   self.first_name := temp_FIRST_NAME; 
   self.last_name := temp_LAST_NAME;
   self.mid := temp_MID ; 
   self.clean_secondary_pname :=if((StringLib.StringFind(left.SECONDARY_OWNER, 'PROPERTIES',1) != 0 OR 
                                StringLib.StringFind(left.SECONDARY_OWNER, 'INC',1) != 0 OR
                                StringLib.StringFind(left.SECONDARY_OWNER, 'MARINE',1) != 0 OR
                                StringLib.StringFind(left.SECONDARY_OWNER, 'TRUST',1) != 0 ) OR left.SECONDARY_OWNER ='', ' ',StringLib.StringFindReplace(Address.CleanPersonFML73(left.SECONDARY_OWNER), '4', ' '));

   self.clean_secondary_cname := if((StringLib.StringFind(left.SECONDARY_OWNER, 'PROPERTIES',1) != 0 OR 
                                StringLib.StringFind(left.SECONDARY_OWNER, 'INC',1) != 0 OR
                                StringLib.StringFind(left.SECONDARY_OWNER, 'MARINE',1) != 0 OR
                                StringLib.StringFind(left.SECONDARY_OWNER, 'TRUST',1) != 0 ), left.SECONDARY_OWNER,' ');
   
   self.clean_business_contact_pname := if(left.BUSINESS_CONTACT<>'', Address.CleanPersonFML73(left.BUSINESS_CONTACT), ' ');
   self.clean_business_cname := fn_temp_bname(temp_business_name);
   
   self.name_format := if(StringLib.StringFind(self.concat_name,',',1)!=0 ,'L' , 'U');

   self := left)); 
   
   ut.Mac_Clean_Dual_Names(fprecelan,concat_name,fcelanDname,name_format);
		   
fcleanaddr := project( fcelanDname , transform({Watercraft.Layout_ME_clean_in}, 
                     string9 temp_residence_zip := if(trim(left.RESIDENCE_ZIP,left,right) <>'',left.RESIDENCE_ZIP, left.RESIDENCE_POSTAL_CODE);


   self.clean_address :='';
   self.state_origin := 'ME'; 
   self.process_date := watercraft_preprocess.version; 
                  self := left)); 
							  
		  
export Map_ME_Update := sequential(output(fcleanaddr,,watercraft.Cluster_In+'in::watercraft_me_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_me', watercraft.Cluster_In+'in::watercraft_me_'+watercraft_preprocess.version)
								  ) ;