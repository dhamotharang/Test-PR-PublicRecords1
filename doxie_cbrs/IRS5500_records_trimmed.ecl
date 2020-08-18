EXPORT IRS5500_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

SHARED temp_irs_records := doxie_cbrs.IRS5500_records(bdids)(Include_IRS5500_val);

doxie_cbrs.mac_Selection_Declare()

EXPORT records := CHOOSEN(temp_irs_records,Max_IRS5500_val);
EXPORT records_count := COUNT(temp_irs_records);

END;
