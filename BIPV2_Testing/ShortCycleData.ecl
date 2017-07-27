EXPORT ShortCycleData := MODULE
import ut;

/*
prioritized:



DNB_FEIN
---gap---
Watercraft
LNCA
---gap---
Aircraft

BLOCKED (still in priority order):
MVR (vehicle key not matching.  julie looking)


DONE:
Judgement
Real Property
Corp SOS
UCC
Bankruptcy
D&B
EBR (the two index method)
Fictitious Business (the two index method)
Accutrend (aka busreg, but it seems to have a source_rec_id mismatch so nothing gets scored)
*/

// export rawp_rec := {BIPV2_Testing.ShortCycleDataRaw2,unsigned6 ultid,unsigned6 orgid,unsigned6 seleid, string mtype};
export rawp_rec := {BIPV2_Testing.ShortCycleDataRaw3,unsigned6 ultid,unsigned6 orgid,unsigned6 seleid, string mtype};

export RawP_QA :=
project(
	// BIPV2_Testing.ShortCycleDataRaw._all,
	// BIPV2_Testing.ShortCycleDataRaw2,
	BIPV2_Testing.ShortCycleDataRaw3,
	transform(
		rawp_rec,
		self.ultid := (unsigned6)left.src_id3,//yeah, these two numbers (src_id3 and src_id2) seem backwards, but they are right according to QA xls
		self.orgid := (unsigned6)left.src_id2,
		self.seleid := (unsigned6)left.id4,//proxid is left.src_id1
		self.mtype := 	
		map(
			left.status in ['GOOD','MISSING']	=> 'G',
			left.status = 'BAD' => 'B',
			left.status = 'DISABLED' => 'D',
			''
		),
		self := left
	)
)(mtype <> '');

export RawP_Test := project(BIPV2_Testing.ShortCycleDataTest, transform(rawp_rec, self := left, self := []));

export RawP :=
if(
	BIPV2_Testing.Constants.SC.Settings.UseQAData,
	RawP_QA,
	RawP_Test
);

//**********  PROP  **************

prop_rec := record
	string fid;
	unsigned6 seleid;
	string1 mtype := '';//match type (G,B, or empty)
end;


// This is my test data

// prop_bad := dataset([
 // {'RA2058295660',102645263}
// ,{'DA0349287918',102645263}
// ], prop_rec);

// prop_good := dataset([
 // {'OA0586463517', 147604838} //these reported missing by QA, note one proxid
// ,{'OA0735380831',147604838}
// ,{'OA0885953379',147604838}

// ,{'RA2058295660',102101972} //looks like this one case is fixed
// ,{'DA0349287918',102101972} //looks like this one case is fixed


// ,{'DD0066657386',13}
// ,{'DA0279807577',93}
/*just assuming these from the index are correct enough for testing*/
// ], prop_rec);

// prop_disabled := dataset([
 // {'DA0000000022',0}//this one is really 0 in the data
// ,{'DA0349287932',0}//these two are not
// ,{'DA0349287930',0}//
// ], prop_rec);

// prop_all := 
	// project(prop_bad, 			transform(prop_rec, self.mtype := 'B', self := left)) 
	// + project(prop_good,		transform(prop_rec, self.mtype := 'G', self := left))
	// + project(prop_disabled,transform(prop_rec, self.mtype := 'D', self := left));
	
// export Prop := prop_all;


export Prop :=
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.prop),
	transform(
		prop_rec,
		self.fid := left.id1,
		self := left
	)
)(fid <> '');




//**********  DNBFEIN  **************

dnbfein_rec := record
	string tmsid;
	unsigned6 ultid;
	unsigned6 orgid;
	unsigned6 seleid;
	string1 mtype := '';
end;

export dnbfein := 
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.dnbfein),
	transform(
		dnbfein_rec,
		self.tmsid := left.id1,
		self := left
	)
);



//**********  Accutrend  **************

