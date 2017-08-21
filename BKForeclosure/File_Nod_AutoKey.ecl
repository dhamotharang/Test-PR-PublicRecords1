// Suppressing 4 Foreclosure IDs as part of dispute database Bug#: 60282 and bugzilla bug#: 170863
FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1','14944559950000SOUTHERNBK&TRUST', '14944559950000RABIMIKE'];
file_in := BKForeclosure.File_BK_Foreclosure.fNod(/*trim(deed_category)='N' and*/ Trim(foreclosure_id, left, right) not in FC_ids);
// file_in := Property.File_Foreclosure_Normalized(trim(deed_category)='N');
Autokey_layout:=
record
	string70	foreclosure_id;
	STRING25 	cln_title;
	STRING30  cln_fname;
	STRING30  cln_mname;
	STRING30  cln_lname;
	STRING5 	cln_suffix;
	STRING25	cln_title2;
	STRING30  cln_fname2;
	STRING30  cln_mname2;
	STRING30  cln_lname2;
	STRING5   cln_suffix2;
	unsigned6 did := 0;
	unsigned1 did_score := 0;
	// unsigned6 bdid := 0;
	// unsigned1 bdid_score := 0;
	string9 	ssn := '';
	string60  cname;
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		addr_suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	string25	p_city_name;
	string25	v_city_name;
	string2		st;
	string5		zip;
	string4		zip4;
	unsigned 	zero :=0;
	string1		blank :='';
end;

export File_NOD_Autokey := dedup(project(file_in(prim_name<>'' and zip<>''),Autokey_layout),record,all) : persist('~thor_data400::persist::file_nod_Autokey');

