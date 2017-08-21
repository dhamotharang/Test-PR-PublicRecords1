lCourtVendorsToOmit 		:= output(Hygenics_Search.sCourt_Vendors_To_Omit,named('Court_Vendors_To_Omit'));
lCourtVendorsWithNoTraffic 	:= output(Hygenics_Search.sCourt_Vendors_With_No_Traffic,named('Court_Vendors_No_Traffic'));
lCourtVendorsWithTrafficOnly:= output(Hygenics_Search.sCourt_Vendors_With_Only_Traffic,named('Court_Vendors_Traffic_Only'));

export Out_Vendor_Select_Attribute_Values
 :=
  parallel(
			lCourtVendorsToOmit,
			lCourtVendorsWithNoTraffic,
			lCourtVendorsWithTrafficOnly
		   );