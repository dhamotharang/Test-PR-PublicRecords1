IMPORT	Business_Credit;
EXPORT	ContractAccNumHistoryService(STRING30	SbfeContributorNumber,	STRING50	ContractAccountNumber)	:=	FUNCTION
  K	:=	Business_Credit.Key_History();
  R	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Original_Contract_Account_Number;
		STRING30	Previous_Sbfe_Contributor_Number;
		STRING50	Previous_Contract_Account_Number;
		STRING8		change_date;
    UNSIGNED2	Depth; // The depth down the tree, 0 is the top node
  END;
  seed	:=	DATASET([{'','',SbfeContributorNumber,ContractAccountNumber,'99999999',0}],R); // The top of the tree
  R	ftch(DATASET(R) existing,	UNSIGNED2	Iteration) := FUNCTION
		recs		:=	K(Sbfe_Contributor_Number	=	existing[Iteration].Previous_Sbfe_Contributor_Number,
									Original_Contract_Account_Number	=	existing[Iteration].Previous_Contract_Account_Number);
    nxtlvl	:=	SORT(PROJECT(recs,TRANSFORM(R,SELF.Depth:=Iteration,SELF:=LEFT))(change_date<	existing[Iteration].change_date),-change_date)[1];
		result	:=	existing+nxtlvl;
		RETURN	result(Previous_Contract_Account_Number<>'');
  END;
  tree	:=	IF(COUNT(K(Sbfe_Contributor_Number	=	SbfeContributorNumber,Contract_Account_Number=ContractAccountNumber))=0,
							seed,
							LOOP(seed,10,ftch(ROWS(LEFT),COUNTER)));
  RETURN	tree;
END;
 
