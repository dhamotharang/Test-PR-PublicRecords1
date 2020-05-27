import business_header, TopBusiness_BIPV2;
EXPORT Files := MODULE


	export	Hdr_Out := dataset(cortera.Constants.sfCorteraHdr, cortera.Layout_Header_Out, thor);
	export	Attributes := dataset(cortera.Constants.sfAttributes, Cortera.Layout_Attributes_Out, thor);
	export	Executives := dataset(cortera.Constants.sfExecutives, cortera.Layout_Executives, thor);
	export	ExecLinkID := dataset(cortera.Constants.sfExecLinkID, cortera.Layout_ExecLinkID, thor);
	// fAs_Business_Header - Needed for Business Header Build per Vern Bentley
	export	Bus_hdr := dataset('~thor_data400::cortera::out::20170131::business',Business_Header.Layout_Business_Header_New, thor);

  export File_Attributes_In := dataset(cortera.Constants.sfAttributesIn,
																					cortera.Layout_Attributes, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(8192)
																							)
																				);
																				
  export File_Header_In := dataset(cortera.Constants.sfHeaderIn, 
																		cortera.Layout_Header, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							)
																				);

END;