export mod_value_is_repeated(string in_val) := module
 
 //valid in Wisconsin
 shared exception_set := ['KINNICKINNIC'];
 
 shared string  in_val_spaces_removed := stringlib.stringfilterout(in_val,' ');
 shared integer v_length_as_is        := length(trim(in_val));
 shared integer v_length_no_spaces    := length(trim(in_val_spaces_removed));
 
 //chose higher lengths because of occurrences like GIGI, DEEDEE, etc
 //the higher the length the greater the likelihood that the repeated value is bogus
 shared boolean is_odd_numbered_length  := v_length_as_is     in [11,13,15,17,19,21];
 shared boolean is_even_numbered_length := v_length_no_spaces in [10,12,14,16,18,20];
 
 shared
 string  first_half  := if(is_odd_numbered_length, in_val               [1..v_length_as_is-1],
                        if(is_even_numbered_length,in_val_spaces_removed[1..(v_length_no_spaces div 2)],
						''));

 string  second_half := if(is_odd_numbered_length, in_val               [v_length_as_is+1..v_length_as_is],
                        if(is_even_numbered_length,in_val_spaces_removed[(v_length_no_spaces div 2)+1..v_length_no_spaces],
						''));
  
 export is_repeated := if(first_half=second_half and first_half<>'' and in_val not in exception_set,true,false);
 export fixed       := if(is_repeated=true,first_half,in_val);
 
end;