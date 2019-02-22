import ut;
export getkeyedcolumn(string filename,string esp) := function

	checkoutAttributeInRecord := record
		
		string OpenLogicalName{xpath('OpenLogicalName')} := filename;

	end;
	
	string_rec1 := record
		string keyfields{xpath('ColumnLabel')};
	end;
	
	checkoutAttributeOutRecord := record
		string logicalname{xpath('LogicalName')};
		dataset(string_rec1) keycols1{xpath('DFUDataKeyedColumns1/DFUDataColumn')};
		dataset(string_rec1) keycols2{xpath('DFUDataKeyedColumns2/DFUDataColumn')};
		dataset(string_rec1) keycols3{xpath('DFUDataKeyedColumns3/DFUDataColumn')};
		dataset(string_rec1) keycols4{xpath('DFUDataKeyedColumns4/DFUDataColumn')};
		dataset(string_rec1) keycols5{xpath('DFUDataKeyedColumns5/DFUDataColumn')};
		dataset(string_rec1) keycols6{xpath('DFUDataKeyedColumns6/DFUDataColumn')};
		dataset(string_rec1) keycols7{xpath('DFUDataKeyedColumns7/DFUDataColumn')};
		dataset(string_rec1) keycols8{xpath('DFUDataKeyedColumns8/DFUDataColumn')};
		dataset(string_rec1) keycols9{xpath('DFUDataKeyedColumns9/DFUDataColumn')};
		dataset(string_rec1) keycols10{xpath('DFUDataKeyedColumns10/DFUDataColumn')};
		dataset(string_rec1) keycols11{xpath('DFUDataKeyedColumns11/DFUDataColumn')};
		dataset(string_rec1) keycols12{xpath('DFUDataKeyedColumns12/DFUDataColumn')};
		dataset(string_rec1) keycols13{xpath('DFUDataKeyedColumns13/DFUDataColumn')};
		dataset(string_rec1) keycols14{xpath('DFUDataKeyedColumns14/DFUDataColumn')};
		dataset(string_rec1) keycols15{xpath('DFUDataKeyedColumns15/DFUDataColumn')};
		dataset(string_rec1) keycols16{xpath('DFUDataKeyedColumns16/DFUDataColumn')};
		dataset(string_rec1) keycols17{xpath('DFUDataKeyedColumns17/DFUDataColumn')};
		dataset(string_rec1) keycols18{xpath('DFUDataKeyedColumns18/DFUDataColumn')};
		dataset(string_rec1) keycols19{xpath('DFUDataKeyedColumns19/DFUDataColumn')};
		dataset(string_rec1) keycols20{xpath('DFUDataKeyedColumns20/DFUDataColumn')};
		/*dataset(string_rec1) nonkeycols1{xpath('DFUDataNonKeyedColumns1/DFUDataColumn')};
		dataset(string_rec1) nonkeycols2{xpath('DFUDataNonKeyedColumns2/DFUDataColumn')};
		dataset(string_rec1) nonkeycols3{xpath('DFUDataNonKeyedColumns3/DFUDataColumn')};
		dataset(string_rec1) nonkeycols4{xpath('DFUDataNonKeyedColumns4/DFUDataColumn')};
		dataset(string_rec1) nonkeycols5{xpath('DFUDataNonKeyedColumns5/DFUDataColumn')};
		dataset(string_rec1) nonkeycols6{xpath('DFUDataNonKeyedColumns6/DFUDataColumn')};
		dataset(string_rec1) nonkeycols7{xpath('DFUDataNonKeyedColumns7/DFUDataColumn')};
		dataset(string_rec1) nonkeycols8{xpath('DFUDataNonKeyedColumns8/DFUDataColumn')};
		dataset(string_rec1) nonkeycols9{xpath('DFUDataNonKeyedColumns9/DFUDataColumn')};
		dataset(string_rec1) nonkeycols10{xpath('DFUDataNonKeyedColumns10/DFUDataColumn')};
		dataset(string_rec1) nonkeycols11{xpath('DFUDataNonKeyedColumns11/DFUDataColumn')};
		dataset(string_rec1) nonkeycols12{xpath('DFUDataNonKeyedColumns12/DFUDataColumn')};
		dataset(string_rec1) nonkeycols13{xpath('DFUDataNonKeyedColumns13/DFUDataColumn')};
		dataset(string_rec1) nonkeycols14{xpath('DFUDataNonKeyedColumns14/DFUDataColumn')};
		dataset(string_rec1) nonkeycols15{xpath('DFUDataNonKeyedColumns15/DFUDataColumn')};
		dataset(string_rec1) nonkeycols16{xpath('DFUDataNonKeyedColumns16/DFUDataColumn')};
		dataset(string_rec1) nonkeycols17{xpath('DFUDataNonKeyedColumns17/DFUDataColumn')};
		dataset(string_rec1) nonkeycols18{xpath('DFUDataNonKeyedColumns18/DFUDataColumn')};
		dataset(string_rec1) nonkeycols19{xpath('DFUDataNonKeyedColumns19/DFUDataColumn')};
		dataset(string_rec1) nonkeycols20{xpath('DFUDataNonKeyedColumns20/DFUDataColumn')};*/
	end;
	
	results := SOAPCALL('http://'+esp+':8010/Wsdfu/?ver_=1.22', 'DFUSearchData', 
											checkoutAttributeInRecord, dataset(checkoutAttributeOutRecord),
											
											xpath('DFUSearchDataResponse')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );

	return results;
	
end;