IMPORT HMS_Medicaid_Common;
d := dataset('~thor400_data::base::hms::Medicaid::NY::20151118',HMS_Medicaid_Common.layouts.Base_NY,Thor);
EXPORT infile_ := d;