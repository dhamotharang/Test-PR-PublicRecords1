import business_header,ebr;

business_header.doxie_MAC_Field_Declare()
bdids := business_header.doxie_get_bdids();

autokey_recs := autokey_ids(false);

ebr.Layout_0010_Header_Base get_bdids(ebr.Key_0010_Header_BDID ri) :=
TRANSFORM
	SELF := ri;
END;

j := JOIN(bdids, ebr.Key_0010_Header_BDID, keyed(LEFT.bdid=RIGHT.bdid), get_bdids(RIGHT), KEEP(500));

export EbrSearchService_header := dedup(j+autokey_recs,all);