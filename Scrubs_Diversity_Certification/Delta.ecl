﻿IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_Diversity_Certification)old_s, DATASET(Layout_Diversity_Certification) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dartid','dateadded','dateupdated','website','state','profilelastupdated','county','servicearea','region1','region2','region3','region4','region5','fname','lname','mname','suffix','title','ethnicity','gender','address1','address2','addresscity','addressstate','addresszipcode','addresszip4','building','contact','phone1','phone2','phone3','cell','fax','email1','email2','email3','webpage1','webpage2','webpage3','businessname','dba','businessid','businesstype1','businesslocation1','businesstype2','businesslocation2','businesstype3','businesslocation3','businesstype4','businesslocation4','businesstype5','businesslocation5','industry','trade','resourcedescription','natureofbusiness','businessdescription','businessstructure','totalemployees','avgcontractsize','firmid','firmlocationaddress','firmlocationaddresscity','firmlocationaddresszip4','firmlocationaddresszipcode','firmlocationcounty','firmlocationstate','certfed','certstate','contractsfederal','contractsva','contractscommercial','contractorgovernmentprime','contractorgovernmentsub','contractornongovernment','registeredgovernmentbus','registerednongovernmentbus','clearancelevelpersonnel','clearancelevelfacility','certificatedatefrom1','certificatedateto1','certificatestatus1','certificationnumber1','certificationtype1','certificatedatefrom2','certificatedateto2','certificatestatus2','certificationnumber2','certificationtype2','certificatedatefrom3','certificatedateto3','certificatestatus3','certificationnumber3','certificationtype3','certificatedatefrom4','certificatedateto4','certificatestatus4','certificationnumber4','certificationtype4','certificatedatefrom5','certificatedateto5','certificatestatus5','certificationnumber5','certificationtype5','certificatedatefrom6','certificatedateto6','certificatestatus6','certificationnumber6','certificationtype6','starrating','assets','biddescription','competitiveadvantage','cagecode','capabilitiesnarrative','category','chtrclass','productdescription1','productdescription2','productdescription3','productdescription4','productdescription5','classdescription1','subclassdescription1','classdescription2','subclassdescription2','classdescription3','subclassdescription3','classdescription4','subclassdescription4','classdescription5','subclassdescription5','classifications','commodity1','commodity2','commodity3','commodity4','commodity5','commodity6','commodity7','commodity8','completedate','crossreference','dateestablished','businessage','deposits','dunsnumber','enttype','expirationdate','extendeddate','issuingauthority','keywords','licensenumber','licensetype','mincd','minorityaffiliation','minorityownershipdate','siccode1','siccode2','siccode3','siccode4','siccode5','siccode6','siccode7','siccode8','naicscode1','naicscode2','naicscode3','naicscode4','naicscode5','naicscode6','naicscode7','naicscode8','prequalify','procurementcategory1','subprocurementcategory1','procurementcategory2','subprocurementcategory2','procurementcategory3','subprocurementcategory3','procurementcategory4','subprocurementcategory4','procurementcategory5','subprocurementcategory5','renewal','renewaldate','unitedcertprogrampartner','vendorkey','vendornumber','workcode1','workcode2','workcode3','workcode4','workcode5','workcode6','workcode7','workcode8','exporter','exportbusinessactivities','exportto','exportbusinessrelationships','exportobjectives','reference1','reference2','reference3'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_Diversity_Certification, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_Diversity_Certification, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Diversity_Certification, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
