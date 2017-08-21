import prof_licensev2;
import text_search;
export Convert_proflic_Func := function

ds := Prof_Licensev2.File_ProfLic_Base;
		
dist_ds := distribute(ds,hash(prolic_seq_id));

text_search.Layout_document prolic_Convert(dist_ds l) := transform
	SELF.docRef.src := TRANSFER(l.source_st, INTEGER2);
	SELF.docRef.doc := l.prolic_seq_id;
	self.segs := dataset([
	       {1,0,l.profession_or_board},
       {2,0,l.license_type + ';' + l.previous_license_type},
        {3,0,l.orig_license_number + ';' + l.license_number + ';' + l.previous_license_number},
        {4,0,l.orig_name},
        {5,0,';' + l.orig_former_name},
				{6,0,l.orig_addr_1 + ' ' + l.orig_addr_2 + ' ' + l.orig_addr_3 + ' ' + 
							l.orig_addr_4 + ' ' + l.orig_city +  ' ' + l.orig_st + ' ' + l.orig_zip +  ' ' + l.country_str},
				//{7,0,l.orig_city + ';' + l.additional_orig_city},
				//{8,0,l.orig_st + ';' + l.additional_orig_st},
				//{9,0,l.orig_zip + ';' + l.additional_orig_zip},
				{10,0,l.phone + ';' + l.additional_phone},
				{11,0,l.sex},
				{12,0,l.dob},
				{13,0,l.issue_date},
				{14,0,l.expiration_date},
				{15,0,l.last_renewal_date},
				{16,0,l.action_complaint_violation_desc},
				{17,0,l.action_complaint_violation_dt},
				{18,0,l.action_effective_dt},
				{19,0,l.action_desc},
				{20,0,l.action_status},
				{21,0,l.action_posting_status_dt},
				{22,0,';' + l.additional_orig_name},
				{23,0,l.additional_orig_additional_1 + ' ' + l.additional_orig_additional_2 + ' ' +
				l.additional_orig_additional_3 + ' ' + l.additional_orig_additional_4 + ' ' + 
				l.additional_orig_city + ' ' + l.additional_orig_st + ' ' + l.additional_orig_zip},
				{24,0,l.misc_email},
				{25,0,l.misc_fax},
				{26,0,l.misc_web_site},
				{27,0,l.best_ssn},
				{36,0,l.best_ssn}, // populate tax-id field as well with ssn bug# 33503
				{37,0,l.source_st},
				{38,0,l.company_name},
				{39,0,l.status}
				
				

     
	],Text_search.Layout_segment);
end;

proj_out := project(dist_ds,prolic_Convert(left));


text_search.Layout_DocSeg norm_prolic(text_search.Layout_Document l,text_search.Layout_segment r) := transform
	self.docref := l.docref;
	self := r;
end;

norm_out := normalize(proj_out,left.segs,norm_prolic(left,right));

sort_out := sort(norm_out,docref.doc,local);

text_search.Layout_DocSeg iterate_prolic(text_search.Layout_DocSeg l,text_search.Layout_DocSeg r) := transform
		self.docref.src := r.docref.src;
		self.sect := if(l.docref.doc <> r.docref.doc or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;
	
	itr_out := iterate(sort_out,iterate_prolic(left,right),local);


	// External key
	
	text_search.Layout_DocSeg MakeKeySegs( itr_out l, unsigned2 segno ) := TRANSFORM
		self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := 'L' + intformat(l.docRef.doc,15,1);
        self.sect := 1;
    END;

    segkeys := PROJECT(itr_out(trim(content) <> '' and trim(content) <> ';'),MakeKeySegs(LEFT,250));

	full_ret := itr_out(trim(content) <> '' and trim(content) <> ';') + segkeys;
	
	return full_ret;
			
end;