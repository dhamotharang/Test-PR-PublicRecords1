import BIPV2;
EXPORT layout_sanctions_bdid :=record
		unsigned6	Bdid	     := 0;
		unsigned6 BDID_Score := 0; 
		layout_sanctions_DID_RecID;
		string8		DerivedReinstateDate	:=	'';
		BIPV2.IDlayouts.l_xlink_ids
end;