#OPTION('multiplePersistInstances',FALSE);
export As_Business_Header(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
function

	basefile := if(pUsingInBusinessHeader, files().base.businessheader, files().base.QA);
	
	dasbh := fAs_Business_Header(basefile) : persist('~thor_data400::persist::UtilFile::As_Business_Header');

	return dasbh;

end;	