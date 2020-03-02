import LocationID;
import LocationId_xLink;

/**
	inputDs  - Address Fields - with a uniqueID for each record
	minScore - Higher Score means higher precision. Lower Score means higher recall.
               NOTE: Any score below 51 will return an empty dataset as this is ambiguous
	debug    - NOTE: Do no use this. This will result in mutliple matches for each address.
**/	
export IdAppendRoxie(dataset(LocationID.IdAppendLayouts.AppendInput) inputDs 
                    ,integer minScore    = 75
				,integer minWeight   = 19
				,boolean debug       = false) := function	
				 
     SALTInput := project(inputDs(prim_name<>''),  // don't bother sending transactions into linking which don't have the address empty
                          transform(LocationId_xLink.Process_LocationID_Layouts.InputLayout,                               
                                   POBoxIndex               := left.prim_name[1..6]='PO BOX';
                                   RRIndex                  := left.prim_name[1..2] in ['RR','HC'];
                                   self.prim_range          := map(POBoxIndex and trim(left.prim_range)='' => left.prim_name[8..],
                                                                   RRIndex and trim(left.prim_range)=''    => left.prim_name[4..],
                                                                   left.prim_range),
                                   self.prim_name_derived   := map(POBoxIndex and trim(left.prim_range)='' => 'PO BOX',
                                                                   RRIndex and trim(left.prim_range)=''    => 'RR',
                                                                   left.prim_name),
                                   self.sec_range           := if(left.sec_range='','NOVALUE',left.sec_range),
                                   self.err_stat            := 'S',
							self.uniqueid            := left.request_id,
							self.unit_desig          := '',
							self.addr_suffix_derived := left.addr_suffix;
                                   self                     := left));
              
     result := LocationId_xLink.MEOW_LocationID(SALTInput).raw_results; 
	
	FlatRec := record
		result.results.locid;
		result.results.score;
		result.results.weight;
		result.uniqueid;
		result.resolved;
	end;

	flattendDs := normalize(result, left.results, 
	                        transform(FlatRec,
	                                  self := left,
	                                  self := right));

	resolvedDs := flattendDs(resolved and score > minScore and weight > minWeight);
	
	svcResulta   := join(inputDs, resolvedDs,
	                     left.request_id = right.uniqueid,
			 		 transform(LocationID.IdAppendLayouts.svcAppendOut,
					           self.locid := right.locid,
							 self       := left), limit(1000));

	emptyDs     := dataset([],LocationID.IdAppendLayouts.svcAppendOut);
	
	svcResult   := if(minScore<51, emptyDs, svcResulta);
	
     debugResult := join(inputDs, flattendDs,
	                    left.request_id = right.uniqueid,
					transform(LocationID.IdAppendLayouts.svcAppendOut,
					          self.locid  := right.locid,
							self        := left), limit(1000));

     return if(debug, debugResult, svcResult);

end;
