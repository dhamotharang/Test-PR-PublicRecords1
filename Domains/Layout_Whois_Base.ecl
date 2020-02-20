import Address;

export Layout_Whois_Base := record
unsigned6 did := 0;
unsigned6 bdid := 0;
Layout_Whois;
Address.Layout_Clean_Name;
//Added for CCPA-357
unsigned4 global_sid;
unsigned8 record_sid;
end;