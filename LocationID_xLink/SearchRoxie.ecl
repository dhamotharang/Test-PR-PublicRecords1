import LocationID;
import LocationId_xLink;
// import SALT37;

/**
	inputDs  - Address Fields - with a uniqueID for each record
	minScore - Higher Score means higher precision. Lower Score means higher recall.
               NOTE: Any score below 51 will return an empty dataset as this is ambiguous
	debug    - NOTE: Do no use this. This will result in mutliple matches for each address.
**/	
export SearchRoxie(dataset(LocationID.IdAppendLayouts.AppendInput) inputDs 
					,boolean debug = false, leadtheshold = 10) := function	
				 
     SALTInput := project(inputDs,
                          transform(LocationId_xLink.Process_LocationID_Layouts.InputLayout,                               
                                   POBoxIndex               := left.prim_name[1..6]='PO BOX';
                                   RRIndex                  := left.prim_name[1..2] in ['RR','HC'];
                                   self.prim_range          := map(POBoxIndex and trim(left.prim_range)='' => left.prim_name[8..],
                                                                   RRIndex and trim(left.prim_range)=''    => left.prim_name[4..],
                                                                   left.prim_range),
                                   self.prim_name_derived   := map(POBoxIndex and trim(left.prim_range)='' => 'PO BOX',
                                                                   RRIndex and trim(left.prim_range)=''    => 'RR',
                                                                   left.prim_name),
                                   self.sec_range           := left.sec_range,
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
		integer maxv;
	end;
	
	
	flattendDs := normalize(result, left.results, 
	                        transform(FlatRec,
									  self.maxv := 0,
	                                  self := left,
	                                  self := right));

	
	distNormweight := distribute(flattendDs, hash(uniqueid));
	
	sortNormweight := sort(distNormweight, uniqueid, -weight, local);
	
	groupNormweight:= group(sortNormweight, uniqueid, local);

	flattendds func(flattendds le, flattendds ri):= TRANSFORM,
		skip(ri.weight<(le.maxv - leadtheshold) and le.maxv > 0)
		self.maxv := if(le.maxv = 0, ri.weight, le.maxv);
		self := ri;
	END;

	
	removeLowWeight := iterate(sortNormweight, func(left, right));

	
	outformat := RECORD
		 unsigned request_id;
		 unsigned6 LocId;
	     string10 prim_range;
	     string2 predir;
	     string28 prim_name;
	     string4 addr_suffix;
	     string2 postdir;
	     string8 sec_range;
	     string25 v_city_name;
	     string2 st;
	     string5 zip5;
		 integer weight;

	END; 

	
	res := join(inputDs, removelowweight,
					left.request_id = right.uniqueid,
					transform(outformat,self.locid := right.locid,
								self.weight:= right.weight, self := left, self := right),limit(config.JoinLimit));
	

	return res;

end;
