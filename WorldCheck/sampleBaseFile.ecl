import ut, Globalwatchlists, WorldCheck;

export sampleBaseFile(string filedate) := function

ds1 := dataset('~thor_data400::base::worldcheck::main',WorldCheck.Layout_WorldCheck_Cleaned.Layout_WorldCheck_Main,flat);

smain := ds1(entered=filedate or updated=filedate); 

///////////////////////////////////////////////////////////////////////////////////////////////

ds3 := dataset('~thor_data400::base::worldcheck::qa::tokens',Globalwatchlists.Layout_SearchFile,flat);
ds4 := dataset('~thor_data400::base::worldcheck::father::tokens',Globalwatchlists.Layout_SearchFile,flat);

ds3_dedup := dedup(sort(distribute(ds3,hash(tkn)),tkn,local),tkn,local);
ds4_dedup := dedup(sort(distribute(ds4,hash(tkn)),tkn,local),tkn,local);

Globalwatchlists.Layout_SearchFile compTable2(ds3_dedup l, ds4_dedup r) := transform
 self := l;
end;

stok := join(ds3_dedup, ds4_dedup,
           left.tkn = right.tkn,
           compTable2(left,right),left only,few); 

////////////////////////////////////////////////////////////////////////////////////////////////

ds5 := dataset('~thor_data400::base::worldcheck::external_sources',WorldCheck.Layout_WorldCheck_Ext_Sources,flat);
ds6 := dataset('~thor_data400::base::worldcheck::external_sources_father',WorldCheck.Layout_WorldCheck_Ext_Sources,flat);

ds5_dedup := dedup(sort(distribute(ds5,hash(external_source)),external_source,local),external_source,local);
ds6_dedup := dedup(sort(distribute(ds6,hash(external_source)),external_source,local),external_source,local);

WorldCheck.Layout_WorldCheck_Ext_Sources compTable3(ds5_dedup l, ds6_dedup r) := transform
 self := l;
end;

sext := join(ds5_dedup, ds6_dedup,
           left.external_source = right.external_source,
           compTable3(left,right),left only,few); 

////////////////////////////////////////////////////////////////////////////////////////////////

sampleout:=  sequential(
	output(choosen(smain,1000),named('PostProcessMainSample')),
	output(choosen(stok,1000),named('PostProcessTokenSample')),
	output(choosen(sext,1000),named('PostProcessExternalSourcesSample'))
	);

return sampleout;

end;














