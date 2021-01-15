import DID_Add;

export fAppendADL(dataset(FLAccidents_Ecrash.Layout_Basefile) pDataset) :=
	function

//Add unique id
	lUniqueId :={FLAccidents_Ecrash.Layout_Basefile ,string15 temp_ssn,unsigned8 unique_id};

	lUniqueId padSSN(pDataset L,unsigned8 cnt) :=
     transform
					self.temp_ssn := map(  length(L.ssn) = 7 => '00'+L.ssn
																,length(L.ssn) = 8 => '0' +L.ssn
																,L.ssn);
					self.unique_id		:= cnt	;
					self := L;
		  end;

	dAddUniqueId := project(pDataset,padSSN(left,counter));

// slim layout
	dSlim := project(dAddUniqueId,FLAccidents_Ecrash.Layout_Infiles_Fixed.DidSlim);

//append DID
	did_matchset := ['A','D','S','Z','G','4'];

	did_add.MAC_Match_Flex(dSlim,did_matchset,
                        temp_ssn,date_of_birth,fname,mname,lname,suffix,
				                prim_range,prim_name,sec_range,z5,st,nophone,
				                did,FLAccidents_Ecrash.Layout_Infiles_Fixed.DidSlim,true,did_score,75,dDidOut);

		dDidOut_dist			:= distribute	(dDidOut(did != 0)	,unique_id										);
		dDidOut_sort			:= sort				(dDidOut_dist				,unique_id, -did_score	,local);
		dDidOut_dedup			:= dedup			(dDidOut_sort				,unique_id							,local);

		dAddUniqueId_dist := distribute	(dAddUniqueId				,unique_id										);


		FLAccidents_Ecrash.Layout_Basefile tAssignDIDs(dAddUniqueId_dist l, FLAccidents_Ecrash.Layout_Infiles_Fixed.DidSlim r) :=
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
											);

		return dAssignDids;

	end;
