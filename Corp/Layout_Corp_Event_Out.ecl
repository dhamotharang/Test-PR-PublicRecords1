export Layout_Corp_Event_Out := record
string12  bdid;                  // Seisint Business Identifier
string8   dt_first_seen;
string8   dt_last_seen;
Layout_Corporate_Direct_Event_In;
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;