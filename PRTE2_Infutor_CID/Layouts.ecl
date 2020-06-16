IMPORT PRTE2_infutor_cid, Phonesplus_v2, Phonesplus, PRTE2_Common, PRTE_CSV, PRTE2_Phonesplus;

EXPORT Layouts := MODULE

         EXPORT Layout_Phonesplus_Base := Phonesplus_v2.Layout_Phonesplus_Base;
         EXPORT Alpha_CSV_Layout := PRTE2_Phonesplus.Layouts.Alpha_CSV_Layout;
         EXPORT Base_in := PRTE2_Phonesplus.Layouts.Base_in;         
         EXPORT Base_common := PRTE2_Phonesplus.Layouts.Base_common;
         EXPORT Base_ext := PRTE2_Phonesplus.Layouts.Base_ext;
                  
         EXPORT DID_key := RECORD
           unsigned6 did;
           string34 persistent_record_id;
           string10 phone;
           string20 fname;
           string20 lname;
           string10 prim_range;
           string2 predir;
           string28 prim_name;
           string4 addr_suffix;
           string2 postdir;
           string10 unit_desig;
           string8 sec_range;
           string25 p_city_name;
           string25 v_city_name;
           string2 st;
           string5 zip;
           string4 zip4;
           string2 rec_type;
           string5 county;
           string10 geo_lat;
           string11 geo_long;
           string7 geo_blk;
           unsigned6 dt_first_seen;
           unsigned6 dt_last_seen;
           unsigned4 global_sid;
           unsigned8 record_sid;
         END;
 
         EXPORT Phone_key := RECORD
           string10 phone;
           string34 persistent_record_id;
           string20 fname;
           string20 lname;
           string10 prim_range;
           string2 predir;
           string28 prim_name;
           string4 addr_suffix;
           string2 postdir;
           string10 unit_desig;
           string8 sec_range;
           string25 p_city_name;
           string25 v_city_name;
           string2 st;
           string5 zip;
           string4 zip4;
           string2 rec_type;
           string5 county;
           string10 geo_lat;
           string11 geo_long;
           string7 geo_blk;
           unsigned6 did;
           unsigned6 dt_first_seen;
           unsigned6 dt_last_seen;
           unsigned4 global_sid;
           unsigned8 record_sid;
         END;

END; 