//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.defendant_counties_BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT Scrubs_Crim,SALT33;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.defendant_counties_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.defendant_counties_Hygiene(ip);
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
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourcename,Examples),NAMED('sourcenameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourcetype,Examples),NAMED('sourcetypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,statecode,Examples),NAMED('statecodeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,recordtype,Examples),NAMED('recordtypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,recorduploaddate,Examples),NAMED('recorduploaddateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,docnumber,Examples),NAMED('docnumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,fbinumber,Examples),NAMED('fbinumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,stateidnumber,Examples),NAMED('stateidnumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,inmatenumber,Examples),NAMED('inmatenumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,aliennumber,Examples),NAMED('aliennumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,orig_ssn,Examples),NAMED('orig_ssnByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,nametype,Examples),NAMED('nametypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,name,Examples),NAMED('nameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,lastname,Examples),NAMED('lastnameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,firstname,Examples),NAMED('firstnameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,middlename,Examples),NAMED('middlenameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,suffix,Examples),NAMED('suffixByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,defendantstatus,Examples),NAMED('defendantstatusByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,defendantadditionalinfo,Examples),NAMED('defendantadditionalinfoByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,dob,Examples),NAMED('dobByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,birthcity,Examples),NAMED('birthcityByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,birthplace,Examples),NAMED('birthplaceByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,age,Examples),NAMED('ageByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,gender,Examples),NAMED('genderByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,height,Examples),NAMED('heightByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,weight,Examples),NAMED('weightByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,haircolor,Examples),NAMED('haircolorByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,eyecolor,Examples),NAMED('eyecolorByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,race,Examples),NAMED('raceByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,ethnicity,Examples),NAMED('ethnicityByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,skincolor,Examples),NAMED('skincolorByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,bodymarks,Examples),NAMED('bodymarksByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,physicalbuild,Examples),NAMED('physicalbuildByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,photoname,Examples),NAMED('photonameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,dlnumber,Examples),NAMED('dlnumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,dlstate,Examples),NAMED('dlstateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,phone,Examples),NAMED('phoneByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,phonetype,Examples),NAMED('phonetypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,uscitizenflag,Examples),NAMED('uscitizenflagByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,addresstype,Examples),NAMED('addresstypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,street,Examples),NAMED('streetByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,unit,Examples),NAMED('unitByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,city,Examples),NAMED('cityByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,orig_state,Examples),NAMED('orig_stateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,orig_zip,Examples),NAMED('orig_zipByvendor'));
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
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourceid,Examples),NAMED('sourceidByvendor'));
