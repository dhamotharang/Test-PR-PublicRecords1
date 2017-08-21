import 	Address, Ut, lib_stringlib, _Control, business_header,_Validate,MDR,
				Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS;
      
export Append_Ids := module

		export fAppendBdid(dataset(Layouts.Keybuild_FULL) pDataset) := function
     
		Layouts.UniqueId tAddUniqueId(Layouts.Keybuild_FULL l, unsigned8 cnt) :=
		transform
			self.BH_Unique_id		:= cnt;
			self								:= l	;
		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));
      
		
		// Slim record for Bdiding
		Layouts.BdidSlim tSlimForBdiding(Layouts.UniqueId l) := transform
			self.bh_unique_id	:= l.bh_unique_id	;
			self.company_name	:= l.Business_Name	;
			self.prim_range		:= l.m_prim_range	;
			self.prim_name		:= l.m_prim_name	;
			self.zip5					:= l.m_zip			  ;
			self.sec_range		:= l.m_sec_range	;
			self.state				:= l.m_st					;
			self.city					:= l.m_p_city_name;
			self.fein         := l.fein         ;
			self.source_rec_id:= l.source_rec_id;
			self.source       := MDR.sourceTools.src_Workers_Compensation;
		end;   
    
	  dSlimForBdiding :=  project( dAddUniqueId ,tSlimForBdiding(left) );	
					
		BDID_Matchset := ['A','F'];

		Business_Header_SS.MAC_Add_BDID_Flex(																						
			 dSlimForBdiding									// Input Dataset													
			,BDID_Matchset                    // BDID Matchset what fields to match on  
			,company_name											// company_name                 
      ,prim_range											  // prim_range
      ,prim_name											  // prim_name
      ,zip5														  // zip5
			,sec_range											  // sec_range
      ,state														// state
      ,''																// phone                      
      ,FEIN															// fein              
      ,bdid															// bdid                                    
      ,Layouts.BdidSlim									// Output Layout 
      ,false														// output layout has bdid score field?                       
      ,bdid_score												// bdid_score                 
      ,dBdidOut													// Output Dataset  
			,																	// deafult threshold
			,																	// use prod version of superfiles
			,																	// default is to hit prod from dataland, and on prod hit prod.	
			,BIPV2.xlink_version_set					// Create BID Keys only
			,																	// Url
			,			 			    									// Email
			,city															// City
			, 				 												// fname
			,  																// mname
			, 																// lname
			,                            		  // contact ssn
	   	,source                           // source 
			,source_rec_id                    // source_rec_id
			,                      );         // src_matching_is_priority default FALSE 
                              
		dBDidOut_dist			:= distribute	(dBDidOut(bdid!=0 or dotid!=0 or empid!=0 or powid!=0 or proxid!=0 or seleid!=0 or orgid!=0 or ultid!=0) ,bh_unique_id	 );
		dBDidOut_sort			:= sort				(dBDidOut_dist	,bh_unique_id, -bdid_score, -dotscore, -empscore, -powscore, -proxscore, -selescore, -orgscore, -ultscore, local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort	,bh_unique_id	,local);		
		dAddUniqueId_dist := distribute	(dAddUniqueId		,bh_unique_id					  );

		Layouts.Keybuild_FULL tAssignBdids(Layouts.UniqueId l, Layouts.bdidslim r) :=
		transform
			self.bdid				:= if(r.bdid 	   		<> 0, r.bdid 				, 0);
			self.DotID		 	:= if(r.DotID				<> 0, r.DotID				, 0);
			self.DotScore	 	:= if(r.DotScore		<> 0, r.DotScore		, 0);
			self.DotWeight 	:= if(r.DotWeight		<> 0, r.DotWeight		, 0);
			self.EmpID		 	:= if(r.EmpID				<> 0, r.EmpID				, 0);
			self.EmpScore	 	:= if(r.EmpScore		<> 0, r.EmpScore		, 0);
			self.EmpWeight 	:= if(r.EmpWeight		<> 0, r.EmpWeight		, 0);
			self.POWID		 	:= if(r.POWID				<> 0, r.POWID				, 0);
			self.POWScore	 	:= if(r.POWScore		<> 0, r.POWScore		, 0);
			self.POWWeight 	:= if(r.POWWeight		<> 0, r.POWWeight		, 0);
			self.ProxID			:= if(r.ProxID			<> 0, r.ProxID			, 0);
			self.ProxScore 	:= if(r.ProxScore		<> 0, r.ProxScore		, 0);
			self.ProxWeight	:= if(r.ProxWeight	<> 0, r.ProxWeight	, 0);
			self.SeleID		 	:= if(r.SeleID			<> 0, r.SeleID			, 0);
			self.SeleScore 	:= if(r.SeleScore		<> 0, r.SeleScore		, 0);
			self.SeleWeight	:= if(r.SeleWeight	<> 0, r.SeleWeight	, 0);
			self.OrgID			:= if(r.OrgID				<> 0, r.OrgID				, 0);
			self.OrgScore		:= if(r.OrgScore		<> 0, r.OrgScore		, 0);
			self.OrgWeight	:= if(r.OrgWeight		<> 0, r.OrgWeight		, 0);
			self.UltID			:= if(r.UltID				<> 0, r.UltID				, 0);
			self.UltScore		:= if(r.UltScore		<> 0, r.UltScore		, 0);
			self.UltWeight	:= if(r.UltWeight		<> 0, r.UltWeight		, 0);
			self 						:= l;
		end;

		dAssignBdids := join(
											 dAddUniqueId_dist
											,dBDidOut_dedup
											,left.bh_unique_id = right.bh_unique_id
											,tAssignBdids(left, right)
											,left outer
											,local
											);
		
		return dAssignBdids;
		
	end;
	
		
	export fAll(dataset(Layouts.Keybuild_FULL)	pDataset) := function
	 
		dAppendBdid		:= fAppendBdid(pDataset);
				
		return dAppendBdid;
	end;


end; 

