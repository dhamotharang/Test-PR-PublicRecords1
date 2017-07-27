EXPORT Layout_Corp4_Temp := RECORD
Layout_Corp4;
STRING350 reg_agent_name;
STRING70  reg_agent_street;
STRING32  reg_agent_city;
STRING2   reg_agent_state;
STRING9   reg_agent_zip5;
STRING1   address_ind;
STRING1   reg_agent_source_ind := 'R';  // 'R' From original registered agent
                                        // 'C' From contact record (title = '39' or '40'
STRING8   dt_first_seen;                // First date seen of name, address, address type
STRING8   dt_last_seen;                 // Last date seen of name, address, address type
STRING1   record_type := 'H';           // 'C' Current
                                        // 'H' Historical
STRING1   suppress_ra_addr := '';       // 'Y' Corporate Address filled with RA address
                                        // otherwise blank
STRING32  orig_sos_charter_nbr;         // Initializied to original value of sos_charter_nbr
STRING1   ra_officer_also := '';        // If 'Y', indicates registered agent is also
                                        // an officer of the company
STRING1   o1_addr_blank := 'N';         // Flag to indicate officer1 address blank
STRING1   o2_addr_blank := 'N';         // Flag to indicate officer2 address blank
STRING1   o3_addr_blank := 'N';         // Flag to indicate officer3 address blank
STRING1   o4_addr_blank := 'N';         // Flag to indicate officer4 address blank
STRING1   o5_addr_blank := 'N';         // Flag to indicate officer5 address blank
END;