import doxie,ut,INQL_v2,Data_Services;

func_desc := INQL_v2.File_Lookups.transaction_desc;

func_desc_dedup := dedup(func_desc(function_name <> ''), all);

layout_desc := record
	string product_id;
	string transaction_type;
	string function_name;
	string description;

end;

p := project(func_desc_dedup, transform(layout_desc, 
	self.description := stringlib.stringtouppercase(left.description), 
	self := left));
InDx_FN := Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::lookup_function_desc_' + doxie.Version_SuperKey;

export key_lookup_function_desc
 := INDEX(p, {string4 s_product_id := product_id,string2 s_transaction_type := transaction_type, string40 s_function_name := function_name}, {p}, InDx_FN);

