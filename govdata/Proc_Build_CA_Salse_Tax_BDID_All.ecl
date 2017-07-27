import ut, _control;

export Proc_Build_CA_Salse_Tax_BDID_All(string filedate) := function

//Spray CA Sales Tax File
spray_sales_tax := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/ca_sales_tax/out/ca_sales_tax_clean.'+filedate+'.d00'
									,827
									,'thor400_92'
									,'~thor_data400::in::ca::'+filedate+'::sales_tax',-1,,,true,true);

//Superfile Transactions for CA Sales Tax File
transac_sales_tax := sequential(fileservices.addsuperfile('~thor_data400::in::ca::sprayed::delete::sales_tax','~thor_data400::in::ca::sprayed::grandfather::sales_tax',,true),
								fileservices.clearsuperfile('~thor_data400::in::ca::sprayed::grandfather::sales_tax'),
								fileservices.addsuperfile('~thor_data400::in::ca::sprayed::grandfather::sales_tax','~thor_data400::in::ca::sprayed::father::sales_tax',,true),
								fileservices.clearsuperfile('~thor_data400::in::ca::sprayed::father::sales_tax'),
								fileservices.addsuperfile('~thor_data400::in::ca::sprayed::father::sales_tax','~thor_data400::in::ca::sprayed::sales_tax',,true),
								fileservices.clearsuperfile('~thor_data400::in::ca::sprayed::sales_tax'),
								fileservices.addsuperfile('~thor_data400::in::ca::sprayed::sales_tax','~thor_data400::in::ca::'+filedate+'::sales_tax'),
								fileservices.clearsuperfile('~thor_data400::in::ca::sprayed::delete::sales_tax',true)																	
								);
								
//Make Base CA Sales Tax File
mk_bdid := govdata.Make_CA_Sales_Tax_BDID;

retval := sequential(spray_sales_tax, transac_sales_tax, mk_bdid);

return retval;
end;