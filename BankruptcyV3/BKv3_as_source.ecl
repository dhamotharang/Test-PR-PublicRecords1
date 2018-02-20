import header,BankruptcyV2, ut, std;

export BKv3_as_source(dataset(BankruptcyV2.layout_bankruptcy_search_v3_supp) pBK_Search = dataset([],BankruptcyV2.layout_bankruptcy_search_v3_supp),
					dataset(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp) pBK_Main = dataset([],bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp),
					boolean pForHeaderBuild=false,
					boolean pFastHeader = false
				   )
 :=
  function

	dSourceSearchData	:=	if(pForHeaderBuild
							   ,dataset('~thor_data400::Base::BKSrcHeader_Building',BankruptcyV2.layout_bankruptcy_search_v3_supp,flat)
							   ,pBK_Search
								 )
								 (name_type='D' and lname!='' and prim_name!='')
								;

	dSourceMainData_		:=	if(pForHeaderBuild
							   ,dataset('~thor_data400::Base::BkMnHeader_Building',bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp,flat)
							   ,pBK_Main
								 )
								 (case_number!='')
								;
							  
	  
	dSourceMainData := 	if (pFastHeader, dSourceMainData_(ut.DaysApart((STRING8)Std.Date.Today(), (string)date_vendor_last_reported[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep) , dSourceMainData_);
	

	f_search := distribute(dSourceSearchData(case_number[1..3] <> '449'),hash(case_number,court_code));
	f_main := distribute(dSourceMainData(case_number[1..3] <> '449'),hash(case_number,court_code));

	src_rec := record
	 header.layout_Source_ID;
	 BankruptcyV2.layout_bk_source; // no need to change to v3 all the necessary fields available for as header and source key .
	end;

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

	dForHeader	:=	withUID	: persist('persist::headerbuild_bk_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
