import DCA, doxie, business_header, Business_Header_SS;
doxie_cbrs.mac_Selection_Declare()

export sales_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

// ut.mac_slim_back(bdid_dataset,doxie_cbrs.layout_references,wla);

dca_recs := doxie_cbrs.fn_DCA_records_dayton(bdids,false,if(multiBDID,0,1))(sales <> '');

ultimate_parent := choosen(sort(dca_recs,level,sub),1);
				
return ultimate_parent;

END;
				