export Layout_Corp_Supp_Base := record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
Layout_Corporate_Direct_Supp_In;
string10  corp_phone10;
string10  supp_phone10;
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;