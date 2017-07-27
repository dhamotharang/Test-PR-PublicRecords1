export Layout_Corp_Out := record
string12  bdid;                  // Seisint Business Identifier
string8   dt_first_seen;
string8   dt_last_seen;
Layout_Corporate_Direct_Corp_In;
string32  corp_sos_charter_nbr;  // For application display
string10  corp_phone10;
string10  corp_ra_phone10;
string9   corp_fein := '';
string1   record_type;           // 'C' Current
                                 // 'H' Historical
string1   address_ind := '';     // 'R' Corporate Addr1 copied from Registered Agent Address								 
end;