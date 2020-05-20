//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.defendant_BWR_Hygiene - Hygiene & Stats - SALT V3.11.9');
IMPORT Scrubs_Crim,SALT311;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.defendant_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.defendant_hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'defendant_Layout_crim'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,recordid,Examples),NAMED('recordidByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sourcename,Examples),NAMED('sourcenameByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sourcetype,Examples),NAMED('sourcetypeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,statecode,Examples),NAMED('statecodeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,recordtype,Examples),NAMED('recordtypeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,recorduploaddate,Examples),NAMED('recorduploaddateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,docnumber,Examples),NAMED('docnumberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,fbinumber,Examples),NAMED('fbinumberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,stateidnumber,Examples),NAMED('stateidnumberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,inmatenumber,Examples),NAMED('inmatenumberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,aliennumber,Examples),NAMED('aliennumberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,orig_ssn,Examples),NAMED('orig_ssnByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,nametype,Examples),NAMED('nametypeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,name,Examples),NAMED('nameByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,lastname,Examples),NAMED('lastnameByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,firstname,Examples),NAMED('firstnameByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,middlename,Examples),NAMED('middlenameByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,suffix,Examples),NAMED('suffixByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,defendantstatus,Examples),NAMED('defendantstatusByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,defendantadditionalinfo,Examples),NAMED('defendantadditionalinfoByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,dob,Examples),NAMED('dobByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,birthcity,Examples),NAMED('birthcityByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,birthplace,Examples),NAMED('birthplaceByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,age,Examples),NAMED('ageByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,gender,Examples),NAMED('genderByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,height,Examples),NAMED('heightByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,weight,Examples),NAMED('weightByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,haircolor,Examples),NAMED('haircolorByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,eyecolor,Examples),NAMED('eyecolorByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,race,Examples),NAMED('raceByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,ethnicity,Examples),NAMED('ethnicityByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,skincolor,Examples),NAMED('skincolorByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,bodymarks,Examples),NAMED('bodymarksByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,physicalbuild,Examples),NAMED('physicalbuildByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,photoname,Examples),NAMED('photonameByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,dlnumber,Examples),NAMED('dlnumberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,dlstate,Examples),NAMED('dlstateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,phone,Examples),NAMED('phoneByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,phonetype,Examples),NAMED('phonetypeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,uscitizenflag,Examples),NAMED('uscitizenflagByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,addresstype,Examples),NAMED('addresstypeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,street,Examples),NAMED('streetByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,unit,Examples),NAMED('unitByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,city,Examples),NAMED('cityByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,orig_state,Examples),NAMED('orig_stateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,orig_zip,Examples),NAMED('orig_zipByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,county,Examples),NAMED('countyByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,institutionname,Examples),NAMED('institutionnameByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,institutiondetails,Examples),NAMED('institutiondetailsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,institutionreceiptdate,Examples),NAMED('institutionreceiptdateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,releasetolocation,Examples),NAMED('releasetolocationByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,releasetodetails,Examples),NAMED('releasetodetailsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,deceasedflag,Examples),NAMED('deceasedflagByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,deceaseddate,Examples),NAMED('deceaseddateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,healthflag,Examples),NAMED('healthflagByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,healthdesc,Examples),NAMED('healthdescByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,bloodtype,Examples),NAMED('bloodtypeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sexoffenderregistrydate,Examples),NAMED('sexoffenderregistrydateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sexoffenderregexpirationdate,Examples),NAMED('sexoffenderregexpirationdateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sexoffenderregistrynumber,Examples),NAMED('sexoffenderregistrynumberByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sourceid,Examples),NAMED('sourceidByvendor'));
