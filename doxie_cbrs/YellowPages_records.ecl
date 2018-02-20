import YellowPages, doxie, business_header,ut,doxie_cbrs_raw, std;

doxie_cbrs.mac_Selection_Declare()

export YellowPages_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

krecs := doxie_cbrs_raw.YellowPage(bdids,Include_YellowPages_val,Max_YellowPages_val).records;

krec := record
	krecs;
	string8 pub_date_decode;
end;

unsigned4 thisyear := (unsigned4)(((STRING)Std.Date.Today())[1..4]);

string8 checkflip(string6 dt) := 
	if(abs(thisyear - (unsigned4)(dt[1..4])) < abs(thisyear - (unsigned4)(dt[3..6])),
	dt + '00',
	dt[3..6] + dt[1..2] + '00');

krec keepk(krecs r):= transform
	self.index_value := if ((integer)R.index_value = 0, '', R.index_value);
	self.pub_date_decode :=checkflip(r.pub_date);
	self := r;
end;

return project(krecs, keepk(left));
END;