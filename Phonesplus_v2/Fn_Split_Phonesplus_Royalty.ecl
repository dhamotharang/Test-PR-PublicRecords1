import ut, mdr;
export Fn_Split_Phonesplus_Royalty (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in, string file_type = '') := function;

wired_assets := phplus_in(Translation_Codes.fFlagIsOn(src_all, Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty))  or Translation_Codes.fFlagIsOn(src_all,Translation_Codes.source_bitmap_code( mdr.sourceTools.src_wired_assets_owned)));
not_wired_assets := phplus_in(~(Translation_Codes.fFlagIsOn(src_all, Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty))  or Translation_Codes.fFlagIsOn(src_all,Translation_Codes.source_bitmap_code( mdr.sourceTools.src_wired_assets_owned))));
										
royalty_file := File_Fake_WiredAssets_Royalty;


//Select records for which royalties have been paid
wa_owned  := join(distribute(wired_assets , hash(cellphone)), 
											dedup(sort(distribute(royalty_file (times_used >= 3), hash(orig_phone)), orig_phone, local), orig_phone, local),
											left.cellphone = right.orig_phone,
											transform(Layout_In_Phonesplus.layout_in_common,
															  self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_owned),
																self.vendor := phonesplus_v2.Translation_Codes.fGet_other_sources_from_bitmap(self.src_all)[..2],
															  self := left),
											local);
											
											
wa_royalty := join(distribute(wired_assets , hash(cellphone)), 
											distribute(royalty_file (times_used >= 3), hash(orig_phone)),
											left.cellphone = right.orig_phone,
											transform(Layout_In_Phonesplus.layout_in_common, 
																self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty),
																self.vendor := phonesplus_v2.Translation_Codes.fGet_other_sources_from_bitmap(self.src_all)[..2],
																self := left),
											left only,
											local);
											
				
											
pplus := not_wired_assets + wa_owned;
royalty :=  wa_royalty;

final_result := if (file_type = 'phonesplus_main',pplus,  royalty);
return final_result;
end;
