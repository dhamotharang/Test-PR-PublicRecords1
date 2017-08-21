import header,mdr;

export mac_Header_Address_Append := module

export append_extended_layout := record
  boolean   is_po_box := false;
  string4   in_eq := '';
  string4   in_en := '';
  string4   in_wp := '';
  string4   in_util := '';
  string4   in_ts := '';
  string4   in_veh := '';
  string4   in_prop := '';
  string4   in_dl := '';
  string4   in_tu := '';
  string4   in_other := '';
  boolean   only_glb := false;
  integer   addr_in_zip := 0;
  integer   prange_srange_in_zip := 0;
end;

export append_process(in_file, result_out) := macro

#Uniquename(hdr)
#Uniquename(din_file)

%din_file% :=distribute(in_file, hash(did));

%hdr% := join(header.File_Headers(zip4<>'' and zip4 not in ['0001','9999'] and (prim_range<>'' or prim_name<>'')),
								%din_file%, left.did = right.did, transform(header.Layout_Header, self := left), local);

#uniquename(r1)


%r1% := record
 %hdr%.did;
 %hdr%.prim_range;
 %hdr%.predir;
 %hdr%.prim_name;
 %hdr%.suffix;
 %hdr%.postdir;
 %hdr%.sec_range;
 %hdr%.city_name;
 %hdr%.st;
 %hdr%.zip;
 %hdr%.zip4;
 mac_Header_Address_Append.append_extended_layout;
end;

#uniquename(t1)
#uniquename(p1)

%r1% %t1%(%hdr% le) := transform
 self.is_po_box := stringlib.stringfind(trim(le.prim_name),'PO BOX',1)>0 or stringlib.stringfind(trim(le.prim_name),' POB ',1)>0;
 self.in_eq    := if(le.src='EQ', le.src, '');
 self.in_en    := if(le.src='EN', le.src, '');
 self.in_wp    := if(le.src='WP', le.src, '');
 self.in_util  := if(MDR.sourceTools.SourceIsUtility(le.src), le.src, '');
 self.in_ts    := if(le.src='TS', le.src, '');
 self.in_veh   := if(mdr.sourcetools.sourceisvehicle(le.src), le.src, '');
 self.in_prop  := if(mdr.sourcetools.sourceisproperty(le.src), le.src, '');
 self.in_dl    := if(mdr.sourcetools.sourceisdl(le.src)      , le.src, '');
 self.in_tu    := if(mdr.sourcetools.sourceistransunion(le.src), le.src, '');
 self.in_other := if(self.in_eq = '' and 
                  self.in_wp  = '' and 
									self.in_util = '' and 
									self.in_ts  = '' and 
                  self.in_veh = '' and 
									self.in_prop = '' and 
									self.in_dl  = '' and 
									self.in_tu  = '', le.src, '');
 self.only_glb             := mdr.sourcetools.sourceisglb(le.src) and ~(header.isPreGLB(le));
 self.addr_in_zip          := 1;
 self.prange_srange_in_zip := 1;
 self                      := le;
end;

%p1%      := project(%hdr%,%t1%(left));

#uniquename(p1_dist)
#uniquename(p1_sort)

%p1_dist% := distribute(%p1%,hash(did,prim_range,predir,prim_name/*,suffix*/,postdir,sec_range,zip));
%p1_sort% := sort      (%p1_dist%,did,prim_range,predir,prim_name/*,suffix*/,postdir,sec_range,zip,local);

#uniquename(t2)
#uniquename(p2)

%r1% %t2%(%r1% le, %r1% ri) := transform
 self.in_eq    := if(le.in_eq   <>'', le.in_eq,   ri.in_eq);
 self.in_en    := if(le.in_en   <>'', le.in_en,   ri.in_en);
 self.in_wp    := if(le.in_wp   <>'', le.in_wp,   ri.in_wp);
 self.in_util  := if(le.in_util <>'', le.in_util, ri.in_util);
 self.in_ts    := if(le.in_ts   <>'', le.in_ts,   ri.in_ts);
 self.in_veh   := if(le.in_veh  <>'', le.in_veh,  ri.in_veh);
 self.in_prop := if(le.in_prop <>'', le.in_prop, ri.in_prop);
 self.in_dl    := if(le.in_dl   <>'', le.in_dl,   ri.in_dl);
 self.in_tu    := if(le.in_tu   <>'', le.in_tu,   ri.in_tu);
 self.in_other := if(le.in_other<>'', le.in_other,ri.in_other);
 self.only_glb := if(le.only_glb=false,le.only_glb,ri.only_glb);
 self          := le;
end;

%p2% := rollup(%p1_sort%,
						left.did       =  right.did        and 
            left.prim_range= right.prim_range and 
						left.predir    =right.predir     and
            left.prim_name =right.prim_name  and 
					  left.suffix    =right.suffix     and 
					  left.postdir   =right.postdir    and
					  left.sec_range =right.sec_range  and 
					  left.zip      =right.zip, %t2%(left,right),local);

#uniquename(p2_dist)
#uniquename(p2_sort)

%p2_dist% := distribute(%p2%,hash(did,zip));
%p2_sort% := sort(%p2_dist%,did,zip,local);

#uniquename(t3)
#uniquename(p3)

%r1% %t3%(%r1% le, %r1% ri) := transform 
 self.addr_in_zip := le.addr_in_zip+1;
 self             := le;
end;

result_out := rollup(%p2_sort%,left.did=right.did and left.zip=right.zip,%t3%(left,right),local)(addr_in_zip=1 and 
																																(in_eq + in_en + in_wp + in_util + in_ts <> ''));
																																
endmacro;

end;