IMPORT $, dx_Gong;

Legacy_Layout := PROJECT($.File_History_Full_Prepped_for_Keys, Layout_History_Legacy);

legacy_filtered := Legacy_Layout(length(TRIM(phone10))=10);

EXPORT data_key_history_npa_nxx_line := PROJECT(legacy_filtered, TRANSFORM(dx_Gong.layouts.i_history_npa_nxx_line,
                                                                  SELF.npa := LEFT.phone10[1..3],
                                                                  SELF.nxx := LEFT.phone10[4..6],
                                                                  SELF.line := LEFT.phone10[7..10],
                                                                  SELF.current_flag := LEFT.current_record_flag='Y',
                                                                  SELF.business_flag := LEFT.listing_type_bus='B',
                                                                  SELF := LEFT));
