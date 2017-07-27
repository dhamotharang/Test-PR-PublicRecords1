import business_header;

bdids := business_regression.Interesting_BDIDs;
ofile := business_header.File_Business_Relatives_Group_Father;

business_header.Layout_Business_Relative_Group tra(business_header.Layout_Business_Relative_Group l) := transform
	self := l;
end;

relsample := join(ofile, bdids,
									left.bdid = right.bdid,
									tra(left), lookup);

export relgroup_sample_old := relsample : persist('BR_Relgroup_Sample_Old');