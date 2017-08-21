export fn_address_hash(string10 in_prange, string28 in_pname, string8 in_srange, string5 in_zip) := function

 unsigned8 v_addr_hash := hash64(in_prange,in_pname,in_srange,in_zip);
 
 return v_addr_hash;

end;