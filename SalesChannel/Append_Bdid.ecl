//Assigns DIDs, BDIDs, and LinkIDs on the passed records
import Address, BIPV2, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,watchdog,Business_HeaderV2,mdr;
//////////////////////////////////////////////////////////////////////////////////////
// -- function: fAppendBdid
// -- Appends Bdids
//////////////////////////////////////////////////////////////////////////////////////
export Append_Bdid(

	 dataset(Layouts.Base_new)	pDataset
	,string									pPersistname	= persistnames().appendBdid

) :=
function

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Slim record for Bdiding
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Base_new l) :=
	transform

		self.unique_id		:= l.rid																;
		self.company_name	:= l.rawfields.company_name			;
		self.prim_range		:= l.Clean_address.prim_range		;
		self.prim_name		:= l.Clean_address.prim_name		;
		self.zip5					:= l.Clean_address.zip					;
		self.sec_range		:= l.Clean_address.sec_range		;
		self.state				:= l.Clean_address.st						;
		self.p_city_name	:= l.Clean_address.p_city_name	;
		self.phone				:= regexreplace('[-]',trim(l.rawfields.phone_number),'');
		self.web_address	:= l.rawfields.web_address			;
		self.email				:= l.rawfields.email						;
		self.fname				:= l.clean_name.fname						;
		self.mname				:= l.clean_name.mname						;
		self.lname				:= l.clean_name.lname						;		
		self.bdid					:= 0														;
		self.bdid_score		:= 0														;
		self.DotID				:= 0														;
		self.DotScore			:= 0														;
		self.DotWeight		:= 0														;
		self.EmpID				:= 0														;
		self.EmpScore			:= 0														;
		self.EmpWeight		:= 0														;
		self.POWID				:= 0														;
		self.POWScore			:= 0														;
		self.POWWeight		:= 0														;
		self.ProxID				:= 0														;
		self.ProxScore		:= 0														;
		self.ProxWeight		:= 0														;
		self.SELEID				:= 0														;
		self.SELEScore		:= 0														;
		self.SELEWeight		:= 0														;	
		self.OrgID				:= 0														;
		self.OrgScore			:= 0														;
		self.OrgWeight		:= 0														;
		self.UltID				:= 0														;
		self.UltScore			:= 0														;
		self.UltWeight		:= 0														;				
		self.source_group := '';
		self.fein					:= '';
	end;   

	dSlimForBdiding :=  project(pDataset,tSlimForBdiding(left));

	BDID_Matchset := ['A','P'];

	Business_Header_SS.MAC_Add_BDID_Flex(
		 dSlimForBdiding											// Input Dataset						
		,BDID_Matchset                        // BDID Matchset what fields to match on           
		,company_name	                        // company_name	              
		,prim_range		                        // prim_range		              
		,prim_name		                        // prim_name		              
		,zip5					                        // zip5					              
		,sec_range		                        // sec_range		              
		,state				                        // state				              
		,phone				                        // phone				              
		,fein_not_used                        // fein              
		,bdid													        // bdid												
		,Layouts.Temporary.BdidSlim           // Output Layout 
		,true                                 // output layout has bdid score field?                       
		,bdid_score                           // bdid_score                 
		,dBdidFlexOut                         // Output Dataset
		,																			// default threshold
		,																			// use prod version of superfiles
		,																			// default is to hit prod from dataland, and on prod hit prod.		
		,BIPV2.xlink_version_set							// create BIP keys only
		,Web_Address													// url
		,Email																// email 
		,p_city_name													// city
		,fname																// fname
		,mname																// mname
		,lname																// lname		
	);   

	dBDidOut 					:= dBdidFlexOut;
	dBDidOut_dist			:= distribute	(dBDidOut(bdid   != 0 	OR
																						dotid	 != 0 	OR
																						empid	 != 0 	OR
																						powid	 != 0 	OR
																						proxid != 0 	OR
																						seleid != 0 	OR
																						orgid	 != 0 	OR	
																						ultid	 != 0)																		
																					 ,unique_id);
	dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -bdid_score,-dotid,-empid,-powid,-proxid,-seleid,-orgid,-ultid,local);
	dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id							,local);

	pDataset_dist 		:= distribute	(pDataset					,rid										);

		 
	Layouts.Base_new tAssignBdids(Layouts.Base_new l, Layouts.Temporary.BdidSlim r) :=
	transform

		self.bdid				:= if(r.bdid 				<> 0, r.bdid				, 0);
		self.bdid_score	:= if(r.bdid_score	<> 0, r.bdid_score	, 0);
		self.DotID			:= if(r.DotID				<> 0, r.DotID				, 0);
		self.DotScore		:= if(r.DotScore		<> 0, r.DotScore		, 0);
		self.DotWeight	:= if(r.DotWeight		<> 0, r.DotWeight		, 0);
		self.EmpID			:= if(r.EmpID				<> 0, r.EmpID				, 0);
		self.EmpScore		:= if(r.EmpScore		<> 0, r.EmpScore		, 0);
		self.EmpWeight	:= if(r.EmpWeight		<> 0, r.EmpWeight		, 0);
		self.POWID			:= if(r.POWID				<> 0, r.POWID				, 0);
		self.POWScore		:= if(r.POWScore		<> 0, r.POWScore		, 0);
		self.POWWeight	:= if(r.POWWeight		<> 0, r.POWWeight		, 0);
		self.ProxID			:= if(r.ProxID			<> 0, r.ProxID			, 0);
		self.ProxScore	:= if(r.ProxScore		<> 0, r.ProxScore		, 0);
		self.ProxWeight	:= if(r.ProxWeight	<> 0, r.ProxWeight	, 0);
		self.SELEID			:= if(r.SELEID			<> 0, r.SELEID			, 0);
		self.SELEScore	:= if(r.SELEScore		<> 0, r.SELEScore		, 0);
		self.SELEWeight	:= if(r.SELEWeight	<> 0, r.SELEWeight	, 0);
		self.OrgID			:= if(r.OrgID				<> 0, r.OrgID				, 0);
		self.OrgScore		:= if(r.OrgScore		<> 0, r.OrgScore		, 0);
		self.OrgWeight	:= if(r.OrgWeight		<> 0, r.OrgWeight		, 0);
		self.UltID			:= if(r.UltID				<> 0, r.UltID				, 0);
		self.UltScore		:= if(r.UltScore		<> 0, r.UltScore		, 0);
		self.UltWeight	:= if(r.UltWeight		<> 0, r.UltWeight		, 0);
		self 						:= l;

	end;

	dAssignBdids := join(
										 pDataset_dist
										,dBDidOut_dedup
										,left.rid = right.unique_id
										,tAssignBdids(left, right)
										,left outer
										,local
										);

	return dAssignBdids;

end;
