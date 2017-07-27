import business_header;

bdids := business_regression.Interesting_BDIDs;
ofile := business_header.File_Business_Relatives;

business_header.Layout_Business_Relative tra(business_header.Layout_Business_Relative l) := transform
	self := l;
end;

relsample := join(ofile, bdids,
									left.bdid1 = right.bdid,
									tra(left), lookup);

export Rel_Sample_New := relsample : persist('BR_Rel_Sample_New');