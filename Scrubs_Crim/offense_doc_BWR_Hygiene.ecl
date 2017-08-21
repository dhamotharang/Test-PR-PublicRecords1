//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.offense_doc_BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT Scrubs_Crim,SALT33;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.offense_doc_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.offense_doc_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT33.MAC_Character_Counts.EclRecord(p,'Layout_crim'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT33.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT33.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,recordid,Examples),NAMED('recordidByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,statecode,Examples),NAMED('statecodeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,caseid,Examples),NAMED('caseidByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,casenumber,Examples),NAMED('casenumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,casetitle,Examples),NAMED('casetitleByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,casetype,Examples),NAMED('casetypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,casestatus,Examples),NAMED('casestatusByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,casestatusdate,Examples),NAMED('casestatusdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,casecomments,Examples),NAMED('casecommentsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fileddate,Examples),NAMED('fileddateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,caseinfo,Examples),NAMED('caseinfoByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,docketnumber,Examples),NAMED('docketnumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensecode,Examples),NAMED('offensecodeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensedesc,Examples),NAMED('offensedescByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensedate,Examples),NAMED('offensedateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensetype,Examples),NAMED('offensetypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensedegree,Examples),NAMED('offensedegreeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offenseclass,Examples),NAMED('offenseclassByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,dispositionstatus,Examples),NAMED('dispositionstatusByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,dispositionstatusdate,Examples),NAMED('dispositionstatusdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,disposition,Examples),NAMED('dispositionByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,dispositiondate,Examples),NAMED('dispositiondateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offenselocation,Examples),NAMED('offenselocationByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,finaloffense,Examples),NAMED('finaloffenseByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,finaloffensedate,Examples),NAMED('finaloffensedateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensecount,Examples),NAMED('offensecountByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,victimunder18,Examples),NAMED('victimunder18Byvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,prioroffenseflag,Examples),NAMED('prioroffenseflagByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,initialplea,Examples),NAMED('initialpleaByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,initialpleadate,Examples),NAMED('initialpleadateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,finalruling,Examples),NAMED('finalrulingByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,finalrulingdate,Examples),NAMED('finalrulingdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,appealstatus,Examples),NAMED('appealstatusByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,appealdate,Examples),NAMED('appealdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,courtname,Examples),NAMED('courtnameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fineamount,Examples),NAMED('fineamountByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,courtfee,Examples),NAMED('courtfeeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,restitution,Examples),NAMED('restitutionByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,trialtype,Examples),NAMED('trialtypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,courtdate,Examples),NAMED('courtdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourcename,Examples),NAMED('sourcenameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourceid,Examples),NAMED('sourceidByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,classification_code,Examples),NAMED('classification_codeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sub_classification_code,Examples),NAMED('sub_classification_codeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,unit,Examples),NAMED('unitByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,city,Examples),NAMED('cityByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,state,Examples),NAMED('stateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,zip,Examples),NAMED('zipByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,county,Examples),NAMED('countyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,institutionname,Examples),NAMED('institutionnameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,institutiondetails,Examples),NAMED('institutiondetailsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,institutionreceiptdate,Examples),NAMED('institutionreceiptdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,releasetolocation,Examples),NAMED('releasetolocationByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,releasetodetails,Examples),NAMED('releasetodetailsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,deceasedflag,Examples),NAMED('deceasedflagByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,deceaseddate,Examples),NAMED('deceaseddateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,healthflag,Examples),NAMED('healthflagByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,healthdesc,Examples),NAMED('healthdescByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,bloodtype,Examples),NAMED('bloodtypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sexoffenderregistrydate,Examples),NAMED('sexoffenderregistrydateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sexoffenderregexpirationdate,Examples),NAMED('sexoffenderregexpirationdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sexoffenderregistrynumber,Examples),NAMED('sexoffenderregistrynumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourceid2,Examples),NAMED('sourceid2Byvendor'));
