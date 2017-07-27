export Layout_BH_Best_Out := record
string12  bdid;	         // Seisint Business Identifier
string120 company_name;
string10  prim_range;
string2   predir;
string28  prim_name;
string4   addr_suffix;
string2   postdir;
string5   unit_desig;
string8   sec_range;
string25  city;
string2   state;
string5   zip;
string4   zip4;
string10  phone;
string9   fein;        // Federal Tax ID
string2   source := '';	   // source type (non-blank only if DPPA_State is non-blank)
string2   DPPA_State := ''; // If nonblank, indicates state code for a DPPA restricted record
end;