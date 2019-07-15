EXPORT output_bug_tests(
//	 dataset(layout_DOT_Base)	pDataset
	 string										pCombo 		= ''		
	,string										pConst		= ''		
) :=
function
/*
APPLE , 1 INFINITE LOOP, CUPERTINO, CA.
updated bug, need to check other examples in the bug next
*/
dbase24  := BIPV2_ProxID.files('20130330_24').base.logical;
dbase27  := BIPV2_ProxID.files('20130330_27').base.logical;
dbase28  := BIPV2_ProxID.files('20130330_28').base.logical;
dbase29  := BIPV2_ProxID.files('20130330_29').base.logical;
dbase30  := BIPV2_ProxID.files('20130330_30').base.logical;
dbase31  := BIPV2_ProxID.files('20130330_31').base.logical;
dbase32  := BIPV2_ProxID.files('20130330_32').base.logical;
dbasenew := BIPV2_ProxID.files(pCombo).base.logical;
dfilt24_Bug123149   := dbase24(prim_range = '1',prim_name = 'INFINITE',v_city_name = 'CUPERTINO',regexfind('^(?!.*?(service|value|care|domestic|saving|invest|pacific|semi|japan|asia|retail|sever|summary|401K|public|health|welfare|credit|commercial|csc|peter).*)apple.*$',company_name,nocase)) : independent;
dfilt27_Bug123149   := dbase27(prim_range = '1',prim_name = 'INFINITE',v_city_name = 'CUPERTINO',regexfind('^(?!.*?(service|value|care|domestic|saving|invest|pacific|semi|japan|asia|retail|sever|summary|401K|public|health|welfare|credit|commercial|csc|peter).*)apple.*$',company_name,nocase)) : independent;
dfilt28_Bug123149   := dbase28(prim_range = '1',prim_name = 'INFINITE',v_city_name = 'CUPERTINO',regexfind('^(?!.*?(service|value|care|domestic|saving|invest|pacific|semi|japan|asia|retail|sever|summary|401K|public|health|welfare|credit|commercial|csc|peter).*)apple.*$',company_name,nocase)) : independent;
dfilt29_Bug123149   := dbase29(prim_range = '1',prim_name = 'INFINITE',v_city_name = 'CUPERTINO',regexfind('^(?!.*?(service|value|care|domestic|saving|invest|pacific|semi|japan|asia|retail|sever|summary|401K|public|health|welfare|credit|commercial|csc|peter).*)apple.*$',company_name,nocase)) : independent;
dfilt30_Bug123149   := dbase30(prim_range = '1',prim_name = 'INFINITE',v_city_name = 'CUPERTINO',regexfind('^(?!.*?(service|value|care|domestic|saving|invest|pacific|semi|japan|asia|retail|sever|summary|401K|public|health|welfare|credit|commercial|csc|peter).*)apple.*$',company_name,nocase)) : independent;
dfilt31_Bug123149   := dbase31(prim_range = '1',prim_name = 'INFINITE',v_city_name = 'CUPERTINO',regexfind('^(?!.*?(service|value|care|domestic|saving|invest|pacific|semi|japan|asia|retail|sever|summary|401K|public|health|welfare|credit|commercial|csc|peter).*)apple.*$',company_name,nocase)) : independent;
dfilt32_Bug123149   := dbase32(prim_range = '1',prim_name = 'INFINITE',v_city_name = 'CUPERTINO',regexfind('^(?!.*?(service|value|care|domestic|saving|invest|pacific|semi|japan|asia|retail|sever|summary|401K|public|health|welfare|credit|commercial|csc|peter).*)apple.*$',company_name,nocase)) : independent;
dfiltnew_Bug123149  := dbasenew(prim_range = '1',prim_name = 'INFINITE',v_city_name = 'CUPERTINO',regexfind('^(?!.*?(service|value|care|domestic|saving|invest|pacific|semi|japan|asia|retail|sever|summary|401K|public|health|welfare|credit|commercial|csc|peter).*)apple.*$',company_name,nocase)) : independent;
dagg24_Bug123149  := BIPV2_ProxID.AggregateProxidElements(dfilt24_Bug123149);
dagg27_Bug123149  := BIPV2_ProxID.AggregateProxidElements(dfilt27_Bug123149);
dagg28_Bug123149  := BIPV2_ProxID.AggregateProxidElements(dfilt28_Bug123149);
dagg29_Bug123149  := BIPV2_ProxID.AggregateProxidElements(dfilt29_Bug123149);
dagg30_Bug123149  := BIPV2_ProxID.AggregateProxidElements(dfilt30_Bug123149);
dagg31_Bug123149  := BIPV2_ProxID.AggregateProxidElements(dfilt31_Bug123149);
dagg32_Bug123149  := BIPV2_ProxID.AggregateProxidElements(dfilt32_Bug123149);
daggnew_Bug123149 := BIPV2_ProxID.AggregateProxidElements(dfiltnew_Bug123149);
dobug123149 := parallel(
   output('Bug: 123149 - LINKING: Search is bringing back duplicate results')
  ,output(choosen(dfilt24_Bug123149  ,500),named('dfilt24_Bug123149'),all)
  ,output(choosen(dfilt27_Bug123149  ,500),named('dfilt27_Bug123149'),all)
  ,output(choosen(dfilt28_Bug123149  ,500),named('dfilt28_Bug123149'),all)
  ,output(choosen(dfilt29_Bug123149  ,500),named('dfilt29_Bug123149'),all)
  ,output(choosen(dfilt30_Bug123149  ,500),named('dfilt30_Bug123149'),all)
  ,output(choosen(dfilt31_Bug123149  ,500),named('dfilt31_Bug123149'),all)
  ,output(choosen(dfilt32_Bug123149  ,500),named('dfilt32_Bug123149'),all)
  ,output(choosen(dfiltnew_Bug123149 ,500),named('dfiltnew_Bug123149'),all)
  ,output(sort(dagg24_Bug123149,addresss[1].address,company_names[1].company_name)   ,named('dagg24_Bug123149'),all)
  ,output(sort(dagg27_Bug123149,addresss[1].address,company_names[1].company_name)   ,named('dagg27_Bug123149'),all)
  ,output(sort(dagg28_Bug123149,addresss[1].address,company_names[1].company_name)   ,named('dagg28_Bug123149'),all)
  ,output(sort(dagg29_Bug123149,addresss[1].address,company_names[1].company_name)   ,named('dagg29_Bug123149'),all)
  ,output(sort(dagg30_Bug123149,addresss[1].address,company_names[1].company_name)   ,named('dagg30_Bug123149'),all)
  ,output(sort(dagg31_Bug123149,addresss[1].address,company_names[1].company_name)   ,named('dagg31_Bug123149'),all)
  ,output(sort(dagg32_Bug123149  ,addresss[1].address,company_names[1].company_name) ,named('dagg32_Bug123149'),all)
  ,output(sort(daggnew_Bug123149 ,addresss[1].address,company_names[1].company_name) ,named('daggnew_Bug123149'),all)
);
///////////////////////////////////////////////////////////////////
ffilt_Bug124743(dataset(recordof(dbase27)) pdataset) :=
pdataset(
      (prim_range = '333'   and prim_name = 'LEO'       and v_city_name = 'DAYTON'        and regexfind('potato'      ,company_name,nocase))
  or  (prim_range = '4411'  and prim_name = 'MICHIGAN'  and v_city_name = 'MICHIGAN CITY' and regexfind('city motors' ,company_name,nocase))
) : independent;
dbase27_filt_Bug124743  := ffilt_Bug124743(dbase27);
dbase28_filt_Bug124743  := ffilt_Bug124743(dbase28);
dbase29_filt_Bug124743  := ffilt_Bug124743(dbase29);
dbase30_filt_Bug124743  := ffilt_Bug124743(dbase30);
dbase31_filt_Bug124743  := ffilt_Bug124743(dbase31);
dbase32_filt_Bug124743  := ffilt_Bug124743(dbase32);
dbasenew_filt_Bug124743  := ffilt_Bug124743(dbasenew);
dagg27_Bug124743 := BIPV2_ProxID.AggregateProxidElements(dbase27_filt_Bug124743);
dagg28_Bug124743 := BIPV2_ProxID.AggregateProxidElements(dbase28_filt_Bug124743);
dagg29_Bug124743 := BIPV2_ProxID.AggregateProxidElements(dbase29_filt_Bug124743);
dagg30_Bug124743 := BIPV2_ProxID.AggregateProxidElements(dbase30_filt_Bug124743);
dagg31_Bug124743 := BIPV2_ProxID.AggregateProxidElements(dbase31_filt_Bug124743);
dagg32_Bug124743 := BIPV2_ProxID.AggregateProxidElements(dbase32_filt_Bug124743);
daggnew_Bug124743 := BIPV2_ProxID.AggregateProxidElements(dbasenew_filt_Bug124743);
dobug124743 := parallel(
   output('Bug: 124743 - LINKING: Companies not coming together with difference of punctuation, Inc, etc.')
  ,output(choosen(dbase27_filt_Bug124743,500),named('dbase27_filt_Bug124743'),all)
  ,output(choosen(dbase28_filt_Bug124743,500),named('dbase28_filt_Bug124743'),all)
  ,output(choosen(dbase29_filt_Bug124743,500),named('dbase29_filt_Bug124743'),all)
  ,output(choosen(dbase30_filt_Bug124743,500),named('dbase30_filt_Bug124743'),all)
  ,output(choosen(dbase31_filt_Bug124743,500),named('dbase31_filt_Bug124743'),all)
  ,output(choosen(dbase32_filt_Bug124743,500),named('dbase32_filt_Bug124743'),all)
  ,output(choosen(dbasenew_filt_Bug124743,500),named('dbasenew_filt_Bug124743'),all)
  
  ,output(sort(dagg27_Bug124743 ,addresss[1].address,company_names[1].company_name) ,named('dagg27_Bug124743'),all)
  ,output(sort(dagg28_Bug124743 ,addresss[1].address,company_names[1].company_name) ,named('dagg28_Bug124743'),all)
  ,output(sort(dagg29_Bug124743 ,addresss[1].address,company_names[1].company_name) ,named('dagg29_Bug124743'),all)
  ,output(sort(dagg30_Bug124743 ,addresss[1].address,company_names[1].company_name) ,named('dagg30_Bug124743'),all)
  ,output(sort(dagg31_Bug124743 ,addresss[1].address,company_names[1].company_name) ,named('dagg31_Bug124743'),all)
  ,output(sort(dagg32_Bug124743 ,addresss[1].address,company_names[1].company_name) ,named('dagg32_Bug124743'),all)
  ,output(sort(daggnew_Bug124743,addresss[1].address,company_names[1].company_name) ,named('daggnew_Bug124743'),all)
);
///////////////////////////////////////////////////////////////////
setproxids_CvrgIssues := [122420628,185032141,195343469,194867238,314779221,555740263,833003344,869365001,350867006,74988541,8119856,8253147,160316135,477022738];
dbase29_filt_CvrgIssues  := dbase29(proxid in setproxids_CvrgIssues);
setrcids_CvrgIssues := set(dbase29_filt_CvrgIssues,rcid);
ffilt_CvrgIssues(dataset(recordof(dbase27)) pdataset) :=
pdataset(
      rcid in setrcids_CvrgIssues
) : independent;
dbase27_filt_CvrgIssues  := ffilt_CvrgIssues(dbase27);
dbase28_filt_CvrgIssues  := ffilt_CvrgIssues(dbase28);
dbase30_filt_CvrgIssues  := ffilt_CvrgIssues(dbase30);
dbase31_filt_CvrgIssues  := ffilt_CvrgIssues(dbase31);
dbase32_filt_CvrgIssues  := ffilt_CvrgIssues(dbase32);
dbasenew_filt_CvrgIssues  := ffilt_CvrgIssues(dbasenew);
dagg27_filt_CvrgIssues  := BIPV2_ProxID.AggregateProxidElements(dbase27_filt_CvrgIssues );
dagg28_filt_CvrgIssues  := BIPV2_ProxID.AggregateProxidElements(dbase28_filt_CvrgIssues );
dagg29_filt_CvrgIssues  := BIPV2_ProxID.AggregateProxidElements(dbase29_filt_CvrgIssues );
dagg30_filt_CvrgIssues  := BIPV2_ProxID.AggregateProxidElements(dbase30_filt_CvrgIssues );
dagg31_filt_CvrgIssues  := BIPV2_ProxID.AggregateProxidElements(dbase31_filt_CvrgIssues );
dagg32_filt_CvrgIssues  := BIPV2_ProxID.AggregateProxidElements(dbase32_filt_CvrgIssues );
daggnew_filt_CvrgIssues := BIPV2_ProxID.AggregateProxidElements(dbasenew_filt_CvrgIssues); 
dobugCvrgIssues := parallel(
   output('BIPV2 Convergence issues')
  ,output(choosen(dbase27_filt_CvrgIssues ,500),named('dbase27_filt_CvrgIssues'),all)
  ,output(choosen(dbase28_filt_CvrgIssues ,500),named('dbase28_filt_CvrgIssues'),all)
  ,output(choosen(dbase29_filt_CvrgIssues ,500),named('dbase29_filt_CvrgIssues'),all)
  ,output(choosen(dbase30_filt_CvrgIssues ,500),named('dbase30_filt_CvrgIssues'),all)
  ,output(choosen(dbase31_filt_CvrgIssues ,500),named('dbase31_filt_CvrgIssues'),all)
  ,output(choosen(dbase32_filt_CvrgIssues ,500),named('dbase32_filt_CvrgIssues'),all)
  ,output(choosen(dbasenew_filt_CvrgIssues,500),named('dbasenew_filt_CvrgIssues'),all)
  
  ,output(sort(dagg27_filt_CvrgIssues  ,addresss[1].address,company_names[1].company_name),named('dagg27_filt_CvrgIssues'),all)
  ,output(sort(dagg28_filt_CvrgIssues  ,addresss[1].address,company_names[1].company_name),named('dagg28_filt_CvrgIssues'),all)
  ,output(sort(dagg29_filt_CvrgIssues  ,addresss[1].address,company_names[1].company_name),named('dagg29_filt_CvrgIssues'),all)
  ,output(sort(dagg30_filt_CvrgIssues  ,addresss[1].address,company_names[1].company_name),named('dagg30_filt_CvrgIssues'),all)
  ,output(sort(dagg31_filt_CvrgIssues  ,addresss[1].address,company_names[1].company_name),named('dagg31_filt_CvrgIssues'),all)
  ,output(sort(dagg32_filt_CvrgIssues  ,addresss[1].address,company_names[1].company_name),named('dagg32_filt_CvrgIssues'),all)
  ,output(sort(daggnew_filt_CvrgIssues ,addresss[1].address,company_names[1].company_name),named('daggnew_filt_CvrgIssues'),all)
);
/////////////////////////
ffilt_Bug124784(dataset(recordof(dbase27)) pdataset) :=
pdataset(
      company_phone = '9543548338'
) : independent;
dbase27_filt_Bug124784  := ffilt_Bug124784(dbase27);
dbase28_filt_Bug124784  := ffilt_Bug124784(dbase28);
dbase29_filt_Bug124784  := ffilt_Bug124784(dbase29);
dbase30_filt_Bug124784  := ffilt_Bug124784(dbase30);
dbase31_filt_Bug124784  := ffilt_Bug124784(dbase31);
dbase32_filt_Bug124784  := ffilt_Bug124784(dbase32);
dbasenew_filt_Bug124784  := ffilt_Bug124784(dbasenew);
dagg27_filt_Bug124784  := BIPV2_ProxID.AggregateProxidElements(dbase27_filt_Bug124784 );
dagg28_filt_Bug124784  := BIPV2_ProxID.AggregateProxidElements(dbase28_filt_Bug124784 );
dagg29_filt_Bug124784  := BIPV2_ProxID.AggregateProxidElements(dbase29_filt_Bug124784 );
dagg30_filt_Bug124784  := BIPV2_ProxID.AggregateProxidElements(dbase30_filt_Bug124784 );
dagg31_filt_Bug124784  := BIPV2_ProxID.AggregateProxidElements(dbase31_filt_Bug124784 );
dagg32_filt_Bug124784  := BIPV2_ProxID.AggregateProxidElements(dbase32_filt_Bug124784 );
daggnew_filt_Bug124784 := BIPV2_ProxID.AggregateProxidElements(dbasenew_filt_Bug124784); 
dobugBug124784 := parallel(
   output('Bug: 124784 - LINKING: Cross-pollination of Industry & Phone Info?')
  ,output(choosen(dbase27_filt_Bug124784 ,500),named('dbase27_filt_Bug124784'),all)
/*  ,output(choosen(dbase28_filt_Bug124784 ,500),named('dbase28_filt_Bug124784'),all)
  ,output(choosen(dbase29_filt_Bug124784 ,500),named('dbase29_filt_Bug124784'),all)
  ,output(choosen(dbase30_filt_Bug124784 ,500),named('dbase30_filt_Bug124784'),all)
  ,output(choosen(dbase31_filt_Bug124784 ,500),named('dbase31_filt_Bug124784'),all)
  ,output(choosen(dbase32_filt_Bug124784 ,500),named('dbase32_filt_Bug124784'),all)
*/  ,output(choosen(dbasenew_filt_Bug124784,500),named('dbasenew_filt_Bug124784'),all)
  
  ,output(sort(dagg27_filt_Bug124784  ,addresss[1].address,company_names[1].company_name),named('dagg27_filt_Bug124784'),all)
/*  ,output(sort(dagg28_filt_Bug124784  ,addresss[1].address,company_names[1].company_name),named('dagg28_filt_Bug124784'),all)
  ,output(sort(dagg29_filt_Bug124784  ,addresss[1].address,company_names[1].company_name),named('dagg29_filt_Bug124784'),all)
  ,output(sort(dagg30_filt_Bug124784  ,addresss[1].address,company_names[1].company_name),named('dagg30_filt_Bug124784'),all)
  ,output(sort(dagg31_filt_Bug124784  ,addresss[1].address,company_names[1].company_name),named('dagg31_filt_Bug124784'),all)
  ,output(sort(dagg32_filt_Bug124784  ,addresss[1].address,company_names[1].company_name),named('dagg32_filt_Bug124784'),all)
*/  ,output(sort(daggnew_filt_Bug124784 ,addresss[1].address,company_names[1].company_name),named('daggnew_filt_Bug124784'),all)
);
///////////////////////////////////////////////////////////////////
setproxids_Bug_124768 := [132082838,218165120,132224081,132077075,1160646101,1010499233,1165131437,1152249724];
dbase29_filt_Bug_124768  := dbase29(proxid in setproxids_Bug_124768);
setrcids_Bug_124768 := set(dbase29_filt_Bug_124768,rcid);
ffilt_Bug_124768(dataset(recordof(dbase27)) pdataset) :=
pdataset(
      rcid in setrcids_Bug_124768
) : independent;
dbase27_filt_Bug_124768  := ffilt_Bug_124768(dbase27);
dbase28_filt_Bug_124768  := ffilt_Bug_124768(dbase28);
dbase30_filt_Bug_124768  := ffilt_Bug_124768(dbase30);
dbase31_filt_Bug_124768  := ffilt_Bug_124768(dbase31);
dbase32_filt_Bug_124768  := ffilt_Bug_124768(dbase32);
dbasenew_filt_Bug_124768  := ffilt_Bug_124768(dbasenew);
dagg27_filt_Bug_124768  := BIPV2_ProxID.AggregateProxidElements(dbase27_filt_Bug_124768 );
dagg28_filt_Bug_124768  := BIPV2_ProxID.AggregateProxidElements(dbase28_filt_Bug_124768 );
dagg29_filt_Bug_124768  := BIPV2_ProxID.AggregateProxidElements(dbase29_filt_Bug_124768 );
dagg30_filt_Bug_124768  := BIPV2_ProxID.AggregateProxidElements(dbase30_filt_Bug_124768 );
dagg31_filt_Bug_124768  := BIPV2_ProxID.AggregateProxidElements(dbase31_filt_Bug_124768 );
dagg32_filt_Bug_124768  := BIPV2_ProxID.AggregateProxidElements(dbase32_filt_Bug_124768 );
daggnew_filt_Bug_124768 := BIPV2_ProxID.AggregateProxidElements(dbasenew_filt_Bug_124768); 
dobugBug124768 := parallel(
   output('Bug: 124768 - LINKING: ProdID linking questions')
  ,output(choosen(dbase27_filt_Bug_124768 ,500),named('dbase27_filt_Bug_124768'),all)
  ,output(choosen(dbase28_filt_Bug_124768 ,500),named('dbase28_filt_Bug_124768'),all)
  ,output(choosen(dbase29_filt_Bug_124768 ,500),named('dbase29_filt_Bug_124768'),all)
  ,output(choosen(dbase30_filt_Bug_124768 ,500),named('dbase30_filt_Bug_124768'),all)
  ,output(choosen(dbase31_filt_Bug_124768 ,500),named('dbase31_filt_Bug_124768'),all)
  ,output(choosen(dbase32_filt_Bug_124768 ,500),named('dbase32_filt_Bug_124768'),all)
  ,output(choosen(dbasenew_filt_Bug_124768,500),named('dbasenew_filt_Bug_124768'),all)
  
  ,output(sort(dagg27_filt_Bug_124768  ,addresss[1].address,company_names[1].company_name),named('dagg27_filt_Bug_124768'),all)
  ,output(sort(dagg28_filt_Bug_124768  ,addresss[1].address,company_names[1].company_name),named('dagg28_filt_Bug_124768'),all)
  ,output(sort(dagg29_filt_Bug_124768  ,addresss[1].address,company_names[1].company_name),named('dagg29_filt_Bug_124768'),all)
  ,output(sort(dagg30_filt_Bug_124768  ,addresss[1].address,company_names[1].company_name),named('dagg30_filt_Bug_124768'),all)
  ,output(sort(dagg31_filt_Bug_124768  ,addresss[1].address,company_names[1].company_name),named('dagg31_filt_Bug_124768'),all)
  ,output(sort(dagg32_filt_Bug_124768  ,addresss[1].address,company_names[1].company_name),named('dagg32_filt_Bug_124768'),all)
  ,output(sort(daggnew_filt_Bug_124768 ,addresss[1].address,company_names[1].company_name),named('daggnew_filt_Bug_124768'),all)
);
///////////////////////////////////////////////////////////////////
//output('Bug: 124966 - LINKING: ProxID Internal Recall: Name variations that should be combining');
setproxids_Bug_124966 := [1606969750,109895745,109624255];
dbase29_filt_Bug_124966  := dbase29(proxid in setproxids_Bug_124966);
setrcids_Bug_124966 := set(dbase29_filt_Bug_124966,rcid);
ffilt_Bug_124966(dataset(recordof(dbase27)) pdataset) :=
pdataset(
      rcid in setrcids_Bug_124966
) : independent;
dbase27_filt_Bug_124966  := ffilt_Bug_124966(dbase27);
dbase28_filt_Bug_124966  := ffilt_Bug_124966(dbase28);
dbase30_filt_Bug_124966  := ffilt_Bug_124966(dbase30);
dbase31_filt_Bug_124966  := ffilt_Bug_124966(dbase31);
dbase32_filt_Bug_124966  := ffilt_Bug_124966(dbase32);
dbasenew_filt_Bug_124966  := ffilt_Bug_124966(dbasenew);
dagg27_filt_Bug_124966  := BIPV2_ProxID.AggregateProxidElements(dbase27_filt_Bug_124966 );
dagg28_filt_Bug_124966  := BIPV2_ProxID.AggregateProxidElements(dbase28_filt_Bug_124966 );
dagg29_filt_Bug_124966  := BIPV2_ProxID.AggregateProxidElements(dbase29_filt_Bug_124966 );
dagg30_filt_Bug_124966  := BIPV2_ProxID.AggregateProxidElements(dbase30_filt_Bug_124966 );
dagg31_filt_Bug_124966  := BIPV2_ProxID.AggregateProxidElements(dbase31_filt_Bug_124966 );
dagg32_filt_Bug_124966  := BIPV2_ProxID.AggregateProxidElements(dbase32_filt_Bug_124966 );
daggnew_filt_Bug_124966 := BIPV2_ProxID.AggregateProxidElements(dbasenew_filt_Bug_124966); 
dobugBug124966 := parallel(
   output('Bug: 124966 - LINKING: ProxID Internal Recall: Name variations that should be combining')
  ,output(choosen(dbase27_filt_Bug_124966 ,500),named('dbase27_filt_Bug_124966'),all)
  ,output(choosen(dbase28_filt_Bug_124966 ,500),named('dbase28_filt_Bug_124966'),all)
  ,output(choosen(dbase29_filt_Bug_124966 ,500),named('dbase29_filt_Bug_124966'),all)
  ,output(choosen(dbase30_filt_Bug_124966 ,500),named('dbase30_filt_Bug_124966'),all)
  ,output(choosen(dbase31_filt_Bug_124966 ,500),named('dbase31_filt_Bug_124966'),all)
  ,output(choosen(dbase32_filt_Bug_124966 ,500),named('dbase32_filt_Bug_124966'),all)
  ,output(choosen(dbasenew_filt_Bug_124966,500),named('dbasenew_filt_Bug_124966'),all)
  
  ,output(sort(dagg27_filt_Bug_124966  ,addresss[1].address,company_names[1].company_name),named('dagg27_filt_Bug_124966'),all)
  ,output(sort(dagg28_filt_Bug_124966  ,addresss[1].address,company_names[1].company_name),named('dagg28_filt_Bug_124966'),all)
  ,output(sort(dagg29_filt_Bug_124966  ,addresss[1].address,company_names[1].company_name),named('dagg29_filt_Bug_124966'),all)
  ,output(sort(dagg30_filt_Bug_124966  ,addresss[1].address,company_names[1].company_name),named('dagg30_filt_Bug_124966'),all)
  ,output(sort(dagg31_filt_Bug_124966  ,addresss[1].address,company_names[1].company_name),named('dagg31_filt_Bug_124966'),all)
  ,output(sort(dagg32_filt_Bug_124966  ,addresss[1].address,company_names[1].company_name),named('dagg32_filt_Bug_124966'),all)
  ,output(sort(daggnew_filt_Bug_124966 ,addresss[1].address,company_names[1].company_name),named('daggnew_filt_Bug_124966'),all)
);
return parallel(
 //  dobug123149
//  dobug124743
//  ,dobugCvrgIssues
  dobugBug124784
//  ,dobugBug124768
//  ,dobugBug124966
);
end;
