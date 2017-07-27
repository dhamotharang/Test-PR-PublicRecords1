import Bipv2;

export layout_historyaid := record
	gong.Layout_history;
	unsigned8 rawaid := 0;
	string pclean := '';
	string5 pdid := '';
	string1   nametype := '';
  string80  preppedname := '';
  unsigned8 nid := 0;
  unsigned2 name_ind := 0;
  unsigned8	persistent_record_id := 0;
	BIPV2.IDlayouts.l_xlink_ids;	
end;