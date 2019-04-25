IMPORT STD;

lay:=RECORD
    STRING field1;
    STRING field2;
    STRING field3;
    STRING field4;
    STRING field5;
    STRING field6;
    STRING field7;
END;

ds:=dataset('~kel_shell::in::acceptance_criteria_rules',lay,CSV(HEADING(1), QUOTE('"')));
// ds;

p_lay:=record
string	sno;
string	category;
string	Jira;
string	case_Type;
string	def_vals;
string	Raw_Acceptance_Criteria;
string	Acceptance_Criteria;
end;

p:=project(ds,transform(p_lay,
self.sno:=left.field1;
self.category:=left.field2;
self.Jira:=left.field3;
self.case_Type:=left.field4;
self.def_vals:=left.field5;
self.Raw_Acceptance_Criteria:=left.field6;
self.Acceptance_Criteria:=left.field7;
))(sno<>'');

EXPORT acceptance_criteria_rules_file := p;

