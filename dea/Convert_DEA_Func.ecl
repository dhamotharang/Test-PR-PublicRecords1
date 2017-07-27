import dea;
import text_search;
export Convert_DEA_Func := function

ds := dea.file_dea;
		
dist_ds := distribute(ds,hash(Dea_Registration_Number));

Layout_DEA_record := record(text_search.Layout_Document)
	typeof(ds.dea_registration_number) Dea_Registration_Number;
end;

		
Layout_DEA_record DEA_Convert(dist_ds l) := transform
	self.Dea_Registration_Number := l.Dea_Registration_Number;
	SELF.docRef.src := if(l.state <> '',TRANSFER(l.state, INTEGER2),
								TRANSFER('NA',integer2));
	SELF.docRef.doc := (unsigned6)l.Dea_Registration_Number;
	self.segs := dataset([
	        {1,0,l.Dea_Registration_Number},
        {2,0,l.Business_activity_code},
        {3,0,l.Drug_Schedules},
        {4,0,l.Expiration_Date},
        {5,0,l.address2 + ';' + l.address3 + ';' + l.address4 + ';' + l.address5 + ';' + l.state + ';' + l.zip_code},
        {6,0,if(not l.is_company_flag,l.address1,'')},
				{7,0,if(l.is_company_flag,l.address1,'')}
     
	],Text_search.Layout_segment);
end;

proj_out := project(dist_ds,DEA_Convert(left));

Layout_DEA_Flat := record(text_search.Layout_DocSeg)
	typeof(ds.dea_registration_number) Dea_Registration_Number;
end;

Layout_Dea_flat norm_dea(layout_dea_record l,text_search.Layout_segment r) := transform
	self.dea_registration_number := l.dea_registration_number;
	self.docref := l.docref;
	self := r;
end;

norm_out := normalize(proj_out,left.segs,norm_dea(left,right));

sort_out := sort(norm_out,dea_registration_number,local);

layout_dea_flat iterate_dea(layout_dea_flat l,layout_dea_flat r) := transform
		self.docref.doc := if(l.dea_registration_number = r.dea_registration_number,l.docref.doc,
								if(l.docref.doc = 0,thorlib.node() +1,l.docref.doc + thorlib.nodes()+1));
		self.docref.src := r.docref.src;
		self.sect := if(l.dea_registration_number <> r.dea_registration_number or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;
	
	itr_out := iterate(sort_out,iterate_dea(left,right),local);


retval := itr_out(trim(content) <> '' and trim(content) <> ';');

return retval;
			
end;