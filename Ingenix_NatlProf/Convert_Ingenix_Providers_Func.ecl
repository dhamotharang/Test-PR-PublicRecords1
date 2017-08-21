import ingenix_natlprof;
import text_search;
export Convert_ingenix_providers_Func := function

ds := ingenix_natlprof.Basefile_Provider_Did;
ds1 := ingenix_natlprof.Basefile_ProviderLicense;
ds2 := ingenix_natlprof.Basefile_Group_BDID;
ds3 := ingenix_natlprof.Basefile_ProviderUPIN;
		
dist_ds := distribute(ds,hash(providerid));
dist_ds1 := distribute(ds1,hash(providerid));
dist_ds2 := distribute(ds2,hash(providerid));
dist_ds3 := distribute(ds3,hash(providerid));

Layout_ingenix_record := record(text_search.Layout_Document)
	typeof(dist_ds.providerid) providerid;
end;

		
Layout_ingenix_record ingenix_Convert(dist_ds l) := transform
	self.providerid := l.providerid;
	SELF.docRef.src := TRANSFER(l.state, INTEGER2);
	SELF.docRef.doc := 0;
	self.segs := dataset([
	        {3,0,';' + l.providerid},
        {4,0,l.lastname + ',' + l.firstname + ' ' + l.middlename},
        {6,0,l.address + ' ' + l.address2 + ' ' + l.city + ' ' +
								l.state + ' ' + l.zip + ' ' + l.extzip + ' ' + l.county},
        //{5,0,l.phonenumber},
				//{7,0,l.city},
				//{8,0,l.state},
				//{9,0,l.zip},
				{10,0,l.phonenumber},
				{11,0,l.gender},
				{12,0,l.birthdate},
				{27,0,l.taxid},
				{36,0,l.taxid}
			
				     
	],Text_search.Layout_segment);
end;

proj_out := project(dist_ds,ingenix_Convert(left));

Layout_ingenix_record ingenix_Convert1(dist_ds1 l) := transform
	self.providerid := l.providerid;
	SELF.docRef.src := TRANSFER(l.licensestate, INTEGER2);
	SELF.docRef.doc := 0;
	self.segs := dataset([
	        {3,0,l.licensenumber},
        {13,0,l.effective_date},
				{14,0,l.termination_date},
        			{37,0,l.licensestate}		     
	],Text_search.Layout_segment);
end;

proj_out1 := project(dist_ds1,ingenix_Convert1(left));


Layout_ingenix_record ingenix_Convert2(dist_ds2 l) := transform
	self.providerid := l.providerid;
	SELF.docRef.src := TRANSFER('GP', INTEGER2);
	SELF.docRef.doc := 0;
	self.segs := dataset([
	        {22,0,l.groupname}
        
	],Text_search.Layout_segment);
end;

proj_out2 := project(dist_ds2,ingenix_Convert2(left));

Layout_ingenix_record ingenix_Convert3(dist_ds3 l) := transform
	self.providerid := l.providerid;
	SELF.docRef.src := TRANSFER('GP', INTEGER2);
	SELF.docRef.doc := 0;
	self.segs := dataset([
	        {35,0,l.upin}
        
	],Text_search.Layout_segment);
end;

proj_out3 := project(dist_ds3,ingenix_Convert3(left));

Layout_ingenix_Flat := record(text_search.Layout_DocSeg)
	typeof(ds.providerid) providerid;
end;

proj_full := proj_out + proj_out1 + proj_out2 + proj_out3;

Layout_ingenix_flat norm_ingenix(layout_ingenix_record l,text_search.Layout_segment r) := transform
	self.providerid := l.providerid;
	self.docref := l.docref;
	self := r;
end;

norm_out := normalize(proj_full,left.segs,norm_ingenix(left,right));

sort_out := sort(norm_out,providerid,local);

layout_ingenix_flat iterate_ingenix(layout_ingenix_flat l,layout_ingenix_flat r) := transform
		self.docref.doc := if(l.providerid = r.providerid,l.docref.doc,
								if(l.docref.doc = 0,thorlib.node() +1,l.docref.doc + thorlib.nodes()+1));
		self.docref.src := r.docref.src;
		self.sect := if(l.providerid <> r.providerid or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;
	
	itr_out := iterate(sort_out,iterate_ingenix(left,right),local);


	// External key
	
	layout_ingenix_flat MakeKeySegs( itr_out l, unsigned2 segno ) := TRANSFORM
		self.providerid := l.providerid;
        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := 'P' + l.providerid;
        self.sect := 1;
    END;

    segkeys := PROJECT(itr_out(trim(content) <> '' and trim(content) <> ';'),MakeKeySegs(LEFT,250));

	full_ret := itr_out(trim(content) <> '' and trim(content) <> ';') + segkeys;
	
	return full_ret;

end;