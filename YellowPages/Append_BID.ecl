import TopBusiness_External,mdr;
export Append_BID(

	dataset(Layout_YellowPages_Base_V2)	pYpBase

) :=
function


	YellowPages_Base_For_Bid := project(pYpBase, transform(YellowPages.Layout_YellowPages_Base_v2_Bid, self := left));

	//////////////////////////////////////////////////////////////////////////////////////////
	//  -- BID records using the BID external macro
	//////////////////////////////////////////////////////////////////////////////////////////
	TopBusiness_External.MAC_External_BID(
			YellowPages_Base_For_Bid,  				  // infile
			YellowPages_out_bid,								// outfile
			bid,    														// bid_field	
			bid_score,  												// bdid_score_field
			MDR.sourceTools.src_Yellow_Pages, 	// source_field
			primary_key, 			 									// source_docid_field
			,							 											// source_party_field
			business_name, 											// company_name_field
			zip,	   														// zip_field
			prim_name,													// prim_name_field
			prim_range,													// prim_range_field
			,			 															// fein_field
			phone10															// phone_field
	);

	return YellowPages_out_bid;

end;