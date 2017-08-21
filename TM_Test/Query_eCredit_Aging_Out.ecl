// eCredit Customer Base file
ecb := TM_Test.File_eCredit_Customer_Base;

// eCredit Aging Input file
ea := TM_Test.File_eCredit_Aging_In;

layout_ecb_bdid := record
ecb.bdid;
ecb.CustomerId;
end;

ecb_bdid := table(ecb(bdid <> 0, CustomerId <> ''), layout_ecb_bdid);
ecb_bdid_dedup := dedup(ecb_bdid, (unsigned6)CustomerId, all);

// Append BDIDs to Aging file
eca_base := join(ea,
                 ecb_bdid_dedup,
			  (unsigned6)left.CustomerId = (unsigned6)right.CustomerId,
			  transform(TM_Test.Layout_eCredit_Aging_Base, self.bdid := right.bdid, self := left),
			  left outer,
			  hash);
			  
output(eca_base,,'TMTEST::eCredit_Aging_Base', overwrite);
