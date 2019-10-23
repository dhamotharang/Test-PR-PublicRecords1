IMPORT BIPV2;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name := credit_unions.keynames().LinkIds.QA;
	
	shared Base				    := credit_unions.Files().base.built;
	
	Keybuild_Base         := project(Base, transform(credit_unions.layouts.keybuild_linkids,
	                                                 self.rawfields.Charter              := left.charter,
																									 self.rawfields.CU_NAME              := left.CU_NAME,
																									 self.rawfields.Address1             := left.Address1,
																									 self.rawfields.City                 := left.City ,
																									 self.rawfields.State                := left.State,
																									 self.rawfields.Zip_Code             := left.Zip_Code,
																									 self.rawfields.Contact_Name         := left.Contact_Name,
																									 self.rawfields.Phone                := left.Phone,
																									 self.rawfields.Assets               := left.Assets,
																									 self.rawfields.Loans                := left.Loans,
																									 self.rawfields.NetWorthRatio        := left.NetWorthRatio,
																									 self.rawfields.Perc_ShareGrowth     := left.Perc_ShareGrowth,
																									 self.rawfields.Perc_LoanGrowth      := left.Perc_LoanGrowth,
																									 self.rawfields.LoantoAssetsRatio    := left.LoantoAssetsRatio,
																									 self.rawfields.InvestAssetsRatio    := left.InvestAssetsRatio,
																									 self.rawfields.NumMem               := left.NumMem,
																									 self.rawfields.NumFull              := left.NumFull,
																									 self.clean_contact_name.title       := left.title,
																									 self.clean_contact_name.fname			 := left.fname,
																									 self.clean_contact_name.mname			 := left.mname,
																									 self.clean_contact_name.lname			 := left.lname,
																									 self.clean_contact_name.name_suffix := left.name_suffix,
																									 self.clean_contact_name.name_score	 := left.name_score,
																									 self.clean_address.prim_range		   := left.prim_range,
																									 self.clean_address.predir				   := left.predir,
																									 self.clean_address.prim_name			   := left.prim_name,
																									 self.clean_address.addr_suffix		   := left.addr_suffix,
																									 self.clean_address.postdir				   := left.postdir,
																									 self.clean_address.unit_desig		   := left.unit_desig,
																									 self.clean_address.sec_range			   := left.sec_range,
																									 self.clean_address.p_city_name		   := left.p_city_name,
																									 self.clean_address.v_city_name		   := left.v_city_name,
																									 self.clean_address.st						   := left.st,
																									 self.clean_address.zip						   := left.zip,
																									 self.clean_address.zip4					   := left.zip4,
																									 self.clean_address.cart					   := left.cart,
																									 self.clean_address.cr_sort_sz		   := left.cr_sort_sz,
																									 self.clean_address.lot						   := left.lot,
																									 self.clean_address.lot_order			   := left.lot_order,
																									 self.clean_address.dbpc					   := left.dbpc,
																									 self.clean_address.chk_digit			   := left.chk_digit,
																									 self.clean_address.rec_type			   := left.rec_type,
																									 self.clean_address.fips_state		   := left.fips_state,
																									 self.clean_address.fips_county		   := left.fips_county,
																									 self.clean_address.geo_lat				   := left.geo_lat,
																									 self.clean_address.geo_long			   := left.geo_long,
																									 self.clean_address.msa						   := left.msa,
																									 self.clean_address.geo_blk				   := left.geo_blk,
																									 self.clean_address.geo_match			   := left.geo_match,
																									 self.clean_address.err_stat			   := left.err_stat,
		                                               self := left));
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Keybuild_Base, k, superfile_name)
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;

END;