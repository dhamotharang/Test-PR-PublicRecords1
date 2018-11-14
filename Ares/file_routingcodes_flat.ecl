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
End;

layout_expanded xform_expand(base l) := Transform
	self.rank := l.usageLocations(primaryAssignee = 'true')[1].rankAtLocation;
	self.primaryOfficeID := std.str.splitwords(l.usageLocations(primaryAssignee = 'true')[1].presence_link.href,'/')[3];
	self.full_primaryOfficeID := l.usageLocations(primaryAssignee = 'true')[1].presence_link.href;
	self.department := std.str.splitwords(l.usageLocations(primaryAssignee = 'true')[1].department_link.href,'/')[3];
	self.full_department := l.usageLocations(primaryAssignee = 'true')[1].department_link.href;
	self.routingnumber_alt := l.codeAlternateForms(form_type = 'tfp_legacy')[1].form;
	self.routing_raw := l.codeValue;
	self := l;
End;

ds_expand := Project(base, xform_expand(left));

EXPORT file_routingcodes_flat := ds_expand;