export Macros := MODULE

	export add_bankruptcy_info(inrecs, outrecs, outlayout, incl_bk) := MACRO
	import BankruptcyV3,AutoStandardI,codes;

			#uniquename(bk_tmsids);
			%bk_tmsids% := join(inrecs, BankruptcyV3.key_bankruptcyv3_did(), (unsigned6) left.did = right.did, 
																		transform(outlayout, self.tmsid := right.tmsid, self := left, 
																																		self := []), left outer, atmost(1000));
			#uniquename(getBKInfo)
			outlayout %getBKInfo%(%bk_tmsids% l, recordof(BankruptcyV3.key_bankruptcyv3_main_full()) r) := TRANSFORM
				self.court_code := r.court_code;
				self.court_name := r.court_name;
				self.case_number := r.case_number;
				self.filing_type_ex := '';
				self.record_type := '';
				self.date_filed := r.date_filed;
				self.disposed_date := '';
				self := l;
			END;
			
			#uniquename(recs_bk0)
			%recs_bk0% := join(%bk_tmsids%, BankruptcyV3.key_bankruptcyv3_main_full(), keyed(left.tmsid = right.tmsid), 
																%getBKInfo%(LEFT, RIGHT), left outer, limit(ut.limits.DEFAULT, skip));
			
			#uniquename(recs_bk)
			%recs_bk% := join(%recs_bk0%, BankruptcyV3.key_bankruptcyv3_search_full_bip(), keyed(left.tmsid = right.tmsid), 
				TRANSFORM(recordof(%recs_bk0%),
					SELF.filing_type_ex := codes.BANKRUPTCIES.FILING_TYPE(right.filing_type);
					SELF.record_type 		:= right.record_type; 
					SELF.disposed_date	:= right.discharged; 
					SELF	:= LEFT), 
				left outer, limit(0), keep(1));  //only need to keep 1 of the matching records as filing_type, record_type and discharged are the same for the same tmsid: W20150403-100501
																
			#uniquename(recs_no_bk)
			%recs_no_bk% := project(inrecs,transform(outlayout, self := left, self := []));

			outrecs := if(incl_bk, %recs_bk%, %recs_no_bk%);	
	ENDMACRO;
END;