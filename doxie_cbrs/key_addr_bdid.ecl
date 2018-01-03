import business_header,doxie, ut, data_services;

bh := Business_Header.File_Business_Header_Base_for_keybuild(prim_name!='' and zip!=0);

layout_bh_slim := 
record
	bh.prim_name;
	bh.zip;
	bh.sec_range;
	bh.prim_range;
	bh.bdid;
end;

layout_bh_slim tstripordinal(bh l) :=
transform
	self.prim_name	:= ut.StripOrdinal(stringlib.stringtouppercase(l.prim_name));
	self			:= l;
end;

bh_slim := project(bh, tstripordinal(left));


d := dedup(bh_slim,prim_name,zip,sec_range,prim_range, bdid, all);

export Key_Addr_bdid := INDEX(d, 
{prim_name,zip,sec_range,prim_range},
{bdid}, 
data_services.data_location.prefix() + 'thor_data400::key::cbrs.addr.bdid_' + doxie.Version_SuperKey);
