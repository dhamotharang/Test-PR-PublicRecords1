import ut;

Export File_LT_Input_Raw := Module
File_LT_Raw := Dataset('~thor400_data::sf_in_201509', layout_LT_SF_InputRaw, CSV(Separator(','), Heading(1), Quote('"')));

layout_LT_SF_InputRaw xForm(File_LT_Raw L) := Transform
			Self.BillingID := ut.fnTrim2Upper(L.BillingID);
			Self.LenderName := ut.fnTrim2Upper(L.LenderName);
			Self.LenderID := ut.fnTrim2Upper(L.LenderID);
			Self.AccountManager := ut.fnTrim2Upper(L.AccountManager);
			Self.QFormName := ut.fnTrim2Upper(L.QFormName);
			Self.QFormID := ut.fnTrim2Upper(L.QFormID);
			Self.QFormUID := ut.fnTrim2Upper(L.QFormUID);
			Self.BorrowerID := ut.fnTrim2Upper(L.BorrowerID);
			Self.BorrowerSSN := ut.fnTrim2Upper(L.BorrowerSSN);
			Self.BorrowerFirstName := ut.fnTrim2Upper(L.BorrowerFirstName);
			Self.BorrowerLastName := ut.fnTrim2Upper(L.BorrowerLastName);
			Self.BorrowerMiddleName := ut.fnTrim2Upper(L.BorrowerMiddleName);
			Self.CoBorrowerSSN := ut.fnTrim2Upper(L.CoBorrowerSSN);
			Self.CoBorrowerFirstName := ut.fnTrim2Upper(L.CoBorrowerFirstName);
			Self.CoBorrowerLastName := ut.fnTrim2Upper(L.CoBorrowerLastName);
			Self.CoBorrowerMiddleName := ut.fnTrim2Upper(L.CoBorrowerMiddleName);
			Self.CompleteDate := ut.fnTrim2Upper(L.CompleteDate);
			Self.TransmitDate := ut.fnTrim2Upper(L.TransmitDate);
			Self.RequestedProduct := ut.fnTrim2Upper(L.RequestedProduct);
			Self.RequestedSubProduct := ut.fnTrim2Upper(L.RequestedSubProduct);
			Self.FoundAHome := ut.fnTrim2Upper(L.FoundAHome);
			Self.CreditScore := ut.fnTrim2Upper(L.CreditScore);
			Self.StatedCreditHistory := ut.fnTrim2Upper(L.StatedCreditHistory);
			Self.AmountRequested := ut.fnTrim2Upper(L.AmountRequested);
			Self.FilterClassLookup := ut.fnTrim2Upper(L.FilterClassLookup);
			Self.FixedFilterDescription := ut.fnTrim2Upper(L.FixedFilterDescription);
			//Self.FilterClassLookupID := ut.fnTrim2Upper(L.FilterClassLookupID); not in Sep 2015 data
			Self.PropertyUse := ut.fnTrim2Upper(L.PropertyUse);
			Self.AddressLine1 := ut.fnTrim2Upper(L.AddressLine1);
			Self.City := ut.fnTrim2Upper(L.City);
			Self.State := ut.fnTrim2Upper(L.State);
			Self.PostalCode := ut.fnTrim2Upper(L.PostalCode);
			integer UnfrmtBorSSN := (integer)L.UnformattedBorrowerSSN;
			UnfrmtBor_SSN := intformat(UnfrmtBorSSN,9,1);
			Self.UnformattedBorrowerSSN :=(String)UnfrmtBor_SSN;
End;
a := table(File_LT_Raw,{completedate,COUNT(GROUP)},completedate);
// output(a);
Export Infile := Project(File_LT_Raw, xForm(Left));

Export matchList := Dataset('~thor400_data::lendingtree_sf::matchlist_201509', Lending_Tree.Lay_ShortForm.Lay_matchList, CSV(Separator(','), Heading(1), Quote('"')));
//Export nomatchList := Dataset('~thor400_data::lendingtree_sf::nomatchlist_201509', Lending_Tree.Lay_ShortForm.Lay_nomatchList, thor);
Export nomatchList := Dataset('~thor400_data::lendingtree_sf::nomatchlist_201509', Lending_Tree.Lay_ShortForm.Lay_nomatchList, CSV(Separator(','), Heading(1), Quote('"')));

End;