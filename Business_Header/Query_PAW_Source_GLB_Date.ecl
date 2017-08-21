// for Amanda
// people at work file broken out by source and date last updated
// pre-GLB equifax header records
//	string1   GLB;
//	string2   source;
//	string2   DPPA_State;
//	string8   dt_last_seen;
import header;
paw := Business_Header.File_Employment_Out;

layout_paw_slim :=
record
	paw.source;
	paw.GLB;
	string8 dt_last_seen := (string8) max(group, (integer4) paw.dt_last_seen);
	integer4 total := count(group);
end;

paw_slim := table(paw, layout_paw_slim, source, GLB, few);

layout_paw_source :=
record
	paw_slim.source;
	string50 hdr_source_long := '';
	string50 bh_source_long := '';
	paw_slim.GLB;
	paw_slim.dt_last_seen;
	paw_slim.total;
end;

layout_paw_source tgetsource(paw_slim l) := 
transform
	self.hdr_source_long := header.translateSource(l.source);
	self.bh_source_long := business_header.translateSource(l.source);
	self := l;
end;

paw_source := project(paw_slim, tgetsource(left));

	
export Query_PAW_Source_GLB_Date := output(paw_source, named('PAWBreakoutForAmanda'),all);



