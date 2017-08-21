import header,ut,BankruptcyV2,BankruptcyV3;

export BK_as_Header(dataset(BankruptcyV2.layout_bankruptcy_search_v3_supp_bip) pBK_Search = dataset([],BankruptcyV2.layout_bankruptcy_search_v3_supp_bip),
					dataset(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp) pBK_Main = dataset([],bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp),
					boolean pForHeaderBuild=false,boolean pFastHeader = false
				   )
 :=
  function
	dBKAsSource	:=	header.Files_SeqdSrc(pFastHeader).BA;

	h := header.Layout_New_Records;

	h trans(dBKAsSource l) := transform
	  self.did := if(pFastHeader, (unsigned) l.did, 0) ;
	  self.rid := 0;
	  self.dt_first_seen := ut.mob(ut.min2((integer)l.orig_filing_date, (integer)l.date_filed));
	  self.dt_last_seen := ut.mob(
	  max(
	  max((integer)l.disposed_date, (integer) l.reopen_date),
	  max((integer)l.converted_date, (integer)l.date_filed)
	  ));
	  self.dt_vendor_last_reported := (integer)l.date_vendor_last_reported[1..6];
	  self.dt_vendor_first_reported := (integer)l.date_vendor_first_reported[1..6];
	  self.dt_nonglb_last_seen  := self.dt_last_seen;
	  self.rec_type := '1';
	  self.vendor_id := l.court_code+l.case_number+l.seq_number[6..10];
	  self.dob := 0;
	  self.ssn := map (
											~regexfind('[^0-9]',trim(l.ssnMatch,all)) and l.ssnMSrc<>'' and ut.NNEQ_SSN(l.ssnMatch,l.ssn) and (integer)l.ssnMatch>0 => intformat((integer)l.ssnMatch,9,1)
											,~regexfind('[^0-9]',trim(l.ssn,all))  and (integer)l.ssn>0 => intformat((integer)l.ssn,9,1)
											,'');
	  self.city_name := l.v_city_name;
	  self.phone := '';
	  self.county := l.county[3..5];
	  self.suffix := l.addr_suffix;
	  self.cbsa := if(l.msa!='',l.msa+'0','');
	  self.jflag3 := if(~regexfind('[^0-9]',trim(l.ssnMatch,all))
											and l.ssnMSrc<>''
											and ut.NNEQ_SSN(l.ssnMatch,l.ssn)
											and (integer)l.ssnMatch>0
												,'C'
												,'');
	  self := l;
	  end;

	from_ba := project(dBKAsSource,trans(left));

	ded := from_ba(prim_name <> '', 
					lname <> '',
					length(trim(fname)) > 1,
					length(trim(mname)) = length(stringlib.StringFilterOut(mname, ' ')));

    return ded;
  end
 ;