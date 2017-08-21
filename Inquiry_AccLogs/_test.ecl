/*--SOAP--
<message name="Inquiry_Tracking_Stats_GroupBy">
<part name="group_by_field1" type="xsd:string" required="1"/>
<part name="group_by_field2" type="xsd:string" required="0"/>
<part name="group_by_field3" type="xsd:string" required="0"/>
<part name="group_by_field4" type="xsd:string" required="0"/>
<part name="group_by_field5" type="xsd:string" required="0"/>
<part name="group_by_field6" type="xsd:string" required="0"/>
<part name="group_by_field7" type="xsd:string" required="0"/>
<part name="group_by_field8" type="xsd:string" required="0"/>
<part name="group_by_field9" type="xsd:string" required="0"/>
<part name="group_by_field10" type="xsd:string" required="0"/>
<part name="group_by_field11" type="xsd:string" required="0"/>
<part name="group_by_field12" type="xsd:string" required="0"/>
<part name="filter_for_has_ssn" type="xsd:boolean" required="0"/>
<part name="filter_for_has_email" type="xsd:boolean" required="0"/>
<part name="filter_for_has_fein" type="xsd:boolean" required="0"/>
<part name="filter_for_has_dob" type="xsd:boolean" required="0"/>
<part name="filter_for_has_address" type="xsd:boolean" required="0"/>
<part name="filter_for_has_phone" type="xsd:boolean" required="0"/>
<part name="filter_for_has_adl" type="xsd:boolean" required="0"/>
<part name="filter_for_has_bdid" type="xsd:boolean" required="0"/>
</message>
*/

/*
Make 4 - Company ID (YM), Business Intel, Product, Populations. All will have date, opt in, and stat type.
*/

Export _test() := MACRO

#WORKUNIT('NAME','Inquiry_Tracking_Stats_GroupBy');

STRING50 group_by_field_value1 := ''	: STORED('group_by_field1');
STRING50 group_by_field_value2 := ''	: STORED('group_by_field2');
STRING50 group_by_field_value3 := ''	: STORED('group_by_field3');
STRING50 group_by_field_value4 := ''	: STORED('group_by_field4');
STRING50 group_by_field_value5 := ''	: STORED('group_by_field5');
STRING50 group_by_field_value6 := ''	: STORED('group_by_field6');
STRING50 group_by_field_value7 := ''	: STORED('group_by_field7');
STRING50 group_by_field_value8 := ''	: STORED('group_by_field8');
STRING50 group_by_field_value9 := ''	: STORED('group_by_field9');
STRING50 group_by_field_value10 := ''	: STORED('group_by_field10');
STRING50 group_by_field_value11 := ''	: STORED('group_by_field11');
STRING50 group_by_field_value12 := ''	: STORED('group_by_field12');
BOOLEAN	phas_ssn := false			: STORED('filter_for_has_ssn');
BOOLEAN	phas_email := false		: STORED('filter_for_has_email');
BOOLEAN	phas_ein := false			: STORED('filter_for_has_fein');
BOOLEAN	phas_dob := false			: STORED('filter_for_has_dob');
BOOLEAN	phas_address := false	: STORED('filter_for_has_address');
BOOLEAN	phas_phone := false		: STORED('filter_for_has_phone');
BOOLEAN	phas_adl := false			: STORED('filter_for_has_adl');
BOOLEAN	phas_bdid := false		: STORED('filter_for_has_bdid');

use_population_filters := phas_phone or phas_email or phas_ssn;

key_layout := RECORD
  string60 global_company_id;
  string60 company_id;
  string1 product_code;
  string60 company_name;
  string10 use;
  boolean opt_out;
  string30 industry;
  string30 vertical;
  string30 sub_market;
  string6 transaction_date;
  integer8 sum_field;
 END;

t7 := dataset([], key_layout);

k7 := index(t7, {t7}, '~thor10_11::key::table_7'); 

ds_new := k7;

acceptable_values := ['','YEAR','INDUSTRY','PRODUCT','PRODUCT CODE','SUB MARKET','VERTICAL','OPT IN','OPT OUT','GLOBAL COMPANY ID','COMPANY ID','DATE','USE'];

is_valid(string group_by_field_value) := group_by_field_value in acceptable_values;

