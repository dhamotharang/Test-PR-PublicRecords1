export Layout_Corp_Cont_Base := record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned6 did := 0;
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
Layout_Corporate_Direct_Cont_In_Raw;
string32  corp_sos_charter_nbr;  // For application display
string10  corp_phone10;
string10  cont_phone10;
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;								 
