import FCRA, bankruptcyv2,LiensV2;
EXPORT ConvertLayouts() := module
	export _default(string varfilename
													,string xmlfilename
													,string headtag = 'dataset'
													,string rowtag = 'row') := output('no action');
	export bankrupt_main(string varfilename
													,string xmlfilename
													,string headtag = 'dataset'
													,string rowtag = 'row') := function
		dVar := dataset(varfilename
																,FCRA.layout_main_ffid_v3
																,csv(separator('\t'),quote('\"'),terminator('\r\n'))
																,opt);
		dSortVar := sort(distribute(dVar,hash(tmsid)),TMSID,-(unsigned)id,-date_created, date_modified,court_code,court_name,court_location,case_number,orig_case_number,
							-date_filed,filing_status,orig_chapter,orig_filing_date,assets_no_asset_indicator,filer_type,-meeting_date,meeting_time,address_341,
							claims_deadline, complaint_deadline,judge_name,judges_identification,filing_jurisdiction,assets,liabilities, CaseType, 
							AssocCode, SplitCase ,FiledInError,reopen_date,case_closing_date,-date_last_seen ,date_first_seen,local);
		 

		rOriginal := record
			bankruptcyv2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing;
			string20 flag_file_id;
		end;


		rOriginal xConvertToOriginal(dSortVar L) := transform
			self.status   := row(L,bankruptcyV2.Layout_bankruptcy_main_v3.layout_status);
			self.comments := row(L,bankruptcyV2.Layout_bankruptcy_main_v3.layout_comments);
			self := L;
		end;

		dOriginal := project(dSortVar, xConvertToOriginal(left));
		
		return output(dOriginal,,xmlfilename,XML(rowtag,heading('<'+headtag+'>','</'+headtag+'>')),overwrite);
	end;	
	// bankrupt search
	export bankrupt_search(string varfilename
													,string xmlfilename
													,string headtag = 'dataset'
													,string rowtag = 'row') := function
		dVar := dataset(varfilename
																,FCRA.layout_search_ffid_v3
																,csv(separator('\t'),quote('\"'),terminator('\r\n'))
																,opt);
		
		FCRA.layout_search_ffid_v3 xConvertToOriginal(dVar L) := transform
			self := L;
		end;

		dOriginal := project(dVar, xConvertToOriginal(left));
		
		return output(dOriginal,,xmlfilename,XML(rowtag,heading('<'+headtag+'>','</'+headtag+'>')),overwrite);
	end;	
	
	export liensv2_main(string varfilename
													,string xmlfilename
													,string headtag = 'dataset'
													,string rowtag = 'row') := function
		dVar := dataset(varfilename
																,FCRA.Layout_Override_Liens_Main_In
																,csv(separator('\t'),quote('\"'),terminator('\r\n'))
																,opt);
		dSortVar := sort(distribute(dVar,hash(tmsid)),tmsid,rmsid,-flag_file_id,local);
		 
		FCRA.Layout_Override_Liensv2_main xConvertToOriginal(dSortVar L) := transform
			self.filing_status   := row(L,LiensV2.layout_liens_main_module.layout_filing_status);
			//self.comments := row(L,bankruptcyV2.Layout_bankruptcy_main_v3.layout_comments);
			self := L;
		end;

		dOriginal := project(dSortVar, xConvertToOriginal(left));
		
		return output(dOriginal,,xmlfilename,XML(rowtag,heading('<'+headtag+'>','</'+headtag+'>')),overwrite);
	end;
	
	export liensv2_party(string varfilename
													,string xmlfilename
													,string headtag = 'dataset'
													,string rowtag = 'row') := function
		dVar := dataset(varfilename
																,FCRA.Layout_Override_Liens_Party_In
																,csv(separator('\t'),quote('\"'),terminator('\r\n'))
																,opt);
		
		FCRA.Layout_Override_Liensv2_party xConvertToOriginal(dVar L) := transform
			self := L;
		end;

		dOriginal := project(dVar, xConvertToOriginal(left));
		
		return output(dOriginal,,xmlfilename,XML(rowtag,heading('<'+headtag+'>','</'+headtag+'>')),overwrite);
	end;	
end;