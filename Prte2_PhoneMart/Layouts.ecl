IMPORT PRTE2_PhoneMart, PhoneMart, Phonesplus_v2, Phonesplus, PRTE2_Common, PRTE_CSV, PRTE2_Phonesplus;

EXPORT Layouts := MODULE

         EXPORT PhoneMart_Base := PhoneMart.Layouts.base;

         EXPORT phones_base := RECORD
           Phonesplus_v2.Layout_Phonesplus_Base;
           STRING20 cust_name;
           STRING10 bug_num;
           STRING9 link_ssn;
           STRING8 link_dob;
         END;
                  
         EXPORT PRTE_PhoneMart_Base := RECORD
           PhoneMart_Base;
           STRING20 cust_name;
           STRING10 bug_num;
         END;
         
         
         
         EXPORT DID_key := RECORD
          unsigned6 l_did;
          string10 phone;
          unsigned6 did;
          unsigned4 dt_vendor_first_reported;
          unsigned4 dt_vendor_last_reported;
          unsigned4 dt_first_seen;
          unsigned4 dt_last_seen;
          string1 record_type;
          qstring18 cid_number;
          string10 csd_ref_number;
          string10 old_csd_ref_number;
          string9 ssn;
          string80 address;
          string28 city;
          string2 state;
          string5 zipcode;
          string1 history_flag;
          string5 title;
          string20 fname;
          string20 mname;
          string20 lname;
          string5 name_suffix;
          unsigned4 global_sid;
          unsigned8 record_sid;  
         END;
 
         EXPORT Phone_key := RECORD
           string10 phone;
           unsigned6 did;
           unsigned4 dt_vendor_first_reported;
           unsigned4 dt_vendor_last_reported;
           unsigned4 dt_first_seen;
           unsigned4 dt_last_seen;
           string1 record_type;
           qstring18 cid_number;
           string10 csd_ref_number;
           string10 old_csd_ref_number;
           string9 ssn;
           string80 address;
           string28 city;
           string2 state;
           string5 zipcode;
           string1 history_flag;
           string5 title;
           string20 fname;
           string20 mname;
           string20 lname;
           string5 name_suffix;
           unsigned4 global_sid;
           unsigned8 record_sid; 
         END;

END; 