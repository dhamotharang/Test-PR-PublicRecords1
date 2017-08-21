import ut;

EXPORT Edit_Distance_NewBaseLine(

	 dataset({qstring120 company_name}) pSample	= Edit_Distance_Input()

) :=
module

	shared fe1	:=	Edit_Distance_NewFns.fEdit1;
	shared fe2	:=	Edit_Distance_NewFns.fEdit2;
	shared fe3	:=	Edit_Distance_NewFns.fEdit3;
	shared fe4	:=	Edit_Distance_NewFns.fEdit5;

	shared f1	:=	Edit_Distance_NewFns.f1;
	shared f2	:=	Edit_Distance_NewFns.f2;
	shared f3	:=	Edit_Distance_NewFns.f3;
	shared f4	:=	Edit_Distance_NewFns.f4;
	shared f5	:=	Edit_Distance_NewFns.f5;
	shared f6	:=	Edit_Distance_NewFns.f6;

	shared ft1	:=	Edit_Distance_NewFns.ft1;
	shared ft2	:=	Edit_Distance_NewFns.ft1;
	shared ft3	:=	Edit_Distance_NewFns.ft3;
	shared ft4	:=	Edit_Distance_NewFns.ft4;
	shared ft5	:=	Edit_Distance_NewFns.ft5;
	shared ft6	:=	Edit_Distance_NewFns.ft6;
	shared ft7	:=	Edit_Distance_NewFns.ft7;
	shared ft8	:=	Edit_Distance_NewFns.ft8;
	shared ft9	:=	Edit_Distance_NewFns.ft9;

	shared editrec := {qstring120 company_name1,qstring120 company_name2,unsigned1 distance,unsigned2 iter};
	shared samplerec	:= {recordof(pSample),qstring120 edit4,unsigned2 iter};
	
	export lSample := distribute(dedup(sort(normalize(pSample, 16,transform(samplerec
		,self.edit4 := map(counter = 1	=> f1(left.company_name)
											,counter = 2	=> f2(left.company_name)
											,counter = 3	=> f3(left.company_name)
											,counter = 4	=> f4(left.company_name)
											,counter = 5	=> f5(left.company_name)
											,counter = 6	=> f6(left.company_name)
											,counter = 7	=> ft1(left.company_name)
											,counter = 8	=> ft2(left.company_name)
											,counter = 9	=> ft3(left.company_name)
											,counter = 10	=> ft4(left.company_name)
											,counter = 11	=> ft5(left.company_name)
											,counter = 12	=> ft6(left.company_name)
											,counter = 13	=> ft7(left.company_name)
											,counter = 14	=> ft8(left.company_name)
											,counter = 15	=> ft9(left.company_name)
											,								fe2(left.company_name)
									);
		,self.iter := counter,self := left)),company_name,edit4,iter),hash64(company_name,edit4)),hash64(edit4));

	export djoinedit1(dataset(samplerec) p1, dataset(samplerec) p2,unsigned1 piter) := 
		join(p1	,p2	,left.edit4 = right.edit4	and left.company_name != right.company_name and ut.WithinEditN(trim(left.company_name),trim(right.company_name),1),transform(editrec,self.company_name1 := left.company_name,self.company_name2 := right.company_name,self.distance := 1,self.iter := left.iter),local);
	export djoinedit2(dataset(samplerec) p1, dataset(samplerec) p2,unsigned1 piter) := 
		join(p1	,p2	,left.edit4 = right.edit4	and left.company_name != right.company_name and ut.WithinEditN(trim(left.company_name),trim(right.company_name),2),transform(editrec,self.company_name1 := left.company_name,self.company_name2 := right.company_name,self.distance := 2,self.iter := left.iter),local);
		
	export dedit1s := dedup(sort(
			djoinedit1(lSample,lSample,1)
		,company_name1,company_name2,iter),hash64(company_name1,company_name2)
	);

	export dedit2s := dedup(sort(
			djoinedit2(lSample,lSample,1)
		,company_name1,company_name2,iter),hash64(company_name1,company_name2)
	);                                         
		                                         
end;