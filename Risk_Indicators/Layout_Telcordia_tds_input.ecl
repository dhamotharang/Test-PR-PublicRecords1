export Layout_Telcordia_tds_input:= module

Export       TDS_Layout := Record 
	STRING3    npa;
	STRING3    nxx;
	STRING1    tb;
	STRING2    state;
	STRING1    timezone;
	STRING3    COCType;
	STRING4    SSC;
	STRING4    Wireless_ind; 
END;


EXPORT    Ab_Initio := Record
  string  npa;
  string  nxx;
  string  tb;
  string  state;
  string  timezone;
  string  junk;
  string  COCType;
  string  SCC;
  string  Wireless_ind;
end;

end; 
