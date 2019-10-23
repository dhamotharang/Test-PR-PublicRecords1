import std;
import ares;

file_office_flat_ds := file_office_flat;
department_ds:=ares.files.ds_department;

layout_w_telecom := record(recordof(file_office_flat_ds))
	STRING office_id;
	STRING telecom_phoneCountryCode;
	STRING telecom_phoneAreaCode;
	STRING telecom_phoneNumber;
	STRING telecom_value;
	STRING telecom_type;
end;

layout_w_telecom telecoms_xform(file_office_flat_ds L, STRING id):= TRANSFORM
	SELF.office_id := IF(id != '', id, '');
	SELF.telecom_phoneCountryCode := L.locations.telecom[1].phoneCountryCode;
	SELF.telecom_phoneAreaCode := L.locations.telecom[1].phoneAreaCode;
	SELF.telecom_phoneNumber := L.locations.telecom[1].phoneNumber;
	SELF.telecom_value := L.locations.telecom[1].value;
	SELF.telecom_type := L.locations.telecom[1].type;
	SELF := L;
END;

office_telecoms_normed := normalize(file_office_flat_ds,LEFT.locations.telecom, telecoms_xform(LEFT, LEFT.id));
output(count(office_telecoms_normed), NAMED ('Office_telecom_count'));
output(office_telecoms_normed, NAMED ('Normilized_Office_telecoms'));
output(office_telecoms_normed(id = '00005498-0496-4576-82a4-c8ed49a1309d'), NAMED ('Office_id_telecom'));


layout_with_officeId := record(recordof(department_ds))
	STRING office_dept_id;
end;


layout_with_officeId dpt_with_officeid_xform(department_ds L):= TRANSFORM
	SELF.office_dept_id :=IF(L.summary.office.link_href != '', std.str.splitwords(L.summary.office.link_href,'/')[3], '');
	SELF := L;
END;

dpt_with_parsed_officeId := project(department_ds,dpt_with_officeid_xform(LEFT));

layout_dpt_telecom := record(recordof(dpt_with_parsed_officeId))
	STRING dept_id;
	//STRING office_dept_id;
	STRING telecom_phoneCountryCode;
	STRING telecom_phoneAreaCode;
	STRING telecom_phoneNumber;
	STRING telecom_value;
	STRING telecom_type;
end;


layout_dpt_telecom dpt_telecoms_office_xform(dpt_with_parsed_officeId L, STRING id):= TRANSFORM
	SELF.dept_id := IF(id != '', id, '');
	//SELF.office_dept_id :=IF(L.summary.office.link_href != '', std.str.splitwords(L.summary.office.link_href,'/')[3], '');
	SELF.office_dept_id :=L.office_dept_id;
	SELF.telecom_phoneCountryCode := L.locations.telecom[1].phoneCountryCode;
	SELF.telecom_phoneAreaCode := L.locations.telecom[1].phoneAreaCode;
	SELF.telecom_phoneNumber := L.locations.telecom[1].phoneNumber;
	SELF.telecom_value := L.locations.telecom[1].value;
	SELF.telecom_type := L.locations.telecom[1].type;
	SELF := L;
END;

dpt_normed := normalize(dpt_with_parsed_officeId,LEFT.locations, dpt_telecoms_office_xform(LEFT, LEFT.id));

output(count(dpt_normed), NAMED ('Normilized_dpt_telecoms_count'));
output(dpt_normed, NAMED ('Normilized_dpt_telecoms'));
output(dpt_normed(office_dept_id = '00005498-0496-4576-82a4-c8ed49a1309d'), NAMED ('officeid_dpt_telecom'));



layout_dpt_telecom combined_xform(dpt_normed L):=TRANSFORM
	SELF := L;
END;

combinedResults := join(dpt_normed,office_telecoms_normed, LEFT.office_dept_id = RIGHT.office_id ,combined_xform(LEFT));
output(combinedResults, NAMED ('Combined_Normilized_telecoms'));