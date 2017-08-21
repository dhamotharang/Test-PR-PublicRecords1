import txbus,mdr;
import text_search;

export Convert_txbus_Func := function
	
	ds := distribute(txbus.File_Txbus_Base,hash(taxpayer_number));
	
	Layout_txbus_record := record(text_search.Layout_Document)
		typeof(ds.Taxpayer_Number) Taxpayer_Number;
	end;
	
	Layout_txbus_record convert_txbus(ds l) := transform
		self.Taxpayer_Number := l.Taxpayer_Number;
		self.docref.doc := 0;
		self.docref.src := transfer(MDR.sourceTools.src_TXBUS,integer2);
		self.segs := dataset([
							{1,0,l.taxpayer_name},
							{2,0,l.taxpayer_address + ' ' + l.taxpayer_city + ' ' + l.taxpayer_state + ' ' +
										l.taxpayer_zipcode + '-' +	l.taxpayer_county_code},
							//{3,0,l.taxpayer_city},
							//{4,0,l.taxpayer_state},
							//{5,0,l.taxpayer_zipcode + '-' + l.taxpayer_county_code},
							{6,0,l.taxpayer_phone + ' ' + l.outlet_phone},
							{7,0,l.Taxpayer_Org_Type_desc},
							{8,0,l.taxpayer_number },
							{9,0,l.outlet_name},
							{10,0,l.outlet_address + ' ' + l.outlet_city + ' ' + l.outlet_state + ' ' +
										l.outlet_zipcode + '-' +	l.outlet_county_code},
							//{11,0,l.outlet_city },
							//{12,0,l.outlet_state},
							//{13,0,l.outlet_zipcode + '-' + l.outlet_county_code},
							{14,0,l.outlet_naics_code},
							{15,0,l.Outlet_Permit_Issue_Date},
							{16,0,l.Outlet_First_Sales_Date},
							{17,0,l.outlet_number}
		],text_search.Layout_Segment)
	end;

	proj_out := project(ds,convert_txbus(left));
	
	layout_txbus_flat := record(text_search.Layout_DocSeg)
		typeof(ds.Taxpayer_Number) Taxpayer_Number;
	end;

	layout_txbus_flat norm_recs(proj_out l,text_search.Layout_Segment r) := transform
			self.Taxpayer_Number := l.Taxpayer_Number;
			self.docref := l.docref;
			self := r;
	end;
	
	norm_out := normalize(proj_out,left.segs,norm_recs(left,right));

	sort_out := sort(norm_out,Taxpayer_Number,local);
	
	layout_txbus_flat iterate_recs(layout_txbus_flat l,layout_txbus_flat r) := transform
		self.docref.doc := if(l.Taxpayer_Number = r.Taxpayer_Number,l.docref.doc,
								if(l.docref.doc = 0,thorlib.node() +1,l.docref.doc + thorlib.nodes()+1));
		self.docref.src := r.docref.src;
		self.sect := if(l.Taxpayer_Number <> r.Taxpayer_Number or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;

	iterate_out := iterate(sort_out,iterate_recs(left,right),local);

	// External key
	
	layout_txbus_flat MakeKeySegs( iterate_out l, unsigned2 segno ) := TRANSFORM
		self.Taxpayer_Number := l.Taxpayer_Number;
        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := l.Taxpayer_Number;
        self.sect := 1;
    END;

    segkeys := PROJECT(iterate_out(trim(content) <> '' and trim(content) <> ';'),MakeKeySegs(LEFT,250));

	full_ret := iterate_out(trim(content) <> '' and trim(content) <> ';') + segkeys;
	
	return full_ret;
	
end;