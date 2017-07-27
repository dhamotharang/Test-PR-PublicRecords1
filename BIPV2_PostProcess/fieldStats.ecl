import strata, BIPV2_Files,BIPv2_HRCHY,BIPV2;

EXPORT fieldStats(

   dataset(BIPV2.CommonBase.layout ) pInfile  = BIPV2.CommonBase.DS_CLEAN

) := module

export fieldPopulation_rec 			:= Strata.macf_Pops(pinfile,,,,,,,,true);              // this will do population statistics on the whole dataset(not grouping on any field) for every field

fieldPopulation_entity0 				:= Strata.macf_Pops(pinfile,'proxid',,,,,,,true);              //this will group by proxid and do stats on all fields
export fieldPopulation_entity 	:= Strata.macf_Pops(fieldPopulation_entity0,,,,,,,['countgroup'],true);              //this will group by proxid and do stats on all fields

/* ------------------------------------------- */
// Count unique identifier
/* ------------------------------------------- */
shared proxFile := project(pinfile, BIPV2_PostProcess.layouts.slim_layout_v1) : persist('~thor::BIPV2_PostProcess::fieldStats');

rec := record
	unsigned6 id;
end;

getCount(dataset(rec) slimInput, string10 fieldName) := module
	op := record
		string10  UniqueID;
		unsigned6 cnt;
	end;
	
	d1 := distribute(slimInput(id > 0), id);
	s1 := dedup(sort(d1, id, local), id, local);
	idCount := count(s1);
	
	output(choosen(d1, 100), named(fieldName));
	export result := dataset([{fieldName, idCount}], op);
	// return result;	
end;

empid 	:= getCount(project(proxFile, transform(rec, self.id := left.empid)), 'EMPID').result;
powid 	:= getCount(project(proxFile, transform(rec, self.id := left.powid)), 'POWID').result;
proxid 	:= getCount(project(proxFile, transform(rec, self.id := left.proxid)), 'PROXID').result;
sele 		:= getCount(project(proxFile, transform(rec, self.id := left.seleid)), 'SELEID').result;
lgid3 	:= getCount(project(proxFile, transform(rec, self.id := if(left.cnt_prox_per_lgid3>1, left.lgid3, SKIP))), 'LGID3').result;
orgid 	:= getCount(project(proxFile, transform(rec, self.id := left.orgid)), 'ORGID').result;
ultid 	:= getCount(project(proxFile, transform(rec, self.id := left.ultid)), 'ULTID').result;

export uniqueIDCounts := empid + powid + proxid + sele + lgid3 + orgid + ultid;

/* -------------------------------------------  */
// Count unique identifier
/* -------------------------------------------  */
shared distRec := record
	string20 fieldName;
	string8  val;
end;

shared op := record
	distRec;
	unsigned4  total;
	string20 field1;
	string20 field2;
end;

shared getFieldDist(dataset(distRec) slimInput, string20 codeName) := module

	d1 := distribute(slimInput(val != ''), hash32(val));
	
	r1 := table(sort(d1, val, local), {fieldName, val, unsigned4 cnt:=count(group)}, val, local);
	r2 := table(sort(r1,  val), {fieldName, val, unsigned4 total:=sum(group,cnt)}, val);	
	
	r3 := project(r2, transform(op, self.field1 := trim(left.val)[1..4], self.field2 := trim(left.val)[5..], self := left));
	s1 := sort(r3, fieldname, field1, field2);	
	
	output(s1, named(codeName), all);
	export result := s1;
	// return result;	
end;

shared sic1 	:= getFieldDist(project(proxFile, transform(distRec, self.val := left.company_sic_code1, self.fieldName := 'SICCode1')), 'SICCode1').result;
shared sic2   := getFieldDist(project(proxFile, transform(distRec, self.val := left.company_sic_code2, self.fieldName := 'SICCode2')), 'SICCode2').result;
shared sic3 	:= getFieldDist(project(proxFile, transform(distRec, self.val := left.company_sic_code3, self.fieldName := 'SICCode3')), 'SICCode3').result;
shared sic4 	:= getFieldDist(project(proxFile, transform(distRec, self.val := left.company_sic_code4, self.fieldName := 'SICCode4')), 'SICCode4').result;
shared sic5 	:= getFieldDist(project(proxFile, transform(distRec, self.val := left.company_sic_code5, self.fieldName := 'SICCode5')), 'SICCode5').result;

shared naics1 	:= getFieldDist(project(proxFile, transform(distRec, self.val := left.company_naics_code1, self.fieldName := 'NAICSCode1')), 'NAICSCode1').result;
shared naics2   := getFieldDist(project(proxFile, transform(distRec, self.val := left.company_naics_code2, self.fieldName := 'NAICSCode2')), 'NAICSCode2').result;
shared naics3 	:= getFieldDist(project(proxFile, transform(distRec, self.val := left.company_naics_code3, self.fieldName := 'NAICSCode3')), 'NAICSCode3').result;
shared naics4 	:= getFieldDist(project(proxFile, transform(distRec, self.val := left.company_naics_code4, self.fieldName := 'NAICSCode4')), 'NAICSCode4').result;
shared naics5 	:= getFieldDist(project(proxFile, transform(distRec, self.val := left.company_naics_code5, self.fieldName := 'NAICSCode5')), 'NAICSCode5').result;

export sicCounts := sic1 + sic2 + sic3 + sic4 + sic5;
export naicsCounts := naics1 + naics2 + naics3 + naics4 + naics5;

end;