export Layout_Corporate_Direct_AR_In := record

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
string30  ar_report_nbr;  //modified length from 10 to 30
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
string350 ar_comment; //modified length from 100 to 350
string60  ar_type; //modified length from 1 to 60

end;