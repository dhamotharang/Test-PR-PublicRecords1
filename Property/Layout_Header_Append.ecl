EXPORT Layout_Header_Append := MODULE;

export inrec :=record
       unsigned8 did;
       unsigned8 rid;
       string10 prim_range;
       string28 prim_name;
       string8  sec_range;
       string25 city;
			 string2  st;
end;

export addrrec := record
       unsigned8 did;
       string10 prim_range;
       string28 prim_name;
       string8  sec_range;
       string25 city;
			 string2  st;
			 string5  zip;
			 string2  addr_ind;
			 string1  best_addr_ind;
end;


export outrec := record
       inrec;
       string2   addr_ind;
       string1   best_addr_ind;
			 unsigned6 addr_tx_id;
			 string1   best_addr_tx_id;
			 unsigned6 locid;
			 string1   best_locid;
end;

END; 