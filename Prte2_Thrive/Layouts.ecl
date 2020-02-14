IMPORT Thrive, address,AID, Bipv2;

EXPORT Layouts := MODULE
   SHARED max_size := thrive._Dataset().max_record_size;
   
       EXPORT INPUT_Base := thrive.layouts.Base;
       EXPORT INPUT_BaseOld := thrive.layouts.BaseOld;
       
       EXPORT INPUT := RECORD 
          INPUT_Base-BIPV2.IDlayouts.l_xlink_ids-global_sid-record_sid;
          STRING link_dob;	
          STRING link_ssn;	
          STRING cust_dob;	
          STRING cust_ssn;	
          STRING10 cust_name;	
          STRING10 bug_num;	
          STRING order;
       END;
       
       EXPORT Base := RECORD
          INPUT_BaseOld-global_sid-record_sid;
          STRING link_dob;	
          STRING link_ssn;	
          STRING cust_dob;	
          STRING cust_ssn;	
          STRING10 cust_name;	
          STRING10 bug_num;	
          STRING order;
          UNSIGNED8 Global_SID;
          UNSIGNED8 Record_SID;
       END;
       
       EXPORT BaseOld := RECORD
          INPUT_BaseOld;
       END;
       
END;       