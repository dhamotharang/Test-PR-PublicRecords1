export Layout_Corporate_Direct_AR_Base :=
record
unsigned6 bdid := 0;       // Seisint Business Identifier
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
//Layout_Corporate_Direct_AR_In;
//*********************************************
string30  corp_key;
string2   corp_vendor;
string3   corp_vendor_county;
string5   corp_vendor_subcode;
string2   corp_state_origin;
string8   corp_process_date;
string32  corp_sos_charter_nbr;

string4   ar_year;
string8   ar_mailed_dt;
string8   ar_due_dt;
string8   ar_filed_dt;
string8   ar_report_dt;
string30  ar_report_nbr;
string8   ar_franchise_tax_paid_dt;
string8   ar_delinquent_dt;
string10  ar_tax_factor;
string10  ar_tax_amount_paid;
string10  ar_annual_report_cap;
string10  ar_illinois_capital;
string10  ar_roll;
string10  ar_frame;
string10  ar_extension;
string10  ar_microfilm_nbr;
string350 ar_comment;
string60  ar_type;
//************************ This block with be replace with AR_In layout
STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;