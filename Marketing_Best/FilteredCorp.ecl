import ut, corp2;

Layout_In := record
	string org_type_desc;
end;

export FilteredCorp(

	 dataset(Corp2.Layout_Corporate_Direct_Corp_Base) pCorp2Base						= corp2.files().base.corp.prod
	,dataset(Layout_In															) pFile_Org_Type_Lookup = File_Org_Type_Lookup



) := 
function

corp2Base := pCorp2Base(bdid<>0,corp_orig_org_structure_desc != '');

ds_org_type_lookup := pFile_Org_Type_Lookup;

Corp2.Layout_Corporate_Direct_Corp_Base foundOrgTypeRecord(Corp2.Layout_Corporate_Direct_Corp_Base l, ds_org_type_lookup r):= transform
	self := l;
end;

return join(corp2Base, ds_org_type_lookup,
							trim(left.corp_orig_org_structure_desc,left,right) = trim(right.org_type_desc,left,right),
							foundOrgTypeRecord(left,right),
							lookup);
end;