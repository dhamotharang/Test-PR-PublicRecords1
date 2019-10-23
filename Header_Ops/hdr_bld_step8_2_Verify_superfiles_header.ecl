IMPORT header;
#workunit('name','PersonHeader - verifysuperfiles');

output(choosen(header.verify_keys('PersonHeaderKeys')   ,1000), named('PersonHeaderKeys')   ,all);
output(choosen(header.verify_keys('PersonHeaderKeys',true)   ,1000), named('FCRA_PersonHeaderKeys')   ,all);
output(choosen(header.verify_keys('RelativeV3Keys')     ,1000),	named('RelativeKeys_v3')    ,all);
output(choosen(header.verify_keys('PersonSlimsortKeys') ,1000),	named('PersonSlimsortKeys') ,all);
output(choosen(header.verify_keys('PersonLabKeys')      ,1000),	named('PersonLabKeys')      ,all);
output(choosen(header.Verify_XADL1_base_files           ,1000),	named('XADLfiles')          ,all);
output(choosen(header.verify_keys('SourceKeys')         ,1000),	named('SourceKeys')         ,all);
output(choosen(header.verify_keys('PersonAncillaryKeys'),1000),	named('PersonAncillaryKeys'),all);
output(header.verify_keys('PowerSearchKeys',,true),named('PowerSearchKeys'));
// fileservices.sendemail('gabriel.marcan@lexisnexis.com'
											 // ,'PersonHeader '+Header.version_build+' keys verification'
											 // ,'Output has been created. See:'+workunit
											// );
// output(header.verify_keys('PersonHeaderKeys',true),named('FCRA_PersonHeaderKeys'));


//(run on hthor)

// 0626 W20180717-111732
// 0522 W20180620-134609
// 0320 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180419-140712#/stub/Summary
// 0221 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180321-094152#/stub/Summary 
// 0130 W20180306-122403
// 1121  W20180105-131659
// 1025a W20171206-103234 
// W20170905-235302 0725
// W20170807-102916 0628
// W20170724-103014 0522
// W20170613-093624 0430
// W20170501-153806 0321
// W20170321-130908 0223
// W20170222-102604 0123
// W20170117-122405
// W20161216-091159
// W20161122-081541
// W20160216-092800
// W20160119-104633
// W20151120-105834
// W20151118-110349
// W20151009-122501
// W20150813-120406
// W20160314-094201 - v20160223
