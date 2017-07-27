
IMPORT Business_Header, Business_Header_SS;

EXPORT layout_BDID_OutBatch_Expanded := RECORD
	Business_Header_SS.Layout_BDID_OutBatch;
	Business_Header.Layout_BH_Super_Group.group_id;
END;