IMPORT PRTE2_SAM, Sam, AccountMonitoring, EPLS, SAM_Services, UT, PromoteSupers, std, Prte2, Address, AID, AID_Support, SAM, PRTE2_SAM, AccountMonitoring, EPLS, SAM_Services;

EXPORT Layouts := MODULE

EXPORT INPUT := SAM.Layout_SAM;
EXPORT BIP_linkid := SAM.layout_bip_linkid;

   EXPORT Input_EXT := RECORD
          INPUT-CAGE;
          unsigned6 did;
          STRING  cust_name;
          STRING  bug_num;
          STRING  link_fein;
          STRING  link_inc_date;
          STRING  link_dob;
          STRING  link_ssn;
   END;

   EXPORT Base := RECORD
          BIP_linkid-CAGE;
          unsigned6 did;
          STRING cust_name;
          STRING bug_num;
          STRING link_fein;
          STRING link_inc_date;
          STRING link_dob;
          STRING link_ssn;
   END;
   
   EXPORT Key := RECORD
          BIP_linkid;
   END;       
END;