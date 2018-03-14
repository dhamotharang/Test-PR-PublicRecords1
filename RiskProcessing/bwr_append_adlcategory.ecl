r := record
	string amex_fileid;
	string LexID;
end;

d := dataset('~tfuerstenberg::in::amex_5695_input_all', r, csv(quote('"')));
// d := dataset('~tfuerstenberg::in::amex_5695_input_sample', r, csv(quote('"')));
output(d);


r2 := record
	r;
	string adlcategory;
end;

j := join(d, risk_indicators.Key_ADL_Risk_Table_v4, left.LexID<>'' and keyed((unsigned)left.LexID=right.did),
	transform(r2, 
	cat := trim(stringlib.stringtouppercase(right.adl_category));	
	self.adlcategory := risk_indicators.iid_constants.adlCategory(cat);
	self := left), 
	left outer);
output(choosen(j, 10), named('mysample'));
output(j,,'~dvstemp::out::amex_5695_adlcategory_append_full_20150218', csv(quote('"'), heading(single)) );

