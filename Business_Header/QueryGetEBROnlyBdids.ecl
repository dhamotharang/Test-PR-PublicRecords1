import mdr;
export QueryGetEBROnlyBdids := 
	business_header.QueryGetSourceOnlyBdids(MDR.sourceTools.src_EBR) 
	: persist(persistnames().Query_GetEBROnlyBdids);