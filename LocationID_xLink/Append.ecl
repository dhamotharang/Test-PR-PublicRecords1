import LocationID_xLink;

export Append(inDs, 
		         prim_range_field, 
              predir_field, 
		         prim_name_field, 
              addr_suffix_field, 
              postdir_field, 
              sec_range_field, 
              city_field, 
              state_field, 
              zip_field, 
              outDs) := macro
		    
	#uniquename(InputRec)
	%InputRec% := record
		unsigned6 ref;
		typeof(inDs.prim_range_field) prim_range_derived;
		typeof(inDs.prim_name_field)  prim_name_derived;
		typeof(inDs.sec_range_field)  sec_range_derived;
		string  err_stat;
		inDs;
	end;
												  
	#uniquename(resolveInput)
	%resolveInput% := project(inDs,
	                          transform(%InputRec%,
	                          POBoxIndex               := left.prim_name_field[1..6]='PO BOX';
	                          RRIndex                  := left.prim_name_field[1..2] in ['RR','HC'];
	                          self.ref                 := ((counter - 1) * thorlib.nodes()) + thorlib.node(),
	                          self.prim_range_derived  := map(POBoxIndex and trim(left.prim_range_field)='' => left.prim_name_field[8..],
	                                                        RRIndex and trim(left.prim_range_field)=''    => left.prim_name_field[4..],
	                                                        left.prim_range_field),
	                          self.prim_name_derived   := map(POBoxIndex and trim(left.prim_range_field)='' => 'PO BOX',
	                                                        RRIndex and trim(left.prim_range_field)=''    => 'RR',
	                                                        left.prim_name_field),
	                          self.sec_range_derived   := if(left.sec_range_field='','NOVALUE',left.sec_range_field);
	                          self.err_stat            := 'S';
	                          self                     := left), local);

	#uniquename(resolveOutput)
	LocationID_xLink.MAC_MEOW_LocationID_Batch(%resolveInput%
	                                       ,ref
	                                       ,/*LocID*/
	                                       ,prim_range_derived
	                                       ,predir_field
	                                       ,prim_name_derived
	                                       ,addr_suffix_field
	                                       ,postdir_field
	                                       ,err_stat
	                                       ,/*unit_desig*/
	                                       ,sec_range_derived
	                                       ,city_field
	                                       ,state_field
	                                       ,zip_field
	                                       ,%resolveOutput%);

	#uniquename(FlatRec)
	%FlatRec% := record
		%resolveOutput%.results.locid;
		%resolveOutput%.results.weight;
		%resolveOutput%.results.reference;
		%resolveOutput%.resolved;
	end;

	#uniquename(flattenDs)
	%flattenDs% := normalize(%resolveOutput%, left.results, 
	                         transform(%FlatRec%,
	                                   self := left,
	                                   self := right));

	#uniquename(resolvedDs)
	%resolvedDs% := dedup(%flattenDs%(resolved), reference);
	
	#uniquename(OutputRec)
	%OutputRec% := record
		%FlatRec%.LocId;
		inDs;
	end;
	
	// output(%resolveOutput%(not resolved),,'~kdw::unresolved2',overwrite,compressed);
	// output(%resolveOutput%(resolved),,'~kdw::resolved',overwrite,compressed,named('RESOLVED'));

	#uniquename(createOutput)
	%createOutput% := join(%resolveInput%, %resolvedDs%,
	                       left.ref = right.reference,
					             transform(%OutputRec%, self := left, self := right), left outer, hash);
							   
	// #uniquename(noMatch)
	// %noMatch% := join(inDs, %flattenDs%,
	                  // left.refField = right.reference,
					        // transform(left), left only, hash);
							   
	// output(%noMatch%,,'~kdw::noMatch',overwrite,compressed,named('NO_MATCHES'));							   
	outDs          := %createOutput%;
	
endmacro;