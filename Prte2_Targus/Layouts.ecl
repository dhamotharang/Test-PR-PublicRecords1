IMPORT Targus, Address;

//Production Layouts
EXPORT LAYOUTS := MODULE
       EXPORT INPUT_Consumer := Targus.Layout_Consumer_in; //Input
       EXPORT CCPA           := Targus.Layout_Consumer_out; //Global_SID Record_SID _In _Slim
       EXPORT UNFILTERED     := Targus.Layout_Consumer_Out_Unfiltered; // _In _slim ScrubsBits1 ScrubsBits2
       EXPORT Address_Clean  := Targus.Layout_Consumer_slim; //address cleaning fields
      
   //Input Layout
   EXPORT INPUT := RECORD
         INPUT_Consumer;
         Address_Clean;
         STRING9   link_ssn;
         STRING8   link_dob;
         STRING10  cust_name;
         STRING10  bug_num;
         STRING    raw_addr1;
         STRING    raw_addr2;

   END;
  
   //Base Layout  
   EXPORT Base := RECORD
         INPUT-raw_addr1-raw_addr2;
         UNFILTERED;
         UNSIGNED8 Global_SID;
         UNSIGNED8 Record_SID;
   END;
   
   //Address and DID key Layout
   EXPORT Key := RECORD
         CCPA; 
   END;
   
   //Phone key Layout
   EXPORT PhoneKey := Record
         STRING7 P7;
         STRING3 P3; 
         CCPA;
   END;
     
END;