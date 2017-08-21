//Assigns DIDs and BDIDs on the passed records
import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,watchdog,Business_HeaderV2,mdr;
//////////////////////////////////////////////////////////////////////////////////////
// -- function: fAppendBdid
// -- Appends Bdids
//////////////////////////////////////////////////////////////////////////////////////
export Append_Bdid(

	 dataset(Layouts.Base)	pDataset
	,string									pPersistname	= persistnames().AppendBdid

) :=
function
	//////////////////////////////////////////////////////////////////////////////////////
	// -- Slim record for Bdiding
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Base l,unsigned8 cnt) :=
	transform
		self.unique_id		:= l.rid																;
		self.company_name	:= stringlib.stringtouppercase(l.rawfields.Employer);
		self.prim_range		:= l.Clean_address.prim_range		;
		self.prim_name		:= l.Clean_address.prim_name		;
		self.zip5					:= l.Clean_address.zip					;
		self.sec_range		:= l.Clean_address.sec_range		;
		self.state				:= l.Clean_address.st						;
		self.phone				:= choose(cnt,l.clean_phones.Phone_Home,l.clean_phones.Phone_Cell,l.clean_phones.Phone_Work);
		self.bdid					:= 0																		;
		self.bdid_score		:= 0																		;
		self.source_group := '';
		self.fein					:= '';
	end;   
	dSlimForBdiding :=  normalize(pDataset,3,tSlimForBdiding(left,counter));

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
	);   
	dBDidOut := dBdidFlexOut;
	
	dBDidOut_dist			:= distribute	(dBDidOut(bdid != 0)	,unique_id										);
	dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -bdid_score	,local);
	dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id							,local);
	pDataset_dist 		:= distribute	(pDataset							,rid													);
		 
	Layouts.Base tAssignBdids(Layouts.Base l, Layouts.Temporary.BdidSlim r) :=
	transform
		self.bdid				:= r.bdid				;
		self.bdid_score	:= r.bdid_score	;
		self 						:= l;
	end;
	dAssignBdids := join(
										 pDataset_dist
										,dBDidOut_dedup
										,left.rid = right.unique_id
										,tAssignBdids(left, right)
										,left outer
										,local
										) : persist(pPersistname);
	
	return dAssignBdids;
		
end; 
