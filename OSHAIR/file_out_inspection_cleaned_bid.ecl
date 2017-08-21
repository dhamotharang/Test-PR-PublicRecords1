import OSHAIR;

export file_out_inspection_cleaned_bid := project(file_out_inspection_cleaned_both,transform(OSHAIR.layout_OSHAIR_inspection_clean,
															self.bdid := left.bid,
															self.bdid_score := left.bid_score,
															self := left));