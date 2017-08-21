myd := dataset(business_header.persistnames.BHBDIDSIC, business_header.Layout_SIC_Code, flat);

UniqueBdidsWithSics := distribute(table(myd, {bdid}, bdid), bdid);
bh := distribute(business_header.File_Business_Header, bdid);

bh_with_sic := join(
								 bh
								,UniqueBdidsWithSics
								,left.bdid = right.bdid
								,transform(recordof(bh), self := left)
								,local
							);


PercentageSicOfTotal := (real)count(bh_with_sic) / (real)count(bh) * 100;

output(count(bh)										,named('TotalBhRecords'									));
output(count(UniqueBdidsWithSics)	,named('UniqueBdidsAssignedSicCodes'		));
output(PercentageSicOfTotal				,named('PercentageFileAssignedSicCodes'));