export IRS5500_records_trimmed(dataset(doxie_cbrs.layout_references) bdids) := 
MODULE

doxie_cbrs.mac_Selection_Declare()

shared temp_irs_records := doxie_cbrs.IRS5500_records(bdids)(Include_IRS5500_val);

doxie_cbrs.mac_Selection_Declare()

export records := choosen(temp_irs_records,Max_IRS5500_val);
export records_count := count(temp_irs_records);

END;