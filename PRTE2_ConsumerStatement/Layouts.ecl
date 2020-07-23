IMPORT ConsumerStatement;

EXPORT Layouts := MODULE

   EXPORT ProdBase := ConsumerStatement.Layout.nonfcra.consumer;

      EXPORT INPUT := RECORD
           UNSIGNED8 lexid;
           STRING xbug_num;
           STRING xvendor_code;
           STRING xsponsorcode;
           STRING xambestnumber;
           STRING xnamefirst;
           STRING xnamemiddle;
           STRING xnamelast;
           STRING xnamesuffix;
           STRING xdateofbirth;
           STRING xsocialsecuritynumber;
           STRING xgender;
           STRING xstreetaddress;
           STRING xcity;
           STRING xstate;
           STRING xzip;
           STRING xzip4;
           STRING xdriverslicensestate;
           STRING xdriverslicensenumber;
           STRING xproductname;
           STRING xmaxsize;
           STRING recid1;
           STRING recid2;
           STRING recid3;
           STRING recid4;
           STRING cd_id_autofill;
           STRING datagroup;
           STRING recordtype;
           STRING datatypeversion_autofill;
           STRING dateadded_autofill;
           STRING eventtype;
           STRING sourcesystem_autofill;
           STRING statementsequence;
           INTEGER statementid_autofill;
           STRING content;
           STRING xreqirement_type;
           STRING10 cust_name;
           STRING10 bug_num;
      END;
      
      EXPORT Base := Record
           ProdBase;
           STRING9 SSN;
           STRING20 cust_name;
           STRING10 bug_num;
      END;
      
      EXPORT Address_Key := RECORD,maxlength(10000)
           string2 st;
           string25 p_city_name;
           string25 v_city_name;
           string5 zip;
           string10 prim_range;
           string28 prim_name;
           string8 sec_range;
           integer8 statement_id;
           string30 orig_fname;
           string30 orig_lname;
           string30 orig_mname;
           string100 orig_cname;
           string100 orig_address;
           string30 orig_city;
           string2 orig_st;
           string5 orig_zip;
           string4 orig_zip4;
           string10 phone;
           string5 title;
           string20 fname;
           string20 mname;
           string20 lname;
           string5 name_suffix;
           string3 name_score;
           string2 predir;
           string4 addr_suffix;
           string2 postdir;
           string10 unit_desig;
           string4 zip4;
           string4 cart;
           string1 cr_sort_sz;
           string4 lot;
           string1 lot_order;
           string2 dbpc;
           string1 chk_digit;
           string2 rec_type;
           string5 county;
           string10 geo_lat;
           string11 geo_long;
           string4 msa;
           string7 geo_blk;
           string1 geo_match;
           string4 err_stat;
           string20 date_submitted;
           string20 date_created;
           unsigned6 did;
           string consumer_text;
           integer8 override_flag;
      END;  
      
      EXPORT Phone_Key := RECORD,maxlength(10000)
           string10 phone;
           integer8 statement_id;
           string30 orig_fname;
           string30 orig_lname;
           string30 orig_mname;
           string100 orig_cname;
           string100 orig_address;
           string30 orig_city;
           string2 orig_st;
           string5 orig_zip;
           string4 orig_zip4;
           string5 title;
           string20 fname;
           string20 mname;
           string20 lname;
           string5 name_suffix;
           string3 name_score;
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
           string4 cart;
           string1 cr_sort_sz;
           string4 lot;
           string1 lot_order;
           string2 dbpc;
           string1 chk_digit;
           string2 rec_type;
           string5 county;
           string10 geo_lat;
           string11 geo_long;
           string4 msa;
           string7 geo_blk;
           string1 geo_match;
           string4 err_stat;
           string20 date_submitted;
           string20 date_created;
           unsigned6 did;
           string consumer_text;
           integer8 override_flag;
      END;

      EXPORT StatementID_Key := RECORD,maxlength(10000)
           integer8 statement_id;
           string30 orig_fname;
           string30 orig_lname;
           string30 orig_mname;
           string100 orig_cname;
           string100 orig_address;
           string30 orig_city;
           string2 orig_st;
           string5 orig_zip;
           string4 orig_zip4;
           string10 phone;
           string5 title;
           string20 fname;
           string20 mname;
           string20 lname;
           string5 name_suffix;
           string3 name_score;
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
           string4 cart;
           string1 cr_sort_sz;
           string4 lot;
           string1 lot_order;
           string2 dbpc;
           string1 chk_digit;
           string2 rec_type;
           string5 county;
           string10 geo_lat;
           string11 geo_long;
           string4 msa;
           string7 geo_blk;
           string1 geo_match;
           string4 err_stat;
           string20 date_submitted;
           string20 date_created;
           unsigned6 did;
           string consumer_text;
           integer8 override_flag;
      END;

      EXPORT LexID_Key := RECORD
           unsigned8 lexid;
           string9 ssn;
           string20 fname;
           string20 lname;
           varstring cs_text;
           string20 datecreated;
      END;

      EXPORT SSN_Key := RECORD
           string9 ssn;
           unsigned8 lexid;
           string20 fname;
           string20 lname;
           varstring cs_text;
           string20 datecreated;
      END;
END;            
               
               
               
               
               
               
               
               
               
               
               
               
               
               
               
               
               
               