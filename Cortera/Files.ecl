import business_header, TopBusiness_BIPV2;
EXPORT Files := MODULE


	export	Hdr_Out := dataset(cortera.Constants.sfCorteraHdr, cortera.Layout_Header_Out, thor);
	export	Attributes := dataset(cortera.Constants.sfAttributes, Cortera.Layout_Attributes_Out, thor);
	export	Executives := dataset(cortera.Constants.sfExecutives, cortera.Layout_Executives, thor);
	// fAs_Business_Header
	export	Bus_hdr := dataset('~thor_data400::cortera::out::20170131::business',Business_Header.Layout_Business_Header_New, thor);
	// As_Business_Linking

END;