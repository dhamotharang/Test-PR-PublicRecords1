import ut,dops;
export pullindexes(string datasetname,string prtedate, string nonprtedate, string environment,string loc) := function	



datasetds := dops.GetRoxieKeys(datasetname,loc,environment,'N');

buildindex_rec := record,maxlength(30000)
	string eclstring;
end;

buildindex_rec buildindex_code(datasetds l,integer cnt) := transform
	dsname := 'dataset([],arecord' + (string)cnt + ')';
	recordsetfield := 'arecord' + (string)cnt + ':= \n';
	dsvar := 'ds' + (string)cnt ;
	wordtoreplace := ut.Word(regexreplace('[\r\n]',l.logicalkey,''),1,'::');
	xmlfilename := regexreplace(':',regexreplace(datasetname+'_DATE',l.logicalkey,''),'_') + '.xml';
	csvfilename := regexreplace(':',regexreplace(datasetname+'_DATE',l.logicalkey,''),'_') + '.csv';
	newkeyname := regexreplace(wordtoreplace,regexreplace('[\r\n]',l.logicalkey,''),'prte');
	normalize_out := demo_data.normkeyfields(datasetname,regexreplace('[\r\n]',l.logicalkey,''),nonprtedate);
	recordlayout := getdfuinfo(regexreplace(datasetname+'_DATE',l.logicalkey,nonprtedate)).fullxml;
	csvorxml := if (regexfind('ataset',recordlayout,NOCASE),'myxml','mycsv');
	modrecordlayout := if (regexfind(',',recordlayout),'RECORD '+regexreplace(',',regexreplace('[{}]',recordlayout,''),';')+' END;',recordlayout);
	self.eclstring :=  regexreplace(':= '+recordsetfield,regexreplace('RECORD',modrecordlayout,recordsetfield + 'RECORD'),':=') + '\n' +
				dsvar + ' := pull(index('+dsname+',{'+regexreplace('^,',normalize_out[1].keyedfields,'')+
				'}'+',{'+dsname+'},\'~'+ regexreplace(datasetname+'_DATE',newkeyname,prtedate)+'\',opt));'
				+ '\n' + ' if (count( ' + dsvar + ') <> 0, ' +
						if (csvorxml = 'myxml',
						'sequential(' +
							'output('+dsvar+',,' + '\'~prte::rebuild::'+xmlfilename+'\',xml,overwrite),' +
							'lib_fileservices.FileServices.Despray('+ '\'~prte::rebuild::'+xmlfilename+'\',_control.IPAddress.edata12,'+'\'/data_999/tkirk/prte_extracts/special/'+xmlfilename+'\',,,,TRUE)));',
						'sequential(' +
							'output(' + dsvar + ',,' + '\'~prte::rebuild::'+csvfilename+'\',csv(separator(' + '\'\\t\'), terminator(' + '\'\\r\\n\'), quote(' + '\'\'), heading(single)),overwrite),' +
							'lib_fileservices.FileServices.Despray(' + '\'~prte::rebuild::'+csvfilename+'\',_control.IPAddress.edata12,' + '\'/data_999/tkirk/prte_extracts/'+csvfilename+'\',,,,TRUE)));'	
							)
						;
end;

buildindex_code_out := project(datasetds,buildindex_code(left,counter));

return buildindex_code_out;

end;