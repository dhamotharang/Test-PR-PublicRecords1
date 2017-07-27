import business_header;

abi_rel_match := Business_Header.BH_Relative_Match_ABI_Number;
output('infousa company base file record count: ' + count(infousa.File_ABIUS_Company_Base));
output('count relative matches: ' + count(abi_rel_match));
output(abi_rel_match,,'out::abi_relatives_match_test',overwrite);
output(choosen(abi_rel_match,1000), named('EXAMPLE_RELATIVE_MATCHES'), all);

abi_sample_bdids := choosen(abi_rel_match,1000);

bhb := sort(distribute(business_header.File_Business_Header_Best,bdid),bdid,local);

company_layout := record
unsigned6 bdid1;
qstring120 company_name1 := '';
unsigned6 bdid2;
qstring120 company_name2 := '';
string2   match_type;
end;

company_layout getbestinfo1(business_header.Layout_Relative_Match l, bhb R) := transform
self.company_name1 := R.company_name;
self := l;
end;

abi_sample_dist := distribute(abi_sample_bdids, bdid1);
abi_sample_sort := sort(abi_sample_dist, bdid1,local);

abi_join1 := join(abi_sample_sort, bhb, left.bdid1 = right.bdid,getbestinfo1(left,right),local);

///////////////////////////////////////////////////////////////////////////////////////////
company_layout getbestinfo2(business_header.Layout_Relative_Match l, bhb R) := transform
self.company_name2 := R.company_name;
self := l;
end;

abi_sample_dist2 := distribute(abi_join1, bdid2);
abi_sample_sort2 := sort(abi_sample_dist2, bdid2,local);

abi_join2 := join(abi_sample_sort2, bhb, left.bdid2 = right.bdid,getbestinfo2(left,right),local);


output(abi_join2,,'out::abi_sample_relatives',overwrite);
output(choosen(abi_join2,1000), named('EXAMPLE_RELATIVE_MATCHES_WITH_NAME'), all);
