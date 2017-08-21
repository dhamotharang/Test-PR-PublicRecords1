EXPORT Max_RCID(

	 dataset(Layout_Business_Header_Base) pBhf					= Business_Header.File_Business_Header_Previous
	,string																pPersistname	= persistnames().maxrcid
	,string																pStoredName		= 'BusinessHeaderMaxRcid'

) :=
function

	bhf := Business_Header.Filters.maxrcid(pBhf);

	Layout_RCID := RECORD
	bhf.rcid;
	END;

	tbl :=TABLE(bhf, Layout_RCID);

	tbl_max := MAX(tbl, rcid) : persist(pPersistname);	//persist it so it will not recalculate on resubmit

	returndata := tbl_max : STORED(pStoredName);
	
	return returndata;

end;