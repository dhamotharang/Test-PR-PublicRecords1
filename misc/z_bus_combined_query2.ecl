my_input:=misc.bus_combined_query1;

layout_all_three_slim := record
unsigned6 c_bdid:=0;
//
string30 c_SALES_VOLUME_DESC:='';
string30 i_SALES_VOLUME_DESC:='';
string30 i_TOTAL_OUTPUT_SALES_DESC:='';
string30 d_annual_sales_volume_desc:='';
//
string30 c_EMPLOYEE_SIZE_DESC:='';
string30 i_EMPLOYEE_SIZE_DESC:='';
string30 i_OFFICE_SIZE_DESC:='';
string1 i_OFFICE_SIZE_CD:='';
string30 i_TOTAL_EMPLOYEE_SIZE_DESC:='';
string30 d_employees_total_desc:='';
string30 d_employees_here_desc:='';
end;

all_three_slim := project(my_input,layout_all_three_slim);

all_three_slim_deduped := dedup(all_three_slim,all);

output(choosen(all_three_slim_deduped,10000));

