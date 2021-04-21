import Healthcare_Header_Services, Prof_LicenseV2_Services, doxie;
export ING_provider_report_records(dataset(Prof_LicenseV2_Services.Layout_Search_Ids_Prov) provs, boolean Include_Sanc=false, dataset(Healthcare_Header_Services.Layouts.autokeyInput) searchByCriteria= dataset([],Healthcare_Header_Services.Layouts.autokeyInput),dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg = dataset([{'1'}],Healthcare_Header_Services.Layouts.common_runtime_config)) := FUNCTION

	doxie.MAC_Header_Field_Declare();
	//Format prov into new format
	newlayout  := Healthcare_Header_Services.Layouts.autokeyInput;
	newProv := if(exists(provs),project(provs, transform(newlayout,self.acctno:='1';self.providersrc := if(left.ProviderSrc = '','H',left.ProviderSrc);
			self := left;self:=[])));
	searchBy:=project(searchByCriteria,transform(newlayout,self:=left))+newProv;
	rawData := Healthcare_Header_Services.Records.getRecordsRawDoxieIndividual(searchBy,cfg);
	fmtData := Healthcare_Header_Services.Records.fmtRecordsLegacyReport(rawData,cfg);
	sancCheck := if(Include_Sanc,fmtData,project(fmtData,transform(recordof(fmtData),self.sanction_data:=[],self:=left)));
	out_final := sancCheck;
return out_final;

END;
