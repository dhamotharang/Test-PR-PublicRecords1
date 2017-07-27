// Convert to Document record
// Needs to match BWR_Build_Segment_Metadata
import Text_Search,census_data;
import Liensv2;

export Convert_Liensv2_Func_OPT := function

STRING oItem := '<dataitem>';
STRING cItem := '</dataitem>';
// Main File Dataset

dmain_in := liensv2.file_liens_main;

string_rec := record
	string50 tmsid := '';
string50 rmsid := '';
string process_date := '';
string record_code := '';
string date_vendor_removed := '';
string filing_jurisdiction := '';
string filing_state := '';
string20 orig_filing_number := '';
string orig_filing_type := '';
string orig_filing_date := '';
string orig_filing_time := '';
string case_number   := '';
string20 filing_number := '';
string filing_type_desc := '';
string filing_date := '';
string filing_time := '';
string vendor_entry_date := '';
string judge := '';
string case_title := '';
string filing_book := '';
string filing_page := '';
string release_date := '';
string amount := '';
string eviction := '';
string satisifaction_type := '';
string judg_satisfied_date := '';
string judg_vacated_date := '';
string tax_code := '';
string irs_serial_number := '';
string effective_date := '';
string lapse_date := '';
string accident_date := '';
string sherrif_indc := '';
string expiration_date := '';
string agency :='';
string agency_city :='';
string agency_state :='';
string agency_county :='';
string legal_lot := '';
string legal_block := '';
string legal_borough := '';
string certificate_number := '';
end;

string_rec proj_rec(dmain_in L) := transform
	self := L;
end;

proj_out := project(dmain_in,proj_rec(left));


child_rec := record
	string50 tmsid;
	string50 rmsid;
	string filing_stat := '';
	string filing_desc := '';
end;

child_rec norm_rec(dmain_in L,Liensv2.layout_liens_main_module.layout_filing_status R) := transform
	self.filing_stat := R.filing_status;
	self.filing_desc := R.filing_status_desc;
	self := L;
end;

dchild := normalize(dmain_in,left.filing_status,norm_rec(left,right));


// Document Record Layout which has child dataset (The content is a child dataset)
Text_Liens_Record := record(Text_Search.Layout_Document)
	string50 tmsid;
	//string50 rmsid;
end;

// Document record in flat format (The content is a record)	
Text_Liens_Flat := record(Text_Search.Layout_DocSeg)
	string50 tmsid;
	//string50 rmsid;
end;

// Project necessary main fields to Document record format
Text_Liens_Record cvt(proj_out l) := TRANSFORM
	self.tmsid := l.tmsid;
	//self.rmsid := l.rmsid;
	SELF.docRef.src := TRANSFER(l.tmsid[1..2], INTEGER2);
		SELF.docRef.doc := 0;
		SELF.segs := DATASET([
			{1,0,if(l.filing_state <> '',l.filing_state,if(l.filing_jurisdiction <> '',
							l.filing_jurisdiction,l.agency_state))},
		{2,0,l.orig_filing_number + '; ' + l.filing_number + '; '},
		{3,0,l.filing_type_desc + '; ' + l.orig_filing_type},
		{4,0,l.orig_filing_date + '; ' + l.filing_date + '; '},
		{5,0,l.orig_filing_time + '; ' + l.filing_time + '; '},
		//{6,0,l.filing_stat},
		{6,0,l.filing_type_desc},
		{7,0,l.case_number},
		{8,0,l.judge},
		{9,0,l.case_title},
		{10,0,l.filing_book + '/' + l.filing_page + '; '},
		{11,0,'; ' + l.release_date},
		{12,0,l.amount},
		{13,0,l.eviction},
		{14,0,'; ' +l.judg_satisfied_date},
	//	{15,0,l.suit_date},
		{16,0,'; ' + l.judg_vacated_date},
		{17,0,l.tax_code},
		{18,0,l.irs_serial_number + '; ' + l.certificate_number},
		{19,0,'; ' + l.effective_date},
		{20,0,'; ' + l.lapse_date},
		{40,0,l.agency + ' ' + l.agency_city + ' ' + l.agency_state + ' ' + l.agency_county + 
		      ' ' + l.filing_jurisdiction},
		{41,0,l.certificate_number + '; ' + l.irs_serial_number},
		{249,0,l.process_date}
		], Text_Search.Layout_Segment);
END;

proj_main_seg := PROJECT(proj_out, cvt(LEFT));

Text_Liens_Record cvt_child(dchild l) := TRANSFORM
	self.tmsid := l.tmsid;
	//self.rmsid := l.rmsid;
	SELF.docRef.src := TRANSFER(l.tmsid[1..2], INTEGER2);
		SELF.docRef.doc := 0;
		SELF.segs := DATASET([
			{6,0,l.filing_desc}
		], Text_Search.Layout_Segment);
END;

proj_child := PROJECT(dchild(filing_desc <> ''), cvt_child(LEFT));

// Party File Dataset
// dparty := Liensv2.File_Liens_Party;

// Bug# 32525
get_recs := LiensV2.file_liens_party;

liensv2.layout_liens_party tformat(liensv2.layout_liens_party_ssn_Bid L) := transform

