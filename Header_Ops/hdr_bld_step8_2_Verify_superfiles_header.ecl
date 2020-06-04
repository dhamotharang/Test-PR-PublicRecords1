IMPORT header;

bver := header.version_build;
#workunit('name',bver + 'PersonHeader - verifysuperfiles');

PHKeys   := header.verify_keys('PersonHeaderKeys');
// F_PHKeys := header.verify_keys('PersonHeaderKeys',true);
RelKeys  := header.verify_keys('RelativeV3Keys');
PSlimKeys:= header.verify_keys('PersonSlimsortKeys');
PLabKeys := header.verify_keys('PersonLabKeys');
XAdlKeys := header.Verify_XADL1_base_files;
SrcKeys  := header.verify_keys('SourceKeys');
PAncKeys := header.verify_keys('PersonAncillaryKeys');
BoolKeys := header.verify_keys('PowerSearchKeys',,true);

output(PHKeys   ,named('PersonHeaderKeys')     ,all);
// output(F_PHKeys ,named('FCRA_PersonHeaderKeys'),all);
output(RelKeys  ,named('RelativeKeys_v3')      ,all);
output(PSlimKeys,named('PersonSlimsortKeys')   ,all);
output(PLabKeys ,named('PersonLabKeys')        ,all);
output(XAdlKeys ,named('XADLfiles')            ,all);
output(SrcKeys  ,named('SourceKeys')           ,all);
output(PAncKeys ,named('PersonAncillaryKeys')  ,all);
output(BoolKeys ,named('PowerSearchKeys')      ,all);

PHWrongKeys := PHKeys(~regexfind(bver, lfn));
if(count(PHWrongKeys) > 0, output(PHWrongKeys, named('PHWrongKeys'), all), output('ALL QA PersonHeaderKeys contains ' + bver + ' keys'));
// F_PHWrongKeys := F_PHKeys(~regexfind(bver, lfn));
// if(count(F_PHWrongKeys) > 0, output(F_PHWrongKeys, named('F_PHWrongKeys'), all), output('ALL QA FCRA_PersonHeaderKeys contains ' + bver + ' keys'));
RelWrongKeys := RelKeys(~regexfind(bver, lfn));
if(count(RelWrongKeys) > 0, output(RelWrongKeys, named('RelWrongKeys'), all), output('ALL QA RelativeKeys_v3 contains ' + bver + ' keys'));
SlimWrongKeys := PSlimKeys(~regexfind(bver, lfn));
if(count(SlimWrongKeys) > 0, output(SlimWrongKeys, named('SlimWrongKeys'), all), output('ALL QA PersonSlimsortKeys contains ' + bver + ' keys'));
LabWrongKeys := PLabKeys(~regexfind(bver, lfn));
if(count(LabWrongKeys) > 0, output(LabWrongKeys, named('LabWrongKeys'), all), output('ALL QA PersonLabKeys contains ' + bver + ' keys'));
XadlWrongKeys := XAdlKeys(regexfind('::qa::|_qa',sfn) and ~regexfind(bver, lfn[1].name));
if(count(XadlWrongKeys) > 0, output(XadlWrongKeys, named('XadlWrongKeys'), all), output('ALL QA XADLfiles contains ' + bver + ' keys'));
SrcWrongKeys := SrcKeys(~regexfind(bver, lfn));
if(count(SrcWrongKeys) > 0, output(SrcWrongKeys, named('SrcWrongKeys'), all), output('ALL QA SourceKeys contains ' + bver + ' keys'));
AncWrongKeys := PAncKeys(~regexfind(bver, lfn));
if(count(AncWrongKeys) > 0, output(AncWrongKeys, named('AncWrongKeys'), all), output('ALL QA PersonAncillaryKeys contains ' + bver + ' keys'));
BoolWrongKeys := BoolKeys(~regexfind(bver, lfn));
if(count(BoolWrongKeys) > 0, output(BoolWrongKeys, named('BoolWrongKeys'), all), output('ALL QA PowerSearchKeys contains ' + bver + ' keys'));

fileservices.sendemail('debendra.kumar@lexisnexisrisk.com;gabriel.marcan@lexisnexisrisk.com'
						,'PersonHeader '+bVer+' keys verification'
						,'Output has been created. See:'+workunit
						);

// (run on hthor)

//20191128 W20200103-133348 


