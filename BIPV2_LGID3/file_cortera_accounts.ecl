import Cortera_Tradeline, BIPV2;

tradelineData     := Cortera_Tradeline.files.Base;
baseFile          := BIPV2.CommonBase.DS_Built(source='RR' and vl_id!='');
dedupBaseFile     := dedup(baseFile, lgid3, vl_id, all, hash);
dedupByIDAccount  := dedup(tradelineData, account_key, link_id, all, hash);

accountsWithMultipleLinkIDs := table(dedupByIDAccount, {account_key, cntGroup := count(group)}, account_key)(cntGroup>1);
getMultiLinks               := join(dedupByIDAccount, accountsWithMultipleLinkIDs,
                                    left.account_key = right.account_key,
			                     transform(left), hash);

AttrFileRec := record
    unsigned6 lgid3;
    unsigned6 account_id;
end;

assignLgids   := join(dedupBaseFile, getMultiLinks,
                      (integer) left.vl_id = right.link_id,
				  transform(AttrFileRec,
				            self.lgid3      := left.lgid3,
						  self.account_id := hash64(right.account_key)), hash);

	
EXPORT file_cortera_accounts := assignLgids;