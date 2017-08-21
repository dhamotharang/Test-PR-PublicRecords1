//Assigns DIDs and BDIDs on the passed records
import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,watchdog,Business_HeaderV2, MDR;

export Append_Ids :=
module

	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBdid
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBdid(dataset(Layouts.Base) pDataset) :=
	function

		Layouts.Temporary.Unique_Id tAddUniqueId(Layouts.Base l) :=
		transform
			 self				:= l	;
		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Bdiding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Temporary.Unique_Id l) :=
  	transform
			self.unique_id		:= l.unique_id																			;
			self.company_name := l.rawfields.InstitutionName											;
			self.prim_range		:= l.FormattedBranchAddr.prim_range									;
			self.prim_name		:= l.FormattedBranchAddr.prim_name									;
			self.zip5					:= l.FormattedBranchAddr.zip			    							;
			self.sec_range		:= l.FormattedBranchAddr.sec_range									;
			self.state				:= l.FormattedBranchAddr.st													;
			self.p_city_name	:= l.FormattedBranchAddr.p_city_name								;
			self.phone				:= ''																								;
			self.bdid					:= 0																								;
			self.bdid_score		:= 0																								;

		end;   
    
	  dSlimForBdiding :=  project( dAddUniqueId
								    ,tSlimForBdiding(left)
								    );
        
		BDID_Matchset := ['A'];

		Business_Header_SS.MAC_Add_BDID_Flex(																						
			 dSlimForBdiding									// Input Dataset													
			,BDID_Matchset                    // BDID Matchset what fields to match on  
			,company_name	                    // company_name	                          
			,prim_range		                    // prim_range		                          
			,prim_name		                    // prim_name		                          
			,zip5					            				// zip5					                          
			,sec_range		                    // sec_range		                          
			,state				                		// state				                          
			,phone				               			// phone				                          
			,fein					                    // fein                                   
			,bdid															// bdid												            
			,Layouts.Temporary.BdidSlim       // Output Layout                          
			,true                             // output layout has bdid score field?                       
			,bdid_score                       // bdid_score                             
			,dBdidOut                         // Output Dataset
			,																	// deafult threscold
			,																	// use prod version of superfiles
			,																	// default is to hit prod from dataland, and on prod hit prod.		
			,bipv2.xlink_version_set					// boolean indicator set to create bdid's & xlinkids
			,																	// url
			,																	// email 
			,p_city_name											// city
			,																	// fname
			,																	// mname
			,																	// lname					
		);                                                                            			

		dBDidOut_dist			:= distribute	(dBDidOut(	Bdid	 != 0 OR
																								DotID  != 0 OR
																								EmpID  != 0 OR
																								POWID  != 0 OR
																								ProxID != 0 OR
																								SELEID != 0 OR
																								OrgID  != 0 OR
																								UltID  != 0																					 
																							)	,unique_id					  );
		dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -bdid_score	, -DotScore, -EmpScore, -POWScore, -SELEScore, -OrgScore, -ProxScore, -UltScore, local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id,local);
		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id);

		Layouts.Base tAssignBdids(Layouts.Temporary.Unique_Id l, Layouts.Temporary.BdidSlim r) :=
		transform
			self.bdid				:= if(r.bdid 	   		<> 0	,r.bdid 			,0);
			self.bdid_score	:= if(r.bdid_score	<> 0	,r.bdid_score	,0);
			self.DotID			:= if(r.DotID				<> 0	,r.bdid_score	,0);
			self.DotScore		:= if(r.DotScore		<> 0	,r.DotScore		,0);
			self.DotWeight	:= if(r.DotWeight		<> 0	,r.DotWeight	,0);
			self.EmpID			:= if(r.EmpID				<> 0	,r.EmpID			,0);
			self.EmpScore		:= if(r.EmpScore		<> 0	,r.EmpScore		,0);
			self.EmpWeight	:= if(r.EmpWeight		<> 0	,r.EmpWeight	,0);
			self.POWID			:= if(r.POWID				<> 0	,r.POWID			,0);
			self.POWScore		:= if(r.POWScore		<> 0	,r.POWScore		,0);
			self.POWWeight	:= if(r.POWWeight		<> 0	,r.POWWeight	,0);
			self.ProxID			:= if(r.ProxID			<> 0	,r.ProxID			,0);
			self.ProxScore	:= if(r.ProxScore		<> 0	,r.ProxScore	,0);
			self.ProxWeight	:= if(r.ProxWeight	<> 0	,r.ProxWeight	,0);
			self.SELEID			:= if(r.SELEID			<> 0	,r.SELEID			,0);
			self.SELEScore	:= if(r.SELEScore		<> 0	,r.SELEScore	,0);
			self.SELEWeight	:= if(r.SELEWeight	<> 0	,r.SELEWeight	,0);
			self.OrgID			:= if(r.OrgID				<> 0	,r.OrgID			,0);
			self.OrgScore		:= if(r.OrgScore		<> 0	,r.OrgScore		,0);
			self.OrgWeight	:= if(r.OrgWeight		<> 0	,r.OrgWeight	,0);
			self.UltID			:= if(r.UltID				<> 0	,r.UltID			,0);
			self.UltScore		:= if(r.UltScore		<> 0	,r.UltScore		,0);
			self.UltWeight	:= if(r.UltWeight		<> 0	,r.UltWeight	,0);
			
			self 						:= l;
		end;

		dAssignBdids := join(
											 dAddUniqueId_dist
											,dBDidOut_dedup
											,left.unique_id = right.unique_id
											,tAssignBdids(left, right)
											,left outer
											,local
											);
		
		return dAssignBdids;
		
	end;
	
	export fAll(

		 dataset(Layouts.Base)	pDataset
		,string 								pPersistbdid	= Persistnames().AppendIdsfAppendBdid	
	) :=
	function

		
dAppendBdid		:= fAppendBdid(pDataset) : persist(pPersistbdid);
		return dAppendBdid;

	end;

end; 
