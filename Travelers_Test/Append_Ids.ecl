import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS;

export Append_Ids(

	 dataset(Layouts.Temporary.StandardizeInput)	pDataset
	,string																				pPersistname = persistnames().AppendIds

) :=
function
	
	//Add unique id
	Layouts.Temporary.UniqueId tAddUniqueId(Layouts.Temporary.StandardizeInput l, unsigned8 cnt) :=
	transform

		self.unique_id		:= cnt	;
		self							:= l		;

	end;   
	
	dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Slim record for Diding
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Temporary.UniqueId l) :=
	transform
		
		self.fname				:= l.clean_subject_name.fname						;
		self.mname				:= l.clean_subject_name.mname						;
		self.lname				:= l.clean_subject_name.lname						;
		self.name_suffix	:= l.clean_subject_name.name_suffix			;
		self.prim_range		:= l.Clean_Subject_address.prim_range		;
		self.prim_name		:= l.Clean_Subject_address.prim_name		;
		self.sec_range		:= l.Clean_Subject_address.sec_range		;
		self.zip5				 	:= l.Clean_Subject_address.zip					;
		self.state				:= l.Clean_Subject_address.st						;
		self.dob					:= (string)l.clean_dates.dob						;
		self.ssn					:= (string)l.Subject.ssn								;
		self.did					:= 0																		;
		self.did_score		:= 0																		;
		self							:= l																		;
	end;
	
	dSlimForDiding	:= project(dAddUniqueId,tSlimForDiding(left));
	
	// Match to Headers by Contact Name and Address
	Did_Matchset := ['A','D','S'];

	DID_Add.MAC_Match_Flex(
		 dSlimForDiding							// Input Dataset
		,Did_Matchset             	// Did_Matchset  what fields to match on
		,ssn                				// ssn
		,dob                 				// dob
		,fname											// fname
		,mname			     						// mname
		,lname			     						// lname
		,name_suffix     						// name_suffix
		,prim_range	          			// prim_range
		,prim_name	          			// prim_name
		,sec_range	          			// sec_range
		,zip5				          			// zip5
		,state			          			// state
		,phone			          			// phone10
		,did                      	// Did
		,Layouts.Temporary.DidSlim  // output layout
		,TRUE                     	// Does output record have the score
		,did_score                	// did score field
		,75                       	// score threshold
		,dDidOut								  	// output dataset			
	);                          


	dDidOut_dist			:= distribute	(dDidOut(did != 0)	,unique_id										);
	dDidOut_sort			:= sort				(dDidOut_dist				,unique_id, -did_score	,local);
	dDidOut_dedup			:= dedup			(dDidOut_sort				,unique_id							,local);
	
	dAddUniqueId_dist := distribute	(dAddUniqueId				,unique_id										);

		 
	Layouts.Temporary.UniqueId tAssignDIDs(Layouts.Temporary.UniqueId l, Layouts.Temporary.DidSlim r) :=
	transform

		self.did				:= if(r.did 			<> 0, r.did				, 0);
		self.did_score	:= if(r.did_score <> 0, r.did_score	, 0);
		self 						:= l;

	end;

	dAssignDids := join(
										 dAddUniqueId_dist
										,dDidOut_dedup
										,left.unique_id = right.unique_id
										,tAssignDIDs(left, right)
										,left outer
										,local
										)
										: persist(pPersistname);
	
	return dAssignDids;

end;