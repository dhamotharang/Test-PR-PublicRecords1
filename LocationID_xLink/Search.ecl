import LocationID_xLink;

export Search(inDs, 
		    prim_range_field, 
            predir_field, 
		    prim_name_field, 
            addr_suffix_field, 
            postdir_field,  
			sec_range_field,
            city_field, 
            state_field, 
            zip_field, 
			outDs, leadThreshold = 10) := macro

     import STD;
   
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
		typeof (inDs.sec_range_field)  sec_range_derived_append;
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
	                          self.sec_range_derived_append   :=  left.sec_range_field; 
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




	#uniquename(normedvals)
	%normedvals% := RECORD
		%resolveOutput%.results.reference;
		%resolveOutput%.results.locid;
		%resolveOutput%.results.weight;
		integer maxv;		
	END;
	
	#uniquename(normweight)
	%normweight% := normalize(%resolveOutput%, left.results,
							TRANSFORM(%normedvals%,
									  self := left,
									  self := right,
									  self.maxv := 0));
	#uniquename(distNormweight)
	%distNormweight% := distribute(%normweight%, hash(reference));
	#uniquename(sortNormweight)
	%sortNormweight% := sort(%distNormweight%, reference, -weight, local);
	#uniquename(groupNormweight)
	%groupNormweight%:= group(%sortNormweight%, reference, local);

	%normweight% func(%normweight% le, %normweight% ri):= TRANSFORM,
		skip(ri.weight<(le.maxv - leadThreshold) and le.maxv > 0)
		self.maxv := if(le.maxv = 0, ri.weight, le.maxv);
		self := ri;
	END;
	#uniquename(removeLowWeight)
	%removeLowWeight% := iterate(%groupNormweight%, func(left, right));

	#DECLARE(CONTAINS_LOCID)
     #SET(CONTAINS_LOCID,'false')
     #EXPORTXML(LayoutStr,recordof(inDs))
     #FOR (LayoutStr)
       #FOR (Field)
	    #IF (Std.Str.ToUpperCase(%'{@label}'%) = 'LOCID')
           #SET(CONTAINS_LOCID,'true')
	    #END
	  #END
	#END

	
	#uniquename(OutputRec)
	%OutputRec% := record		
		inDs;
		#IF(%CONTAINS_LOCID%<>true)
		unsigned6 LocId;
		#END
		integer weight := 0;
	end;
	
	#uniquename(searchoutput)
	%searchoutput% := RECORD
		integer4 locid := %removeLowWeight%.locid;
		integer weight := %removeLowWeight%.weight;
	END;

	#uniquename(createOutput)
	%createOutput% := join(%addRef%, %flattenDs%,
	                       left.ref_append = right.reference,
					   transform(%OutputRec%, self.locid := right.locid, self := left, self := right), left outer, hash);

	
	#uniquename(finalresult)
	%finalresult% := join(%createoutput%, %removeLowWeight%, 
							left.locid = right.locid,
							transform(%OutputRec%,self.locid := right.locid, self.weight := right.weight,
							self := left, self := right), left outer, hash);

	#uniquename(sortedRes)
	%sortedRes% := sort(%finalresult%, inDs, -weight);
	outDs          := %sortedRes%;
endmacro;
