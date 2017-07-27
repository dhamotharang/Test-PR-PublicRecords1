
IMPORT UCCV2;

export layout_ucc_rollup_src := record
	unsigned2 penalt;
	uccv2_services.layout_ucc_filing_src;
	dataset(uccv2_services.layout_ucc_hist_src)		filings{maxcount(UCCv2_Services.Constants.MAXCOUNT_FILINGS)};
	dataset(uccv2_services.layout_ucc_party_src)	debtors{maxcount(UCCv2_Services.Constants.MAXCOUNT_DEBTORS)};
	dataset(uccv2_services.layout_ucc_party_src)	secureds{maxcount(UCCv2_Services.Constants.MAXCOUNT_SECUREDS)};
	dataset(uccv2_services.layout_ucc_party_src)	assignees{maxcount(UCCv2_Services.Constants.MAXCOUNT_ASSIGNEES)};
	dataset(uccv2_services.layout_ucc_party_src)	creditors{maxcount(UCCv2_Services.Constants.MAXCOUNT_CREDITORS)};
	dataset(uccv2_services.layout_ucc_signer)			signers{maxcount(UCCv2_Services.Constants.MAXCOUNT_SIGNERS)};
	dataset(uccv2_services.layout_ucc_filofc)			filing_offices{maxcount(UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES)};
	dataset(uccv2_services.layout_ucc_coll_src)		collateral{maxcount(UCCv2_Services.Constants.MAXCOUNT_COLLATERAL)};	
end;
