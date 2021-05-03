//NOTE:  For the question on number of entities use the CORE result provided in the segmentation stats
import header, ut, utilfile, relationship;

fn_rollup_on_did(dataset(recordof(header.Layout_Header)) file_in) :=
function

r1 := record
	file_in.did;
	unsigned8 did_ct:= 1;
 end;

r1 t1(file_in l) := transform
	self := l;
 end;

p1      := project   (file_in,t1(left));
p1_dist := distribute(p1,hash(did));
p1_sort := sort      (p1_dist,did,local);

r1 t2(p1_sort l, p1_sort r) := transform
	self.did_ct := l.did_ct+1;
	self        := l;
 end;

p2       := rollup    (p1_sort,left.did=right.did,t2(left,right),local);

return p2;

end;

ds_hdr_in := header.File_Headers + Header.File_Transunion_did + Header.File_tucs_did + Header.File_TN_did;

ds      := fn_rollup_on_did(ds_hdr_in);
ds_hdr0 := distribute(ds_hdr_in,hash(did));

r1 := record
	ds_hdr0.did;
	ds_hdr0.ssn;
	ds_hdr0.dob;
	ds.did_ct;
 end;

r1 join_to_hdr(ds_hdr0 le, ds ri) := transform
	self := le;
	self := ri;
 end;

j1 := join(ds_hdr0,ds,
           left.did=right.did,
               join_to_hdr(left,right),
               local);

r2 := record
	ds_hdr_in.fname;
	ds_hdr_in.mname;
	ds_hdr_in.lname;
	ds_hdr_in.name_suffix;
	ds_hdr_in.prim_range;
	ds_hdr_in.prim_name;
	ds_hdr_in.sec_range;
	ds_hdr_in.zip;
 end;

r2 t2(ds_hdr_in le) := transform
	self := le;
 end;

//death sources in header as of March 2015
DM := ['DE', 'D0', 'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'D!', 'D@', 'D#', 'D%', 'DS', 'TR', 'D$', 'OB'];

//p3 := project (ds_hdr_in(src<>'DE'),t2(left));
p3      := project   (ds_hdr_in(src not in DM),t2(left)); 
p3_dist := distribute(p3,hash(fname,mname,lname,name_suffix,prim_range,prim_name,sec_range,zip));
p3_sort := sort      (p3_dist,fname,mname,lname,name_suffix,prim_range,prim_name,sec_range,zip,local);
p3_dupd := dedup     (p3_sort,fname,mname,lname,name_suffix,prim_range,prim_name,sec_range,zip,local);
                                  
fn_AddStat(integer value, string name) := 
FUNCTION

return ut.fn_AddStatDS(dataset([{name, value}], ut.layout_stats_extend)/*, name*/);

END;
segmentation_stats := header.fn_ADLSegmentation(header.file_headers).tab;
segmentation_core:= segmentation_stats(ind = 'CORE'); 

hdr_stats := parallel(
fn_AddStat(count(ds_hdr_in),                     '01) Header Total Records'),
fn_AddStat(count((j1)(dob<>0)),                  '02) Header Total DOB Count'),
fn_AddStat(count(p3_dupd),                       '03) Header Unique Name+Address Combinations'),
fn_AddStat(count(ds(did_ct>1)),                  '04) Header Unique identities(ADL Non-Fragments)'), 
fn_AddStat(segmentation_core[1].cnt,               '05) Header Unique identities'),
fn_AddStat(count((j1)((integer)ssn<>0)),                              '06) Header Total SSN Count'),
fn_AddStat(count((j1)(length(trim(ssn))=9 and ssn[1]='9' and ssn[4] in ['7','8'])),           '07) Header Total ITIN Count'),
fn_AddStat(count(relationship.File_Relative),                              '08) Relatives & Associates Count')

);

export various_people_assets_stats1 := hdr_stats;
