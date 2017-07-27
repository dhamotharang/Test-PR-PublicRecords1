EXPORT Layout_Corporate_Base := RECORD
UNSIGNED6 bdid;
Layout_Corporate;
STRING32 orig_sos_ter_nbr;
STRING1 ra_officer_also;        // If 'Y', indicates registered agent is also
                                // an officer of the company
END;