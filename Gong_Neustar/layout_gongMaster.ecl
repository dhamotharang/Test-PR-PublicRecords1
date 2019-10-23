import Gong_v2, BIPV2;

EXPORT layout_gongMaster := record
	Layout_Neustar - filename;
  Gong_v2.Layout_GongHistory;
  string5 pdid := '';
	string2 pfrd_address_ind:='';
	unsigned8 rawAid := 0;
  unsigned8 nid := 0;
  string1   nametype := '';
	string5		cln_title := '';
	string20	cln_fname := '';
	string20	cln_mname := '';
	string20	cln_lname := '';
	string5		cln_suffix := '';
	string5		cln_title2 := '';
	string20	cln_fname2 := '';
	string20	cln_mname2 := '';
	string20	cln_lname2 := '';
	string5		cln_suffix2 := '';
  unsigned2 name_ind := 0;
  unsigned8 persistent_record_id := 0;
	BIPV2.IDlayouts.l_xlink_ids;	
  //CCPA-22 CCPA new fields
  UNSIGNED4 global_sid := 0;
  UNSIGNED8 record_sid := 0;
end;
