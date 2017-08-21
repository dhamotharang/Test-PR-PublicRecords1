import Text_Search;
import uccv2;

export Convert_uccv2_Func := function


// if filing jurisdiction is blank populate it with orig state from party file.
dmain_in := uccv2.File_UCC_Main_Base;
in_party := uccv2.File_UCC_Party_Base;

UCCV2.Layout_UCC_Common.Layout_ucc join_recs(dmain_in l, in_party r) := transform
	self.filing_jurisdiction := if ( l.filing_jurisdiction <> '', l.filing_jurisdiction, r.orig_state);
	self := l;
end;

dmain := join(dmain_in,in_party,left.tmsid = right.tmsid and left.rmsid = right.rmsid,
				join_recs(left,right),
				left outer,
				local
				);

// Document Record Layout which has child dataset (The content is a child dataset)
Text_ucc_Record := record(Text_Search.Layout_Document)
	typeof(uccv2.File_UCC_Main_Base.tmsid) tmsid;
	typeof(uccv2.File_UCC_Main_Base.rmsid) rmsid;
end;

// Document record in flat format (The content is a record)	
Text_ucc_Flat := record(Text_Search.Layout_DocSeg)
	typeof(uccv2.File_UCC_Main_Base.tmsid) tmsid;
	typeof(uccv2.File_UCC_Main_Base.rmsid) rmsid;
end;


// Project necessary main fields to Document record format
Text_ucc_Record cvt(dmain l) := TRANSFORM
	self.tmsid := l.tmsid;
	self.rmsid := l.rmsid;
	SELF.docRef.src := TRANSFER('UC', INTEGER2);
		SELF.docRef.doc := 0;
		SELF.segs := DATASET([
			{1,0,l.orig_filing_number + ';' + l.filing_number},
		{2,0,l.orig_filing_type + '; ' + l.filing_type},
		{3,0,l.orig_filing_date + '; ' + l.filing_date},
		{4,0,l.orig_filing_time + '; ' + l.filing_time},
		{5,0,l.status_type},
		{6,0,l.page},
		{7,0,l.expiration_date},
		{8,0,l.contract_type},
		{9,0,l.statements_filed},
		{10,0,l.amount},
		{11,0,l.irs_serial_number},
		{12,0,l.effective_date},
		{29,0,l.signer_name},
		{30,0,l.filing_agency + ';' + l.address + ' ' + l.city + ' ' + l.state + ' ' + l.county + ' ' + l.zip},
		{31,0,l.description},
		{32,0,l.collateral_desc + ' ' + l.prim_machine + ' ' +
					l.sec_machine + ' ' + l.manufacturer_code + ' ' +
					l.manufacturer_name + ' ' + l.model + ' ' + l.model_year + ' ' + 
					l.model_desc + ' ' + l.manufactured_year + ' ' + l.serial_number},
		{33,0,l.borough},
		{34,0, l.block},
		{35,0, l.lot},
		{36,0,l.collateral_address},
		{37,0,l.filing_jurisdiction},
		{249,0,l.process_date}
		], Text_Search.Layout_Segment);
END;

proj_main_seg := PROJECT(dmain, cvt(LEFT));


// Party File Dataset
dparty := uccv2.File_ucc_Party_base;

// Project necessary Party fields to Document record format

Text_ucc_record Join_ucc(dparty r) := Transform
	  self.tmsid := r.tmsid;
		self.rmsid := r.rmsid;
		SELF.docRef.src := TRANSFER('UC', INTEGER2);
		SELF.docRef.doc := 0;
    SELF.segs := Dataset([
			{13,0,if(r.party_type = 'D',r.orig_name + ';' + r.orig_fname + ' ' + r.orig_mname + ' ' + r.orig_lname + '; ','')},
		{14,0,r.ssn},
		{15,0,r.fein},
		{16,0,if(r.party_type = 'D',r.orig_address1 + ' ' + r.orig_address2 + 
										' ' + r.orig_city + ' ' + r.orig_state + ' ' + r.orig_country +
										' ' + r.orig_zip5 + '-' + r.orig_zip4 + '; ','')},
		//{17,0,if(r.party_type = 'D',r.orig_city + '; ','')},
		//{18,0,if(r.party_type = 'D',r.orig_state + '; ','')},
		{19,0,r.orig_country + '; '},
		{20,0,r.orig_province + '; '},
		{21,0,if(r.party_type = 'S',r.orig_name + ';' + r.orig_fname + ' ' + r.orig_mname + ' ' + r.orig_lname + '; ','')},
		{22,0,if(r.party_type = 'S',r.orig_address1 + ' ' + r.orig_address2 + 
										' ' + r.orig_city + ' ' + r.orig_state + ' ' + r.orig_country +
										' ' + r.orig_zip5 + '-' + r.orig_zip4 + ';','')},
		{23,0,if(r.party_type = 'A',r.orig_name + ';' + r.orig_fname + ' ' + r.orig_mname + ' ' + r.orig_lname,'')},
		{24,0,if(r.party_type = 'A',r.orig_address1 + ' ' + r.orig_address2 + ' ' + r.orig_city + ' '  + 
						r.orig_state + ' ' + r.orig_zip5 + '-' + r.orig_zip4,'')}
		],Text_Search.Layout_Segment);
		self := r;
end;
	
proj_party_seg := project(dparty,join_ucc(left));

// Funnel Party and Main
dist_ucc := distribute(proj_main_seg + proj_Party_seg,hash(tmsid));

// Distribute full file (tmsid,rmsid) since both datasets are concatenated
//dist_ucc := distribute(Join_ucc_Record,hash(tmsid));

// Normalize records to flatten the segs field
Text_ucc_Flat flat1(Text_ucc_Record l, Text_Search.Layout_Segment r) 
	:= TRANSFORM
		SELF.docRef := l.docRef;
		SELF.tmsid 	:= l.tmsid;
		SELF.rmsid	:= l.rmsid;
		SELF := r;
END;
	
norm_ucc := NORMALIZE(dist_ucc, LEFT.segs, flat1(LEFT,RIGHT));

sort_norm_ucc := sort(norm_ucc,tmsid,rmsid,segment,record,local);
							

// populate document id and section
Text_ucc_flat Iterate_doc(Text_ucc_flat L,Text_ucc_flat R) 
	:= Transform
		self.DocRef.doc := if(L.tmsid = R.tmsid, L.docref.doc,
													if (L.docref.doc = 0,thorlib.node()+1,L.DocRef.doc + thorlib.nodes()));
		self.sect := IF(L.tmsid<>R.tmsid OR L.segment<>R.segment, 0, l.sect+1);
		self.docRef.src := r.docRef.src;
		self := R;
end;

iterate_ucc := iterate(sort_norm_ucc,Iterate_doc(left,right),local);

// External key
	
	text_ucc_Flat MakeKeySegs( iterate_ucc l, unsigned2 segno ) := TRANSFORM
		self.tmsid := l.tmsid;
		self.rmsid := l.rmsid;
        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := l.tmsid;
        self.sect := 1;
    END;

    segkeys := PROJECT(iterate_ucc,MakeKeySegs(LEFT,250));

	full_ret := segkeys + iterate_ucc;

return full_ret(trim(content) <> '' and trim(content) <> ';');
 
END;