choose_field(string group_by_field_value) := map(group_by_field_value = 'INDUSTRY' and is_valid(group_by_field_value) => ds_new.industry,
																			// group_by_field_value = 'PRODUCT' and is_valid(group_by_field_value) => ds_new.product,
																			group_by_field_value = 'PRODUCT CODE' and is_valid(group_by_field_value) => ds_new.product_code,
																			group_by_field_value = 'SUB MARKET' and is_valid(group_by_field_value) => ds_new.sub_market,
																			group_by_field_value = 'VERTICAL' and is_valid(group_by_field_value) => ds_new.VERTICAL,
																			group_by_field_value = 'OPT IN' and is_valid(group_by_field_value) => (string)ds_new.opt_out,
																			group_by_field_value = 'OPT OUT' and is_valid(group_by_field_value) => (string)ds_new.opt_out,
																			group_by_field_value = 'GLOBAL COMPANY ID' and is_valid(group_by_field_value) => ds_new.global_company_id,
																			group_by_field_value = 'COMPANY ID' and is_valid(group_by_field_value) => ds_new.company_id,
																			group_by_field_value = 'DATE' and is_valid(group_by_field_value) => ds_new.transaction_date,
																			group_by_field_value = 'YEAR' and is_valid(group_by_field_value) => ds_new.transaction_date[..4],
																			// group_by_field_value = 'CCYYMMDD' and is_valid(group_by_field_value) => ds_new.transaction_datey+ds_new.transaction_datem+ds_new.transaction_dated,
																			// group_by_field_value = 'CCYY' and is_valid(group_by_field_value) => ds_new.transaction_datey,
																			group_by_field_value = 'USE' and is_valid(group_by_field_value) => ds_new.use, '');

// #if (group_by_field_value1 = 'VERTICAL')
// choose_ds := t2;
// #elseif (regexfind('(INDUSTRY)&(SUB MARKET)', group_by_field_value1+group_by_field_value2))
// choose_ds := t3;
// #elseif (group_by_field_value1 = 'PRODUCT')
// choose_ds := t1;
// #else
choose_ds := ds_new;
// #end

tb1 := table(choose_ds, {sum_field,
								 field1 := stringlib.stringtouppercase(choose_field(group_by_field_value1)),
								 field2 := stringlib.stringtouppercase(choose_field(group_by_field_value2)),
								 field3 := stringlib.stringtouppercase(choose_field(group_by_field_value3)),
								 field4 := stringlib.stringtouppercase(choose_field(group_by_field_value4)),
								 field5 := stringlib.stringtouppercase(choose_field(group_by_field_value5)),
								 field6 := stringlib.stringtouppercase(choose_field(group_by_field_value6)),
								 field7 := stringlib.stringtouppercase(choose_field(group_by_field_value7)),
								 field8 := stringlib.stringtouppercase(choose_field(group_by_field_value8)),
								 field9 := stringlib.stringtouppercase(choose_field(group_by_field_value9)),
								 field10 := stringlib.stringtouppercase(choose_field(group_by_field_value10)),
								 field11 := stringlib.stringtouppercase(choose_field(group_by_field_value11)),
								 field12 := stringlib.stringtouppercase(choose_field(group_by_field_value12))});
								 // source;
								 // product_code;
								 // has_ssn;
								 // has_email;
								 // has_ein;
								 // has_dob;
								 // has_address;
								 // has_phone;
								 // has_adl;
								 // has_bdid});
								 
// filt_t1 := tb1(if(phas_ssn, (string)has_ssn > '0', source <> ''));
// filt_t2 := filt_t1(if(phas_email, (string)has_email >'0', source <> ''));
// filt_t3 := filt_t2(if(phas_ein, (string)has_ein >'0', source <> ''));
// filt_t4 := filt_t3(if(phas_dob, (string)has_dob >'0', source <> ''));
// filt_t5 := filt_t4(if(phas_address, (string)has_address >'0', source <> ''));
// filt_t6 := filt_t5(if(phas_phone, (string)has_phone >'0', source <> ''));
// filt_t7 := filt_t6(if(phas_adl, (string)has_adl >'0', source <> ''));
// filt_t8 := filt_t7(if(phas_bdid, (string)has_bdid >'0', source <> ''));

// #if(use_population_filters)
// filt_t8;
// #else
// tb1;
// #end

tb2 := table(tb1, {sum_groups := sum(group, sum_field),
									field1,
									field2,
									field3,
									field4,
									field5,
									field6,
									field7,
									field8,
									field9,
									field10,
									field11,
									field12},
									field1,
									field2,
									field3,
									field4,
									field5,
									field6,
									field7,
									field8,
									field9,
									field10,
									field11,
									field12, 
									few);

// OUTPUT(ds, named('test_output'));
OUTPUT(group_by_field_value1 + ', ' + group_by_field_value2 + ', ' + group_by_field_value3 + ', ' + group_by_field_value4, named('Fields_Selected'));
OUTPUT(choosen(sort(tb2, record, except sum_groups), 5000), named('test_group'));
endmacro;