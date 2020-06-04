import Data_Services, INQL_V2;

r:= record
string orig_response_time;
string orig_billing_code;
string orig_loginid;
end;

export File_RTime_Report := dataset(Data_Services.foreign_logs + 'thor100_21::base::inquiry::rtime::report', 
                                 {recordof (INQL_v2.Files().Inql_base.qa), r}, thor); 

