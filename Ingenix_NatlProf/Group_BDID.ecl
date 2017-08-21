import BIPV2, Ingenix_natlprof, did_add, Business_Header_SS, ut, business_header;

file_in := Ingenix_NatlProf.update_group_bdid;

Pre_BDID_Rec := record
	ingenix_natlprof.Layout_Group_Base_BIP;
	integer8	temp_BDID				:= 0;
	integer8	temp_BDID_SCORE	:= 0;
end;

Pre_BDID_Rec taddBDID(file_in L) := transform
	self.DotID			:= 0;
	self.DotScore		:= 0;
	self.DotWeight	:= 0;
	self.EmpID			:= 0;
	self.EmpScore		:= 0;
	self.EmpWeight	:= 0;
	self.POWID			:= 0;
	self.POWScore		:= 0;
	self.POWWeight	:= 0;
	self.ProxID			:= 0;
	self.ProxScore	:= 0;
	self.ProxWeight	:= 0; 
	self.SeleID			:= 0; 
	self.SeleScore	:= 0; 
	self.SeleWeight	:= 0; 	
	self.OrgID			:= 0; 
	self.OrgScore		:= 0; 
	self.OrgWeight	:= 0; 
	self.UltID			:= 0; 
	self.UltScore		:= 0; 
	self.UltWeight	:= 0; 	
	self.bdid 			:= '';
	self.bdid_score := '';
	self						:=	L;
end;

PreBDID	:= project(file_in,taddBDID(left));

bmatchset := ['N'];

Business_Header_SS.MAC_Add_BDID_Flex(
		 preBDID															// Input Dataset						
		,bmatchset                        		// BDID Matchset what fields to match on           
		,Groupname	                        	// company_name	              
		,''		                        				// prim_range		              
		,''		                        				// prim_name		              
		,''					                        	// zip5					              
		,''		                        				// sec_range		              
		,''				                        		// state				              
		,''				                        		// phone				              
		,''                        						// fein              
		,temp_bdid													  // bdid												
		,Pre_BDID_Rec           							// Output Layout 
		,true                                 // output layout has bdid score field?                       
		,temp_BDID_Score                      // bdid_score                 
		,postBDID                             // Output Dataset
		,																			// deafault threshold
		,																			// use prod version of superfiles
		,																			// default is to hit prod from dataland, and on prod hit prod.		
		,bipv2.xlink_version_set							// boolean indicator set to create bdid's & xlinkids
		,																			// url
		,																			// email 
		,''																		// city
		,																			// fname
		,																			// mname
		,																			// lname				
);  
	
PostBDIDpersist	:=	PostBDID;


Layout_Group_Base_BIP tBdid(PostBDIDpersist L) :=	transform
	self.BDID				:=	intformat(L.temp_BDID,12,1);
	self.BDID_SCORE	:=	(string3)L.temp_BDID_SCORE;
	self            := L;
end;
	
export Group_BDID := project(PostBDIDpersist, tBdid(left)):persist('~thor_data400::persist::Ingenix_provider_group_bdid');