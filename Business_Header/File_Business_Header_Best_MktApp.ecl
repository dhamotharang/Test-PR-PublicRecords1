bh_mkt := Business_Header.File_Business_Header_MktApp;

layout_bdid_list := record
bh_mkt.bdid;
end;

bh_mkt_list := dedup(table(bh_mkt, layout_bdid_list), all);

bh_mkt_best := join(File_Business_Header_Best,
                    bh_mkt_list,
				left.bdid = right.bdid,
				transform(Layout_BH_Best, self := left),
				hash);


export File_Business_Header_Best_MktApp := bh_mkt_best;