accu_rec := record
	string source_rec_id;
	unsigned6 ultid;
	unsigned6 orgid;
	unsigned6 seleid;
	string1 mtype := '';
end;

export accu := 
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.accu),
	transform(
		accu_rec,
		self.source_rec_id := left.id1,
		self := left
	)
);

//**********  LNCA  **************

LNCA_rec := record
	string root;
	string sub;
	unsigned6 ultid;
	unsigned6 orgid;
	unsigned6 seleid;
	string1 mtype := '';
end;

export LNCA := 
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.lnca),
	transform(
		LNCA_rec,
		
		self.root	:= intformat((unsigned)left.id1,9,1),
		self.sub		:= intformat((unsigned)left.id2,4,1),		
		
		self := left
	)
);




//**********  FBN  **************

fbn_rec := record
	string tmsid;
	string rmsid;
	unsigned6 ultid;
	unsigned6 orgid;
	unsigned6 seleid;
	string1 mtype := '';
end;

export fbn := 
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.fbn),
	transform(
		fbn_rec,
		self.tmsid := left.id1,
		self.rmsid := left.id2,
		self := left
	)
);


//**********  EBR  **************

ebr_rec := record
	string file_number;
	unsigned6 ultid;
	unsigned6 orgid;
	unsigned6 seleid;
	string1 mtype := '';
end;

export ebr := 
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.ebr),
	transform(
		ebr_rec,
		self.file_number := left.id1,
		self := left
	)
);

//**********  DBDMI  **************

dbdmi_rec := record
	string duns_number;
	unsigned6 seleid;
	string1 mtype := '';
end;

export dbdmi := 
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.dbdmi),
	transform(
		dbdmi_rec,
		self.duns_number := left.id1,
		self := left
	)
);




//**********  BK  **************

bk_rec := record
	string tmsid;
	unsigned6 seleid;
	string1 mtype := '';
end;

export bk := 
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.bk),
	transform(
		bk_rec,
		self.tmsid := left.id1,
		self := left
	)
);




//**********  UCC  **************

ucc_rec := record
	string tmsid;
	unsigned6 seleid;
	string1 mtype := '';
end;

export ucc := 
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.ucc),
	transform(
		ucc_rec,
		self.tmsid := left.id1,
		self := left
	)
);


//**********  MVR  **************

mvr_rec := record
	string vk;
	string ik;
	string sk;
	unsigned6 seleid;
	string1 mtype := '';
end;//vehicle_key		iteration_key		sequence_key

export mvr :=
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.mvr),
	transform(
		mvr_rec,
		self.vk := left.id1[1..15],//workaround bug 140309
		self.ik := left.id2,
		self.sk := left.id3,
		self := left
	)
);
											
//**********  LJ  **************
import LiensV2;
lj_rec := record
	string tmsid;
	string tmsid2;
	unsigned6 seleid;
	string1 mtype := '';
end;

export LJ := 
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.lj),
	transform(
		lj_rec,
		self.tmsid := left.id1;
		self.tmsid2 := TRIM(left.id1[1..2]) + (STRING)HASH(left.id1 + LiensV2.Key_liens_party_ID_linkids(keyed(tmsid = left.id1))[1].rmsid); 
		self := left
	)
) : persist('~thor_data400::BIPV2_Testing.ShortCycleData.lj');


//**********  CORP  **************


corp_rec := record
	string ck;
	unsigned6 seleid;
	string1 mtype := '';
end;

// corp_all := dataset([
 // {'12-M25316', 105857216,				'G'} //these part of rms set
// ,{'12-S54220',	105857216,			'G'}
// ,{'06-199608810035',106751584,	'G'}

// ], corp_rec);

// export Corp := corp_all;

export Corp :=
project(
	RawP(datasource_name in BIPV2_Testing.Constants.SC.DSNames.corp),
	transform(
		corp_rec,
		self.ck := left.id1,
		self := left
	)
);

END;