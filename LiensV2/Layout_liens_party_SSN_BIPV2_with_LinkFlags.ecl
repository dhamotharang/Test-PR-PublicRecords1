IMPORT	LiensV2;
EXPORT	Layout_liens_party_SSN_BIPV2_with_LinkFlags	:=	RECORD
	Layout_liens_party_SSN_BIPV2 and not [TMSID_old,RMSID_old,global_sid,record_sid,orig_rmsid];
	UNSIGNED4	xadl2_keys_used			:=	0 ;
	STRING		xadl2_keys_desc			:=	'';
	INTEGER2	xadl2_weight				:=	0 ;
	UNSIGNED2	xadl2_Score					:=	0 ;
	UNSIGNED2	xadl2_distance			:=	0 ;
	STRING22	xadl2_matches				:=	'';
	STRING		xadl2_matches_desc	:=	'';
	string50  TMSID_old;
  string50  RMSID_old;
	string10  orig_rmsid;
	unsigned4 global_sid;
  unsigned8 record_sid;
END;