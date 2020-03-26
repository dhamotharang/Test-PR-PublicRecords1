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
	
	#uniquename(RecWithRef)
	%RecWithRef% := record
		unsigned6 ref_append;
		inDs;
	end;
	
	#uniquename(addRef)
	%addRef% := project(inDs,
	                    transform(%RecWithRef%,
	                          self.ref_append  := ((counter - 1) * thorlib.nodes()) + thorlib.node(),
	                          self             := left), local);	
	
	#uniquename(InputRec)
	%InputRec% := record
	  %addRef%;
		typeof(inDs.prim_range_field) prim_range_derived_append;
		typeof(inDs.prim_name_field)  prim_name_derived_append;
		typeof(inDs.sec_range_field)  sec_range_derived_append;
		string  err_stat_append;
	end;
												  
	#uniquename(resolveInput)
	%resolveInput% := project(%addRef%,
	                          transform(%InputRec%,
	                          POBoxIndex                      := left.prim_name_field[1..6]='PO BOX';
	                          RRIndex                         := left.prim_name_field[1..2] in ['RR','HC'];
	                          self.prim_range_derived_append  := map(POBoxIndex and trim(left.prim_range_field)='' => left.prim_name_field[8..],
	                                                                 RRIndex and trim(left.prim_range_field)=''    => left.prim_name_field[4..],
	                                                                 left.prim_range_field),
	                          self.prim_name_derived_append   := map(POBoxIndex and trim(left.prim_range_field)='' => 'PO BOX',
	                                                                 RRIndex and trim(left.prim_range_field)=''    => 'RR',
	                                                                 left.prim_name_field),
	                          self.sec_range_derived_append   := if(left.sec_range_field='','NOVALUE',left.sec_range_field);
	                          self.err_stat_append            := 'S';
	                          self                            := left));

	#uniquename(resolveOutput)
	LocationID_xLink.MAC_MEOW_LocationID_Batch(%resolveInput%
	                                       ,ref_append
	                                       ,/*LocID*/
	                                       ,prim_range_derived_append
	                                       ,predir_field
	                                       ,prim_name_derived_append
	                                       ,addr_suffix_field
	                                       ,postdir_field
	                                       ,err_stat_append
	                                       ,/*unit_desig*/
	                                       ,sec_range_derived_append
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
	

	#uniquename(createOutput)
	%createOutput% := join(%addRef%, %resolvedDs%,
	                       left.ref_append = right.reference,
					               transform(recordof(inDs), self.locid := right.locid, self := left), left outer, hash);
							   
				   
	outDs          := %createOutput%;
	
endmacro;