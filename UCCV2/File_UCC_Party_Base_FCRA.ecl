export File_UCC_Party_Base_FCRA	:=	module

export Party_Base_AID	:= DATASET(cluster.cluster_out+'base::ucc::party_AID',Layout_UCC_Common.Layout_Party_With_AID, thor)(tmsid not in UCCV2.Suppress_TMSID(TRUE));

export Party_Base_Slim := 
			PROJECT(Party_Base_AID,TRANSFORM(Layout_UCC_Common.Layout_Party,SELF := LEFT;));
			
end;