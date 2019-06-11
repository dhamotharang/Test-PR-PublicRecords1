Import Ares, std;

base := files.ds_routingcode;
base_layout := layout_RoutingCode;

layout_expanded := Record(base_layout)
	string rank;
	string primaryOfficeID;
	string full_primaryOfficeID;
	string department;
	string full_department;
	string routingnumber_alt;
	string routing_raw;
	string codetype_derived := '';
End;

layout_expanded xform_expand(base l) := Transform
	self.rank := l.usageLocations(primaryAssignee = 'true')[1].rankAtLocation;
	self.primaryOfficeID := std.str.splitwords(l.usageLocations(primaryAssignee = 'true')[1].presence_link.href,'/')[3];
	self.full_primaryOfficeID := l.usageLocations(primaryAssignee = 'true')[1].presence_link.href;
	self.department := std.str.splitwords(l.usageLocations(primaryAssignee = 'true' )[1].department_link.href,'/')[3];
	self.full_department := l.usageLocations(primaryAssignee = 'true')[1].department_link.href;
	self.routingnumber_alt := l.codeAlternateForms(form_type = 'tfp_legacy')[1].form;
	self.routing_raw := l.codeValue;
	self.codeType := map(	std.str.startswith(L.tfpid,'BIC-') => 'BIC',
												std.str.startswith(L.tfpid,'SWIFT-') => 'SWIFT',
												trim(l.codeType,left,right));
	self := l;
End;

ds_expand := Project(base, xform_expand(left));

codetype_lookup := Files.ds_lookup(lookupname ='Routing Code Type').lookupBody;

ds_expand xform_codetypes(ds_expand l, recordof(codetype_lookup) r) := transform
	self.codetype := map(	std.str.splitwords(l.tfpid,'-')[1] = l.codeType and r.tfpid != '' => r.tfpid,  
												l.codeType != '' => l.codeType, 
												std.str.splitwords(l.tfpid,'-')[1] != '' => std.str.splitwords(l.tfpid,'-')[1], 
												l.codeType) ;
	self.routingnumber_alt := if(self.codetype = 'ABA', l.routing_raw, l.routingnumber_alt);
	self := l;	
end;
xlated_codetypes := join(ds_expand(primaryOfficeID != ''), codetype_lookup, left.codetype = right.id, xform_codetypes(left,right), left outer, keep(1)); 

EXPORT file_routingcodes_flat := xlated_codetypes;