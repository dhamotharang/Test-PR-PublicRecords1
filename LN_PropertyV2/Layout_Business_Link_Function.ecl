IMPORT Business_Header;

EXPORT Layout_Business_Link_Function := RECORD
   Business_Header.Layout_Business_Linking.Company_;
   UNSIGNED6 group1_id;  // Group identifier (temporary) for matching groups of records pre-linked
END;