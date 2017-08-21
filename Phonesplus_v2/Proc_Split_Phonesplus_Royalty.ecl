import ut, mdr;
export Proc_Split_Phonesplus_Royalty (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in, string file_type = '') := function;

wired_assets := phplus_in(src_all = ut.bit_set(0,37) or src_all = ut.bit_set(0,38));
not_wired_assets := phplus_in(~(src_all = ut.bit_set(0,37) or src_all = ut.bit_set(0,38)));

royalty_file := File_Fake_WiredAssets_Royalty;


//Select records for which royalties have been paid
wa_owned  := join(distribute(wired_assets, hash(cellphone)), 
											distribute(royalty_file (times_used >= 3), hash(orig_phone)),
											left.cellphone = right.orig_phone,
											transform(Layout_In_Phonesplus.layout_in_common, 
																self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_owned),
																self.src := phonesplus_v2.Translation_Codes.fGet_other_sources_from_bitmap(self.src_all)[..2],
																self := left),
											local);
											
											
wa_royalty := join(distribute(wired_assets, hash(cellphone)), 
											distribute(royalty_file (times_used >= 3), hash(orig_phone)),
											left.cellphone = right.orig_phone,
											transform(Layout_In_Phonesplus.layout_in_common, 
																self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_royalty),
																self.src := phonesplus_v2.Translation_Codes.fGet_other_sources_from_bitmap(self.src_all)[..2],
																self := left),
											left only,
											local);
											
pplus := not_wired_assets + wa_owned;

final_result := if (file_type = 'phonesplus_main',pplus,  wa_royalty );
return final_result;
end;
