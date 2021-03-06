import doxie, BIPV2;
export layout_corp_affiliations_records := record
	//unsigned8 filepos;
	unsigned6    did;
unsigned6    bdid;
BIPV2.IDlayouts.l_header_ids;
string2      state_origin;
qstring32    charter_number;
qstring120   corporation_name;
qstring250   corporation_name_comment;
qstring60    corporation_status;
qstring350   corporation_status_comment;
qstring8     corp_process_date;
qstring8     filing_date;
qstring100   contact_name;
qstring35    affiliation;
qstring5     title;
qstring20    fname;
qstring20    mname;
qstring20    lname;
qstring5     name_suffix;
qstring25    address_type;
qstring10    prim_range;
string2      predir;
qstring28    prim_name;
qstring4     suffix;
string2      postdir;
qstring10    unit_desig;
qstring8     sec_range;
qstring25    city_name;
string2      st;
qstring5     zip;
qstring4     zip4;
string8			 record_date;
string10		 record_type;
string1	  corp_for_profit_ind;
string25	corp_for_profit_ind_decoded;
dataset({doxie.layout_AppendGongByAddr_input.phone,doxie.layout_AppendGongByAddr_input.timezone}) phones{maxcount(10)};
end;
	