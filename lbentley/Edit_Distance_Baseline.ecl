import ut;
EXPORT Edit_Distance_Baseline(

	 dataset({qstring120 company_name}) pSample	= Edit_Distance_Input()

) :=
module

	shared editrec := {qstring120 company_name1,qstring120 company_name2,unsigned1 distance};

	export dedit1 := dedup(sort(join(pSample	,pSample	,ut.WithinEditN(trim(left.company_name),trim(right.company_name),1)	and left.company_name != right.company_name,transform(editrec,self.company_name1 := left.company_name,self.company_name2 := right.company_name,self.distance := 1),all),company_name1,company_name2),hash64(company_name1,company_name2))
		:persist('~thor_data400::persist::lbentley::Edit_Distance_Baseline.dedit1');
	export dedit2 := dedup(sort(join(pSample	,pSample	,ut.WithinEditN(trim(left.company_name),trim(right.company_name),2)	and left.company_name != right.company_name and not ut.WithinEditN(trim(left.company_name),trim(right.company_name),1),transform(editrec,self.company_name1 := left.company_name,self.company_name2 := right.company_name,self.distance := 2),all),company_name1,company_name2),hash64(company_name1,company_name2))
		:persist('~thor_data400::persist::lbentley::Edit_Distance_Baseline.dedit2');
		
end;