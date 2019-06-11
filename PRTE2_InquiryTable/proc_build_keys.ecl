import prte2_inquirytable, prte2, _control, prte, inquiry_acclogs, BIPV2, PRTE2_Common;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTO='') := function
#workunit('name','PRTE Inquiry Table');

  is_running_in_prod 		:= PRTE2_Common.Constants.is_running_in_prod;
  doDOPS 								:= is_running_in_prod AND NOT skipDOPS;

  df          := dataset([],inquiry_acclogs.Layout.common_indexes);
	df_NoCCPA   := dataset([],inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA);
  df_linkids  := dataset([],{Inquiry_AccLogs.Layout.Common_ThorAdditions_SBA,bipv2.IDlayouts.l_key_ids});

  rReformat := record
  BIPV2.IDlayouts.l_key_ids;
  Inquiry_AccLogs.Layout.Common_ThorAdditions_SBA;
  end;
  
  dfLinkid_reformat := project(df_linkids, rReformat);
  
  dsIndustryVerticalUse  := dataset([],Inquiry_AccLogs.Layout_MBS_Industry_vertical);
  df_did      := dataset([], Inquiry_AccLogs.Layout.Common_indexes_DID_SBA);
  
  dfCRA       := dataset([], inquiry_acclogs.Layout.common_ccpa); 
  dfDID_FCRA  := dataset([],inquiry_acclogs.Layout.Common_Indexes_FCRA_DID_SBA);
  
  df_bill := dataset([], recordof(Inquiry_AccLogs.File_Inquiry_Billgroups_DID().File));
  
 
	Key_Inquiry_Address := INDEX(df, {string5 zip := map((unsigned)person_q.zip > 0 => person_q.zip, person_q.zip5),person_q.prim_name,person_q.prim_range,person_q.sec_range}, {df},
                               prte2.Constants.Prefix + 'key::inquiry::'+filedate+'::address');

  Key_Inquiry_Phone := INDEX(df, {string10 phone10 := person_q.personal_phone}, {df}, prte2.Constants.Prefix + 'key::inquiry::'+filedate+'::phone');

  Key_Inquiry_SSN := INDEX(df, {string9 ssn := person_q.SSN}, {df}, prte2.Constants.Prefix + 'key::inquiry::'+filedate+'::ssn' );

  Key_Inquiry_DID := INDEX(df_did, {unsigned6 s_did := person_q.appended_ADL}, {df_did}, prte2.Constants.Prefix + 'key::inquiry::'+filedate+'::did');


  slim := record
	df.bus_intel;
	df.person_q;
	df.search_info;
	df.fraudpoint_score;
	inquiry_acclogs.Layout.ccpaLayout ccpa;
  end;
  
  df_email := project(df, transform(slim, self := left));

	Key_Inquiry_Email := INDEX(df_email, {string50 email_address := person_q.email_address}, {df_email}, prte2.Constants.Prefix +  'key::inquiry::'+filedate+'::email');

  Key_Inquiry_Billgroups := INDEX(df_bill, {did}, {df_bill}, prte2.Constants.Prefix + 'key::inquiry::'+filedate+'::billgroups_did');
  
  
  
  r:= record
  recordof(df_NoCCPA);
  inquiry_acclogs.layout.ccpaLayout ccpa;
  end;

  dsFein := project(df_NoCCPA,transform(r,self:=left)); 
  Key_Inquiry_Fein := INDEX(dsFein, {string15 appended_ein := bus_q.appended_ein}, {dsFein}, prte2.Constants.Prefix +'key::inquiry::'+filedate+'::fein');
	
  
  Layout_slim := record
	df.bus_intel;
	df.person_q;
	df.search_info;
	inquiry_acclogs.layout.ccpaLayout ccpa;
  end;

  p := project(df, transform(Layout_slim, self := left, self := []));
	Key_Inquiry_IPaddr := INDEX(p, {string20 IPaddr := person_q.IPaddr}, {p}, prte2.Constants.Prefix + 'key::inquiry::'+filedate+'::IPAddr');

  rLinkids:= record
	recordof(dfLinkid_reformat);
	Inquiry_AccLogs.Layout.ccpaLayout ccpa;
  integer1 fp;
	end;
	
	Base := project(dfLinkid_reformat, transform(rLinkids,self:=left, self := [])); 
  Key_Inquiry_Linkids := index(Base, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {Base}, prte2.Constants.Prefix + 'key::inquiry::'+filedate+'::linkids');
  
  Key_Inquiry_Name := INDEX(p, {person_q.fname,person_q.mname,person_q.lname}, {p}, prte2.Constants.Prefix +'key::inquiry::'+filedate+'::name') ;

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
 Key_Inquiry_Transaction_ID := INDEX(dfTransaction, {transaction_id}, {dfTransaction},  prte2.Constants.Prefix +'key::inquiry::'+filedate+'::transaction_id');



