import BIPV2;

EXPORT Layout_liens_party_for_hogan_BIPV2 := record
	layout_liens_party_for_hogan;
	BIPV2.IDlayouts.l_xlink_ids;
	UNSIGNED4	xadl2_keys_used			:=	0 ;
	STRING		xadl2_keys_desc			:=	'';
	INTEGER2	xadl2_weight				:=	0 ;
	UNSIGNED2	xadl2_Score					:=	0 ;
	UNSIGNED2	xadl2_distance			:=	0 ;
	STRING22	xadl2_matches				:=	'';
	STRING		xadl2_matches_desc	:=	'';
end;