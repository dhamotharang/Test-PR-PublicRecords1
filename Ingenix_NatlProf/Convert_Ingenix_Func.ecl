import ingenix_natlprof;
import text_search;
export Convert_ingenix_Func := function

ds := ingenix_natlprof.Basefile_Sanctions;
		
dist_ds := distribute(ds,hash(sanc_id));

Layout_ingenix_record := record(text_search.Layout_Document)
	typeof(ds.sanc_id) sanc_id;
end;

		
Layout_ingenix_record ingenix_Convert(dist_ds l) := transform
	self.sanc_id := l.sanc_id;
	SELF.docRef.src := TRANSFER(l.sanc_state, INTEGER2);
	SELF.docRef.doc := 0;
	self.segs := dataset([
	        {1,0,l.sanc_provtype},
        {2,0,l.sanc_licnbr},
        {3,0,l.sanc_lnme + ',' + l.sanc_fnme + ' '+ l.SANC_MID_I_NM},
        {4,0,l.sanc_street + ' ' + l.sanc_city + ' ' + l.sanc_state + ' ' + l.sanc_zip + ' ' + l.sanc_cntry},
        //{5,0,l.phonenumber},
				{6,0,l.sanc_dob},
				{7,0,l.sanc_sancdte_form},
				{8,0,l.sanc_sancst},
				{9,0,l.sanc_reas},
				{10,0,l.sanc_id},
				{11,0,l.sanc_cond + ';' + l.sanc_fines},
				{12,0,l.sanc_type + ';' + l.sanc_terms},
				{13,0,l.sanc_updte_form},
				{14,0,l.sanc_upin},
				{15,0,l.sanc_tin},
				{33,0,l.sanc_tin}, // bug# 33503
				{34,0,l.sanc_sancst}


     
	],Text_search.Layout_segment);
end;

proj_out := project(dist_ds,ingenix_Convert(left));

Layout_ingenix_Flat := record(text_search.Layout_DocSeg)
	typeof(ds.sanc_id) sanc_id;
end;

Layout_ingenix_flat norm_ingenix(layout_ingenix_record l,text_search.Layout_segment r) := transform
	self.sanc_id := l.sanc_id;
	self.docref := l.docref;
	self := r;
end;

norm_out := normalize(proj_out,left.segs,norm_ingenix(left,right));

sort_out := sort(norm_out,sanc_id,local);

layout_ingenix_flat iterate_ingenix(layout_ingenix_flat l,layout_ingenix_flat r) := transform
		self.docref.doc := if(l.sanc_id = r.sanc_id,l.docref.doc,
								if(l.docref.doc = 0,thorlib.node() +1,l.docref.doc + thorlib.nodes()+1));
		self.docref.src := r.docref.src;
		self.sect := if(l.sanc_id <> r.sanc_id or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;
	
	itr_out := iterate(sort_out,iterate_ingenix(left,right),local);


	// External key
	
	layout_ingenix_flat MakeKeySegs( itr_out l, unsigned2 segno ) := TRANSFORM
		self.sanc_id := l.sanc_id;
        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := 'S' + l.sanc_id;
        self.sect := 1;
    END;

    segkeys := PROJECT(itr_out(trim(content) <> '' and trim(content) <> ';'),MakeKeySegs(LEFT,250));

	full_ret := itr_out(trim(content) <> '' and trim(content) <> ';') + segkeys;
	
	return full_ret;
			
end;