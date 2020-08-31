IMPORT DCA, doxie, business_header, Business_Header_SS;
doxie_cbrs.mac_Selection_Declare()

EXPORT sales_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

// ut.mac_slim_back(bdid_dataset,doxie_cbrs.layout_references,wla);

dca_recs := doxie_cbrs.fn_DCA_records_dayton(bdids,FALSE,IF(multiBDID,0,1))(sales <> '');

ultimate_parent := CHOOSEN(SORT(dca_recs,level,sub),1);
        
RETURN ultimate_parent;

END;
        
