IMPORT ut, gong;

// Add record id and TNT Indicator to Customer Analytic file
Layout_Customer_TNT := RECORD
Lending_Tree.Layout_Customer_Analytic;
INTEGER8 record_id := 0;
BOOLEAN TNT_Indicator := FALSE;
END;

Layout_Customer_TNT InitTNTIndicator(Lending_Tree.Layout_Customer_Analytic L) := TRANSFORM
SELF := L;
END;

// Project file to add temporary TNT indicator
Customer_TNT_Init := PROJECT(Lending_Tree.File_Customer_Analytic, InitTNTIndicator(LEFT));

// Add Unique Record ID for deduping
ut.MAC_Sequence_Records(Customer_TNT_Init, record_id, Customer_TNT_Seq)

// Get TNT Indicators
Gong.TNT(Customer_TNT_Seq, Customer_TNT_Out, TNT_Indicator, name_first, name_last, prim_range, prim_name, ace_zip)

Customer_TNT_Dedup := DEDUP(Customer_TNT_Out, record_id, ALL);

Lending_Tree.Layout_Customer_Analytic SetTNTFlag(Layout_Customer_TNT L) := TRANSFORM
SELF.TNT_Flag := IF(L.TNT_Indicator = TRUE, 'Y', 'N');
SELF := L;
END;

Customer_TNT_Updated := PROJECT(Customer_TNT_Dedup, SetTNTFlag(LEFT));

COUNT(Customer_TNT_Updated);
OUTPUT(Customer_TNT_Updated,,'LendTree::Customer_Analytic_TNT');