import header,ut,BankruptcyV2,BankruptcyV3;

export BK_as_Header(dataset(BankruptcyV2.layout_bankruptcy_search_v3) pBK_Search = dataset([],BankruptcyV2.layout_bankruptcy_search_v3),
					dataset(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing) pBK_Main = dataset([],bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing),
					boolean pForHeaderBuild=false
				   )
 :=
  function
	dBKAsSource	:=	BankruptcyV3.BKv3_as_source(pBK_Search,pBK_Main,pForHeaderBuild);

	h := header.Layout_New_Records;

	h trans(dBKAsSource rt) := transform
	  self.did := 0;
	  self.rid := 0;
	  self.dt_first_seen := ut.mob(ut.min2((integer)rt.orig_filing_date, (integer)rt.date_filed));
	  self.dt_last_seen := ut.mob(
	  ut.max2(
	  ut.max2((integer)rt.disposed_date, (integer) rt.reopen_date),
	  ut.max2((integer)rt.converted_date, (integer)rt.date_filed)
	  ));
	  self.dt_vendor_last_reported := self.dt_last_seen;
	  self.dt_vendor_first_reported := self.dt_first_seen;
	  self.dt_nonglb_last_seen  := self.dt_last_seen;
	  self.rec_type := '1';
	  self.vendor_id := rt.court_code+rt.case_number+rt.seq_number[6..10];
	  self.dob := 0;
	  self.ssn := if ((integer)rt.ssn=0 or length(trim(rt.ssn, all)) <> 9 or regexfind('[^0-9]', rt.ssn),'',rt.ssn);
	  self.city_name := rt.v_city_name;
	  self.phone := '';
	  self.county := rt.county[3..5];
	  self.suffix := rt.addr_suffix;
	  self.cbsa := if(rt.msa!='',rt.msa+'0','');
	  self := rt;
	  end;

	from_ba := project(dBKAsSource,trans(left));

	ded := from_ba(prim_name <> '', 
					lname <> '',
					length(trim(fname)) > 1,
					length(trim(mname)) = length(stringlib.StringFilterOut(mname, ' ')));

    return ded;
  end
 ;
