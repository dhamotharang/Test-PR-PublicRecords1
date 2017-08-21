export MD_Stats(getretval) := macro
	import marriage_divorce_v2,codes,ut,lib_fileservices,_Control;
	mds := marriage_divorce_v2.file_mar_div_base(filing_type = '3' and marriage_filing_dt <> '');
	dds := marriage_divorce_v2.file_mar_div_base(filing_type = '7' and divorce_filing_dt <> '');
	md_string_rec := record
		string state;
		string county;
		string flag;
		string filing_date;		
	end;
	
	md_string_rec getmrecs(mds l) := transform
		self.flag := 'Marriage';
		self.state := l.state_origin;
		self.county := if(l.marriage_county <> '',trim(l.marriage_county),'None');
		self.filing_date := l.marriage_filing_dt;
	end;
	
	md_projmrecs := project(mds,getmrecs(left));
	
	md_string_rec getdrecs(dds l) := transform
		self.flag := 'Divorce';
		self.state := l.state_origin;
		self.county := if(l.divorce_county <> '',trim(l.divorce_county),'None');
		self.filing_date := l.divorce_filing_dt;
	end;
	
	md_projdrecs := project(dds,getdrecs(left));
	
	fullmdrecs := md_projmrecs + md_projdrecs;
	
	
	md_slim_recs := record
		string subcat;
		string filing_date;
	end;

	md_slim_recs getlongst(fullmdrecs l,Codes.File_Codes_V3_In r) := transform
		self.subcat := if(trim(r.long_desc)<>'',trim(r.long_desc),'None')
						+ ',' + stringlib.stringtouppercase(trim(l.county)[1..1])+
								stringlib.stringtolowercase(trim(l.county)[2..]) +
								',' + l.flag;
		self.filing_date := trim(l.filing_date);
	end;
		

	joindmlongst := join(fullmdrecs(trim(filing_date) <> '' 
							and trim(state) <> ''),
							Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG'),
							left.state = right.code,
							getlongst(left,right),
							left outer,
							lookup);
	
	md_slim_recs getstatewide(fullmdrecs l,Codes.File_Codes_V3_In r) := transform
		self.subcat := if(trim(r.long_desc)<>'',trim(r.long_desc),'None')
						+ ',' + 'Statewide' + ',' + l.flag;
		self.filing_date := trim(l.filing_date);
	end;
		

	joinlongst := join(fullmdrecs(trim(filing_date) <> '' 
							and trim(state) <> ''),
							Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG'),
							left.state = right.code,
							getstatewide(left,right),
							left outer,
							lookup);
	
	fullstjoin := joindmlongst + joinlongst;
	
	Orbit_Report.Run_Stats('md',fullstjoin,subcat,filing_date,'emailme','nst',getretval);
	
endmacro;