self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
self.tax_id := if(L.tax_id <> '', if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
self := L;

end;

pre_dparty := project(get_recs, tformat(left));

// Bug # 40061 - explode county names

add_county_name_recs := record
	liensv2.layout_liens_party;
	string orig_county_name := '';
end;

add_county_name_recs join_county_recs(pre_dparty l,census_data.File_Fips2County r) := transform
	self := l;
	self.orig_county_name := r.county_name;
end;

dparty := join(pre_dparty,census_data.File_Fips2County,
				left.county[1..2] = right.state_fips and
				left.county[3..5] = right.county_fips,
				join_county_recs(left,right),
				left outer,
				lookup);



// Project necessary Party fields to Document record format

Text_liens_record Join_Liens(dparty r) := Transform
	  self.tmsid := r.tmsid;
		//self.rmsid := r.rmsid;
		SELF.docRef.src := TRANSFER(r.tmsid[1..2], INTEGER2);
		SELF.docRef.doc := 0;
    SELF.segs := Dataset([
			{21,0,if(r.name_type = 'D',r.orig_name + ' ' + r.orig_fname + ' ' + r.orig_mname + ' ' + r.orig_lname + '; ','')},
		{22,0,if(r.name_type = 'D',r.tax_id,'')},
		{23,0,if(r.name_type = 'D',r.ssn,'')},
		{24,0,if(r.name_type = 'D',r.orig_address1 + ' ' + r.orig_address2 + ' ' + r.orig_county_name + ' ' + 'COUNTY' +
										' ' + r.orig_city + ' ' + r.orig_state + ' ' + r.orig_country +
										' ' + r.orig_zip5 + '-' + r.orig_zip4 + '; ','')},
		//{25,0,if(r.name_type = 'D',r.orig_city + '; ','')},
		//{26,0,if(r.name_type = 'D',r.orig_state + '; ','')},
		//{27,0,if(r.name_type = 'D',r.orig_zip5 + '-' + r.orig_zip4 + '; ','')},
		//{29,0,if(r.name_type = 'D',r.orig_country + '; ','')},
		{30,0,if(r.name_type = 'C',r.orig_name + ' ' + r.orig_fname + ' ' + r.orig_mname + ' ' + r.orig_lname + '; ','')},
		{31,0,if(r.name_type = 'C',r.orig_address1 + ' ' + r.orig_address2 +  ' ' + r.orig_county_name + ' ' + 'COUNTY' + 
										' ' + r.orig_city + ' ' + r.orig_state + ' ' + r.orig_country +
										' ' + r.orig_zip5 + '-' + r.orig_zip4 + '; ','')},
		//{32,0,if(r.name_type = 'C',r.orig_city + '; ','')},
		//{33,0,if(r.name_type = 'C',r.orig_state + '; ','')},
		//{34,0,if(r.name_type = 'C',r.orig_zip5 + '-' + r.orig_zip4 + '; ','')},
		//{36,0,if(r.name_type = 'C',r.orig_country,'')},
		{37,0,if(r.name_type = 'A','; ' + r.orig_name,'')},
		{38,0,if(r.name_type = 'A','; ' + r.orig_address1 + ' ' + r.orig_address2 + ' ' + r.orig_city + ' '  + r.orig_county_name + ' ' + 'COUNTY' + ' ' +
						r.orig_state + ' ' + r.orig_zip5 + '-' + r.orig_zip4,'')},
		{39,0,r.phone},
		{42,0,if(r.name_type = 'T','; ' + r.orig_name,'')},
		{43,0,if(r.name_type = 'T','; ' + r.orig_address1 + ' ' + r.orig_address2 + ' ' + r.orig_city + ' '  + r.orig_county_name + ' ' + 'COUNTY' +' ' +
						r.orig_state + ' ' + r.orig_zip5 + '-' + r.orig_zip4,'')}
		],Text_Search.Layout_Segment);
		self := r;
end;
	
proj_party_seg := project(dparty,join_liens(left));

// Funnel Party and Main
dist_liens := distribute(proj_main_seg + proj_Party_seg + proj_child,hash32(tmsid));

// Distribute full file (tmsid,rmsid) since both datasets are concatenated
//dist_liens := distribute(Join_Liens_Record,hash(tmsid));

// Normalize records to flatten the segs field
Text_Liens_Flat flat1(Text_Liens_Record l, Text_Search.Layout_Segment r) 
	:= TRANSFORM
		SELF.docRef := l.docRef;
		SELF.tmsid 	:= l.tmsid;
	//	SELF.rmsid	:= l.rmsid;
		SELF := r;
END;
	
norm_liens := NORMALIZE(dist_liens, LEFT.segs, flat1(LEFT,RIGHT));

sort_norm_liens := sort(norm_liens,tmsid/*,rmsid*/,segment,record,local);
							

// populate document id and section
Text_Liens_flat Iterate_doc(Text_Liens_flat L,Text_Liens_flat R) 
	:= Transform
		self.DocRef.doc := if(L.tmsid = R.tmsid, L.docref.doc,
													if (L.docref.doc = 0,thorlib.node()+1,L.DocRef.doc + thorlib.nodes()));
		self.sect := IF(L.tmsid<>R.tmsid OR L.segment<>R.segment, 0, l.sect+1);
		self.docRef.src := r.docRef.src;
		self := R;
end;

iterate_liens := iterate(sort_norm_liens,Iterate_doc(left,right),local);

// External key
	
	text_liens_Flat MakeKeySegs( iterate_liens l, unsigned2 segno ) := TRANSFORM
		self.tmsid := l.tmsid;
		//self.rmsid := l.rmsid;
        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := l.tmsid;
        self.sect := 1;
    END;

    segkeys := PROJECT(iterate_liens,MakeKeySegs(LEFT,250));

	full_ret := segkeys + iterate_liens;


return full_ret;
 
END;