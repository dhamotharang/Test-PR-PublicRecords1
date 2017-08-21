import	gong_v2;
EXPORT Layout_gongMasterAid := record
	gong_v2.layout_gongMaster;
	unsigned8 rawAid;
	string pclean := '';
  string1   nametype := '';
  string80  preppedname := '';
  unsigned8 nid := 0;
  unsigned2 name_ind := 0;
  unsigned6	bid := 0;
end;