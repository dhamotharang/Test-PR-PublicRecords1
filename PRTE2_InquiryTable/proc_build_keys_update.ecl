import prte2_inquirytable, prte2, _control, prte, inquiry_acclogs, BIPV2, PRTE2_Common;

EXPORT proc_build_keys_update(string filedate, boolean skipDOPS=FALSE, string emailTO='') := function
#workunit('name','PRTE Inquiry Table Update');

 is_running_in_prod 		:= PRTE2_Common.Constants.is_running_in_prod;
 doDOPS 								:= is_running_in_prod AND NOT skipDOPS;
	
df          := dataset([],Inquiry_AccLogs.layout.common_indexes);
dfDID       := dataset([],Inquiry_AccLogs.Layout.Common_indexes_DID_SBA); 

vert        := dataset([],Inquiry_AccLogs.Layout_MBS_Industry_vertical);
															
key_inquiry_did_update := index(dfDID, {unsigned6 s_did := person_q.appended_ADL}, {dfDID}, prte2.Constants.Prefix +'key::inquiry::'+filedate+'::did_update');
																
key_inquiry_address_update := index(df, {string5 zip := person_q.zip,person_q.prim_name,person_q.prim_range,person_q.sec_range}, {df},
																prte2.Constants.Prefix +'key::inquiry::'+filedate+'::address_update');
																
key_inquiry_phone_update := index(df, {string10 phone10 := person_q.personal_phone}, {df}, prte2.Constants.Prefix +'key::inquiry::'+filedate+'::phone_update');
																
key_inquiry_ssn_update := index(df, {string9 ssn := person_q.SSN}, {df}, prte2.Constants.Prefix +	'key::inquiry::'+filedate+'::ssn_update');

slim := record
	df.bus_intel;
	df.person_q;
	df.search_info;
	df.fraudpoint_score;
  inquiry_acclogs.Layout.ccpaLayout ccpa;
  end;
	
p := project(df, transform(slim, 
	self.person_q.email_address := stringlib.stringtouppercase(left.person_q.email_address), 
	self := left));

key_inquiry_email_update := index(p, {string50 email_address := person_q.email_address}, {p}, prte2.Constants.Prefix +'key::inquiry::'+filedate+'::email_update');

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

key_inquiry_table_did := index(rolled, {did}, {rolled}, prte2.Constants.Prefix +'key::inquiry_table::'+filedate+'::did');
													
key_inquiry_industry_use := INDEX(vert, {string20 s_company_id := company_id, string4 s_product_id := product_id,string20 s_gc_id := gc_id }, {vert},
																prte2.Constants.Prefix +'key::inquiry_table::'+filedate+'::industry_use_vertical');																

rKey_ipaddr := record
	df.bus_intel;
	df.person_q;
	df.search_info;
	inquiry_acclogs.layout.ccpaLayout ccpa;
end;

  dsFile := dataset([], rKey_ipaddr);
  Key_Inquiry_IPaddr_update := INDEX(dsFile, {string20 IPaddr := person_q.IPaddr}, {dsFile}, prte2.Constants.Prefix + 'key::inquiry::' +filedate+ '::IPAddr_update');


rKey_fein:= record
inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA;
inquiry_acclogs.layout.ccpaLayout ccpa;
end;

dfFein := dataset([], rKey_fein); 

 Key_Inquiry_FEIN_Update := INDEX(dfFein, {string15 appended_ein := bus_q.appended_ein}, {dfFein}, prte2.Constants.Prefix + 'key::inquiry::' + filedate +'::fein_update');

 Key_Inquiry_name_update := INDEX(dsFile, {person_q.fname,person_q.mname,person_q.lname}, {dsFile},	prte2.Constants.Prefix + 'key::inquiry::' + filedate  + '::name_update');
					

  rReformat := record
    BIPV2.IDlayouts.l_key_ids;
    Inquiry_AccLogs.Layout.Common_ThorAdditions_SBA;
    Inquiry_AccLogs.Layout.ccpaLayout ccpa;
    integer1 fp;
  end;
  
    df_linkids := dataset([], rReformat);
  
  Key_Inquiry_Linkids_update := index(df_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {df_linkids}, prte2.Constants.Prefix + 'key::inquiry::'+filedate+'::linkids_update');


 rTransactionID := RECORD
  string50 transaction_id;
  unsigned6 appended_adl;
  string datetime;
  string industry;
  string vertical;
  string sub_market;
  string function_description;
  string product_code;
  string use;
  string sequence_number;
  unsigned8 __internal_fpos__;
 END;

 dfTransaction := dataset([],  rTransactionID);
 Key_Inquiry_Transaction_ID_Update := INDEX(dfTransaction, {transaction_id}, {dfTransaction},  prte2.Constants.Prefix + 'key::inquiry::' + filedate  + '::transaction_id_update');							


layout_desc := record
	string product_id;
	string transaction_type;
	string function_name;
	string description;
end;	

dfLookup := dataset([], layout_desc);
 
key_lookup_desc := INDEX(dfLookup, 
                                  {string4 s_product_id := product_id,
                                   string2 s_transaction_type := transaction_type, 
                                   string40 s_function_name := function_name}, 
                                   {dfLookup},
                                   prte2.Constants.Prefix +  'key::inquiry_table::'+ filedate+ '::lookup_function_desc');

rMBS_login := RECORD
  string20  s_company_id;
  string4   s_product_id;
  string20  s_gc_id;
  string    vertical;
  string    sub_market;
  string    industry;
  unsigned8 __internal_fpos__;
 END;
 
 dfMBS_login := dataset([], rMBS_login);

  Key_Inquiry_Industry_use_vertical_login := INDEX(dfMBS_login, {s_company_id, s_product_id, s_gc_id}, {dfMBS_login},
                                                          prte2.Constants.Prefix + 'key::inquiry_table::'+filedate+'::industry_use_vertical_login');

//---------- making DOPS optional -------------------------------
  notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
  NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
 	updatedops   		 		:= PRTE.UpdateVersion('InquiryTableUpdateKeys',filedate,notifyEmail,'B','N','N');
	PerformUpdateOrNot 	:= IF(doDOPS,updatedops,NoUpdate);
//--------------------------------------------------------------------------------------
	
	return 
	sequential(
		parallel(
			 build(Key_Inquiry_Address_update 		          ,update)
			,build(Key_Inquiry_Phone_update  		            ,update)
			,build(Key_Inquiry_SSN_update  		              ,update)
			,build(Key_Inquiry_DID_update  		              ,update)
			,build(Key_Inquiry_Email_update  		            ,update)
			,build(Key_Inquiry_Fein_update                  ,update)
      ,build(Key_Inquiry_IPaddr_update                ,update)
      ,build(Key_Inquiry_Linkids_update               ,update)
      ,build(Key_Inquiry_Name_update                  ,update)
      ,build(Key_Inquiry_Transaction_ID_update        ,update)
      ,build(Key_lookup_desc                          ,update)
      ,build(Key_inquiry_table_did                    ,update) 
      ,build(key_inquiry_industry_use                 ,update)
      ,build(Key_Inquiry_Industry_use_vertical_login  ,update)
   	)
      ,PerformUpdateOrNot
	);
	
end;