// FCRA Keys            
  Key_Inquiry_Address_FCRA  := INDEX(dfCRA, {string5 zip := map((unsigned)person_q.zip > 0 => person_q.zip, person_q.zip5),person_q.prim_name,person_q.prim_range,person_q.sec_range}, {dfCRA},
                                    prte2.Constants.Prefix + 'key::inquiry::fcra::'+filedate+'::address');          
						
  Key_Inquiry_Phone_FCRA    := INDEX(dfCRA, {string10 phone10 := person_q.personal_phone}, {dfCRA}, prte2.Constants.Prefix + 'key::inquiry::fcra::'+filedate+'::phone');

  Key_Inquiry_SSN_FCRA      := INDEX(dfCRA, {string9 ssn := person_q.SSN}, {dfCRA}, prte2.Constants.Prefix + 'key::inquiry::fcra::'+filedate+'::ssn' );
  
  Key_Inquiry_DID_FCRA      := INDEX(dfDID_FCRA, {person_q.appended_adl}, {dfDID_FCRA}, prte2.Constants.Prefix + 'key::inquiry::fcra::'+filedate+'::did');

  Key_Inquiry_Billgroups_FCRA := INDEX(df_bill, {did}, {df_bill}, prte2.Constants.Prefix + 'key::inquiry::fcra::'+filedate+'::billgroups_did'); 

  rMBS := RECORD
  string20 s_company_id;
  string4 s_product_id;
  string20 s_gc_id;
  string product_id;
  string gc_id;
  string company_id;
  string billing_id;
  string banko_mn;
  string company_id_finance;
  string pid;
  string id_source;
  string sub_acct_id;
  string co_cd;
  string vertical;
  string market;
  string sub_market;
  string industry;
  string use;
  string mbs_primary_market_code;
  string mbs_secondary_market_code;
  string mbs_industry_code_1;
  string mbs_industry_code_2;
  string primary_market_code;
  string secondary_market_code;
  string industry_code_1;
  string industry_code_2;
  unsigned8 __internal_fpos__;
 END;
 
 dfMBS := dataset([], rMBS);
  
  vert        := dataset([],Inquiry_AccLogs.Layout_MBS_Industry_vertical);
  Key_Inquiry_industry_use_vertical := INDEX(vert, 
                                            {string20 s_company_id := company_id, 
                                             string4 s_product_id := product_id,
                                             string20 s_gc_id := gc_id }, 
                                             {vert},
                                             prte2.Constants.Prefix +'key::inquiry_table::fcra::'+filedate+'::industry_use_vertical');																

  
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
                                                          prte2.Constants.Prefix + 'key::inquiry_table::fcra::'+filedate+'::industry_use_vertical_login');


  //---------- making DOPS optional -------------------------------
  notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
  NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
 	updatedops   		 		:= PRTE.UpdateVersion('InquirytableKeys',filedate,notifyEmail,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_InquirytableKeys',filedate,notifyEmail,'B','F','N');
	PerformUpdateOrNot 	:= IF(doDOPS,parallel(updatedops,updatedops_fcra),NoUpdate);
//--------------------------------------------------------------------------------------
	
	return 
	sequential(
		parallel(
			 build(Key_Inquiry_Address 		      ,update)
			,build(Key_Inquiry_Phone  		      ,update)
			,build(Key_Inquiry_SSN  		        ,update)
			,build(Key_Inquiry_DID  		        ,update)
			,build(Key_Inquiry_Email  		      ,update)
			,build(Key_Inquiry_Billgroups       ,update)
      ,build(Key_Inquiry_Fein             ,update)
      ,build(Key_Inquiry_IPaddr           ,update)
      ,build(Key_Inquiry_Linkids          ,update)
      ,build(Key_Inquiry_Name             ,update)
      ,build(Key_Inquiry_Transaction_ID   ,update)
      ,build(Key_Inquiry_Address_FCRA     ,update)
      ,build(Key_Inquiry_Billgroups_FCRA  ,update)
      ,build(Key_Inquiry_DID_FCRA         ,update)
      ,build(Key_Inquiry_Phone_FCRA       ,update)
      ,build(Key_Inquiry_SSN_FCRA         ,update)
      ,build(Key_Inquiry_industry_use_vertical        ,update)
      ,build(Key_Inquiry_Industry_use_vertical_login  ,update)
   	)
      ,PerformUpdateOrNot
	);
	
end;