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
		    
	#uniquename(OutputRec)
	%OutputRec% := record
		unsigned6 LocId := 0;
		inDs;
	end;

	outDs          := project(inDs, %OutputRec%);
	
endmacro;
