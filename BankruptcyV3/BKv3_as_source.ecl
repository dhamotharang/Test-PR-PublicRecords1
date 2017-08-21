import header,BankruptcyV2, ut,Std;
export BKv3_as_source(dataset(BankruptcyV2.layout_bankruptcy_search_v3_supp_bip) pBK_Search = dataset([],BankruptcyV2.layout_bankruptcy_search_v3_supp_bip),
					dataset(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp) pBK_Main = dataset([],bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp),
					boolean pForHeaderBuild=false,
					boolean pFastHeader = false
				   )
 :=
  function

	dSourceSearchData	:=	map(pForHeaderBuild => dataset('~thor_data400::Base::BKSrcHeader_Building',BankruptcyV2.layout_bankruptcy_search_v3_supp_bip,flat)
							   ,pFastHeader => dataset('~thor_data400::Base::BKSrcQuickHeader_Building',BankruptcyV2.layout_bankruptcy_search_v3_supp_bip,flat)
							   ,pBK_Search
								 )
								 (name_type='D' and lname!='' and prim_name!='')
								;

	dSourceMainData_		:=	map(pForHeaderBuild => dataset('~thor_data400::Base::BkMnHeader_Building',bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp,flat)
							   ,pFastHeader => dataset('~thor_data400::Base::BkMnQuickHeader_Building',bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp,flat)
							   ,pBK_Main
								 )
								 (case_number!='')
								;
							  
	  
	dSourceMainData := 	if (pFastHeader, dSourceMainData_(ut.DaysApart((STRING8)Std.Date.Today(), (string)date_vendor_last_reported[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep) , dSourceMainData_);
	

	f_search := distribute(dSourceSearchData(case_number[1..3] <> '449'),hash(case_number,court_code));
	f_main0 := distribute(dSourceMainData(case_number[1..3] <> '449'),hash(case_number,court_code));
	f_main := project(f_main0,transform({f_main0},self.status:=choosen(left.status,50),self:=left));

	src_rec := header.layouts_SeqdSrc.BA_src_rec;

	src_rec addSearch(f_search L,f_main R) := transform
		self := L;
		self.disposed_date := l.discharged ; 
		self := R;
		self := [];
	end;			 

	in_format := join(f_search,f_main,
						 (left.case_number = right.case_number) and
						(left.court_code = right.court_code),
						addSearch(left,right),local);

	seed:=if(pFastHeader,999999999999,1);
	header.Mac_Set_Header_Source(in_format,src_rec,src_rec,'BA',withUID,seed);

	return withUID;
  end
 ;