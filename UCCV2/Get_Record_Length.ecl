import UCCV2;

export Get_Record_Length(string source,string sourcetype) := 
map( 
		(source='CA' and sourcetype='BusinessDebtor') => sizeof(UCCV2.Layout_File_CA_BusinessDebtor_in),
		(source='CA' and sourcetype='BusinessSecuredP') => sizeof(UCCV2.Layout_File_CA_BusinessSecuredParty_in),
		(source='CA' and sourcetype='Collateral') => sizeof(UCCV2.Layout_File_CA_Collateral_in),
		(source='CA' and sourcetype='InitialFiling') => sizeof(UCCV2.Layout_File_CA_Filing_Master_in),
		(source='CA' and sourcetype='PersonDebtor') => sizeof(UCCV2.Layout_File_CA_PersonDebtor_in),
		(source='CA' and sourcetype='PersonSecuredP') => sizeof(UCCV2.Layout_File_CA_PersonSecuredParty_in),
		(source='CA' and sourcetype='Ucc3') => sizeof(UCCV2.Layout_File_CA_ucc3_in),
		
		(source='DnB' and sourcetype='financingStatement') => sizeof(UCCV2.Layout_File_DnB_FinancingStatement_in),
		(source='DnB' and sourcetype='debtor') => sizeof(UCCV2.Layout_File_DnB_Debtor_in),
		(source='DnB' and sourcetype='signer') => sizeof(UCCV2.Layout_File_DnB_Signer_in),
		(source='DnB' and sourcetype='financingComment') => sizeof(UCCV2.Layout_File_DnB_FinancingComment_in),
		(source='DnB' and sourcetype='collateral') => sizeof(UCCV2.Layout_File_DnB_Collateral_in),
		(source='DnB' and sourcetype='collateralItem') => sizeof(UCCV2.Layout_File_DnB_CollateralItem_in),
		(source='DnB' and sourcetype='securedParty') => sizeof(UCCV2.Layout_File_DnB_SecuredParty_in),
		
		(source='IL' and sourcetype='Debtor') => sizeof(UCCV2.Layout_File_IL_Debtor_in),
		(source='IL' and sourcetype='SecuredParty') => sizeof(UCCV2.Layout_File_IL_SecuredParty_in),
		(source='IL' and sourcetype='collateral') => 1,
		(source='IL' and sourcetype='filing') => sizeof(UCCV2.Layout_File_IL_Master_in),
		(source='IL' and sourcetype='transaction') => sizeof(UCCV2.Layout_File_IL_Transaction_in),
		(source='MA' and sourcetype='UCC') => sizeof(UCCV2.Layout_File_MA_in),
		(source='NYC' and sourcetype='Ref') => sizeof(UCCV2.Layout_File_NYC_Ref_in),
		(source='NYC' and sourcetype='lot') => sizeof(UCCV2.Layout_File_NYC_Lot_in),
		(source='NYC' and sourcetype='master') => sizeof(UCCV2.Layout_File_NYC_Filing_Master_in),
		(source='NYC' and sourcetype='party') => sizeof(UCCV2.Layout_File_NYC_Party_in),
		(source='NYC' and sourcetype='remark') => sizeof(UCCV2.Layout_File_NYC_Remark_in),
		(source='TX' and sourcetype='Amendment') => sizeof(UCCV2.Layout_File_TX_Amendment_in),
		(source='TX' and sourcetype='BSecuredParty') => sizeof(UCCV2.Layout_File_TX_BusinessSecuredParty_in),
		(source='TX' and sourcetype='Bdebtor') => sizeof(UCCV2.Layout_File_TX_BusinessDebtor_in),
		(source='TX' and sourcetype='collateral') => sizeof(UCCV2.Layout_File_TX_Collateral_in),
		(source='TX' and sourcetype='filing') => sizeof(UCCV2.Layout_File_TX_Master_in),
		(source='TX' and sourcetype='pSecuredParty') => sizeof(UCCV2.Layout_File_TX_PersonSecuredParty_in),
		(source='TX' and sourcetype='pdebtor') => sizeof(UCCV2.Layout_File_TX_PersonDebtor_in),
		(source='TH' and sourcetype='UCC') => sizeof(UCCV2.Layout_File_Harris_TX_in),
		(source='TD' and sourcetype='UCC') => sizeof(UCCV2.Layout_File_Dallas_TX_in),
		0
 );