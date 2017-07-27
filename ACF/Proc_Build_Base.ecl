IMPORT Address,Business_header,Business_header_ss,ut,ACF;

EXPORT Proc_Build_Base (STRING filedate) 
:= FUNCTION 

dBase		 	:= Mapping_Cleansing(filedate) ;

dBaseFile       :=SORT(DISTRIBUTE(dBase+File_ACF_Base ,HASH(COMPANY_NAME,orig_name,company_title)),record,LOCAL);

Layout_Base  t_rollup(dBase pleft, dBase pRight) 
   := TRANSFORM
		SELF.Dt_First_Seen := IF(pleft.dt_First_Seen >pright.Dt_First_Seen,pright.Dt_First_Seen, pleft.Dt_First_Seen);
		SELF.Dt_Last_Seen  := IF(pleft.dt_Last_Seen  <pright.Dt_Last_Seen, pright.Dt_Last_Seen,  pleft.Dt_Last_Seen);
		SELF := pleft;
   END;

dBaseout := ROLLUP(dBaseFile,t_rollup(LEFT,RIGHT),RECORD, EXCEPT Dt_First_Seen,msa,geo_lat,geo_long,local);

ut.mac_suppress_by_phonetype(dBaseout,phone,state,dBaseout_Clean_Phones);
ut.mac_suppress_by_phonetype(dBaseout_Clean_Phones,company_phone,state,dBaseout_Clean_Comp_Phones);

Temp_Layout_Base := record
		ACF.Layout_Base;
		string5 	temp_company_zip 		:= '';
		string10	temp_company_phone	:= '';
		end;

Temp_Layout_Base  integer_2_string(dBaseout_Clean_Phones l) 
   := TRANSFORM
		SELF.temp_company_zip 		:= (string5)l.company_zip;
		SELF.temp_company_phone  	:= (string10)l.company_phone;
		SELF 											:= l;
end;

ds_temp := project(dBaseout_Clean_Phones,integer_2_string(left));

myset := ['A','P'];

business_header_ss.MAC_Match_Flex(
			 ds_temp															// input dataset						
			,myset				                				// bdid matchset what fields to match on           
			,company_name              						// company_name	              
			,company_prim_range		           			// prim_range		              
			,company_prim_name		             		// prim_name		              
			,temp_company_zip					            // zip					              
			,company_sec_range		             		// sec_range		              
			,company_state				        	 			// state				              
			,temp_company_phone		                // phone				              
			,foo            			          			// fein              
			,bdid																  // bdid												
			,Temp_Layout_Base    									// output layout 
			,false                                // output layout has bdid score field? 																	
			,foo                     							// bdid_score                 
			,dbase_temp		          							// output dataset
			,																			// keep count
			,																			// default threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set							// create BIP keys only
			,																			// url
			,email_address												// email 
			,company_city													// city
			,fname																// fname
			,mname																// mname
			,lname																// lname
		);					

dbase_out := project(dbase_temp,transform(Layout_Base,self:=left));

ut.MAC_SF_BuildProcess(dbase_out ,ACF.cluster.cluster_out+'base::ACF',Outbase, 2);

RETURN Outbase;

END; 