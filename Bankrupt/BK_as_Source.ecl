import header;

export BK_as_Source(dataset(Layout_BK_Search_v8) pBK_Search = dataset([],Layout_BK_Search_v8),
					dataset(layout_bk_main_v8) pBK_Main = dataset([],layout_bk_main_v8),
					boolean pForHeaderBuild=false
				   )
 :=
  function
	dSourceSearchData	:=	if(pForHeaderBuild,
							   dataset('~thor_data400::Base::BKSrcHeader_Building',Layout_BK_Search_v8,flat)(debtor_lname!='' and prim_name!=''),
							   pBK_Search(debtor_lname!='' and prim_name!='')
							  );

	dSourceMainData		:=	if(pForHeaderBuild,
							   dataset('~thor_data400::Base::BkMnHeader_Building',layout_bk_main_v8,flat)(case_number!=''),
							   pBK_Main(case_number!='')
							  );

	f_search := distribute(dSourceSearchData(case_number[1..3] <> '449'),hash(case_number,court_code));
	f_main := distribute(dSourceMainData(case_number[1..3] <> '449'),hash(case_number,court_code));

	src_rec := record
	 header.layout_Source_ID;
	 layout_bk_source;
	end;

	src_rec addSearch(f_main L, f_search R) := transform
		self := r;
		self := L;
		self := [];
	end;			 

	in_format := join(f_main, f_search,
						 (left.case_number = right.case_number) and
						(left.court_code = right.court_code),
						addSearch(left, right),local);

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
