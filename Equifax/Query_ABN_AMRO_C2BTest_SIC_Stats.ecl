f := dataset('~thor_data400::TMTEST::abn_amro_c2btest_data_append', Equifax.Layout_ABN_AMRO_C2BTest_Base, flat, __compressed__);

//f := Equifax.abn_amro_c2btest_data_append;

layout_bdid_list := record
f.bdid;
end;

bdid_list := dedup(table(f(bdid <> 0), layout_bdid_list),all);

// Get the SIC codes
//bh_sic := Business_Header.BH_BDID_SIC;

bh_sic := dataset('~thor_data400::TEMP::BH_SIC_Codes', Business_Header.Layout_SIC_Code, flat, __compressed__ );

layout_sic_code := record
unsigned6 bdid;
string4 sic_code;
end;

// Select SIC Codes
bh_sic_select := join(bh_sic,
                      bdid_list,
				  left.bdid = right.bdid,
				  transform(layout_sic_code, self.sic_code := left.sic_code[1..4], self := left),
				  hash);
				  
bh_sic_select_dedup := dedup(bh_sic_select, all);

layout_sic_code_stat := record
bh_sic_select_dedup.sic_code;
cnt := count(group);
end;

bh_sic_stat := table(bh_sic_select_dedup, layout_sic_code_stat, sic_code, few);

// Append description

layout_sic_code_desc := record
bh_sic_stat.sic_code;
string50 sic_description := Business_Header.Decode_SIC4(bh_sic_stat.sic_code);
bh_sic_stat.cnt;
end;

bh_sic_stat_desc := sort(table(bh_sic_stat, layout_sic_code_desc), -cnt);

output(bh_sic_stat_desc, named('SIC_Code_Description_Stat'), all);


