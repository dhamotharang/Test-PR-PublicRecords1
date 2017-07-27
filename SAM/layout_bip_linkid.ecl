import bipv2, SAM, address;

EXPORT layout_bip_linkid := record,MAXLENGTH(18000)

  SAM.Layout_SAM;
	address.Layout_Clean182;
	address.Layout_Clean_Name;
	unsigned6			BDID;
	string cname;
  bipv2.IDlayouts.l_xlink_ids;

end;
