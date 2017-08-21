#workunit('name', 'Corporate Build Output Files ' + corp.Corp_Build_Date);

create_corp_out := corp.proc_corp_out;
create_cont_out := corp.proc_corp_cont_out;

sequential(create_corp_out, create_cont_out);
