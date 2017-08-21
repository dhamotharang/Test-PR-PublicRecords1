import ut,dops;
// dataset - dataset id from DOPS
// filedate - date of build version for prte
// environment - 'N' - nonfcra, F - 'FCRA'
// loc - 'B' - boca, 'A' - Alpharetta
export buildindexcode(string datasetname,string filedate,string environment,string loc) := function	



datasetds := dops.GetRoxieKeys(datasetname,loc,environment,'Y');

buildindex_rec := record,maxlength(30000)
	string eclstring;
end;

buildindex_rec buildindex_code(datasetds l,integer cnt) := transform
	dsname := 'dataset([],arecord' + (string)cnt + ')';
	recordsetfield := 'arecord' + (string)cnt + ':= \n';
	wordtoreplace := ut.Word(regexreplace('[\r\n]',l.logicalkey,''),1,'::');
	newkeyname := regexreplace(wordtoreplace,regexreplace('[\r\n]',l.logicalkey,''),'prte');
	normalize_out := demo_data.normkeyfields(datasetname,regexreplace('[\r\n]',l.logicalkey,''),filedate);
	recordlayout := getdfuinfo(regexreplace(datasetname+'_DATE',l.logicalkey,filedate)).fullxml;
	modrecordlayout := if (regexfind(',',recordlayout),'RECORD '+regexreplace(',',regexreplace('[{}]',recordlayout,''),';')+' END;',recordlayout);
	//nonnormalize_out := demo_data.normnonkeyfields(datasetname,regexreplace('[\r\n]',l.logicalkey,''),filedate);
	self.eclstring :=  regexreplace(':= '+recordsetfield,regexreplace('RECORD',modrecordlayout,recordsetfield + 'RECORD'),':=') + '\n' +
				'buildindex(index('+dsname+',{'+regexreplace('^,',normalize_out[1].keyedfields,'')+
				'}'+',{'+dsname+'},\'keyname\'),\'~' + regexreplace(datasetname+'_DATE',newkeyname,filedate) + '\',update);'
				;
end;

buildindex_code_out := project(datasetds,buildindex_code(left,counter));

return buildindex_code_out;

end;