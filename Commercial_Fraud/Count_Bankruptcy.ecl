import BankruptcyV2;
export Count_Bankruptcy(

	dataset(BankruptcyV2.layout_bankruptcy_search	) pBankruptcy = BankruptcyV2.file_bankruptcy_search

) :=
module

	shared laycount := layouts.temporary.counts;

	export fBdid(
	
		string pPersistname = Persistnames().CountBankruptcyfBdid
	
	) :=
	function
	
		dbkslim := table(pBankruptcy((unsigned8)bdid != 0,name_type = 'D')	,{tmsid,bdid},tmsid,bdid);
		
		dbk_counts := table(dbkslim, {bdid, unsigned8 cnt := count(group)},bdid);
		
		dreturn := project(dbk_counts,transform(laycount,self.id := (unsigned8)left.bdid;self.Count_filings := left.cnt))
			: persist(pPersistname);
		
		return dreturn;
	
	end;

	export fDid(
	
		string pPersistname = Persistnames().CountBankruptcyfDid
	
	) :=
	function
	
		dbkslim := table(pBankruptcy((unsigned8)Did != 0,name_type = 'D')	,{tmsid,DID},tmsid,DID);
		
		dbk_counts := table(dbkslim, {DID, unsigned8 cnt := count(group)},did);
		
		dreturn := project(dbk_counts,transform(laycount,self.id := (unsigned8)left.Did;self.Count_filings := left.cnt))
			: persist(pPersistname);
		
		return dreturn;
	
	end;

end;