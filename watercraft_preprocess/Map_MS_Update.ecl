import watercraft,ut,address,AID,header,watercraft_preprocess;

// translates  ms_phase01.mp Ab intio graph into ECL 

fIn_raw := watercraft_preprocess.Files_raw.MS ; 

fnameRef := project(fIn_raw , transform({fIn_raw} , 

            self.EXPIRE_DATE := if(trim(left.EXPIRE_DATE,left,right)[1]< '3', '20'+trim(left.EXPIRE_DATE,left,right), '19'+trim(left.EXPIRE_DATE,left,right));
			self := left)); 

fcompanyNames := project(fnameRef(watercraft_preprocess.Mod_Clean_Entities.filterCompany(first_name,last_name)= true), 
                   transform( {fIn_raw, string concat_name }, 
				   self.concat_name := if(StringLib.StringFind(left.FIRST_NAME, ' AND ',1)>0 , StringLib.StringToUpperCase(trim(left.FIRST_NAME,left,right)+' '+trim(left.LAST_NAME)) ,
	      
		                           if(StringLib.StringFind(left.LAST_NAME, ' AND ',1) >0  ,StringLib.StringToUpperCase(trim(left.LAST_NAME)+' '+trim(left.FIRST_NAME)) , StringLib.StringToUpperCase(trim(left.FIRST_NAME)+' '+trim(left.LAST_NAME))));

				   self := left )); 

Address.Mac_Is_Business(fcompanyNames,concat_name,fNametype,name_type);

fNametype_1 := project(fNametype, transform({Watercraft.Layout_MS_clean_in} , 

  self.is_company_flag := if(left.name_type ='B', 1,0);
  self.clean_pname1 := if(left.name_type <>'B',Address.CleanPersonFML73(left.concat_name),''); 
  self.clean_pname2 := '';
  self.clean_cname := if(left.name_type ='B', left.concat_name[1..73],'');
  self.clean_address := ''; 
  self.process_date := watercraft_preprocess.version; 
  self.state_origin := 'MS'; 
  self := left)); 

fNcompanyNames := fnameRef(watercraft_preprocess.Mod_Clean_Entities.filterCompany(first_name,last_name)=false); 
						
watercraft_preprocess.fn_concat_name_MS( fNcompanyNames, fNcompanyNamesp);

Address.Mac_Is_Business(fNcompanyNamesp,temp_name,fNametypeout,name_type);

fNametype_2  := project(fNametypeout, transform({Watercraft.Layout_MS_clean_in}, 

             pname := Address.CleanPersonFML73(left.temp_name);

   self.is_company_flag := if(left.name_type ='B', 1,0);
   
   self.clean_pname1 := if(StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1) = 0 AND StringLib.StringFind(left.FIRST_NAME,' OR ',1)!=0 AND left.name_type <>'B',  Address.CleanPersonFML73(trim(left.v_firstname,left,right)+' '+trim(left.LAST_NAME,left,right)), 
			if(( StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1) =0 AnD StringLib.StringFind(left.FIRST_NAME,' OR ',1) = 0) AND StringLib.StringFind(left.FIRST_NAME,' AND ',1)!=0 AND left.name_type <>'B', Address.CleanPersonFML73(trim(left.v_secondname)+' '+trim(left.LAST_NAME,left,right)) ,
			if(( StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1) = 0 AND StringLib.StringFind(left.FIRST_NAME,' OR ',1)= 0 AND StringLib.StringFind(left.FIRST_NAME,' AND ',1)= 0 ) AND StringLib.StringFind(left.FIRST_NAME,'/',1)!=0 AND left.name_type <>'B', Address.CleanPersonFML73(trim(left.v_slashname,left,right)+' '+trim(left.LAST_NAME,left,right)), 
	        if(left.name_type <> 'B' , pname , ''))));
		        
   self.clean_pname2 :=  if( StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1) = 0 AND StringLib.StringFind(left.FIRST_NAME,' OR ',1)!=0 AND left.name_type <>'B', Address.CleanPersonFML73(trim(left.v_firstname2)+' '+trim(left.LAST_NAME)) ,
			if(( StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1)=0 AND StringLib.StringFind(left.FIRST_NAME,' OR ',1) = 0) AND StringLib.StringFind(left.FIRST_NAME,' AND ',1)!=0 AND left.name_type <>'B' ,Address.CleanPersonFML73(trim(left.v_secondname2,left,right)+' '+trim(left.LAST_NAME,left,right)) , 
			if(( StringLib.StringFind(StringLib.StringToUpperCase(left.FIRST_NAME), '10',1)=0 AND StringLib.StringFind(left.FIRST_NAME,' OR ',1)=0 AND StringLib.StringFind(left.FIRST_NAME,' AND ',1) = 0) AND StringLib.StringFind(left.FIRST_NAME,'/',1)!=0 AND left.name_type <>'B', Address.CleanPersonFML73(trim(left.v_slashname2,left,right)+' '+trim(left.LAST_NAME,left,right)) 
  			 , '')));
		       
  self.clean_cname :=  if(left.name_type = 'B', left.temp_name[1..73],''); 
  self.concat_name := left.temp_name; 
  self.clean_address := ''; 
  self.process_date := watercraft_preprocess.version; 
  self.state_origin := 'MS'; 
  self := left; 
  
)); 


fclean := fNametype_1 +fNametype_2; 
export Map_MS_Update := sequential(output(fclean,,watercraft.Cluster_In+'in::watercraft_MS_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_MS', watercraft.Cluster_In+'in::watercraft_MS_'+watercraft_preprocess.version)
								  ) ;
 