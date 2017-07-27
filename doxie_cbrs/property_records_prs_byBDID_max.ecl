import doxie, business_header;
doxie_cbrs.mac_Selection_Declare()
pr := doxie_cbrs.property_records_prs_byBDID; 
export property_records_prs_byBDID_max := choosen(pr(Return_Properties_val), Max_Properties_val);
