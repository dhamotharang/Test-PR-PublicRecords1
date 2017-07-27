export Layout_Corp_Supp_Out := record
string12  bdid;                  // Seisint Business Identifier
string8   dt_first_seen;
string8   dt_last_seen;
Layout_Corporate_Direct_Supp_In;
string10  corp_phone10;
string10  supp_phone10;
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;