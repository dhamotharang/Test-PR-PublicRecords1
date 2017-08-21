import lib_fileservices;
export Despray_Official_Records(string volumename) := 
function

#workunit('name','Despray Official Records')

destip := '10.173.12.240';
despray_party := fileservices.despray('~thor_200::base::official_records_party',
										 destip,'/'+volumename+'/official_records_party.d00',,,,
										true);

despray_doc := fileservices.despray('~thor_200::base::official_records_document',
										 destip,'/'+volumename+'/official_records_document.d00',,,,
										true);
//compress the party and document base full files
fname :=  lib_fileservices.FileServices.GetSuperFileSubName('~thor_200::base::official_records_party',1,false);
ds := dataset('~'+fname,official_records.Layout_Moxie_Party,thor);

party_cmp := sequential(output(ds,,'~'+fname+'_comp',__COMPRESSED__,OVERWRITE),
				FileServices.StartSuperFileTransaction(),
   				FileServices.ClearSuperFile('~thor_200::base::official_records_party',true),
				FileServices.AddSuperFile('~thor_200::base::official_records_party','~'+fname+'_comp'),
				FileServices.FinishSuperFileTransaction());
				
				
docfname :=  lib_fileservices.FileServices.GetSuperFileSubName('~thor_200::base::official_records_document',1,false);
docds := dataset('~'+docfname,official_records.Layout_Moxie_document,thor);

doc_cmp := sequential(output(docds,,'~'+docfname+'_comp',__COMPRESSED__,OVERWRITE),
				FileServices.StartSuperFileTransaction(),
   				FileServices.ClearSuperFile('~thor_200::base::official_records_document',true),
				FileServices.AddSuperFile('~thor_200::base::official_records_document','~'+docfname+'_comp'),
				FileServices.FinishSuperFileTransaction());

return sequential(despray_party,despray_doc,party_cmp,doc_cmp);
	
end;