import did_add, Business_Header_SS, Business_Header, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville, MDR;

in_file := Txbus.Update_Txbus;

in_file_with_source:=record
	Layouts_Txbus.Layout_Bdid;
	string2 source;
end;

in_file_with_source trans_MapRec_ID(Txbus.Layouts_Txbus.Layout_AID_Common l):=transform
		self.source 			 := MDR.sourceTools.src_TXBUS;
		self.source_rec_id := hash64( trim(l.Taxpayer_Number,left,right)+ 
																	l.raw_aid + l.mail_raw_aid +
																	trim(l.Outlet_Number,left,right) + 
																	trim(l.Taxpayer_Name,left,right) +
																	trim(l.Taxpayer_Address,left,right) + 
																	trim(l.Taxpayer_City,left,right) +
																	trim(l.Taxpayer_State,left,right) + 
																	trim(l.Taxpayer_ZipCode,left,right) + 
																	trim(l.Taxpayer_County_Code,left,right) + 
																	trim(l.Taxpayer_Phone,left,right) +
																	trim(l.Taxpayer_Org_Type,left,right) + 
																	trim(l.Outlet_Name,left,right) +
																	trim(l.Outlet_Address,left,right) +
																	trim(l.Outlet_City,left,right) + 
																	trim(l.Outlet_State,left,right) +
																	trim(l.Outlet_ZipCode,left,right) +
																	trim(l.Outlet_County_Code,left,right) + 
																	trim(l.Outlet_Phone,left,right) + 
																	trim(l.Outlet_NAICS_Code,left,right) + 
																	trim(l.Outlet_City_Limits_Indicator,left,right) + 
																	trim(l.Outlet_Permit_Issue_Date,left,right) + 
																	trim(l.Outlet_First_Sales_Date,left,right));
		self							:= l; 
		self							:= [];
end;

in_file_recID := project(in_file,trans_MapRec_ID(left));

matchset := ['A','P','N'];

Business_Header_SS.MAC_Add_BDID_Flex(
           in_file_recID									 			      		// Input Dataset						
          ,matchset                                      // BDID Matchset           
          ,Outlet_Name        		             		      // company_name	              
          ,Outlet_prim_range		                       // prim_range		              
          ,Outlet_prim_name		                        // prim_name		              
          ,Outlet_zip5 					                     // zip5					              
          ,Outlet_sec_range		                      // sec_range		              
          ,Outlet_st				                       // state				              
          ,Outlet_Phone			           					  // phone				              
          ,orig_fein                             // fein              
          ,bdid											 					  // bdid												
          ,in_file_with_source	       				 // Output Layout 
          ,false                         			// output layout has bdid score field?                       
          ,BDID_Score                        // bdid_score                 
          ,dPostFlex          						  // Output Dataset   
          ,																 // deafult threscold
          ,													 			// use prod version of superfiles
          ,															 // default is to hit prod from dataland, and on prod hit prod.		
          ,BIPV2.xlink_version_set 			// Create BIP Keys only
          ,           								 // Url
          ,								            // Email
          ,Outlet_p_city_name				 // City
          ,Taxpayer_fname						// fname
          ,Taxpayer_mname					 // mname
          ,Taxpayer_lname					// lname
					,                    	 //	ssn
					,source             	//sourceField
					,source_rec_id       //persistent_rec_id
					,            				//Src_matching_is_priority  
);
	
	
/* 
BDID_rec := record
   Txbus.Layouts_Txbus.Layout_Base;
end;


BDID_rec tBdid(PostBDID L) := transform
	self.bdid		    := if(L.bdid = 0, '', intformat(L.bdid,12,1));
	//self.BDID_SCORE	:= (string3)L.bdid_score;
	self            := L;
end;
	
ds_Txbus_BDID := project(PostBDID, tBdid(left)); 
*/
export Cleaned_Txbus_BDID := project(dPostFlex,transform(Layouts_Txbus.Layout_Bdid,self:=left;)) : persist(Txbus.Constants.Cluster + 'persist::txbus::Cleaned_Txbus_bdid');
