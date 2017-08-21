import Driversv2,Text_Search,codes;

non_dist_ds := Driversv2.File_DL;

my_ds := distribute(non_dist_ds,hash(dl_seq));

my_rec := record
	my_ds;
	string50 hair_color_desc := '';
	string50 eye_color_desc := '';
	string50 sex_flag_desc := '';
	string50 license_class_desc := '';
	string50 license_type_desc := '';
	string50 rest_desc := '';
	string50 endor_desc := '';
	string50 issuance_desc := '';
	string50 status_desc := '';
	string50 cdl_status_desc := '';
end;


lookup_macro(myds,myrec,lkpds,retds,filename,fieldname,getval,codeval) := macro
	#uniquename(join_lkp)
	myrec %join_lkp%(myds l,lkpds r) := transform
		self.getval := r.long_desc;
		self := l;
	end;
	
	retds := if(filename = 'DRIVERS_LICENSE2',
						join(myds,lkpds(file_name = filename,field_name = fieldname), 
									left.orig_state = right.field_name2 and left.codeval = right.code,
									%join_lkp%(left,right),left outer,lookup,local),
						join(myds,lkpds(file_name = filename,field_name = fieldname), 
								left.codeval = right.code,
									%join_lkp%(left,right),left outer,lookup,local)
							);
	
endmacro;

lookup_macro(my_ds,my_rec,codes.File_Codes_V3_In,hair_color_ds,
							'DRIVERS_LICENSE2','HAIR_COLOR',hair_color_desc,hair_color);
lookup_macro(hair_color_ds,my_rec,codes.File_Codes_V3_In,eye_color_ds,
						'DRIVERS_LICENSE2','EYE_COLOR',eye_color_desc,eye_color);
lookup_macro(eye_color_ds,my_rec,codes.File_Codes_V3_In,sex_flag_ds,
						'GENERAL','GENDER',sex_flag_desc,sex_flag);
lookup_macro(sex_flag_ds,my_rec,codes.File_Codes_V3_In,lic_class_ds,
					'DRIVERS_LICENSE2','LICENSE_CLASS',license_class_desc,license_class);
lookup_macro(lic_class_ds,my_rec,codes.File_Codes_V3_In,lic_type_ds,
					'DRIVERS_LICENSE2','LICENSE_TYPE',license_type_desc,license_type);
lookup_macro(lic_type_ds,my_rec,codes.File_Codes_V3_In,rest_ds,
						'DRIVERS_LICENSE2','RESTRICTIONS',rest_desc,restrictions);
lookup_macro(rest_ds,my_rec,codes.File_Codes_V3_In,endor_ds,
						'DRIVERS_LICENSE2','LIC_ENDORSEMENT',endor_desc,lic_endorsement);
// lookup_macro(endor_ds,my_rec,codes.File_Codes_V3_In,iss_ds,
						// 'DRIVERS_LICENSE2','ISSUANCE',issuance_desc,issuance);
lookup_macro(endor_ds,my_rec,codes.File_Codes_V3_In,status_ds,
						'DRIVERS_LICENSE2','STATUS',status_desc,status);
lookup_macro(status_ds,my_rec,codes.File_Codes_V3_In,ds,
						'DRIVERS_LICENSE2','CDL_STATUS',cdl_status_desc,cdl_status);

Text_Search.Layout_Document convert_dl(ds l) := transform
	self.docref.src := transfer(l.source_code,integer2);
	self.docref.doc := l.dl_seq;
	self.segs := DATASET([
			{1,0,l.name},
			{2,0,l.addr1 + ' ' + l.city + ' ' + l.state + ' ' + l.zip + ';'},
			//{3,0,l.city + ' ' + l.addr1},
			//{4,0,l.state + ' ' + l.addr1},
		//{5,0,l.zip + ' ' + l.addr1},
		{6,0,l.country},
		{7,0,l.province},
		//{8,0,l.postal_code},
		{9,0,';' + l.dob},
		//{10,0,';' + l.dod},
		{11,0,l.ssn},
		//{12,0,l.age},
		{13,0,l.height},
		{14,0,l.hair_color_desc}, // requires lookup
		{15,0,l.eye_color_desc}, // requires lookup
		{16,0,l.weight},
		{17,0,l.sex_flag_desc}, // requires lookup
		{18,0,l.orig_state}, // ???
		{19,0,l.license_class_desc}, // requires lookup
		{20,0,l.license_type_desc}, // requires lookup
		{21,0,l.rest_desc}, // requires lookup
		{22,0,';' + l.orig_expiration_date + ';' + l.expiration_date},
		{23,0,';' + l.orig_issue_date + ';' + l.lic_issue_date},
		//{24,0,';' + l.active_date},
		//{25,0,';' + l.inactive_date},
		{26,0,l.endor_desc}, // requires lookup
		{27,0,l.dl_number},
		{28,0,l.oos_previous_dl_number},
		{29,0,l.oos_previous_st},
		//{30,0,l.issuance_desc}, // requires lookup
 		//{31,0,l.old_dl_number}, 
		{32,0,l.status_desc + ';' + l.cdl_status_desc + ';'} // requires lookup
		], Text_Search.Layout_Segment);
end;

proj_dl_recs := project(ds,convert_dl(left));

Text_Search.Layout_DocSeg norm_recs(Text_search.Layout_Document l,Text_search.Layout_segment r ) := transform
		SELF.docRef := l.docRef;
		SELF := r;
end;

norm_out := normalize(proj_dl_recs,left.segs,norm_recs(left,right));

sort_out := sort(norm_out,docRef,segment,local);


Text_Search.Layout_DocSeg iterate_recs(Text_search.Layout_DocSeg l,Text_search.Layout_DocSeg r) := transform
	self.sect := IF(L.docref.doc <> R.docref.doc OR L.segment <> R.segment, 0, l.sect+1);
	self := r;
end;

itr_full := iterate(sort_out,iterate_recs(left,right),local);

// External key
	
	Text_Search.Layout_DocSeg MakeKeySegs( itr_full l, unsigned2 segno ) := TRANSFORM
		self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := intformat(l.docref.doc,15,1);
        self.sect := 1;
    END;

    segkeys := PROJECT(itr_full,MakeKeySegs(LEFT,250));

	full_ret := itr_full + segkeys;
	

export Convert_DLV2_Func := full_ret;
