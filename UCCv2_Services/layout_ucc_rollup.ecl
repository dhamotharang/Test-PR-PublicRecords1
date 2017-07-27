import ffd;
export layout_ucc_rollup := record
	unsigned2 penalt;
	uccv2_services.layout_ucc_filing;
	UCCv2_Services.assorted_layouts.matched_party_rec   matched_party; 
	dataset(uccv2_services.layout_ucc_hist)		filings{maxcount(UCCv2_Services.Constants.MAXCOUNT_FILINGS)};
	dataset(uccv2_services.layout_ucc_party)	debtors{maxcount(UCCv2_Services.Constants.MAXCOUNT_DEBTORS)};
	dataset(uccv2_services.layout_ucc_party)	secureds{maxcount(UCCv2_Services.Constants.MAXCOUNT_SECUREDS)};
	dataset(uccv2_services.layout_ucc_party)	assignees{maxcount(UCCv2_Services.Constants.MAXCOUNT_ASSIGNEES)};
	dataset(uccv2_services.layout_ucc_party)	creditors{maxcount(UCCv2_Services.Constants.MAXCOUNT_CREDITORS)};
	dataset(uccv2_services.layout_ucc_signer)	signers{maxcount(UCCv2_Services.Constants.MAXCOUNT_SIGNERS)};
	dataset(uccv2_services.layout_ucc_filofc)	filing_offices{maxcount(UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES)};
	dataset(uccv2_services.layout_ucc_coll)		collateral{maxcount(UCCv2_Services.Constants.MAXCOUNT_COLLATERAL)};	
	boolean isDeepDive := false;
	FFD.Layouts.CommonRawRecordElements;
end;
