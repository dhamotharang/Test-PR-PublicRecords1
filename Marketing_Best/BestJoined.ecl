import bankrupt,Business_Header,mdr;

export BestJoined(

	 Dataset(marketing_best.Layout_Common)	pinDataSet
	,String																	pfileDesc
	,dataset(bankrupt.Layout_BK_Search_v8)	pBK_Search					= bankrupt.File_BK_Search
	,string																	pPersistName				= '~thor_data400::persist::Marketing_best::BestJoined.'

) :=
function

InFile := distribute(pinDataSet,hash64(bdid));

bdid_rec := record
	InFile.bdid;
	integer4 total_records := count(group);
end;

bdid_dups := sort(table(InFile, bdid_rec, bdid, local),bdid) 
	: persist(pPersistName + 'Bdid_Dedup.' + pfileDesc);

bsic 		:= sort(Marketing_Best.Best_SIC_Codes(inFile(trim(sic,left,right) <> '')),bdid);
bsales 		:= sort(Marketing_Best.Best_Annual_Sales(InFile((trim(exactSales,left,right) <> '' and
														(integer) exactSales > 0) or 
														trim(salesMin,left,right) <> '' or
														trim(salesMax,left,right) <> '')),bdid);
bemplCnt 	:= sort(Marketing_Best.Best_Employee_Count(InFile(trim(exactEmplCnt,left,right) <> '' or
														trim(emplCntMin,left,right) <> '' or
														trim(emplCntMax,left,right) <> '')),bdid);
btaxLien 	:= sort(Marketing_Best.Best_Tax_Lien(InFile(trim(taxLienAmount,left,right) <> '' and 
														MDR.sourceTools.SourceisLiens_and_Judgments(sourceCode))),bdid);
borgType 	:= sort(Marketing_Best.Best_Org_Type(InFile(trim(orgType,left,right)<>'')),bdid);


lbest := Marketing_Best.Layout_Best;

//getsic
lbest getsic(bdid_dups l, bsic r) := transform
	self.sic 			:= r.sic;
	self.sicSource 		:= r.sourceCode;
	self 				:= l;
end;

wsic := join(bdid_dups, bsic, left.bdid = right.bdid, 
			   getsic(left, right), left outer);
			   
// output(wsic,,'~thor_data400::persist::best_sic',overwrite);

//getsales
lbest getsales(lbest l, bsales r) := transform
	self.exactSales 	:= r.exactSales;
	self.salesMin 		:= r.salesMin;
	self.salesMax 		:= r.salesMax;
	self.salesSource 	:= r.sourceCode;
	self 				:= l;
end;

wsales := join(wsic, bsales, left.bdid = right.bdid, 
			 getsales(left, right), left outer);


//getemplCnt
lbest getemplCnt(lbest l, bemplCnt r) := transform
	self.exactEmplCnt 	:= r.exactEmplCnt;
	self.emplCntMin 	:= r.emplCntMin;
	self.emplCntMax 	:= r.emplCntMax;
	self.emplCntType 	:= r.emplCntType;
	self.emplCntSource 	:= r.sourceCode;
	self 				:= l;
end;

wemplCnt := join(wsales, bemplCnt, left.bdid = right.bdid,
			 getemplCnt(left, right), left outer);

//gettaxLien
lbest gettaxLien(lbest l, btaxLien r) := transform
	self.taxLienAmount 	:= r.taxLienAmount;
	self.taxLienTMSID 	:= r.taxLienTMSID;
	self.taxLienSource 	:= r.sourceCode;
	self 				:= l;
end;

wtaxLien := join(wemplCnt, btaxLien, left.bdid = right.bdid,
			     gettaxLien(left, right), left outer);
				 
//getOrgType
lbest getorgType(lbest l, borgType r) := transform
	self.orgType 		:= r.orgType;
	self.orgTypeSource 	:= r.sourceCode;
	self 				:= l;
end;

worgType := join(wtaxLien, borgType, left.bdid = right.bdid,
			     getorgType(left, right), left outer);

//Bankrupt Flag
ds_bankrupt  := dedup(sort(pBK_Search(trim(bdid,left,right)<>'' and (integer)trim(bdid,left,right)<>0),bdid),bdid);

Layout_best trfBanJoin(Layout_best l, ds_bankrupt r) := transform
	self.bankrupt_flag 	:= if (l.bdid = (integer)r.bdid,'Y','');
	self 				:= l;
end;

ds_base := join(worgType, ds_bankrupt, left.bdid = (integer)right.bdid, 
							 trfBanJoin(left, right),left outer)
							 ;

returnds := ds_base
				 : persist(pPersistName + pfileDesc);

return returnds;
							 
end;