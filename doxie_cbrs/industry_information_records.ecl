import DCA, doxie, business_header, Business_Header_SS;
doxie_cbrs.mac_Selection_Declare()

export industry_information_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

// ut.MAC_Slim_Back(bdid_dataset, doxie_Cbrs.layout_references, wla)

dca_recs := doxie_cbrs.fn_DCA_records_dayton(bdids,false,if(multiBDID,0,1))(Include_DCA_val);

ultimate_parent := choosen(sort(dca_recs,level,sub),1);

				
return ultimate_parent(sic1 <> '');

END;
				
