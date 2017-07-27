export Layout_Corp_Event_Base := record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
Layout_Corporate_Direct_Event_In;
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;