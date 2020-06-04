import STD,ut;
EXPORT cmd_text := module

	// cert_date - package version in Boca Cert DOPS
	// new_date - desired package version to Cert DOPS
	// prte_date - current package version in PRTE (AKA PRCT) Prod DOPS

	// This outputs the command text for renaming a Cert package dates.
  // It does not execute the command.  IOW, you have to copy the
	// output and paste to a BWR window, make any desired modifications,
	// and run separately â€“ for safety.

	EXPORT rename_keys(
										string pk
										,string cert_date = ''
										,string new_date = ''
										,boolean isFCRA = false
										,boolean isBoolean = false
										) := function

	pkg     := if(isFCRA,'fcra_'+pk, pk);
	envment := map(isFCRA=>'F',isBoolean=>'B','N');
	bool    := if(isBoolean,'Y','N');
	gen     := 'qa';

	d:=header.GetPackageKeys(pkg,cert_date,envment,bool)(lkeyname<>'');

	rough:=dedup(dataset([{'all_packagekeys := DATASET(['}],{string250 cmd}))
	+table(d,{string250 cmd:='{\'~'+regexreplace('generation',superkeys,gen)+'\', \'~'+regexreplace(cert_date,FileServices.GetSuperFileSubName('~'+regexreplace('generation',superkeys,gen),1),new_date)+'\'},'})
	+dataset([{'],  tools.Layout_SuperFilenames.inputlayout);'},
			  {'nothor(tools.fun_RenameFiles(all_packagekeys, false));'}],{string250 cmd});

	clean:=choosen(rough,count(rough)-3)  //everything but the last three lines
			+ table(CHOOSESETS(rough,cmd<>'' => 3,last),{string250 cmd:=regexreplace('\\},',cmd,'\\}')})  // last three lines
			;

	return clean;

	end;

	//////////////////////////////////////////////////////////////////

	EXPORT rename_prte_keys(
										string pk
										,string cert_date = ''
										,string new_date = ''
										,string prte_date = ''
										,boolean isFCRA = false
										,boolean isBoolean = false
										) := function

	pkg     := if(isFCRA,'fcra_'+pk, pk);
	envment := if(isFCRA,'F','N');
	bool    := if(isBoolean,'Y','N');
	gen     := 'qa';

	d:=header.GetPackageKeys(pkg,,envment,bool)(lkeyname<>'');

	clean
		:=
		table(d
					,{
						string250
							cmd
								:=
						'fileservices.renamelogicalfile(\'~'
						+regexreplace('thor_data400',regexreplace(cert_date,FileServices.GetSuperFileSubName('~'+regexreplace('generation',superkeys,gen),1),prte_date),'prte')
						+'\', \'~'
						+regexreplace('thor_data400',regexreplace(cert_date,FileServices.GetSuperFileSubName('~'+regexreplace('generation',superkeys,gen),1),new_date),'prte')
						+'\');'
						});

	return clean;

	end;

	//////////////////////////////////////////////////////////////////

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

	//////////////////////////////////////////////////////////////////
	fgetdfuinfo(string filename) := function
									checkoutAttributeInRecord := record
												string Name{xpath('Name')} := filename;
									end;
									
									checkoutAttributeOutRecord := record,maxlength(30000)
												string fullxml{xpath('FileDetail/Ecl')};
									end;
									
									results := SOAPCALL(gESPAddressAndPort + '/Wsdfu', 'DFUInfo', 
																			checkoutAttributeInRecord, checkoutAttributeOutRecord,
																			xpath('DFUInfoResponse'));

									string ReturnValue   :=   results.FullXML;
									return ReturnValue;
	end;
	//////////////////////////////////////////////////////////////////

	// creates empty PRTE keys using built production THOR keys as a templete
	// fPattern - file pattern to list all keys in THOR to be used as templates ex: 'thor_data400::key::enclarity::*::20140207b::*'
	// built_date - key version in Boca prod THOR to use as template

	EXPORT create_empty_prte_keys(
										string fPattern = ''
										,string built_date = ''
										) := function

	datasetds:=STD.File.LogicalFileList(fPattern);

	buildindex_rec := record,maxlength(30000)
		string eclstring;
	end;

	ut_GetDate:=(STRING8)Std.Date.Today();
	buildindex_rec buildindex_code(datasetds l,integer cnt) := transform
		self.eclstring :=  'r'+(string)cnt+':='+fgetdfuinfo(l.name) + '\n'
					+'ds'+(string)cnt+':=dataset([],r'+(string)cnt + ');\n'
					+'i'+(string)cnt+':=index('+'ds'+(string)cnt+',{'+fgetkeyedcolumns(l.name)+'},{'+'ds'+(string)cnt+'},\'~' + regexreplace(built_date,regexreplace('thor_data400',l.name,'prte'),ut_GetDate)+'\');\n'
					+'BUILDINDEX(i'+(string)cnt+',\'~' + regexreplace(built_date,regexreplace('thor_data400',l.name,'prte'),ut_GetDate) + '\',update);\n\n'
					;
	end;

	buildindex_code_out := project(datasetds,buildindex_code(left,counter));

	return buildindex_code_out;

	end;

end;