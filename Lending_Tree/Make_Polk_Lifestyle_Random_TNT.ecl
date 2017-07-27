IMPORT ut, gong;

// Add record id and TNT Indicator to Polk Lifestyle Random Sample file
Layout_Polk_Lifestyle_TNT := RECORD
Lending_Tree.Layout_Polk_Lifestyle_Random;
INTEGER8 record_id := 0;
BOOLEAN TNT_Indicator := FALSE;
END;

Layout_Polk_Lifestyle_TNT InitTNTIndicator(Lending_Tree.Layout_Polk_Lifestyle_Random L) := TRANSFORM
SELF := L;
END;

// Project file to add temporary TNT indicator
Polk_Lifestyle_TNT_Init := PROJECT(Lending_Tree.File_Polk_Lifestyle_Random, InitTNTIndicator(LEFT));

// Add Unique Record ID for deduping
ut.MAC_Sequence_Records(Polk_Lifestyle_TNT_Init, record_id, Polk_Lifestyle_TNT_Seq)

// Get TNT Indicators
Gong.TNT(Polk_Lifestyle_TNT_Seq, Polk_Lifestyle_TNT_Out, TNT_Indicator, pk_fname, pk_lname, pk_prim_range, pk_prim_name, pk_zip5)

Polk_Lifestyle_TNT_Dedup := DEDUP(Polk_Lifestyle_TNT_Out, record_id, ALL);

Lending_Tree.Layout_Polk_Lifestyle_Random SetTNTFlag(Layout_Polk_Lifestyle_TNT L) := TRANSFORM
SELF.TNT_Flag := IF(L.TNT_Indicator = TRUE, 'Y', 'N');
SELF := L;
END;

Polk_Lifestyle_TNT_Updated := PROJECT(Polk_Lifestyle_TNT_Dedup, SetTNTFlag(LEFT));

COUNT(Polk_Lifestyle_TNT_Updated);
OUTPUT(Polk_Lifestyle_TNT_Updated,,'LendTree::Polk_Lifestyle_Random_TNT');