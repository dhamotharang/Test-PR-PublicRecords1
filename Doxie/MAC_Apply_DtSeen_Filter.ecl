//this should be called after doxie.MAC_Header_Field_Declare

export MAC_Apply_DtSeen_Filter(in_file, out_file, l_seen, f_seen) := macro

out_file := 

in_file((date_first_seen_value=0 and (date_last_seen_value BETWEEN f_seen and l_seen)) OR
        (date_first_seen_value<>0 and l_seen >= date_first_seen_value and f_seen <= date_last_seen_value)); 

endmacro;