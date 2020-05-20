IMPORT ADDRESS, CERTEGY;
EXPORT layouts := MODULE
         
   EXPORT Certegy_SLIM := Certegy.layouts.orig_DL_slim;
   EXPORT CERTEGY_PROD := Certegy.layouts.base;

   EXPORT INPUT := RECORD
        Certegy_SLIM;
        CERTEGY_PROD-global_sid-record_sid;
        STRING link_dob;	
        STRING link_ssn;
        STRING10 cust_name;
        STRING10 bug_num;
   END;     

   EXPORT Base := RECORD
        Certegy_SLIM;
        CERTEGY_PROD;
        STRING link_dob;	
        STRING link_ssn;
        STRING10 cust_name;
        STRING10 bug_num;
   END;  
   
   EXPORT Key := RECORD
        CERTEGY_PROD
   END;

END;