import Data_Services, ut;
EXPORT File_Build_Metrics := module

export build_metrics_ly := record
string9 version;
string5 update_type;
string8 prep_start_date := '';
string8 prep_end_date := '';
string8 base_build_start_date := '';
string8 base_build_end_date := '';
string8 key_build_start_date := '';
string8 key_build_end_date := '';
string8 cert_date := '';
string8 prod_date := '';
unsigned total_processing_days:= 0;
unsigned total_deployment_days;
unsigned total_qa_days := 0;
unsigned total_days := 0;
string120 workunits:= '';
string8 last_updated := '';
end;

export file := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::lookup::ln_propertyv2::build_metrics', build_metrics_ly, thor);

end;