export svcAppend := function
     import LocationID;
	import LocationId_xLink;
	import SALT37;
	
     inputDs := dataset([], LocationID.IdAppendLayouts.AppendInput) : stored('append_input');

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
                                   self.sec_range           := if(left.sec_range='','NOVALUE',left.sec_range),
                                   self.err_stat            := 'S',
							self.uniqueid            := left.request_id,
							self.unit_desig          := '',
							self.addr_suffix_derived := left.addr_suffix;
                                   self                     := left));
              
     pm := LocationId_xLink.MEOW_LocationID(SALTInput); 
     ds := pm.Data_;

     FieldNumber(SALT37.StrType fn) := CASE(fn,'prim_range' => 1,'predir' => 2,'prim_name' => 3,'addr_suffix' => 4,'postdir' => 5,'unit_desig' => 6,'sec_range' => 7,'v_city_name' => 8,'st' => 9,'zip5' => 10,11);
     result := CHOOSE(FieldNumber(''),SORT(ds,-weight,LocId,prim_range,RECORD),SORT(ds,-weight,LocId,predir_derived,RECORD),SORT(ds,-weight,LocId,prim_name_derived,RECORD),SORT(ds,-weight,LocId,addr_suffix_derived,RECORD),SORT(ds,-weight,LocId,postdir,RECORD),SORT(ds,-weight,LocId,unit_desig,RECORD),SORT(ds,-weight,LocId,sec_range,RECORD),SORT(ds,-weight,LocId,v_city_name,RECORD),SORT(ds,-weight,LocId,st,RECORD),SORT(ds,-weight,LocId,zip5,RECORD),SORT(ds,-weight,LocId,RECORD));
		
     dedupResult := dedup(result, uniqueid, all);
	
	svcResult   := join(inputDs, dedupResult,
	                    left.request_id = right.uniqueid,
					transform(LocationID.IdAppendLayouts.svcAppendOut,
					          self.locid := right.locid,
							self       := left));
	
     return output(svcResult,NAMED('result'));

end;