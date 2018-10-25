import fcc;
import text_search;

export Convert_fcc_Func := function
	
	ds := distribute(fcc.File_fcc_Base,hash(fcc_seq));

	
	text_search.Layout_document convert_fcc(ds l) := transform
		self.docref.doc := l.fcc_seq;
		self.docref.src := transfer(l.licensees_state,integer2);
		self.segs := dataset([
							{1,0,l.licensees_name},
							{2,0,l.dba_name},
							{3,0,l.licensees_attention_line + ' ' + l.licensees_street + ' ' + l.licensees_city + ' ' +
										l.licensees_state + ' ' +	l.licensees_zip},
							//{4,0,l.licensees_city + ';' + l.contact_firms_city},
							//{5,0,l.licensees_state + ';' + l.contact_firms_state},
							//{6,0,l.licensees_zip + ';' + l.contact_firms_zipcode},
							{7,0,l.licensees_phone + ';' + l.contact_firms_phone_number },
							{8,0,l.contact_firms_street_address},
							{9,0,l.contact_firms_fax_number },
							{10,0,l.callsign_of_license},
							{11,0,l.license_type},
							{12,0,l.file_number},
							{13,0,l.date_application_received_at_FCC},
							{14,0,l.date_license_issued},
							{15,0,l.date_license_expires},
							{16,0,l.date_of_last_change},
							{17,0,l.pending_or_granted + ';' + l.paging_license_status}
		],text_search.Layout_Segment)
	end;

	proj_out := project(ds,convert_fcc(left));
	
	text_search.Layout_DocSeg norm_recs(proj_out l,text_search.Layout_Segment r) := transform
			self.docref := l.docref;
			self := r;
	end;
	
	norm_out := normalize(proj_out,left.segs,norm_recs(left,right));

	sort_out := sort(norm_out,docref.doc,local);
	
	text_search.Layout_DocSeg iterate_recs(text_search.Layout_DocSeg l,text_search.Layout_DocSeg r) := transform
		self.docref := r.docref;
		self.sect := if(l.docref.doc <> r.docref.doc or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;

	iterate_out := iterate(sort_out,iterate_recs(left,right),local);

	// External key
	
	text_search.Layout_DocSeg MakeKeySegs( iterate_out l, unsigned2 segno ) := TRANSFORM
	    self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := intformat(l.docref.doc,15,1);
        self.sect := 1;
    END;

    segkeys := PROJECT(iterate_out(trim(content) <> '' and trim(content) <> ';'),MakeKeySegs(LEFT,250));

	full_ret := iterate_out(trim(content) <> '' and trim(content) <> ';') + segkeys;
	
	return full_ret;
	
end;