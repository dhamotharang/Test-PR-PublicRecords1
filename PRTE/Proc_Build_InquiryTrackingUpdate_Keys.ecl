IMPORT inquiry_acclogs;

/////////////////////////// THIS IS A BWR

#workunit('name','Inquiry PRTE Copy')

version := '20130916';
	
df := dataset([], Inquiry_AccLogs.layout.common_indexes);
															
buildindex(df, {unsigned6 s_did := person_q.appended_ADL}, {df},
																'~prte::key::inquiry::'+version+'::did_update',overwrite);
																
buildindex(df, {string5 zip := person_q.zip,person_q.prim_name,person_q.prim_range,person_q.sec_range}, {df},
																'~prte::key::inquiry::'+version+'::address_update',overwrite);
																
buildindex(df, {string10 phone10 := person_q.personal_phone}, {df},
																'~prte::key::inquiry::'+version+'::phone_update',overwrite);
																
buildindex(df, {string9 ssn := person_q.SSN}, {df},
																'~prte::key::inquiry::'+version+'::ssn_update',overwrite);

slim := record
	df.bus_intel;
	df.person_q;
	df.search_info;
	df.fraudpoint_score;
  end;
	
p := project(df, transform(slim, 
	self.person_q.email_address := stringlib.stringtouppercase(left.person_q.email_address), 
	self := left));

buildindex(p, {string50 email_address := person_q.email_address}, {p},
																'~prte::key::inquiry::'+version+'::email_update',overwrite);

layout_counts := record
	unsigned2 CountTotal;
	unsigned2 Count01;
	unsigned2 Count03;
	unsigned2 Count06;
	unsigned2 Count12;
	unsigned2 Count24;
	unsigned2 Count36;
	unsigned2 Count60;
end;

layout_final := record
	unsigned6 did;
	layout_counts Collection;
	layout_counts AccountOpen;
	layout_counts Other;
end;

rolled := dataset([], recordof(layout_final));


buildindex(rolled, {did}, {rolled}, '~prte::key::inquiry_table::'+version+'::did',overwrite);

vert := dataset([], Inquiry_AccLogs.Layout_MBS_Industry_vertical);
													
buildINDEX(vert, {string20 s_company_id := company_id, string4 s_product_id := product_id,string20 s_gc_id := gc_id }, {vert},
																'~prte::key::inquiry_table::'+version+'::industry_use_vertical', overwrite);	
																
																
															
	layout_desc := record
	string product_id;
	string transaction_type;
	string function_name;
	string description;

end;
file_lookup_transaction := dataset([], layout_desc);
													
BUILDINDEX(file_lookup_transaction, 
{string4 s_product_id := product_id,string2 s_transaction_type := transaction_type, string40 s_function_name := function_name}, {file_lookup_transaction},
'~prte::key::inquiry_table::'+version+'::lookup_function_desc', overwrite);

//add name and IP address

slim_p := record
	df.bus_intel;
	df.person_q;
	df.search_info;
end;

p_name_ipaddr := project(df, transform(slim_p, self := left));
					
buildindex(p_name_ipaddr, {person_q.fname,person_q.mname,person_q.lname}, {p_name_ipaddr},
																'~prte::key::inquiry::'+version+'::name_update',overwrite);
															
buildindex(p_name_ipaddr, {string20 IPaddr := person_q.IPaddr}, {p_name_ipaddr},
																'~prte::key::inquiry::'+version+'::IPaddr_update',overwrite);


																

