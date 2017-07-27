import calbus;
import text_search;

export Convert_Calbus_Func := function
	
	ds := distribute(calbus.File_Calbus_Base,hash(account_number));
	
	Layout_calbus_record := record(text_search.Layout_Document)
		string13 account_number;
	end;
	
	Layout_calbus_record convert_calbus(ds l) := transform
		self.account_number := l.account_number;
		self.docref.doc := 0;
		self.docref.src := transfer('CA',integer2);
		self.segs := dataset([
							{1,0,l.firm_name},
							{2,0,l.business_street + ' ' + l.business_city + ' ' + l.business_state + ' ' +
										l.business_country_name + ' ' + l.business_zip_5 + '-' + l.business_zip_plus_4 + ' ' + 
										l.business_foreign_zip},
							{3,0,l.business_city + ';' +  l.mailing_city},
							{4,0,l.business_state + ';' + l.mailing_state},
							{5,0,l.business_zip_5 + '-' + l.business_zip_plus_4 + ';' + 
									l.mailing_zip_5 + '-' + l.mailing_zip_plus_4},
							{6,0,l.business_foreign_zip + ';' + l.mailing_foreign_zip},
							{7,0,l.business_country_name + ';' + l.mailing_country_name},
							{8,0, ';' + l.mailing_street + ' ' + l.mailing_city + ' ' + l.mailing_state + ' ' +
										l.mailing_country_name + ' ' + l.mailing_zip_5 + '-' + l.mailing_zip_plus_4 + ' ' + 
										l.mailing_foreign_zip},
							{9,0,';' + l.owner_name},
							{10,0,l.start_date},
							{11,0,l.Industry_code_desc},
							{12,0,l.Tax_code_full_desc},
							{13,0,l.city_code},
							{14,0,l.district_branch},
							{15,0,l.district}
							
		],text_search.Layout_Segment)
	end;

	proj_out := project(ds,convert_calbus(left));
	
	layout_calbus_flat := record(text_search.Layout_DocSeg)
		string13 account_number;
	end;

	layout_calbus_flat norm_recs(proj_out l,text_search.Layout_Segment r) := transform
			self.account_number := l.account_number;
			self.docref := l.docref;
			self := r;
	end;
	
	norm_out := normalize(proj_out,left.segs,norm_recs(left,right));

	sort_out := sort(norm_out,account_number,local);
	
	layout_calbus_flat iterate_recs(layout_calbus_flat l,layout_calbus_flat r) := transform
		self.docref.doc := if(l.account_number = r.account_number,l.docref.doc,
								if(l.docref.doc = 0,thorlib.node() +1,l.docref.doc + thorlib.nodes()+1));
		self.docref.src := r.docref.src;
		self.sect := if(l.account_number <> r.account_number or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;

	iterate_out := iterate(sort_out,iterate_recs(left,right),local);

	return iterate_out(trim(content) <> '' or trim(content) <> ';');
	
end;