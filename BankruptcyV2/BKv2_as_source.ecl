import header;
export BKv2_as_source(dataset(BankruptcyV2.layout_bankruptcy_search) pBK_Search = dataset([],BankruptcyV2.layout_bankruptcy_search),
					dataset(bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing) pBK_Main = dataset([],bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing),
					boolean pForHeaderBuild=false
				   )
 :=
  function

	dSourceSearchData	:=	if(pForHeaderBuild,
							   dataset('~thor_data400::Base::BKSrcHeader_Building',BankruptcyV2.layout_bankruptcy_search,flat)(name_type='D' and lname!='' and prim_name!=''),
							   pBK_Search(name_type='D' and lname!='' and prim_name!='')
							  );

	dSourceMainData		:=	if(pForHeaderBuild,
							   dataset('~thor_data400::Base::BkMnHeader_Building',bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing,flat)(case_number!=''),
							   pBK_Main(case_number!='')
							  );

	f_search := distribute(dSourceSearchData(case_number[1..3] <> '449'),hash(case_number,court_code));
	f_main := distribute(dSourceMainData(case_number[1..3] <> '449'),hash(case_number,court_code));

	src_rec := record
	 header.layout_Source_ID;
	 BankruptcyV2.layout_bk_source;
	end;

	src_rec addSearch(f_search L,f_main R) := transform
		self := L;
		self := R;
		self := [];
	end;			 

	in_format := join(f_search,f_main,
						 (left.case_number = right.case_number) and
						(left.court_code = right.court_code),
						addSearch(left,right),local);

	header.Mac_Set_Header_Source(in_format,src_rec,src_rec,'BA',withUID)

	dForHeader	:=	withUID	: persist('persist::headerbuild_bk_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
