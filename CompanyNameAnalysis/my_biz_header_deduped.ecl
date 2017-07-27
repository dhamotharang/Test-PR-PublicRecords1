import NGBDL2, Business_Header;
import CompanyNameAnalysis;
import text;

/*
my_biz_header := DATASET(
              '~thumphrey::base::business_header_qa',
	            business_header.Layout_Business_Header_Base, FLAT
						);

export my_biz_header_deduped := dedup(
                                      my_biz_header
																			, left.company_name = right.company_name
																		 ) : PERSIST('thumphrey::my_biz_header_deduped');
*/

export my_biz_header_deduped := DATASET(
              '~thumphrey::my_biz_header_deduped',
	            business_header.Layout_Business_Header_Base, FLAT
						);
