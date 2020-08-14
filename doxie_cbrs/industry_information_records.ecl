IMPORT DCA, doxie, business_header, Business_Header_SS;
doxie_cbrs.mac_Selection_Declare()

EXPORT industry_information_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

// ut.MAC_Slim_Back(bdid_dataset, doxie_Cbrs.layout_references, wla)

dca_recs := doxie_cbrs.fn_DCA_records_dayton(bdids,FALSE,IF(multiBDID,0,1))(Include_DCA_val);

ultimate_parent := CHOOSEN(SORT(dca_recs,level,sub),1);

        
RETURN ultimate_parent(sic1 <> '');

END;
        
