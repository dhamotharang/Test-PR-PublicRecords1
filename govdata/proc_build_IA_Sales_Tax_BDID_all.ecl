import ut, _control;

export proc_build_ia_sales_tax_BDID_all(string filedate) := function

//Spray File
sprayfile := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/prod_data_build_10/production_data/business_headers/ia_sales_tax/out/ia_sales_tax.d00'
									,813
									, 'thor400_92',
									'~thor_data400::in::ia::'+filedate+'::sales_tax_in',-1,,,true,true);
									
//Superfile Transactions
superfile_transac := sequential(fileservices.addsuperfile('~thor_data400::in::ia::sprayed::delete::sales_tax','~thor_data400::in::ia::sprayed::grandfather::sales_tax',,true),
								fileservices.clearsuperfile('~thor_data400::in::ia::sprayed::grandfather::sales_tax'),
								fileservices.addsuperfile('~thor_data400::in::ia::sprayed::grandfather::sales_tax','~thor_data400::in::ia::sprayed::father::sales_tax',,true),
								fileservices.clearsuperfile('~thor_data400::in::ia::sprayed::father::sales_tax'),
								fileservices.addsuperfile('~thor_data400::in::ia::sprayed::father::sales_tax','~thor_data400::in::ia::sprayed::sales_tax',,true),
								fileservices.clearsuperfile('~thor_data400::in::ia::sprayed::sales_tax'),
								fileservices.addsuperfile('~thor_data400::in::ia::sprayed::sales_tax','~thor_data400::in::ia::'+filedate+'::sales_tax_in'),
								fileservices.clearsuperfile('~thor_data400::in::ia::sprayed::delete::sales_tax',true)																	
								);

// Make BDID 
make_bdid := govdata.Make_IA_SalesTax_BDID;

//STRATA
strata_counts := govdata.Strata_Population_Stats.IA_Sales_pop;

retval := sequential(sprayfile
					  ,superfile_transac
					  ,make_bdid
					  ,strata_counts);
return retval;
end;