import Oshair;
import text_search;
import property;
export Convert_Oshair_Func := function
	
	ds_ac := oshair.file_out_accident_cleaned;
	ds_ins := oshair.file_out_inspection_cleaned;
	
	dist_ds_ac := distribute(ds_ac,hash(activity_number));
	dist_ds_ins := distribute(ds_ins,hash(activity_number));
	
	mylayout := record
		oshair.layout_OSHAIR_inspection_clean;
		OSHAIR.layout_OSHAIR_clean.OSHAIR_accident_rec;
		string20 county_name := '';
	end;
	
	mylayout join_recs(dist_ds_ins l,dist_ds_ac r) := transform
		self := l;
		self := r;
	end;

	join_out := join(dist_ds_ins,dist_ds_ac,left.activity_number = right.activity_number,
																join_recs(left,right),left outer,local);
	
	// Get county 
	
	mylayout get_county(join_out l,Property.File_County_Code_Names r) := transform
		self.county_name := r.county_name;
		self := l;
	end;
	

	county_out := JOIN(join_out,
                                 Property.File_County_Code_Names,
                                 LEFT.Inspected_Site_State = RIGHT.state AND
                                   LEFT.Inspected_Site_County_Code = (INTEGER)RIGHT.fips_county_code,
                                 get_county(LEFT, RIGHT),
                                 left outer,local);
	// work starts here
	
	text_search.Layout_Document convert_oshair(county_out l) := transform
		self.docref.src := TRANSFER(l.region_code, INTEGER2);
		self.docref.doc := l.activity_number;
		self.segs := dataset([
				{1,0,l.Prev_Activity_Type_Desc},
				{2,0,l.Previous_Activity_Number},
				{3,0,l.Activity_Number},
				{4,0,l.Region_Code + ' ' + l.area_code + ' ' + l.office_code},
				{5,0,l.Compl_Officer_Job_Title_Desc},
				{6,0,l.Inspected_Site_Name},
				{7,0,l.Inspected_Site_Street + ' ' + l.Inspected_Site_City_Name + ' ' + l.Inspected_Site_State + ' ' + l.Inspected_Site_Zip},
				// ??? {9,0,l.county_name},
				//{8,0,l.Inspected_Site_State},
				//{9,0,l.Inspected_Site_Zip},
				//{10,0,l.Inspected_Site_City_Name},
				{11,0,l.county_name},
				{12,0,l.duns_number},
				{13,0,l.Host_Establishment_key},
				{14,0,l.Own_Type_desc},
				{15,0,l.Owner_Code},
				{16,0,l.Advance_Notice_Flag},
				{17,0,l.Inspection_Opening_Date},
				{18,0,l.Inspection_Close_Date},
				{19,0,l.Safety_Health_Flag},
				{20,0,l.SIC_Code + ';' + l.SIC_Guide},
				{21,0,l.NAICS_Code + ';' + l.NAICS_Secondary_Code + ';' + l.NAIC_Inspected},
				{22,0,l.Insp_type_desc},
				{23,0,l.Insp_scope_desc},
				{24,0,l.Close_Case_Date},
				{25,0,';' + l.name},
				{26,0,l.sex},
				{27,0,l.age},
				{28,0,l.Deg_of_Injury_Desc},
				{29,0,l.Nat_of_Inj_Desc},
				{30,0,l.Event_Desc}
		],text_search.Layout_Segment);
	end;
	
	proj_out := project(county_out,convert_oshair(left));
	
	text_search.Layout_DocSeg norm_recs(proj_out l,text_search.Layout_Segment r) := transform
		self.docref := l.docref;
		self := r;
	end;
	
	norm_out := normalize(proj_out,left.segs,norm_recs(left,right));
	
	sort_out := sort(norm_out,docref.doc,local);
	
	text_search.Layout_DocSeg iterate_recs(text_search.Layout_DocSeg l,text_search.Layout_DocSeg r) := transform
		self.sect := if(l.docref.doc <> r.docref.doc or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;
	
	iterate_out := iterate(sort_out,iterate_recs(left,right),local);
	
	retval := iterate_out(trim(content) <> '' and trim(content) <> ';');
		// External key
	
	text_search.Layout_DocSeg MakeKeySegs( retval l, unsigned2 segno ) := TRANSFORM
	    self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := intformat(l.docref.doc,15,1);
        self.sect := 1;
    END;

    segkeys := PROJECT(retval,MakeKeySegs(LEFT,250));

	full_ret := segkeys + retval;
	
	return full_ret;
	
	
end;