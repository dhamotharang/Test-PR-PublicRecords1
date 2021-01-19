﻿// For sources that doesn't have a sourcetype please use "UCC" as sourcetype.

export UCCV2_Dictionary := 
dataset(
[
{'CA','ALL',0},
{'CA','AllSecureParty',0},
{'CA','AllDebtors',0},
{'CA','FilingAmendments',0},
{'CA','Filings',0},
{'CA','BusinessDebtor',sizeof(UCCV2.Layout_File_CA_BusinessDebtor_in)},
{'CA','BusinessSecuredP',sizeof(UCCV2.Layout_File_CA_BusinessSecuredParty_in)},
{'CA','InitialFiling',sizeof(UCCV2.Layout_File_CA_Filing_Master_in)},
{'CA','PersonDebtor',sizeof(UCCV2.Layout_File_CA_PersonDebtor_in)},
{'CA','PersonSecuredP',sizeof(UCCV2.Layout_File_CA_PersonSecuredParty_in)},
{'CA','Ucc3',sizeof(UCCV2.Layout_File_CA_ucc3_in)},
{'US_DNB','ALL',0},
{'DnB','financingStatement',sizeof(UCCV2.Layout_File_DnB_FinancingStatement_in)},
{'DnB','debtor',sizeof(UCCV2.Layout_File_DnB_Debtor_in)},
{'DnB','signer',sizeof(UCCV2.Layout_File_DnB_Signer_in)},
{'DnB','financingComment',sizeof(UCCV2.Layout_File_DnB_FinancingComment_in)},
{'DnB','collateral',sizeof(UCCV2.Layout_File_DnB_Collateral_in)},
{'DnB','collateralItem',sizeof(UCCV2.Layout_File_DnB_CollateralItem_in)},
{'DnB','securedParty',sizeof(UCCV2.Layout_File_DnB_SecuredParty_in)},
{'IL','ALL',0},
{'IL','Debtor',sizeof(UCCV2.Layout_File_IL_Debtor_in)},
{'IL','SecuredParty',sizeof(UCCV2.Layout_File_IL_SecuredParty_in)},
{'IL','collateral',0},
{'IL','filing',sizeof(UCCV2.Layout_File_IL_Master_in)},
{'IL','transaction',sizeof(UCCV2.Layout_File_IL_Transaction_in)},
{'MA','UCC',sizeof(UCCV2.Layout_File_MA_in)},
{'MA','ALL',0},
{'NYC','Ref',sizeof(UCCV2.Layout_File_NYC_Ref_in)},
{'NYC','lot',sizeof(UCCV2.Layout_File_NYC_Lot_in)},
{'NYC','master',sizeof(UCCV2.Layout_File_NYC_Filing_Master_in)},
{'NYC','party',sizeof(UCCV2.Layout_File_NYC_Party_in)},
{'NYC','remark',sizeof(UCCV2.Layout_File_NYC_Remark_in)},
{'NY_NEW_YORK','ALL',0},
{'TX','Amendment',sizeof(UCCV2.Layout_File_TX_Amendment_in)},
{'TX','BSecuredParty',sizeof(UCCV2.Layout_File_TX_BusinessSecuredParty_in)},
{'TX','Bdebtor',sizeof(UCCV2.Layout_File_TX_BusinessDebtor_in)},
{'TX','collateral',sizeof(UCCV2.Layout_File_TX_Collateral_in)},
{'TX','filing',sizeof(UCCV2.Layout_File_TX_Master_in)},
{'TX','pSecuredParty',sizeof(UCCV2.Layout_File_TX_PersonSecuredParty_in)},
{'TX','pdebtor',sizeof(UCCV2.Layout_File_TX_PersonDebtor_in)},
{'TX','ALL',0},
{'TH','UCC',sizeof(UCCV2.Layout_File_Harris_TX_in)},
{'TD','UCC',sizeof(UCCV2.Layout_File_Dallas_TX_in)},
{'WA','UCC',0}/*,
{'WA','ALL',0}*/],

{string source,string sourcetype,integer size}
);
