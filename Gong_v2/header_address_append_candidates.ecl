import header,mdr;

export header_address_append_candidates(dataset(recordof(header.layout_header)) in_hdr) := module

shared hdr := in_hdr(zip4<>'' and zip4 not in ['0001','9999'] and (prim_range<>'' or prim_name<>''));

shared r1 := record
 unsigned6 did;
 string10  prim_range;
 string2   predir;
 string28  prim_name;
 string4   suffix;
 string2   postdir;
 string8   sec_range;
 string25  city_name;
 string2   st;
 string5   zip;
 string4   zip4;
 boolean   is_po_box;
 boolean   in_eq;
 boolean   in_en;
 boolean   in_wp;
 boolean   in_util;
 boolean   in_ts;
 boolean   in_veh;
 boolean   in_prop;
 boolean   in_dl;
 boolean   in_tu;
 boolean   in_other;
 boolean   only_glb;
 integer   addr_in_zip;
 integer   prange_srange_in_zip;
end;

r1 t1(hdr le) := transform
 self.is_po_box := stringlib.stringfind(trim(le.prim_name),'PO BOX',1)>0 or stringlib.stringfind(trim(le.prim_name),' POB ',1)>0;
 self.in_eq    := le.src='EQ';
 self.in_en    := le.src='EN';
 self.in_wp    := le.src='WP';
 self.in_util  := MDR.sourceTools.SourceIsUtility(le.src);
 self.in_ts    := le.src='TS';
 self.in_veh   := mdr.sourcetools.sourceisvehicle(le.src)   =true;
 self.in_prop  := mdr.sourcetools.sourceisproperty(le.src)  =true;
 self.in_dl    := mdr.sourcetools.sourceisdl(le.src)        =true;
 self.in_tu    := mdr.sourcetools.sourceistransunion(le.src)=true;
 self.in_other := self.in_eq  =false and 
                  self.in_wp  =false and 
				  self.in_util=false and 
				  self.in_ts  =false and 
                  self.in_veh =false and 
				  self.in_prop=false and 
				  self.in_dl  =false and 
				  self.in_tu  =false
				  ;
 self.only_glb             := mdr.sourcetools.sourceisglb(le.src) and ~(header.isPreGLB(le));
 self.addr_in_zip          := 1;
 self.prange_srange_in_zip := 1;
 self                      := le;
end;

p1      := project   (hdr,t1(left));
p1_dist := distribute(p1,hash(did,prim_range,predir,prim_name/*,suffix*/,postdir,sec_range,zip));
p1_sort := sort      (p1_dist,did,prim_range,predir,prim_name/*,suffix*/,postdir,sec_range,zip,local);

r1 t2(r1 le, r1 ri) := transform
 self.in_eq    := if(le.in_eq   =true, le.in_eq,   ri.in_eq);
 self.in_en    := if(le.in_en   =true, le.in_en,   ri.in_en);
 self.in_wp    := if(le.in_wp   =true, le.in_wp,   ri.in_wp);
 self.in_util  := if(le.in_util =true, le.in_util, ri.in_util);
 self.in_ts    := if(le.in_ts   =true, le.in_ts,   ri.in_ts);
 self.in_veh   := if(le.in_veh  =true, le.in_veh,  ri.in_veh);
 self.in_prop  := if(le.in_prop =true, le.in_prop, ri.in_prop);
 self.in_dl    := if(le.in_dl   =true, le.in_dl,   ri.in_dl);
 self.in_tu    := if(le.in_tu   =true, le.in_tu,   ri.in_tu);
 self.in_other := if(le.in_other=true, le.in_other,ri.in_other);
 self.only_glb := if(le.only_glb=false,le.only_glb,ri.only_glb);
 self          := le;
end;

p2 := rollup(p1_sort,left.did       =right.did        and 
                     left.prim_range=right.prim_range and 
					 left.predir    =right.predir     and
                     left.prim_name =right.prim_name  and 
					 left.suffix    =right.suffix     and 
					 left.postdir   =right.postdir    and
					 left.sec_range =right.sec_range  and 
					 left.zip       =right.zip,
						  t2(left,right),local) : persist('~thor400_84::persist::hdr_addr_append_prep');

       p2_dist := distribute(p2,hash(did,zip));
shared p2_sort := sort      (p2_dist,did,zip,local);

r1 t3(r1 le, r1 ri) := transform 
 self.addr_in_zip := le.addr_in_zip+1;
 self             := le;
end;

shared p3 := rollup(p2_sort,left.did=right.did and left.zip=right.zip,t3(left,right),local);

//adl's with only 1 address in a zip
export zips_with_only_one_address := p3(addr_in_zip=1);

r1 t5(r1 le, r1 ri) := transform
 self.addr_in_zip := ri.addr_in_zip;
 self             := le;
end;

another_look := join(p2_sort,p3(addr_in_zip>1),left.did=right.did and left.zip=right.zip,t5(left,right),local);

//exlude PO BOX's?
p4_dist := distribute(another_look/*(prim_range<>'')*/,hash(did,prim_name/*,sec_range*/,zip));
p4_sort := sort      (p4_dist,did,prim_range,prim_name,sec_range,zip,local);
p4_dupd := dedup     (p4_sort,did,prim_range,prim_name,sec_range,zip,local);

r1 t4(r1 le, r1 ri) := transform 
 self.prange_srange_in_zip := le.prange_srange_in_zip+1;
 self                      := le;
end;

p5 := rollup(p4_dupd,left.did=right.did and left.prim_name=right.prim_name /*and left.sec_range=right.sec_range*/ and left.zip=right.zip,t4(left,right),local) : persist('persist::jtrost_hdr_for_gong4');

//adl's with only 1 address in that zip
export street_with_only_one_street_number := p5(prim_name<>'' and prange_srange_in_zip=1) : persist('~thor400_84::persist::header_address_append_candidates');

end;