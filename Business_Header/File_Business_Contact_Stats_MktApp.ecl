bh_mkt := Business_Header.File_Business_Header_MktApp;

layout_bdid_list := record
bh_mkt.bdid;
end;

bh_mkt_list := dedup(table(bh_mkt, layout_bdid_list), all);

bc_mkt_stats := join(File_Business_Contacts_Stats,
                     bh_mkt_list,
				 left.bdid = right.bdid,
				 transform(Layout_Business_Contacts_Stats, self := left),
				 hash);

export File_Business_Contact_Stats_MktApp := bc_mkt_stats;