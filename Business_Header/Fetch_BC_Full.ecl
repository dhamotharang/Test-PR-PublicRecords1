export  Fetch_BC_Full(dataset(business_header.layout_filepos) ds_fp) := 
FUNCTION

k := business_header.Key_Business_Contacts_FP;
business_header.Layout_Business_Contact_Full tra(k r) := transform
	self := r;
end;

j := join(ds_fp, k, left.fp > 0 and left.fp = right.fp, tra(right));

return j;

END;