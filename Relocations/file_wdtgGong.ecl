// This is a value-add version of Gong.File_Gong_History_Full used
// by the Where Did They Go routines.
//
// doxie.key_nbr_headers
// doxie.key_nbr_headers_uid


import Gong_Neustar, ut;


// where to get the data
gong_raw := Gong_Neustar.File_History_Full_Prepped_for_Keys;



// where to put the restructured data
fname_persist := '~thor_data400::persist::gong_history_wdtg';


// define layouts
layout_narrow := Relocations.layout_wdtg.narrow;

layout_narrow_gsid := record
	layout_narrow;
	//CCPA-22 add global_sid/record_sid
	UNSIGNED4 global_sid;
	UNSIGNED8 record_sid;
end;

layout_span := record
	layout_narrow;
	typeof(gong_raw.dt_first_seen)	span_first_seen;
	typeof(gong_raw.dt_last_seen) 	span_last_seen := '';
  UNSIGNED4 global_sid;
	UNSIGNED8 record_sid;
end;


// make sure we have all the fields we need
gong_decent := gong_raw(
	z5<>'',
	name_last<>'',
	name_first<>'',
	dt_last_seen<>'',
	dt_first_seen<>'',
	dt_first_seen<>'Signat'
);


// define narrowed layout with date-spanning fields
gong_slim := project(gong_decent, layout_narrow_gsid);


// add date-spanning fields, grouped by phone/location/surname
gong_srt := sort(gong_slim, phone10,z5,prim_name,prim_range,name_last);
gong_grp := group(gong_srt, phone10,z5,prim_name,prim_range,name_last);
gong_grp_f := dedup(sort(gong_grp,dt_first_seen));
gong_grp_l := dedup(sort(gong_grp,-dt_last_seen));
gong_span_f := join(
	gong_grp, gong_grp_f,
	left.phone10=right.phone10
		and left.z5=right.z5
		and left.prim_name=right.prim_name
		and left.prim_range=right.prim_range
		and left.name_last=right.name_last,
	transform(layout_span, self.span_first_seen:=right.dt_first_seen, self:=left),
	keep(1), left outer
);
gong_span_fl := join(
	gong_span_f, gong_grp_l,
	left.phone10=right.phone10
		and left.z5=right.z5
		and left.prim_name=right.prim_name
		and left.prim_range=right.prim_range
		and left.name_last=right.name_last,
	transform(layout_span, self.span_last_seen:=right.dt_last_seen, self:=left),
	keep(1), left outer, skew(0.2)
);
gong_span := ungroup(gong_span_fl);


// final sort by phone/location/surname
results := sort( gong_span, phone10,z5,prim_name,prim_range,name_last, -dt_last_seen );


// we may need these results more than once
export file_wdtgGong := results : PERSIST(fname_persist);