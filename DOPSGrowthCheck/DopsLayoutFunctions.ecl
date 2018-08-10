export DopsLayoutFunctions := module
    SHARED string     gESPAddressAndPort :=  'http://prod_esp.br.seisint.com:8010';
    EXPORT fgetkeyedcolumns(string filename) := function
									checkoutAttributeInRecord := record
												string OpenLogicalName{xpath('OpenLogicalName')} := filename;
									end;
									
									string_rec1 := record
												string keyfields{xpath('ColumnLabel')};
									end;
									
									checkoutAttributeOutRecord := record
												string logicalname{xpath('LogicalName')};
												dataset(string_rec1) keycols{xpath('DFUDataKeyedColumns*/DFUDataColumn')};
									end;
									
									results := SOAPCALL(gESPAddressAndPort + '/Wsdfu', 'DFUSearchData', 
																									checkoutAttributeInRecord, dataset(checkoutAttributeOutRecord),
																									xpath('DFUSearchDataResponse'));

									rWithCodeString  :=
									record
													checkoutAttributeOutRecord;
													string     KeyedFieldList{maxlength(1000)};
									end;

									rWithCodeString              tWithCodeString(results pInput) :=
									transform
												self.KeyedFieldList    := '';//pInput.keycols[1].keyfields;
												self.keycols           := pInput.keycols;
												self.logicalname       := pInput.logicalname;
									end;

									dWithCodeString  :=  project(results, tWithCodeString(left));

									rWithCodeString   tNormalize(rWithCodeString pParent, string_rec1 pChild) :=
									transform
												self.KeyedFieldList := pChild.keyfields;
												self.keycols        := pParent.keycols;
												self.logicalname    := pParent.logicalname;
									end;

									dNormalize   := normalize(dWithCodeString, left.keycols,tNormalize(left, right)	);

									rWithCodeString   tRollup(dNormalize pLeft, dNormalize pRight)    :=
									transform
												self.KeyedFieldList :=  pLeft.KeyedFieldList + ',' + pRight.KeyedFieldList;
												self                :=  pLeft;
									end;

									dRollup := rollup(dNormalize,	true,	tRollup(left, right)	);

									return dRollup[1].KeyedFieldList;
									
	end;
    EXPORT fgetnonkeyedcolumns(string filename) := function
									checkoutAttributeInRecord := record
												string OpenLogicalName{xpath('OpenLogicalName')} := filename;
									end;
									
									string_rec1 := record
												string keyfields{xpath('ColumnLabel')};
									end;
									
									checkoutAttributeOutRecord := record
												string logicalname{xpath('LogicalName')};
												dataset(string_rec1) keycols{xpath('DFUDataNonKeyedColumns*/DFUDataColumn')};
									end;
									
									results := SOAPCALL(gESPAddressAndPort + '/Wsdfu', 'DFUSearchData', 
																									checkoutAttributeInRecord, dataset(checkoutAttributeOutRecord),
																									xpath('DFUSearchDataResponse'));

									rWithCodeString  :=
									record
													checkoutAttributeOutRecord;
													string     KeyedFieldList{maxlength(1000)};
									end;

									rWithCodeString              tWithCodeString(results pInput) :=
									transform
												self.KeyedFieldList    := '';//pInput.keycols[1].keyfields;
												self.keycols           := pInput.keycols;
												self.logicalname       := pInput.logicalname;
									end;

									dWithCodeString  :=  project(results, tWithCodeString(left));

									rWithCodeString   tNormalize(rWithCodeString pParent, string_rec1 pChild) :=
									transform
												self.KeyedFieldList := pChild.keyfields;
												self.keycols        := pParent.keycols;
												self.logicalname    := pParent.logicalname;
									end;

									dNormalize   := normalize(dWithCodeString, left.keycols,tNormalize(left, right)	);

									rWithCodeString   tRollup(dNormalize pLeft, dNormalize pRight)    :=
									transform
												self.KeyedFieldList :=  pLeft.KeyedFieldList + ',' + pRight.KeyedFieldList;
												self                :=  pLeft;
									end;

									dRollup := rollup(dNormalize,	true,	tRollup(left, right)	);

									return dRollup[1].KeyedFieldList;
									
	end;
end;