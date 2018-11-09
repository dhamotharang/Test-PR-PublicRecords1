IMPORT header;

/*

FACTACT codes:

'W' : Active Duty Alert with Fraud Victim "Extended Alert". Active for 1-Year then rolls to an 'X' for the remaining 7 years term
'X' : Fraud Victom "Extended Alert". Active for 7 years
'Q' : Active Duty Alert with Fraud Victim "Initial Alert". Active for 90 days then rolls to 'N' for the remaining 1 year term
'V' : Fraud Victom "Initial Alert". Active for 90 days
'N' : Active Dury Alert. Active for 1 year

*/

EXPORT layout_fraud_flag_eq := module

        EXPORT in := record

            ebcdic string9 cid;     	    // 9	1	9	H	Consumer ID #	 
            ebcdic string1 factact_code;  // 1	10	10	C	Fraud Victim Code (L=90 day purge, E=7 year purge, Blank)	Blank
            ebcdic string4 date_reported; // 4	11	14	C	Fraud Victim Code Date Reported (MMYY)	Blank
            string filename { VIRTUAL( logicalfilename ) };
            
        END;

        EXPORT base := record

            qstring18 vendor_id;
            string1 factact_code;
            unsigned3 date_reported;
            unsigned3 dt_vendor_first_reported;
            unsigned3 dt_vendor_last_reported;
            
        END;
        
        EXPORT key := record
        
            header.Layout_Header.did;
            base;
            boolean current;
        
        END;
end;