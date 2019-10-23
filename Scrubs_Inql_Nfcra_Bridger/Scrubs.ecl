IMPORT SALT39,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 25;
  EXPORT NumRulesFromFieldType := 25;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 21;
  EXPORT NumFieldsWithPossibleEdits := 21;
  EXPORT NumRulesWithPossibleEdits := 25;
  EXPORT Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 datetime_Invalid;
    BOOLEAN datetime_wouldClean;
    UNSIGNED1 customer_id_Invalid;
    BOOLEAN customer_id_wouldClean;
    UNSIGNED1 search_function_name_Invalid;
    BOOLEAN search_function_name_wouldClean;
    UNSIGNED1 entity_type_Invalid;
    BOOLEAN entity_type_wouldClean;
    UNSIGNED1 field1_Invalid;
    BOOLEAN field1_wouldClean;
    UNSIGNED1 field2_Invalid;
    BOOLEAN field2_wouldClean;
    UNSIGNED1 field3_Invalid;
    BOOLEAN field3_wouldClean;
    UNSIGNED1 field4_Invalid;
    BOOLEAN field4_wouldClean;
    UNSIGNED1 field5_Invalid;
    BOOLEAN field5_wouldClean;
    UNSIGNED1 field6_Invalid;
    BOOLEAN field6_wouldClean;
    UNSIGNED1 field7_Invalid;
    BOOLEAN field7_wouldClean;
    UNSIGNED1 field8_Invalid;
    BOOLEAN field8_wouldClean;
    UNSIGNED1 field9_Invalid;
    BOOLEAN field9_wouldClean;
    UNSIGNED1 field10_Invalid;
    BOOLEAN field10_wouldClean;
    UNSIGNED1 field11_Invalid;
    BOOLEAN field11_wouldClean;
    UNSIGNED1 field12_Invalid;
    BOOLEAN field12_wouldClean;
    UNSIGNED1 field13_Invalid;
    BOOLEAN field13_wouldClean;
    UNSIGNED1 field14_Invalid;
    BOOLEAN field14_wouldClean;
    UNSIGNED1 field15_Invalid;
    BOOLEAN field15_wouldClean;
    UNSIGNED1 field16_Invalid;
    BOOLEAN field16_wouldClean;
    UNSIGNED1 id__Invalid;
    BOOLEAN id__wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.datetime_Invalid := Fields.InValid_datetime((SALT39.StrType)le.datetime);
    clean_datetime := (TYPEOF(le.datetime))Fields.Make_datetime((SALT39.StrType)le.datetime);
    clean_datetime_Invalid := Fields.InValid_datetime((SALT39.StrType)clean_datetime);
    SELF.datetime := IF(withOnfail, clean_datetime, le.datetime); // ONFAIL(CLEAN)
    SELF.datetime_wouldClean := TRIM((SALT39.StrType)le.datetime) <> TRIM((SALT39.StrType)clean_datetime);
    SELF.customer_id_Invalid := Fields.InValid_customer_id((SALT39.StrType)le.customer_id);
    clean_customer_id := (TYPEOF(le.customer_id))Fields.Make_customer_id((SALT39.StrType)le.customer_id);
    clean_customer_id_Invalid := Fields.InValid_customer_id((SALT39.StrType)clean_customer_id);
    SELF.customer_id := IF(withOnfail, clean_customer_id, le.customer_id); // ONFAIL(CLEAN)
    SELF.customer_id_wouldClean := TRIM((SALT39.StrType)le.customer_id) <> TRIM((SALT39.StrType)clean_customer_id);
    SELF.search_function_name_Invalid := Fields.InValid_search_function_name((SALT39.StrType)le.search_function_name);
    clean_search_function_name := (TYPEOF(le.search_function_name))Fields.Make_search_function_name((SALT39.StrType)le.search_function_name);
    clean_search_function_name_Invalid := Fields.InValid_search_function_name((SALT39.StrType)clean_search_function_name);
    SELF.search_function_name := IF(withOnfail, clean_search_function_name, le.search_function_name); // ONFAIL(CLEAN)
    SELF.search_function_name_wouldClean := TRIM((SALT39.StrType)le.search_function_name) <> TRIM((SALT39.StrType)clean_search_function_name);
    SELF.entity_type_Invalid := Fields.InValid_entity_type((SALT39.StrType)le.entity_type);
    clean_entity_type := (TYPEOF(le.entity_type))Fields.Make_entity_type((SALT39.StrType)le.entity_type);
    clean_entity_type_Invalid := Fields.InValid_entity_type((SALT39.StrType)clean_entity_type);
    SELF.entity_type := IF(withOnfail, clean_entity_type, le.entity_type); // ONFAIL(CLEAN)
    SELF.entity_type_wouldClean := TRIM((SALT39.StrType)le.entity_type) <> TRIM((SALT39.StrType)clean_entity_type);
    SELF.field1_Invalid := Fields.InValid_field1((SALT39.StrType)le.field1);
    clean_field1 := (TYPEOF(le.field1))Fields.Make_field1((SALT39.StrType)le.field1);
    clean_field1_Invalid := Fields.InValid_field1((SALT39.StrType)clean_field1);
    SELF.field1 := IF(withOnfail, clean_field1, le.field1); // ONFAIL(CLEAN)
    SELF.field1_wouldClean := TRIM((SALT39.StrType)le.field1) <> TRIM((SALT39.StrType)clean_field1);
    SELF.field2_Invalid := Fields.InValid_field2((SALT39.StrType)le.field2);
    clean_field2 := (TYPEOF(le.field2))Fields.Make_field2((SALT39.StrType)le.field2);
    clean_field2_Invalid := Fields.InValid_field2((SALT39.StrType)clean_field2);
    SELF.field2 := IF(withOnfail, clean_field2, le.field2); // ONFAIL(CLEAN)
    SELF.field2_wouldClean := TRIM((SALT39.StrType)le.field2) <> TRIM((SALT39.StrType)clean_field2);
    SELF.field3_Invalid := Fields.InValid_field3((SALT39.StrType)le.field3);
    clean_field3 := (TYPEOF(le.field3))Fields.Make_field3((SALT39.StrType)le.field3);
    clean_field3_Invalid := Fields.InValid_field3((SALT39.StrType)clean_field3);
    SELF.field3 := IF(withOnfail, clean_field3, le.field3); // ONFAIL(CLEAN)
    SELF.field3_wouldClean := TRIM((SALT39.StrType)le.field3) <> TRIM((SALT39.StrType)clean_field3);
    SELF.field4_Invalid := Fields.InValid_field4((SALT39.StrType)le.field4);
    clean_field4 := (TYPEOF(le.field4))Fields.Make_field4((SALT39.StrType)le.field4);
    clean_field4_Invalid := Fields.InValid_field4((SALT39.StrType)clean_field4);
    SELF.field4 := IF(withOnfail, clean_field4, le.field4); // ONFAIL(CLEAN)
    SELF.field4_wouldClean := TRIM((SALT39.StrType)le.field4) <> TRIM((SALT39.StrType)clean_field4);
    SELF.field5_Invalid := Fields.InValid_field5((SALT39.StrType)le.field5);
    clean_field5 := (TYPEOF(le.field5))Fields.Make_field5((SALT39.StrType)le.field5);
    clean_field5_Invalid := Fields.InValid_field5((SALT39.StrType)clean_field5);
    SELF.field5 := IF(withOnfail, clean_field5, le.field5); // ONFAIL(CLEAN)
    SELF.field5_wouldClean := TRIM((SALT39.StrType)le.field5) <> TRIM((SALT39.StrType)clean_field5);
    SELF.field6_Invalid := Fields.InValid_field6((SALT39.StrType)le.field6);
    clean_field6 := (TYPEOF(le.field6))Fields.Make_field6((SALT39.StrType)le.field6);
    clean_field6_Invalid := Fields.InValid_field6((SALT39.StrType)clean_field6);
    SELF.field6 := IF(withOnfail, clean_field6, le.field6); // ONFAIL(CLEAN)
    SELF.field6_wouldClean := TRIM((SALT39.StrType)le.field6) <> TRIM((SALT39.StrType)clean_field6);
    SELF.field7_Invalid := Fields.InValid_field7((SALT39.StrType)le.field7);
    clean_field7 := (TYPEOF(le.field7))Fields.Make_field7((SALT39.StrType)le.field7);
    clean_field7_Invalid := Fields.InValid_field7((SALT39.StrType)clean_field7);
    SELF.field7 := IF(withOnfail, clean_field7, le.field7); // ONFAIL(CLEAN)
    SELF.field7_wouldClean := TRIM((SALT39.StrType)le.field7) <> TRIM((SALT39.StrType)clean_field7);
    SELF.field8_Invalid := Fields.InValid_field8((SALT39.StrType)le.field8);
    clean_field8 := (TYPEOF(le.field8))Fields.Make_field8((SALT39.StrType)le.field8);
    clean_field8_Invalid := Fields.InValid_field8((SALT39.StrType)clean_field8);
    SELF.field8 := IF(withOnfail, clean_field8, le.field8); // ONFAIL(CLEAN)
    SELF.field8_wouldClean := TRIM((SALT39.StrType)le.field8) <> TRIM((SALT39.StrType)clean_field8);
    SELF.field9_Invalid := Fields.InValid_field9((SALT39.StrType)le.field9);
    clean_field9 := (TYPEOF(le.field9))Fields.Make_field9((SALT39.StrType)le.field9);
    clean_field9_Invalid := Fields.InValid_field9((SALT39.StrType)clean_field9);
    SELF.field9 := IF(withOnfail, clean_field9, le.field9); // ONFAIL(CLEAN)
    SELF.field9_wouldClean := TRIM((SALT39.StrType)le.field9) <> TRIM((SALT39.StrType)clean_field9);
    SELF.field10_Invalid := Fields.InValid_field10((SALT39.StrType)le.field10);
    clean_field10 := (TYPEOF(le.field10))Fields.Make_field10((SALT39.StrType)le.field10);
    clean_field10_Invalid := Fields.InValid_field10((SALT39.StrType)clean_field10);
    SELF.field10 := IF(withOnfail, clean_field10, le.field10); // ONFAIL(CLEAN)
    SELF.field10_wouldClean := TRIM((SALT39.StrType)le.field10) <> TRIM((SALT39.StrType)clean_field10);
    SELF.field11_Invalid := Fields.InValid_field11((SALT39.StrType)le.field11);
    clean_field11 := (TYPEOF(le.field11))Fields.Make_field11((SALT39.StrType)le.field11);
    clean_field11_Invalid := Fields.InValid_field11((SALT39.StrType)clean_field11);
    SELF.field11 := IF(withOnfail, clean_field11, le.field11); // ONFAIL(CLEAN)
    SELF.field11_wouldClean := TRIM((SALT39.StrType)le.field11) <> TRIM((SALT39.StrType)clean_field11);
    SELF.field12_Invalid := Fields.InValid_field12((SALT39.StrType)le.field12);
    clean_field12 := (TYPEOF(le.field12))Fields.Make_field12((SALT39.StrType)le.field12);
    clean_field12_Invalid := Fields.InValid_field12((SALT39.StrType)clean_field12);
    SELF.field12 := IF(withOnfail, clean_field12, le.field12); // ONFAIL(CLEAN)
    SELF.field12_wouldClean := TRIM((SALT39.StrType)le.field12) <> TRIM((SALT39.StrType)clean_field12);
    SELF.field13_Invalid := Fields.InValid_field13((SALT39.StrType)le.field13);
    clean_field13 := (TYPEOF(le.field13))Fields.Make_field13((SALT39.StrType)le.field13);
    clean_field13_Invalid := Fields.InValid_field13((SALT39.StrType)clean_field13);
    SELF.field13 := IF(withOnfail, clean_field13, le.field13); // ONFAIL(CLEAN)
    SELF.field13_wouldClean := TRIM((SALT39.StrType)le.field13) <> TRIM((SALT39.StrType)clean_field13);
    SELF.field14_Invalid := Fields.InValid_field14((SALT39.StrType)le.field14);
    clean_field14 := (TYPEOF(le.field14))Fields.Make_field14((SALT39.StrType)le.field14);
    clean_field14_Invalid := Fields.InValid_field14((SALT39.StrType)clean_field14);
    SELF.field14 := IF(withOnfail, clean_field14, le.field14); // ONFAIL(CLEAN)
    SELF.field14_wouldClean := TRIM((SALT39.StrType)le.field14) <> TRIM((SALT39.StrType)clean_field14);
    SELF.field15_Invalid := Fields.InValid_field15((SALT39.StrType)le.field15);
    clean_field15 := (TYPEOF(le.field15))Fields.Make_field15((SALT39.StrType)le.field15);
    clean_field15_Invalid := Fields.InValid_field15((SALT39.StrType)clean_field15);
    SELF.field15 := IF(withOnfail, clean_field15, le.field15); // ONFAIL(CLEAN)
    SELF.field15_wouldClean := TRIM((SALT39.StrType)le.field15) <> TRIM((SALT39.StrType)clean_field15);
    SELF.field16_Invalid := Fields.InValid_field16((SALT39.StrType)le.field16);
    clean_field16 := (TYPEOF(le.field16))Fields.Make_field16((SALT39.StrType)le.field16);
    clean_field16_Invalid := Fields.InValid_field16((SALT39.StrType)clean_field16);
    SELF.field16 := IF(withOnfail, clean_field16, le.field16); // ONFAIL(CLEAN)
    SELF.field16_wouldClean := TRIM((SALT39.StrType)le.field16) <> TRIM((SALT39.StrType)clean_field16);
    SELF.id__Invalid := Fields.InValid_id_((SALT39.StrType)le.id_);
    clean_id_ := (TYPEOF(le.id_))Fields.Make_id_((SALT39.StrType)le.id_);
    clean_id__Invalid := Fields.InValid_id_((SALT39.StrType)clean_id_);
    SELF.id_ := IF(withOnfail, clean_id_, le.id_); // ONFAIL(CLEAN)
    SELF.id__wouldClean := TRIM((SALT39.StrType)le.id_) <> TRIM((SALT39.StrType)clean_id_);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.datetime_Invalid << 0 ) + ( le.customer_id_Invalid << 2 ) + ( le.search_function_name_Invalid << 4 ) + ( le.entity_type_Invalid << 6 ) + ( le.field1_Invalid << 8 ) + ( le.field2_Invalid << 9 ) + ( le.field3_Invalid << 10 ) + ( le.field4_Invalid << 11 ) + ( le.field5_Invalid << 12 ) + ( le.field6_Invalid << 13 ) + ( le.field7_Invalid << 14 ) + ( le.field8_Invalid << 15 ) + ( le.field9_Invalid << 16 ) + ( le.field10_Invalid << 17 ) + ( le.field11_Invalid << 18 ) + ( le.field12_Invalid << 19 ) + ( le.field13_Invalid << 20 ) + ( le.field14_Invalid << 21 ) + ( le.field15_Invalid << 22 ) + ( le.field16_Invalid << 23 ) + ( le.id__Invalid << 24 );
    SELF.ScrubsCleanBits1 := ( IF(le.datetime_wouldClean, 1, 0) << 0 ) + ( IF(le.customer_id_wouldClean, 1, 0) << 1 ) + ( IF(le.search_function_name_wouldClean, 1, 0) << 2 ) + ( IF(le.entity_type_wouldClean, 1, 0) << 3 ) + ( IF(le.field1_wouldClean, 1, 0) << 4 ) + ( IF(le.field2_wouldClean, 1, 0) << 5 ) + ( IF(le.field3_wouldClean, 1, 0) << 6 ) + ( IF(le.field4_wouldClean, 1, 0) << 7 ) + ( IF(le.field5_wouldClean, 1, 0) << 8 ) + ( IF(le.field6_wouldClean, 1, 0) << 9 ) + ( IF(le.field7_wouldClean, 1, 0) << 10 ) + ( IF(le.field8_wouldClean, 1, 0) << 11 ) + ( IF(le.field9_wouldClean, 1, 0) << 12 ) + ( IF(le.field10_wouldClean, 1, 0) << 13 ) + ( IF(le.field11_wouldClean, 1, 0) << 14 ) + ( IF(le.field12_wouldClean, 1, 0) << 15 ) + ( IF(le.field13_wouldClean, 1, 0) << 16 ) + ( IF(le.field14_wouldClean, 1, 0) << 17 ) + ( IF(le.field15_wouldClean, 1, 0) << 18 ) + ( IF(le.field16_wouldClean, 1, 0) << 19 ) + ( IF(le.id__wouldClean, 1, 0) << 20 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.datetime_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.customer_id_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.search_function_name_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.entity_type_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.field1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.field2_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.field3_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.field4_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.field5_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.field6_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.field7_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.field8_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.field9_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.field10_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.field11_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.field12_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.field13_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.field14_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.field15_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.field16_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.id__Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.datetime_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.customer_id_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.search_function_name_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.entity_type_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.field1_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.field2_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.field3_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.field4_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.field5_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.field6_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.field7_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.field8_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.field9_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.field10_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.field11_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.field12_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.field13_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.field14_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.field15_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.field16_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.id__wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    datetime_ALLOW_ErrorCount := COUNT(GROUP,h.datetime_Invalid=1);
    datetime_ALLOW_WouldModifyCount := COUNT(GROUP,h.datetime_Invalid=1 AND h.datetime_wouldClean);
    datetime_WORDS_ErrorCount := COUNT(GROUP,h.datetime_Invalid=2);
    datetime_WORDS_WouldModifyCount := COUNT(GROUP,h.datetime_Invalid=2 AND h.datetime_wouldClean);
    datetime_Total_ErrorCount := COUNT(GROUP,h.datetime_Invalid>0);
    customer_id_ALLOW_ErrorCount := COUNT(GROUP,h.customer_id_Invalid=1);
    customer_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.customer_id_Invalid=1 AND h.customer_id_wouldClean);
    customer_id_WORDS_ErrorCount := COUNT(GROUP,h.customer_id_Invalid=2);
    customer_id_WORDS_WouldModifyCount := COUNT(GROUP,h.customer_id_Invalid=2 AND h.customer_id_wouldClean);
    customer_id_Total_ErrorCount := COUNT(GROUP,h.customer_id_Invalid>0);
    search_function_name_ALLOW_ErrorCount := COUNT(GROUP,h.search_function_name_Invalid=1);
    search_function_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.search_function_name_Invalid=1 AND h.search_function_name_wouldClean);
    search_function_name_WORDS_ErrorCount := COUNT(GROUP,h.search_function_name_Invalid=2);
    search_function_name_WORDS_WouldModifyCount := COUNT(GROUP,h.search_function_name_Invalid=2 AND h.search_function_name_wouldClean);
    search_function_name_Total_ErrorCount := COUNT(GROUP,h.search_function_name_Invalid>0);
    entity_type_ALLOW_ErrorCount := COUNT(GROUP,h.entity_type_Invalid=1);
    entity_type_ALLOW_WouldModifyCount := COUNT(GROUP,h.entity_type_Invalid=1 AND h.entity_type_wouldClean);
    entity_type_WORDS_ErrorCount := COUNT(GROUP,h.entity_type_Invalid=2);
    entity_type_WORDS_WouldModifyCount := COUNT(GROUP,h.entity_type_Invalid=2 AND h.entity_type_wouldClean);
    entity_type_Total_ErrorCount := COUNT(GROUP,h.entity_type_Invalid>0);
    field1_ALLOW_ErrorCount := COUNT(GROUP,h.field1_Invalid=1);
    field1_ALLOW_WouldModifyCount := COUNT(GROUP,h.field1_Invalid=1 AND h.field1_wouldClean);
    field2_ALLOW_ErrorCount := COUNT(GROUP,h.field2_Invalid=1);
    field2_ALLOW_WouldModifyCount := COUNT(GROUP,h.field2_Invalid=1 AND h.field2_wouldClean);
    field3_ALLOW_ErrorCount := COUNT(GROUP,h.field3_Invalid=1);
    field3_ALLOW_WouldModifyCount := COUNT(GROUP,h.field3_Invalid=1 AND h.field3_wouldClean);
    field4_ALLOW_ErrorCount := COUNT(GROUP,h.field4_Invalid=1);
    field4_ALLOW_WouldModifyCount := COUNT(GROUP,h.field4_Invalid=1 AND h.field4_wouldClean);
    field5_ALLOW_ErrorCount := COUNT(GROUP,h.field5_Invalid=1);
    field5_ALLOW_WouldModifyCount := COUNT(GROUP,h.field5_Invalid=1 AND h.field5_wouldClean);
    field6_ALLOW_ErrorCount := COUNT(GROUP,h.field6_Invalid=1);
    field6_ALLOW_WouldModifyCount := COUNT(GROUP,h.field6_Invalid=1 AND h.field6_wouldClean);
    field7_ALLOW_ErrorCount := COUNT(GROUP,h.field7_Invalid=1);
    field7_ALLOW_WouldModifyCount := COUNT(GROUP,h.field7_Invalid=1 AND h.field7_wouldClean);
    field8_ALLOW_ErrorCount := COUNT(GROUP,h.field8_Invalid=1);
    field8_ALLOW_WouldModifyCount := COUNT(GROUP,h.field8_Invalid=1 AND h.field8_wouldClean);
    field9_ALLOW_ErrorCount := COUNT(GROUP,h.field9_Invalid=1);
    field9_ALLOW_WouldModifyCount := COUNT(GROUP,h.field9_Invalid=1 AND h.field9_wouldClean);
    field10_ALLOW_ErrorCount := COUNT(GROUP,h.field10_Invalid=1);
    field10_ALLOW_WouldModifyCount := COUNT(GROUP,h.field10_Invalid=1 AND h.field10_wouldClean);
    field11_ALLOW_ErrorCount := COUNT(GROUP,h.field11_Invalid=1);
    field11_ALLOW_WouldModifyCount := COUNT(GROUP,h.field11_Invalid=1 AND h.field11_wouldClean);
    field12_ALLOW_ErrorCount := COUNT(GROUP,h.field12_Invalid=1);
    field12_ALLOW_WouldModifyCount := COUNT(GROUP,h.field12_Invalid=1 AND h.field12_wouldClean);
    field13_ALLOW_ErrorCount := COUNT(GROUP,h.field13_Invalid=1);
    field13_ALLOW_WouldModifyCount := COUNT(GROUP,h.field13_Invalid=1 AND h.field13_wouldClean);
    field14_ALLOW_ErrorCount := COUNT(GROUP,h.field14_Invalid=1);
    field14_ALLOW_WouldModifyCount := COUNT(GROUP,h.field14_Invalid=1 AND h.field14_wouldClean);
    field15_ALLOW_ErrorCount := COUNT(GROUP,h.field15_Invalid=1);
    field15_ALLOW_WouldModifyCount := COUNT(GROUP,h.field15_Invalid=1 AND h.field15_wouldClean);
    field16_ALLOW_ErrorCount := COUNT(GROUP,h.field16_Invalid=1);
    field16_ALLOW_WouldModifyCount := COUNT(GROUP,h.field16_Invalid=1 AND h.field16_wouldClean);
    id__ALLOW_ErrorCount := COUNT(GROUP,h.id__Invalid=1);
    id__ALLOW_WouldModifyCount := COUNT(GROUP,h.id__Invalid=1 AND h.id__wouldClean);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.datetime_Invalid > 0 OR h.customer_id_Invalid > 0 OR h.search_function_name_Invalid > 0 OR h.entity_type_Invalid > 0 OR h.field1_Invalid > 0 OR h.field2_Invalid > 0 OR h.field3_Invalid > 0 OR h.field4_Invalid > 0 OR h.field5_Invalid > 0 OR h.field6_Invalid > 0 OR h.field7_Invalid > 0 OR h.field8_Invalid > 0 OR h.field9_Invalid > 0 OR h.field10_Invalid > 0 OR h.field11_Invalid > 0 OR h.field12_Invalid > 0 OR h.field13_Invalid > 0 OR h.field14_Invalid > 0 OR h.field15_Invalid > 0 OR h.field16_Invalid > 0 OR h.id__Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.datetime_wouldClean OR h.customer_id_wouldClean OR h.search_function_name_wouldClean OR h.entity_type_wouldClean OR h.field1_wouldClean OR h.field2_wouldClean OR h.field3_wouldClean OR h.field4_wouldClean OR h.field5_wouldClean OR h.field6_wouldClean OR h.field7_wouldClean OR h.field8_wouldClean OR h.field9_wouldClean OR h.field10_wouldClean OR h.field11_wouldClean OR h.field12_wouldClean OR h.field13_wouldClean OR h.field14_wouldClean OR h.field15_wouldClean OR h.field16_wouldClean OR h.id__wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.datetime_Total_ErrorCount > 0, 1, 0) + IF(le.customer_id_Total_ErrorCount > 0, 1, 0) + IF(le.search_function_name_Total_ErrorCount > 0, 1, 0) + IF(le.entity_type_Total_ErrorCount > 0, 1, 0) + IF(le.field1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field11_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field13_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field14_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field16_ALLOW_ErrorCount > 0, 1, 0) + IF(le.id__ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.datetime_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datetime_WORDS_ErrorCount > 0, 1, 0) + IF(le.customer_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.customer_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.search_function_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.search_function_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.entity_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entity_type_WORDS_ErrorCount > 0, 1, 0) + IF(le.field1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field11_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field13_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field14_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.field16_ALLOW_ErrorCount > 0, 1, 0) + IF(le.id__ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.datetime_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.datetime_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.customer_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.customer_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.search_function_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.search_function_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.entity_type_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.entity_type_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.field1_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field2_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field3_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field5_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field6_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field7_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field8_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field9_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field10_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field11_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field12_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field13_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field14_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field15_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.field16_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.id__ALLOW_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.datetime_Invalid,le.customer_id_Invalid,le.search_function_name_Invalid,le.entity_type_Invalid,le.field1_Invalid,le.field2_Invalid,le.field3_Invalid,le.field4_Invalid,le.field5_Invalid,le.field6_Invalid,le.field7_Invalid,le.field8_Invalid,le.field9_Invalid,le.field10_Invalid,le.field11_Invalid,le.field12_Invalid,le.field13_Invalid,le.field14_Invalid,le.field15_Invalid,le.field16_Invalid,le.id__Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_datetime(le.datetime_Invalid),Fields.InvalidMessage_customer_id(le.customer_id_Invalid),Fields.InvalidMessage_search_function_name(le.search_function_name_Invalid),Fields.InvalidMessage_entity_type(le.entity_type_Invalid),Fields.InvalidMessage_field1(le.field1_Invalid),Fields.InvalidMessage_field2(le.field2_Invalid),Fields.InvalidMessage_field3(le.field3_Invalid),Fields.InvalidMessage_field4(le.field4_Invalid),Fields.InvalidMessage_field5(le.field5_Invalid),Fields.InvalidMessage_field6(le.field6_Invalid),Fields.InvalidMessage_field7(le.field7_Invalid),Fields.InvalidMessage_field8(le.field8_Invalid),Fields.InvalidMessage_field9(le.field9_Invalid),Fields.InvalidMessage_field10(le.field10_Invalid),Fields.InvalidMessage_field11(le.field11_Invalid),Fields.InvalidMessage_field12(le.field12_Invalid),Fields.InvalidMessage_field13(le.field13_Invalid),Fields.InvalidMessage_field14(le.field14_Invalid),Fields.InvalidMessage_field15(le.field15_Invalid),Fields.InvalidMessage_field16(le.field16_Invalid),Fields.InvalidMessage_id_(le.id__Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.datetime_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.customer_id_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.search_function_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.entity_type_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.field1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field8_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field9_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field10_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field11_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field12_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field13_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field14_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field15_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.field16_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.id__Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'datetime','customer_id','search_function_name','entity_type','field1','field2','field3','field4','field5','field6','field7','field8','field9','field10','field11','field12','field13','field14','field15','field16','id_','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'datetime','datetime','datetime','datetime','field1','field2','field3','field4','field5','field6','field7','field8','field9','field10','field11','field12','field13','field14','field15','field16','id_','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.datetime,(SALT39.StrType)le.customer_id,(SALT39.StrType)le.search_function_name,(SALT39.StrType)le.entity_type,(SALT39.StrType)le.field1,(SALT39.StrType)le.field2,(SALT39.StrType)le.field3,(SALT39.StrType)le.field4,(SALT39.StrType)le.field5,(SALT39.StrType)le.field6,(SALT39.StrType)le.field7,(SALT39.StrType)le.field8,(SALT39.StrType)le.field9,(SALT39.StrType)le.field10,(SALT39.StrType)le.field11,(SALT39.StrType)le.field12,(SALT39.StrType)le.field13,(SALT39.StrType)le.field14,(SALT39.StrType)le.field15,(SALT39.StrType)le.field16,(SALT39.StrType)le.id_,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,21,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_File) prevDS = DATASET([], Layout_File), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'datetime:datetime:ALLOW','datetime:datetime:WORDS'
          ,'customer_id:datetime:ALLOW','customer_id:datetime:WORDS'
          ,'search_function_name:datetime:ALLOW','search_function_name:datetime:WORDS'
          ,'entity_type:datetime:ALLOW','entity_type:datetime:WORDS'
          ,'field1:field1:ALLOW'
          ,'field2:field2:ALLOW'
          ,'field3:field3:ALLOW'
          ,'field4:field4:ALLOW'
          ,'field5:field5:ALLOW'
          ,'field6:field6:ALLOW'
          ,'field7:field7:ALLOW'
          ,'field8:field8:ALLOW'
          ,'field9:field9:ALLOW'
          ,'field10:field10:ALLOW'
          ,'field11:field11:ALLOW'
          ,'field12:field12:ALLOW'
          ,'field13:field13:ALLOW'
          ,'field14:field14:ALLOW'
          ,'field15:field15:ALLOW'
          ,'field16:field16:ALLOW'
          ,'id_:id_:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_datetime(1),Fields.InvalidMessage_datetime(2)
          ,Fields.InvalidMessage_customer_id(1),Fields.InvalidMessage_customer_id(2)
          ,Fields.InvalidMessage_search_function_name(1),Fields.InvalidMessage_search_function_name(2)
          ,Fields.InvalidMessage_entity_type(1),Fields.InvalidMessage_entity_type(2)
          ,Fields.InvalidMessage_field1(1)
          ,Fields.InvalidMessage_field2(1)
          ,Fields.InvalidMessage_field3(1)
          ,Fields.InvalidMessage_field4(1)
          ,Fields.InvalidMessage_field5(1)
          ,Fields.InvalidMessage_field6(1)
          ,Fields.InvalidMessage_field7(1)
          ,Fields.InvalidMessage_field8(1)
          ,Fields.InvalidMessage_field9(1)
          ,Fields.InvalidMessage_field10(1)
          ,Fields.InvalidMessage_field11(1)
          ,Fields.InvalidMessage_field12(1)
          ,Fields.InvalidMessage_field13(1)
          ,Fields.InvalidMessage_field14(1)
          ,Fields.InvalidMessage_field15(1)
          ,Fields.InvalidMessage_field16(1)
          ,Fields.InvalidMessage_id_(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.datetime_ALLOW_ErrorCount,le.datetime_WORDS_ErrorCount
          ,le.customer_id_ALLOW_ErrorCount,le.customer_id_WORDS_ErrorCount
          ,le.search_function_name_ALLOW_ErrorCount,le.search_function_name_WORDS_ErrorCount
          ,le.entity_type_ALLOW_ErrorCount,le.entity_type_WORDS_ErrorCount
          ,le.field1_ALLOW_ErrorCount
          ,le.field2_ALLOW_ErrorCount
          ,le.field3_ALLOW_ErrorCount
          ,le.field4_ALLOW_ErrorCount
          ,le.field5_ALLOW_ErrorCount
          ,le.field6_ALLOW_ErrorCount
          ,le.field7_ALLOW_ErrorCount
          ,le.field8_ALLOW_ErrorCount
          ,le.field9_ALLOW_ErrorCount
          ,le.field10_ALLOW_ErrorCount
          ,le.field11_ALLOW_ErrorCount
          ,le.field12_ALLOW_ErrorCount
          ,le.field13_ALLOW_ErrorCount
          ,le.field14_ALLOW_ErrorCount
          ,le.field15_ALLOW_ErrorCount
          ,le.field16_ALLOW_ErrorCount
          ,le.id__ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.datetime_ALLOW_ErrorCount,le.datetime_WORDS_ErrorCount
          ,le.customer_id_ALLOW_ErrorCount,le.customer_id_WORDS_ErrorCount
          ,le.search_function_name_ALLOW_ErrorCount,le.search_function_name_WORDS_ErrorCount
          ,le.entity_type_ALLOW_ErrorCount,le.entity_type_WORDS_ErrorCount
          ,le.field1_ALLOW_ErrorCount
          ,le.field2_ALLOW_ErrorCount
          ,le.field3_ALLOW_ErrorCount
          ,le.field4_ALLOW_ErrorCount
          ,le.field5_ALLOW_ErrorCount
          ,le.field6_ALLOW_ErrorCount
          ,le.field7_ALLOW_ErrorCount
          ,le.field8_ALLOW_ErrorCount
          ,le.field9_ALLOW_ErrorCount
          ,le.field10_ALLOW_ErrorCount
          ,le.field11_ALLOW_ErrorCount
          ,le.field12_ALLOW_ErrorCount
          ,le.field13_ALLOW_ErrorCount
          ,le.field14_ALLOW_ErrorCount
          ,le.field15_ALLOW_ErrorCount
          ,le.field16_ALLOW_ErrorCount
          ,le.id__ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_File));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'datetime:' + getFieldTypeText(h.datetime) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_id:' + getFieldTypeText(h.customer_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'search_function_name:' + getFieldTypeText(h.search_function_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_type:' + getFieldTypeText(h.entity_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field1:' + getFieldTypeText(h.field1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field2:' + getFieldTypeText(h.field2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field3:' + getFieldTypeText(h.field3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field4:' + getFieldTypeText(h.field4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field5:' + getFieldTypeText(h.field5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field6:' + getFieldTypeText(h.field6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field7:' + getFieldTypeText(h.field7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field8:' + getFieldTypeText(h.field8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field9:' + getFieldTypeText(h.field9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field10:' + getFieldTypeText(h.field10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field11:' + getFieldTypeText(h.field11) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field12:' + getFieldTypeText(h.field12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field13:' + getFieldTypeText(h.field13) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field14:' + getFieldTypeText(h.field14) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field15:' + getFieldTypeText(h.field15) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'field16:' + getFieldTypeText(h.field16) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'id_:' + getFieldTypeText(h.id_) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_datetime_cnt
          ,le.populated_customer_id_cnt
          ,le.populated_search_function_name_cnt
          ,le.populated_entity_type_cnt
          ,le.populated_field1_cnt
          ,le.populated_field2_cnt
          ,le.populated_field3_cnt
          ,le.populated_field4_cnt
          ,le.populated_field5_cnt
          ,le.populated_field6_cnt
          ,le.populated_field7_cnt
          ,le.populated_field8_cnt
          ,le.populated_field9_cnt
          ,le.populated_field10_cnt
          ,le.populated_field11_cnt
          ,le.populated_field12_cnt
          ,le.populated_field13_cnt
          ,le.populated_field14_cnt
          ,le.populated_field15_cnt
          ,le.populated_field16_cnt
          ,le.populated_id__cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_datetime_pcnt
          ,le.populated_customer_id_pcnt
          ,le.populated_search_function_name_pcnt
          ,le.populated_entity_type_pcnt
          ,le.populated_field1_pcnt
          ,le.populated_field2_pcnt
          ,le.populated_field3_pcnt
          ,le.populated_field4_pcnt
          ,le.populated_field5_pcnt
          ,le.populated_field6_pcnt
          ,le.populated_field7_pcnt
          ,le.populated_field8_pcnt
          ,le.populated_field9_pcnt
          ,le.populated_field10_pcnt
          ,le.populated_field11_pcnt
          ,le.populated_field12_pcnt
          ,le.populated_field13_pcnt
          ,le.populated_field14_pcnt
          ,le.populated_field15_pcnt
          ,le.populated_field16_pcnt
          ,le.populated_id__pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,21,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_File));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),21,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_File) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Inql_Nfcra_Bridger, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
