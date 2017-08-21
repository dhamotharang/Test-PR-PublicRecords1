import ut;
export Bankruptcy_Stats(getretval) := macro

#uniquename(dsmain)
#uniquename(dssearch)

%dsmain% := distribute(bankruptcyv2.file_bankruptcy_main,hash(tmsid));
%dssearch% := distribute(bankruptcyv2.file_bankruptcy_search,hash(tmsid));


#uniquename(add_cty_name)
%add_cty_name% := record
	%dssearch%;
	string newst := '';
	string county_name := '';
end;

#uniquename(tab_cty)
%tab_cty% := table(%dssearch%,%add_cty_name%);

#uniquename(join_fips)
%add_cty_name% %join_fips%(%tab_cty% l,census_data.File_Fips2County r) := transform
	self.newst := r.state_code;
	self.county_name := r.county_name;
	self := l;
end;

#uniquename(join_cty_out)
%join_cty_out% := join(%tab_cty%,census_data.File_Fips2County,
						left.county[1..2] = right.state_fips and
						left.county[3..5] = right.county_fips,
						%join_fips%(left,right),
						left outer,
						local,
						lookup);


#uniquename(string_rec)
%string_rec% := record
	string st := '';
	string subcat := '';
	string filing_date := '';
	
end;

#uniquename(proj_rec)
%string_rec% %proj_rec%(%dsmain% l) := transform
	cnt :=  ut.NoWords(l.court_name,'-');
	self.st :=  l.filing_jurisdiction;
	self.subcat :=  trim(ut.word(l.court_name,cnt,'-'),left,right);
	
	self.filing_date := if (l.orig_filing_date <> '',l.orig_filing_date,l.date_filed);
end;

#uniquename(proj_out)
%proj_out% := project(%dsmain%(filing_jurisdiction <> '' and court_name <> ''),
				%proj_rec%(left));

#uniquename(join_rec)
%string_rec% %join_rec%(%dsmain% l,%join_cty_out% r) := transform
	self.st := r.newst;
	self.subcat := if(r.orig_city <> '',r.orig_city,r.p_city_name);
	self.filing_date := if (l.orig_filing_date <> '',l.orig_filing_date,l.date_filed);
	
end;


#uniquename(join_out)
%join_out% := join(%dsmain%,%join_cty_out%(newst <> '' and county_name <> ''),
				left.tmsid = right.tmsid,
					%join_rec%(left,right),
					local);

#uniquename(join_rec1)
%string_rec% %join_rec1%(%dsmain% l,%join_cty_out% r) := transform
	self.st := r.newst;
	self.subcat := r.county_name;
	
	self.filing_date := if (l.orig_filing_date <> '',l.orig_filing_date,l.date_filed);
end;


#uniquename(join_out1)
%join_out1% := join(%dsmain%,%join_cty_out%(newst <> '' and county_name <> ''),
					left.tmsid = right.tmsid,
					%join_rec1%(left,right),
					local);

#uniquename(full_dataset)
%full_dataset% := %proj_out% + %join_out% + %join_out1%;

#uniquename(string_rec1)
%string_rec1% := record
	string subcat;
	string filing_date;
end;

#uniquename(join_recs)
%string_rec1% %join_recs%(%full_dataset% l,Codes.File_Codes_V3_In r) := transform
	self.subcat := if(trim(r.long_desc)<>'',trim(r.long_desc),'None')
						+ ',' + stringlib.stringtouppercase(trim(l.subcat)[1..1])+
								stringlib.stringtolowercase(trim(l.subcat)[2..]);
	self.filing_date := trim(l.filing_date);
end;
		
#uniquename(join_out2)
%join_out2% := join(%full_dataset%(trim(filing_date) <> '' 
							and trim(st) <> ''),
							Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG'),
							left.st = right.code,
							%join_recs%(left,right),
							left outer,
							lookup);

Orbit_Report.Run_Stats('bankruptcy',%join_out2%,subcat,filing_date,'emailme','nst',getretval);


endmacro;