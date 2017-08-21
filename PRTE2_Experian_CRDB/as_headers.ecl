
import ut, business_header, mdr, lib_stringlib, email_data, _validate,Experian_CRDB;

Export as_headers := module
 Export new_business_header_experian_crdb := Experian_CRDB.As_business_linking(,files.Base(company_name<>'') , True);
 End;

