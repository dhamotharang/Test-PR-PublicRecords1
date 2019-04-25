EXPORT Compare_function_v4_batch(current_dt,previous_dt) := functionmacro


 file1:= dataset('~foreign::10.241.3.238::sghatti::out::batch_fcra_rvattributes_v4_'+previous_dt, RiskView_Attributes_Reports.batch_fcra_rvattributes_v4_layout,


 CSV(HEADING(single), QUOTE('"')));

 file2:= dataset('~foreign::10.241.3.238::sghatti::out::batch_fcra_rvattributes_v4_'+current_dt, RiskView_Attributes_Reports.batch_fcra_rvattributes_v4_layout,


 CSV(HEADING(single), QUOTE('"')));


 
	
aa:=join(file1,file2,left.accountnumber=right.accountnumber,inner);



projected_layout:= record
string12 did;
 string6 history_date;
  string200 errorcode;
RiskView_Attributes_Reports.fcra_rvattributes_v4_layout - {unsigned8 seq,  string6 historydate,
unsigned6 did,boolean fnamepop,
  boolean lnamepop,
  boolean addrpop,
  string1 ssnlength,
  boolean dobpop,
  boolean emailpop,
  boolean ipaddrpop,
  boolean hphnpop};
	
end;

projected_layout func(file1 l):=transform
self.did:=l.did;
self.accountnumber:=l.accountnumber;
self.ageoldestrecord:=l.v4_ageoldestrecord;
self.agenewestrecord:=l.v4_agenewestrecord;
self.recentupdate:=l.v4_recentupdate;
self. srcsconfirmidaddrcount:=l.v4_srcsconfirmidaddrcount;
self. invaliddl:=l.v4_invaliddl;
self. verificationfailure:=l.v4_verificationfailure;
self. ssnnotfound:=l.v4_ssnnotfound;
self. verifiedname:=l.v4_verifiedname;
self. verifiedssn:=l.v4_verifiedssn;
self. verifiedphone:=l.v4_verifiedphone;
self. verifiedaddress:=l.v4_verifiedaddress;
self. verifieddob:=l.v4_verifieddob;
self. inferredminimumage:=l.v4_inferredminimumage;
self. bestreportedage:=l.v4_bestreportedage;
self. subjectssncount:=l.v4_subjectssncount;
self. subjectaddrcount:=l.v4_subjectaddrcount;
self. subjectphonecount:=l.v4_subjectphonecount;
self. subjectssnrecentcount:=l.v4_subjectssnrecentcount;
self. subjectaddrrecentcount:=l.v4_subjectaddrrecentcount;
self. subjectphonerecentcount:=l.v4_subjectphonerecentcount;
self. ssnidentitiescount:=l.v4_ssnidentitiescount;
self. ssnaddrcount:=l.v4_ssnaddrcount;
self. ssnidentitiesrecentcount:=l.v4_ssnidentitiesrecentcount;
self. ssnaddrrecentcount:=l.v4_ssnaddrrecentcount;
self. inputaddrphonecount:=l.v4_inputaddrphonecount;
self. inputaddrphonerecentcount:=l.v4_inputaddrphonerecentcount;
self. phoneidentitiescount:=l.v4_phoneidentitiescount;
self. phoneidentitiesrecentcount:=l.v4_phoneidentitiesrecentcount;
self. ssnagedeceased:=l.v4_ssnagedeceased;
self. ssnrecent:=l.v4_ssnrecent;
self. ssnlowissueage:=l.v4_ssnlowissueage;
self. ssnhighissueage:=l.v4_ssnhighissueage;
self. ssnissuestate:=l.v4_ssnissuestate;
self. ssnnonus:=l.v4_ssnnonus;
self. ssn3years:=l.v4_ssn3years;
self. ssnafter5:=l.v4_ssnafter5;
self. ssnproblems:=l.v4_ssnproblems;
self. inputaddrageoldestrecord:=l.v4_inputaddrageoldestrecord;
self. inputaddragenewestrecord:=l.v4_inputaddragenewestrecord;
self. inputaddrhistoricalmatch:=l.v4_inputaddrhistoricalmatch;
self. inputaddrlenofres:=l.v4_inputaddrlenofres;
self. inputaddrdwelltype:=l.v4_inputaddrdwelltype;
self. inputaddrdelivery:=l.v4_inputaddrdelivery;
self. inputaddrapplicantowned:=l.v4_inputaddrapplicantowned;
self. inputaddrfamilyowned:=l.v4_inputaddrfamilyowned;
self. inputaddroccupantowned:=l.v4_inputaddroccupantowned;
self. inputaddragelastsale:=l.v4_inputaddragelastsale;
self.inputaddrlastsalesprice:=l.v4_inputaddrlastsalesprice;
self. inputaddrmortgagetype:=l.v4_inputaddrmortgagetype;
self. inputaddrnotprimaryres:=l.v4_inputaddrnotprimaryres;
self. inputaddractivephonelist:=l.v4_inputaddractivephonelist;
self. inputaddrtaxvalue:=l.v4_inputaddrtaxvalue;
self. inputaddrtaxyr:=l.v4_inputaddrtaxyr;
self. inputaddrtaxmarketvalue:=l.v4_inputaddrtaxmarketvalue;
self. inputaddravmvalue:=l.v4_inputaddravmvalue;
self.inputaddravmvalue12:=l.v4_inputaddravmvalue12;
self. inputaddravmvalue60:=l.v4_inputaddravmvalue60;
self. inputaddrcountyindex:=l.v4_inputaddrcountyindex;
self. inputaddrtractindex:=l.v4_inputaddrtractindex;
self. inputaddrblockindex:=l.v4_inputaddrblockindex;
self. curraddrageoldestrecord:=l.v4_curraddrageoldestrecord;
self. curraddragenewestrecord:=l.v4_curraddragenewestrecord;
self. curraddrlenofres:=l.v4_curraddrlenofres;
self. curraddrdwelltype:=l.v4_curraddrdwelltype;
self. curraddrapplicantowned:=l.v4_curraddrapplicantowned;
self. curraddrfamilyowned:=l.v4_curraddrfamilyowned;
self. curraddroccupantowned:=l.v4_curraddroccupantowned;
self. curraddragelastsale:=l.v4_curraddragelastsale;
self.curraddrlastsalesprice:=l.v4_curraddrlastsalesprice;
self. curraddrmortgagetype:=l.v4_curraddrmortgagetype;
self. curraddractivephonelist:=l.v4_curraddractivephonelist;
self. curraddrtaxvalue:=l.v4_curraddrtaxvalue;
self. curraddrtaxyr:=l.v4_curraddrtaxyr;
self. curraddrtaxmarketvalue:=l.v4_curraddrtaxmarketvalue;
self. curraddravmvalue:=l.v4_curraddravmvalue;
self. curraddravmvalue12:=l.v4_curraddravmvalue12;
self. curraddravmvalue60:=l.v4_curraddravmvalue60;
self. curraddrcountyindex:=l.v4_curraddrcountyindex;
self. curraddrtractindex:=l.v4_curraddrtractindex;
self. curraddrblockindex:=l.v4_curraddrblockindex;
self. prevaddrageoldestrecord:=l.v4_prevaddrageoldestrecord;
self. prevaddragenewestrecord:=l.v4_prevaddragenewestrecord;
self. prevaddrlenofres:=l.v4_prevaddrlenofres;
self. prevaddrdwelltype:=l.v4_prevaddrdwelltype;
self. prevaddrapplicantowned:=l.v4_prevaddrapplicantowned;
self. prevaddrfamilyowned:=l.v4_prevaddrfamilyowned;
self. prevaddroccupantowned:=l.v4_prevaddroccupantowned;
self. prevaddragelastsale:=l.v4_prevaddragelastsale;
self. prevaddrlastsalesprice:=l.v4_prevaddrlastsalesprice;
self. prevaddrtaxvalue:=l.v4_prevaddrtaxvalue;
self. prevaddrtaxyr:=l.v4_prevaddrtaxyr;
self. prevaddrtaxmarketvalue:=l.v4_prevaddrtaxmarketvalue;
self. prevaddravmvalue:=l.v4_prevaddravmvalue;
self. prevaddrcountyindex:=l.v4_prevaddrcountyindex;
self. prevaddrtractindex:=l.v4_prevaddrtractindex;
self. prevaddrblockindex:=l.v4_prevaddrblockindex;
self. addrmostrecentdistance:=l.v4_addrmostrecentdistance;
self. addrmostrecentstatediff:=l.v4_addrmostrecentstatediff;
self. addrmostrecenttaxdiff:=l.v4_addrmostrecenttaxdiff;
self. addrmostrecentmoveage:=l.v4_addrmostrecentmoveage;
self. addrrecentecontrajectory:=l.v4_addrrecentecontrajectory;
self. addrrecentecontrajectoryindex:=l.v4_addrrecentecontrajectoryindex;
self. educationattendedcollege:=l.v4_educationattendedcollege;
self. educationprogram2yr:=l.v4_educationprogram2yr;
self. educationprogram4yr:=l.v4_educationprogram4yr;
self. educationprogramgraduate:=l.v4_educationprogramgraduate;
self. educationinstitutionprivate:=l.v4_educationinstitutionprivate;
self. educationfieldofstudytype:=l.v4_educationfieldofstudytype;
self. educationinstitutionrating:=l.v4_educationinstitutionrating;
self. addrstability:=l.v4_addrstability;
self. statusmostrecent:=l.v4_statusmostrecent;
self. statusprevious:=l.v4_statusprevious;
self. statusnextprevious:=l.v4_statusnextprevious;
self. addrchangecount01:=l.v4_addrchangecount01;
self. addrchangecount03:=l.v4_addrchangecount03;
self. addrchangecount06:=l.v4_addrchangecount06;
self. addrchangecount12:=l.v4_addrchangecount12;
self. addrchangecount24:=l.v4_addrchangecount24;
self. addrchangecount60:=l.v4_addrchangecount60;
self. estimatedannualincome:=l.v4_estimatedannualincome;
self. propertyowner:=l.v4_propertyowner;
self. propownedcount:=l.v4_propownedcount;
self. propownedtaxtotal:=l.v4_propownedtaxtotal;
self. propownedhistoricalcount:=l.v4_propownedhistoricalcount;
self. propageoldestpurchase:=l.v4_propageoldestpurchase;
self. propagenewestpurchase:=l.v4_propagenewestpurchase;
self. propagenewestsale:=l.v4_propagenewestsale;
self. propnewestsaleprice:=l.v4_propnewestsaleprice;
self. propnewestsalepurchaseindex:=l.v4_propnewestsalepurchaseindex;
self. proppurchasedcount01:=l.v4_proppurchasedcount01;
self. proppurchasedcount03:=l.v4_proppurchasedcount03;
self. proppurchasedcount06:=l.v4_proppurchasedcount06;
self. proppurchasedcount12:=l.v4_proppurchasedcount12;
self. proppurchasedcount24:=l.v4_proppurchasedcount24;
self. proppurchasedcount60:=l.v4_proppurchasedcount60;
self. propsoldcount01:=l.v4_propsoldcount01;
self. propsoldcount03:=l.v4_propsoldcount03;
self. propsoldcount06:=l.v4_propsoldcount06;
self. propsoldcount12:=l.v4_propsoldcount12;
self. propsoldcount24:=l.v4_propsoldcount24;
self. propsoldcount60:=l.v4_propsoldcount60;
self. assetowner:=l.v4_assetowner;
self. watercraftowner:=l.v4_watercraftowner;
self. watercraftcount:=l.v4_watercraftcount;
self. watercraftcount01:=l.v4_watercraftcount01;
self. watercraftcount03:=l.v4_watercraftcount03;
self. watercraftcount06:=l.v4_watercraftcount06;
self. watercraftcount12:=l.v4_watercraftcount12;
self. watercraftcount24:=l.v4_watercraftcount24;
self. watercraftcount60:=l.v4_watercraftcount60;
self. aircraftowner:=l.v4_aircraftowner;
self. aircraftcount:=l.v4_aircraftcount;
self. aircraftcount01:=l.v4_aircraftcount01;
self. aircraftcount03:=l.v4_aircraftcount03;
self. aircraftcount06:=l.v4_aircraftcount06;
self. aircraftcount12:=l.v4_aircraftcount12;
self. aircraftcount24:=l.v4_aircraftcount24;
self. aircraftcount60:=l.v4_aircraftcount60;
self. wealthindex:=l.v4_wealthindex;
self. businessactiveassociation:=l.v4_businessactiveassociation;
self. businessinactiveassociation:=l.v4_businessinactiveassociation;
self. businessassociationage:=l.v4_businessassociationage;
self. businesstitle:=l.v4_businesstitle;
self. derogseverityindex:=l.v4_derogseverityindex;
self. derogcount:=l.v4_derogcount;
self. derogrecentcount:=l.v4_derogrecentcount;
self. derogage:=l.v4_derogage;
self. felonycount:=l.v4_felonycount;
self. felonyage:=l.v4_felonyage;
self. felonycount01:=l.v4_felonycount01;
self. felonycount03:=l.v4_felonycount03;
self. felonycount06:=l.v4_felonycount06;
self. felonycount12:=l.v4_felonycount12;
self. felonycount24:=l.v4_felonycount24;
self. felonycount60:=l.v4_felonycount60;
self. liencount:=l.v4_liencount;
self. lienfiledcount:=l.v4_lienfiledcount;
self. lienfiledage:=l.v4_lienfiledage;
self. lienfiledcount01:=l.v4_lienfiledcount01;
self. lienfiledcount03:=l.v4_lienfiledcount03;
self. lienfiledcount06:=l.v4_lienfiledcount06;
self. lienfiledcount12:=l.v4_lienfiledcount12;
self. lienfiledcount24:=l.v4_lienfiledcount24;
self. lienfiledcount60:=l.v4_lienfiledcount60;
self. lienreleasedcount:=l.v4_lienreleasedcount;
self. lienreleasedage:=l.v4_lienreleasedage;
self. lienreleasedcount01:=l.v4_lienreleasedcount01;
self. lienreleasedcount03:=l.v4_lienreleasedcount03;
self. lienreleasedcount06:=l.v4_lienreleasedcount06;
self. lienreleasedcount12:=l.v4_lienreleasedcount12;
self. lienreleasedcount24:=l.v4_lienreleasedcount24;
self. lienreleasedcount60:=l.v4_lienreleasedcount60;
self. lienfiledtotal:=l.v4_lienfiledtotal;
self.lienfederaltaxfiledtotal:=l.v4_lienfederaltaxfiledtotal;
self. lientaxotherfiledtotal:=l.v4_lientaxotherfiledtotal;
self. lienforeclosurefiledtotal:=l.v4_lienforeclosurefiledtotal;
self. lienlandlordtenantfiledtotal:=l.v4_lienlandlordtenantfiledtotal;
self. lienjudgmentfiledtotal:=l.v4_lienjudgmentfiledtotal;
self. liensmallclaimsfiledtotal:=l.v4_liensmallclaimsfiledtotal;
self.lienotherfiledtotal:=l.v4_lienotherfiledtotal;
self. lienreleasedtotal:=l.v4_lienreleasedtotal;
self. lienfederaltaxreleasedtotal:=l.v4_lienfederaltaxreleasedtotal;
self.lientaxotherreleasedtotal:=l.v4_lientaxotherreleasedtotal;
self. lienforeclosurereleasedtotal:=l.v4_lienforeclosurereleasedtotal;
self. lienlandlordtenantreleasedtotal:=l.v4_lienlandlordtenantreleasedtotal;
self.lienjudgmentreleasedtotal:=l.v4_lienjudgmentreleasedtotal;
self. liensmallclaimsreleasedtotal:=l.v4_liensmallclaimsreleasedtotal;
self. lienotherreleasedtotal:=l.v4_lienotherreleasedtotal;
self. lienfederaltaxfiledcount:=l.v4_lienfederaltaxfiledcount;
self. lientaxotherfiledcount:=l.v4_lientaxotherfiledcount;
self. lienforeclosurefiledcount:=l.v4_lienforeclosurefiledcount;
self. lienlandlordtenantfiledcount:=l.v4_lienlandlordtenantfiledcount;
self. lienjudgmentfiledcount:=l.v4_lienjudgmentfiledcount;
self. liensmallclaimsfiledcount:=l.v4_liensmallclaimsfiledcount;
self. lienotherfiledcount:=l.v4_lienotherfiledcount;
self. lienfederaltaxreleasedcount:=l.v4_lienfederaltaxreleasedcount;
self. lientaxotherreleasedcount:=l.v4_lientaxotherreleasedcount;
self. lienforeclosurereleasedcount:=l.v4_lienforeclosurereleasedcount;
self. lienlandlordtenantreleasedcount:=l.v4_lienlandlordtenantreleasedcount;
self. lienjudgmentreleasedcount:=l.v4_lienjudgmentreleasedcount;
self. liensmallclaimsreleasedcount:=l.v4_liensmallclaimsreleasedcount;
self. lienotherreleasedcount:=l.v4_lienotherreleasedcount;
self. bankruptcycount:=l.v4_bankruptcycount;
self. bankruptcyage:=l.v4_bankruptcyage;
self. bankruptcytype:=l.v4_bankruptcytype;
self. bankruptcystatus:=l.v4_bankruptcystatus;
self. bankruptcycount01:=l.v4_bankruptcycount01;
self. bankruptcycount03:=l.v4_bankruptcycount03;
self. bankruptcycount06:=l.v4_bankruptcycount06;
self. bankruptcycount12:=l.v4_bankruptcycount12;
self. bankruptcycount24:=l.v4_bankruptcycount24;
self. bankruptcycount60:=l.v4_bankruptcycount60;
self. evictioncount:=l.v4_evictioncount;
self. evictionage:=l.v4_evictionage;
self. evictioncount01:=l.v4_evictioncount01;
self. evictioncount03:=l.v4_evictioncount03;
self. evictioncount06:=l.v4_evictioncount06;
self. evictioncount12:=l.v4_evictioncount12;
self. evictioncount24:=l.v4_evictioncount24;
self. evictioncount60:=l.v4_evictioncount60;
self. recentactivityindex:=l.v4_recentactivityindex;
self. nonderogcount:=l.v4_nonderogcount;
self. nonderogcount01:=l.v4_nonderogcount01;
self. nonderogcount03:=l.v4_nonderogcount03;
self. nonderogcount06:=l.v4_nonderogcount06;
self. nonderogcount12:=l.v4_nonderogcount12;
self. nonderogcount24:=l.v4_nonderogcount24;
self. nonderogcount60:=l.v4_nonderogcount60;
self. voterregistrationrecord:=l.v4_voterregistrationrecord;
self. profliccount:=l.v4_profliccount;
self. proflicage:=l.v4_proflicage;
self.proflictype:=l.v4_proflictype;
self. proflictypecategory:=l.v4_proflictypecategory;
self. proflicexpired:=l.v4_proflicexpired;
self. profliccount01:=l.v4_profliccount01;
self. profliccount03:=l.v4_profliccount03;
self. profliccount06:=l.v4_profliccount06;
self. profliccount12:=l.v4_profliccount12;
self. profliccount24:=l.v4_profliccount24;
self. profliccount60:=l.v4_profliccount60;
self. inquirycollectionsrecent:=l.v4_inquirycollectionsrecent;
self. inquirypersonalfinancerecent:=l.v4_inquirypersonalfinancerecent;
self. inquiryotherrecent:=l.v4_inquiryotherrecent;
self. highriskcreditactivity:=l.v4_highriskcreditactivity;
self. subprimeofferrequestcount:=l.v4_subprimeofferrequestcount;
self. subprimeofferrequestcount01:=l.v4_subprimeofferrequestcount01;
self. subprimeofferrequestcount03:=l.v4_subprimeofferrequestcount03;
self. subprimeofferrequestcount06:=l.v4_subprimeofferrequestcount06;
self. subprimeofferrequestcount12:=l.v4_subprimeofferrequestcount12;
self. subprimeofferrequestcount24:=l.v4_subprimeofferrequestcount24;
self. subprimeofferrequestcount60:=l.v4_subprimeofferrequestcount60;
self. inputphonemobile:=l.v4_inputphonemobile;
self. phoneedaageoldestrecord:=l.v4_phoneedaageoldestrecord;
self. phoneedaagenewestrecord:=l.v4_phoneedaagenewestrecord;
self. phoneotherageoldestrecord:=l.v4_phoneotherageoldestrecord;
self. phoneotheragenewestrecord:=l.v4_phoneotheragenewestrecord;
self. inputphonehighrisk:=l.v4_inputphonehighrisk;
self. inputphoneproblems:=l.v4_inputphoneproblems;
self. emailaddress:=l.v4_emailaddress;
self. inputaddrhighrisk:=l.v4_inputaddrhighrisk;
self. curraddrcorrectional:=l.v4_curraddrcorrectional;
self. prevaddrcorrectional:=l.v4_prevaddrcorrectional;
self. historicaladdrcorrectional:=l.v4_historicaladdrcorrectional;
self. inputaddrproblems:=l.v4_inputaddrproblems;
self. securityfreeze:=l.v4_securityfreeze;
self. securityalert:=l.v4_securityalert;
self. idtheftflag:=l.v4_idtheftflag;
self. consumerstatement:=l.v4_consumerstatement;
self. prescreenoptout:=l.v4_prescreenoptout;
self.history_date:=l.history_date;
 self.errorcode:=l.errorcode;

end;

file3:=project(file1,func(left));



 file4:=project(file2,func(left));



DS1:=join(file3,aa,left.accountnumber=right.accountnumber,inner);

DS2:=join(file4,aa,left.accountnumber=right.accountnumber,inner);


   	    
      	
      	RiskView_Attributes_Reports.Range_func(DS1,'ageoldestrecord',ra1);
      	RiskView_Attributes_Reports.Range_func(DS1,'agenewestrecord',ra2);
				RiskView_Attributes_Reports.Range_func(DS1,'ssnagedeceased',ra3);
      	RiskView_Attributes_Reports.Range_func(DS1,'ssnlowissueage',ra4);
      	RiskView_Attributes_Reports.Range_func(DS1,'ssnhighissueage',ra5);
				RiskView_Attributes_Reports.Range_func(DS1,'inputaddrageoldestrecord',ra6);
      	RiskView_Attributes_Reports.Range_func(DS1,'inputaddragenewestrecord',ra7);
      	RiskView_Attributes_Reports.Range_func(DS1,'inputaddrlenofres',ra8);
				RiskView_Attributes_Reports.Range_func(DS1,'inputaddragelastsale',ra9);
				RiskView_Attributes_Reports.Range_func(DS1,'inferredminimumage',ra10);
      	RiskView_Attributes_Reports.Range_func(DS1,'bestreportedage',ra11);
				RiskView_Attributes_Reports.Range_func(DS1,'curraddrageoldestrecord',ra12);
				RiskView_Attributes_Reports.Range_func(DS1,'curraddragenewestrecord',ra13);
      	RiskView_Attributes_Reports.Range_func(DS1,'curraddrlenofres',ra14);
      	RiskView_Attributes_Reports.Range_func(DS1,'curraddragelastsale',ra15);
				RiskView_Attributes_Reports.Range_func(DS1,'prevaddrageoldestrecord',ra16);
      	RiskView_Attributes_Reports.Range_func(DS1,'prevaddragenewestrecord',ra17);
      	RiskView_Attributes_Reports.Range_func(DS1,'prevaddrlenofres',ra18);
				RiskView_Attributes_Reports.Range_func(DS1,'prevaddragelastsale',ra19);
				RiskView_Attributes_Reports.Range_func(DS1,'addrmostrecentmoveage',ra20);
				RiskView_Attributes_Reports.Range_func(DS1,'propageoldestpurchase',ra21);
      	RiskView_Attributes_Reports.Range_func(DS1,'propagenewestpurchase',ra22);
				RiskView_Attributes_Reports.Range_func(DS1,'propagenewestsale',ra23);
				RiskView_Attributes_Reports.Range_func(DS1,'businessassociationage',ra24);
				RiskView_Attributes_Reports.Range_func(DS1,'proflicage',ra25);
				RiskView_Attributes_Reports.Range_func(DS1,'phoneedaageoldestrecord',ra26);
      	RiskView_Attributes_Reports.Range_func(DS1,'phoneedaagenewestrecord',ra27);
      	RiskView_Attributes_Reports.Range_func(DS1,'phoneotherageoldestrecord',ra28);
				RiskView_Attributes_Reports.Range_func(DS1,'phoneotheragenewestrecord',ra29);
      	
				
			  	
      	ra:= ra1  + ra2  + ra3  + ra4  + ra5  + ra6  + ra7  + ra8  + ra9  + ra10 +
				     ra11 + ra12 + ra13 + ra14 + ra15 + ra16 + ra17 + ra18 + ra19 + ra20 +
						 ra21 + ra22 + ra23 + ra24 + ra25 + ra26 + ra27 + ra28 + ra29 ;
      	
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount',ra0_1);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount01',ra0_2);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount03',ra0_3);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount06',ra0_4);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount12',ra0_5);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount24',ra0_6);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'addrchangecount60',ra0_7);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propownedcount',ra0_8);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'propownedhistoricalcount',ra0_9);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount01',ra0_10);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount03',ra0_11);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount06',ra0_12);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount12',ra0_13);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount24',ra0_14);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'proppurchasedcount60',ra0_15);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount01',ra0_16);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount03',ra0_17);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount06',ra0_18);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount12',ra0_19);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount24',ra0_20);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'propsoldcount60',ra0_21);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount',ra0_22);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount01',ra0_23);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount03',ra0_24);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount06',ra0_25);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount12',ra0_26);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount24',ra0_27);
			  	RiskView_Attributes_Reports.Range_Function_0(DS1,'watercraftcount60',ra0_28);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectssncount',ra0_29);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectaddrcount',ra0_30);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectphonecount',ra0_31);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectssnrecentcount',ra0_32);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectaddrrecentcount',ra0_33);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'subjectphonerecentcount',ra0_34);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'ssnidentitiescount',ra0_35);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'ssnaddrcount',ra0_36);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'ssnidentitiesrecentcount',ra0_37);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'ssnaddrrecentcount',ra0_38);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrphonecount',ra0_39);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'inputaddrphonerecentcount',ra0_40);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'phoneidentitiescount',ra0_41);
      	  RiskView_Attributes_Reports.Range_Function_0(DS1,'phoneidentitiesrecentcount',ra0_42);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount01',ra0_43);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount03',ra0_44);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount06',ra0_45);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount12',ra0_46);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount24',ra0_47);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'aircraftcount60',ra0_48);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'derogcount',ra0_49);
					// RiskView_Attributes_Reports.Range_Function_0(DS1,'derogrecentcount',ra0_50);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount',ra0_51);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount01',ra0_52);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount03',ra0_53);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount06',ra0_54);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount12',ra0_55);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount24',ra0_56);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'felonycount60',ra0_57);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'liencount',ra0_58);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount',ra0_59);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount01',ra0_60);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount03',ra0_61);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount06',ra0_62);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount12',ra0_63);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount24',ra0_64);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfiledcount60',ra0_65);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount',ra0_66);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount01',ra0_67);
			  	RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount03',ra0_68);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount06',ra0_69);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount12',ra0_70);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount24',ra0_71);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienreleasedcount60',ra0_72);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfederaltaxfiledcount',ra0_73);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lientaxotherfiledcount',ra0_74);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienforeclosurefiledcount',ra0_75);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienlandlordtenantfiledcount',ra0_76);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienjudgmentfiledcount',ra0_77);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'liensmallclaimsfiledcount',ra0_78);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienotherfiledcount',ra0_79);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienfederaltaxreleasedcount',ra0_80);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lientaxotherreleasedcount',ra0_81);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienforeclosurereleasedcount',ra0_82);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienlandlordtenantreleasedcount',ra0_83);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'lienjudgmentreleasedcount',ra0_84);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'liensmallclaimsreleasedcount',ra0_85);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'lienotherreleasedcount',ra0_86);
		  		RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount',ra0_87);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount01',ra0_88);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount03',ra0_89);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount06',ra0_90);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount12',ra0_91);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount24',ra0_92);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'bankruptcycount60',ra0_93);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount',ra0_94);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount01',ra0_95);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount03',ra0_96);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount06',ra0_97);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount12',ra0_98);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount24',ra0_99);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'evictioncount60',ra0_100);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount01',ra0_101);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount03',ra0_102);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount06',ra0_103);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount12',ra0_104);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount24',ra0_105);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'nonderogcount60',ra0_106);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount',ra0_107);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount01',ra0_108);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount03',ra0_109);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount06',ra0_110);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount12',ra0_111);
				  RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount24',ra0_112);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'profliccount60',ra0_113);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount',ra0_114);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount01',ra0_115);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount03',ra0_116);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount06',ra0_117);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount12',ra0_118);
			    RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount24',ra0_119);
					RiskView_Attributes_Reports.Range_Function_0(DS1,'subprimeofferrequestcount60',ra0_120);
								 
								ra_0:= ra0_1  + ra0_2  + ra0_3  + ra0_4  + ra0_5  + ra0_6  + ra0_7  + ra0_8  + ra0_9  + ra0_10 +
				               ra0_11 + ra0_12 + ra0_13 + ra0_14 + ra0_15 + ra0_16 + ra0_17 + ra0_18 + ra0_19 + ra0_20 +
						           ra0_21 + ra0_22 + ra0_23 + ra0_24 + ra0_25 + ra0_26 + ra0_27 + ra0_28 + ra0_29 + ra0_30 +
				               ra0_31 + ra0_32 + ra0_33 + ra0_34 + ra0_35 + ra0_36 + ra0_37 + ra0_38 + ra0_39 + ra0_40 +
				               ra0_41 + ra0_42 + ra0_43 + ra0_44 + ra0_45 + ra0_46 + ra0_47 + ra0_48  +
                       ra0_51 + ra0_52 + ra0_53 + ra0_54 + ra0_55 + ra0_56 + ra0_57 + ra0_58 + ra0_59 + ra0_60 +
                       ra0_61 + ra0_62 + ra0_63 + ra0_64 + ra0_65 + ra0_66 + ra0_67 + ra0_68 + ra0_69 + ra0_70 + 
                       ra0_71 + ra0_72 + ra0_73 + ra0_74 + ra0_75 + ra0_76 + ra0_77 + ra0_78 + ra0_79 + ra0_80 + 
                       ra0_81 + ra0_82 + ra0_83 + ra0_84 + ra0_85 + ra0_86 + ra0_87 + ra0_88 + ra0_89 + ra0_90 + 
					             ra0_91 + ra0_92 + ra0_93 + ra0_94 + ra0_95 + ra0_96 + ra0_97 + ra0_98 + ra0_99 + ra0_100 + 
				               ra0_101 + ra0_102 + ra0_103 + ra0_104 + ra0_105 + ra0_106 + ra0_107 + ra0_108 + ra0_109 + ra0_110 + 
											 ra0_111 + ra0_112 + ra0_113 + ra0_114 + ra0_115 + ra0_116 + ra0_117 + ra0_118 + ra0_119 + ra0_120;
								
								RiskView_Attributes_Reports.Range_Function_1(DS1,'inputaddrcountyindex',ra1_1);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'inputaddrtractindex',ra1_2);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'inputaddrblockindex',ra1_3);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'curraddrcountyindex',ra1_4);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'curraddrtractindex',ra1_5);
							  RiskView_Attributes_Reports.Range_Function_1(DS1,'curraddrblockindex',ra1_6);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'prevaddrcountyindex',ra1_7);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'prevaddrtractindex',ra1_8);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'prevaddrblockindex',ra1_9);
								RiskView_Attributes_Reports.Range_Function_1(DS1,'propnewestsalepurchaseindex',ra1_10);
											
							
											 
											 ra_1:=ra1_1  + ra1_2  + ra1_3  + ra1_4  + ra1_5  + ra1_6  + ra1_7  + ra1_8  + ra1_9  + ra1_10;
				
								 RiskView_Attributes_Reports.Range_Function_2(DS1,'srcsconfirmidaddrcount',ra2_1);
								 
								 ra_2:=ra2_1;
								 
								 RiskView_Attributes_Reports.Range_Function_3(DS1,'felonyage',ra3_1);
								  RiskView_Attributes_Reports.Range_Function_3(DS1,'lienfiledage',ra3_2);
									 RiskView_Attributes_Reports.Range_Function_3(DS1,'lienreleasedage',ra3_3);
								  RiskView_Attributes_Reports.Range_Function_3(DS1,'evictionage',ra3_4);
								 
								 ra_3:=ra3_1+ ra3_2  + ra3_3  + ra3_4;
								 
								 RiskView_Attributes_Reports.Range_Function_4(DS1,'derogage',ra4_1);
								 RiskView_Attributes_Reports.Range_Function_4(DS1,'bankruptcyage',ra4_2);
								 
								 ra_4:=ra4_1+ ra4_2;
								 
								 RiskView_Attributes_Reports.Range_Function_7(DS1,'derogcount',ra7_1);
								  RiskView_Attributes_Reports.Range_Function_7(DS1,'derogrecentcount',ra7_2);
									
								 
								 ra_7:=ra7_1+ ra7_2;
				
					RiskView_Attributes_Reports.Distinct_function(DS1,'recentupdate',di1);
					RiskView_Attributes_Reports.Distinct_function(DS1,'invaliddl',di2);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verificationfailure',di3);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnnotfound',di4);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedname',di5);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedssn',di6);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedphone',di7);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifiedaddress',di8);
					RiskView_Attributes_Reports.Distinct_function(DS1,'verifieddob',di9);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'aircraftowner',di10);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'invaliddl',di11);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'verificationfailure',di12);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnrecent',di13);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnissuestate',di14);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnnonus',di15);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssn3years',di16);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnafter5',di17);
					RiskView_Attributes_Reports.Distinct_function(DS1,'ssnproblems',di18);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrhistoricalmatch',di19);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrdwelltype',di20);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrdelivery',di21);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrapplicantowned',di22);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrfamilyowned',di23);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddroccupantowned',di24);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrmortgagetype',di25);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrnotprimaryres',di26);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddractivephonelist',di27);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrtaxyr',di28);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrdwelltype',di29);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrapplicantowned',di30);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrfamilyowned',di31);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddroccupantowned',di32);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrmortgagetype',di33);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddractivephonelist',di34);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrtaxyr',di35);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrdwelltype',di36);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrapplicantowned',di37);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrfamilyowned',di38);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddroccupantowned',di39);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrtaxyr',di40);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrmostrecentstatediff',di41);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrrecentecontrajectory',di42);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrrecentecontrajectoryindex',di43);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationattendedcollege',di44);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationprogram2yr',di45);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationprogram4yr',di46);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationprogramgraduate',di47);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationinstitutionprivate',di48);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationfieldofstudytype',di49);
					RiskView_Attributes_Reports.Distinct_function(DS1,'educationinstitutionrating',di50);
					RiskView_Attributes_Reports.Distinct_function(DS1,'statusmostrecent',di51);
					RiskView_Attributes_Reports.Distinct_function(DS1,'statusprevious',di52);
					RiskView_Attributes_Reports.Distinct_function(DS1,'statusnextprevious',di53);
					RiskView_Attributes_Reports.Distinct_function(DS1,'propertyowner',di54);
					RiskView_Attributes_Reports.Distinct_function(DS1,'assetowner',di55);
					RiskView_Attributes_Reports.Distinct_function(DS1,'watercraftowner',di56);
					RiskView_Attributes_Reports.Distinct_function(DS1,'wealthindex',di57);
					RiskView_Attributes_Reports.Distinct_function(DS1,'businessactiveassociation',di58);
					RiskView_Attributes_Reports.Distinct_function(DS1,'businessinactiveassociation',di59);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'businesstitle',di60);
					RiskView_Attributes_Reports.Distinct_function(DS1,'derogseverityindex',di61);
					RiskView_Attributes_Reports.Distinct_function(DS1,'bankruptcytype',di62);
					RiskView_Attributes_Reports.Distinct_function(DS1,'bankruptcystatus',di63);
					RiskView_Attributes_Reports.Distinct_function(DS1,'recentactivityindex',di64);
					RiskView_Attributes_Reports.Distinct_function(DS1,'voterregistrationrecord',di65);
					RiskView_Attributes_Reports.Distinct_function(DS1,'proflictype',di66);
					RiskView_Attributes_Reports.Distinct_function(DS1,'proflictypecategory',di67);
					RiskView_Attributes_Reports.Distinct_function(DS1,'proflicexpired',di68);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inquirycollectionsrecent',di69);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inquirypersonalfinancerecent',di70);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inquiryotherrecent',di71);
					RiskView_Attributes_Reports.Distinct_function(DS1,'highriskcreditactivity',di72);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputphonemobile',di73);	
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputphonehighrisk',di74);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputphoneproblems',di75);
					RiskView_Attributes_Reports.Distinct_function(DS1,'emailaddress',di76);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrhighrisk',di77);
					RiskView_Attributes_Reports.Distinct_function(DS1,'curraddrcorrectional',di78);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prevaddrcorrectional',di79);
				  RiskView_Attributes_Reports.Distinct_function(DS1,'historicaladdrcorrectional',di80);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrproblems',di81);
					RiskView_Attributes_Reports.Distinct_function(DS1,'securityfreeze',di82);
					RiskView_Attributes_Reports.Distinct_function(DS1,'securityalert',di83);	
					RiskView_Attributes_Reports.Distinct_function(DS1,'idtheftflag',di84);
					RiskView_Attributes_Reports.Distinct_function(DS1,'consumerstatement',di85);
					RiskView_Attributes_Reports.Distinct_function(DS1,'prescreenoptout',di86);
					
					RiskView_Attributes_Reports.Distinct_function(DS1,'history_date',di87);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'fnamepop',di88);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'lnamepop',di89);
				  // RiskView_Attributes_Reports.Distinct_function(DS1,'addrpop',di90);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'ssnlength',di91);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'dobpop',di92);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'emailpop',di93);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'ipaddrpop',di94);
					// RiskView_Attributes_Reports.Distinct_function(DS1,'hphnpop',di95);
					RiskView_Attributes_Reports.Distinct_function(DS1,'errorcode',di96);
					
					
					di:= di1  + di2  + di3  + di4  + di5  + di6  + di7  + di8  + di9  + di10 +
				         di13 + di14 + di15 + di16 + di17 + di18 + di19 + di20 +
						   di21 + di22 + di23 + di24 + di25 + di26 + di27 + di28 + di29 + di30 +
				       di31 + di32 + di33 + di34 + di35 + di36 + di37 + di38 + di39 + di40 +
				       di41 + di42 + di43 + di44 + di45 + di46 + di47 + di48 + di49 + di50 +
						   di51 + di52 + di53 + di54 + di55 + di56 + di57 + di58 + di59 + di60 +
               di61 + di62 + di63 + di64 + di65 + di66 + di67 + di68 + di69 + di70 + 
               di71 + di72 + di73 + di74 + di75 + di76 + di77 + di78 + di79 + di80 + 
               di81 + di82 + di83 + di84 + di85 + di86 + di87  + di96 ; 
				
			RiskView_Attributes_Reports.Length_Function(DS1,'did',le1);
				
			le:=le1;
											 
      	result1_stats:= ra + di + ra_0 + ra_1 + ra_2 + ra_3 + ra_4 + ra_7 + le;
				
		      	// result1_stats;
				///////////////////////////////////////////////////////////////////////////////
				///////////////////////////////////////////////////////////////////////////////
				//////////////////////////////////////////////////////////////////////////////
				

      	RiskView_Attributes_Reports.Range_func(DS2,'ageoldestrecord',ran1);
      	RiskView_Attributes_Reports.Range_func(DS2,'agenewestrecord',ran2);
				RiskView_Attributes_Reports.Range_func(DS2,'ssnagedeceased',ran3);
      	RiskView_Attributes_Reports.Range_func(DS2,'ssnlowissueage',ran4);
      	RiskView_Attributes_Reports.Range_func(DS2,'ssnhighissueage',ran5);
				RiskView_Attributes_Reports.Range_func(DS2,'inputaddrageoldestrecord',ran6);
      	RiskView_Attributes_Reports.Range_func(DS2,'inputaddragenewestrecord',ran7);
      	RiskView_Attributes_Reports.Range_func(DS2,'inputaddrlenofres',ran8);
				RiskView_Attributes_Reports.Range_func(DS2,'inputaddragelastsale',ran9);
				RiskView_Attributes_Reports.Range_func(DS2,'inferredminimumage',ran10);
      	RiskView_Attributes_Reports.Range_func(DS2,'bestreportedage',ran11);
				RiskView_Attributes_Reports.Range_func(DS2,'curraddrageoldestrecord',ran12);
				RiskView_Attributes_Reports.Range_func(DS2,'curraddragenewestrecord',ran13);
      	RiskView_Attributes_Reports.Range_func(DS2,'curraddrlenofres',ran14);
      	RiskView_Attributes_Reports.Range_func(DS2,'curraddragelastsale',ran15);
				RiskView_Attributes_Reports.Range_func(DS2,'prevaddrageoldestrecord',ran16);
      	RiskView_Attributes_Reports.Range_func(DS2,'prevaddragenewestrecord',ran17);
      	RiskView_Attributes_Reports.Range_func(DS2,'prevaddrlenofres',ran18);
				RiskView_Attributes_Reports.Range_func(DS2,'prevaddragelastsale',ran19);
				RiskView_Attributes_Reports.Range_func(DS2,'addrmostrecentmoveage',ran20);
				RiskView_Attributes_Reports.Range_func(DS2,'propageoldestpurchase',ran21);
      	RiskView_Attributes_Reports.Range_func(DS2,'propagenewestpurchase',ran22);
				RiskView_Attributes_Reports.Range_func(DS2,'propagenewestsale',ran23);
				RiskView_Attributes_Reports.Range_func(DS2,'businessassociationage',ran24);
				RiskView_Attributes_Reports.Range_func(DS2,'proflicage',ran25);
				RiskView_Attributes_Reports.Range_func(DS2,'phoneedaageoldestrecord',ran26);
      	RiskView_Attributes_Reports.Range_func(DS2,'phoneedaagenewestrecord',ran27);
      	RiskView_Attributes_Reports.Range_func(DS2,'phoneotherageoldestrecord',ran28);
				RiskView_Attributes_Reports.Range_func(DS2,'phoneotheragenewestrecord',ran29);
		
      	
      	
      	ran:= ran1  + ran2  + ran3  + ran4  + ran5  + ran6  + ran7  + ran8  + ran9  + ran10 +
				      ran11 + ran12 + ran13 + ran14 + ran15 + ran16 + ran17 + ran18 + ran19 + ran20 +
						  ran21 + ran22 + ran23 + ran24 + ran25 + ran26 + ran27 + ran28 + ran29;
				
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount',ran0_1);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount01',ran0_2);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount03',ran0_3);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount06',ran0_4);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount12',ran0_5);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount24',ran0_6);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'addrchangecount60',ran0_7);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propownedcount',ran0_8);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'propownedhistoricalcount',ran0_9);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount01',ran0_10);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount03',ran0_11);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount06',ran0_12);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount12',ran0_13);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount24',ran0_14);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'proppurchasedcount60',ran0_15);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount01',ran0_16);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount03',ran0_17);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount06',ran0_18);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount12',ran0_19);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount24',ran0_20);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'propsoldcount60',ran0_21);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount',ran0_22);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount01',ran0_23);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount03',ran0_24);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount06',ran0_25);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount12',ran0_26);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount24',ran0_27);
			  	RiskView_Attributes_Reports.Range_Function_0(DS2,'watercraftcount60',ran0_28);
					
				RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectssncount',ran0_29);
				RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectaddrcount',ran0_30);
      	RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectphonecount',ran0_31);
      	RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectssnrecentcount',ran0_32);
				RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectaddrrecentcount',ran0_33);
      	RiskView_Attributes_Reports.Range_Function_0(DS2,'subjectphonerecentcount',ran0_34);
      	RiskView_Attributes_Reports.Range_Function_0(DS2,'ssnidentitiescount',ran0_35);
				RiskView_Attributes_Reports.Range_Function_0(DS2,'ssnaddrcount',ran0_36);
      	RiskView_Attributes_Reports.Range_Function_0(DS2,'ssnidentitiesrecentcount',ran0_37);
      	RiskView_Attributes_Reports.Range_Function_0(DS2,'ssnaddrrecentcount',ran0_38);
				RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrphonecount',ran0_39);
				RiskView_Attributes_Reports.Range_Function_0(DS2,'inputaddrphonerecentcount',ran0_40);
      	RiskView_Attributes_Reports.Range_Function_0(DS2,'phoneidentitiescount',ran0_41);
      	RiskView_Attributes_Reports.Range_Function_0(DS2,'phoneidentitiesrecentcount',ran0_42);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount01',ran0_43);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount03',ran0_44);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount06',ran0_45);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount12',ran0_46);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount24',ran0_47);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'aircraftcount60',ran0_48);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'derogcount',ran0_49);
					// RiskView_Attributes_Reports.Range_Function_0(DS2,'derogrecentcount',ran0_50);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount',ran0_51);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount01',ran0_52);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount03',ran0_53);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount06',ran0_54);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount12',ran0_55);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount24',ran0_56);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'felonycount60',ran0_57);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'liencount',ran0_58);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount',ran0_59);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount01',ran0_60);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount03',ran0_61);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount06',ran0_62);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount12',ran0_63);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount24',ran0_64);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfiledcount60',ran0_65);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount',ran0_66);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount01',ran0_67);
			  	RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount03',ran0_68);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount06',ran0_69);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount12',ran0_70);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount24',ran0_71);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienreleasedcount60',ran0_72);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfederaltaxfiledcount',ran0_73);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lientaxotherfiledcount',ran0_74);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienforeclosurefiledcount',ran0_75);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienlandlordtenantfiledcount',ran0_76);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienjudgmentfiledcount',ran0_77);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'liensmallclaimsfiledcount',ran0_78);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienotherfiledcount',ran0_79);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienfederaltaxreleasedcount',ran0_80);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lientaxotherreleasedcount',ran0_81);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienforeclosurereleasedcount',ran0_82);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienlandlordtenantreleasedcount',ran0_83);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'lienjudgmentreleasedcount',ran0_84);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'liensmallclaimsreleasedcount',ran0_85);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'lienotherreleasedcount',ran0_86);
		  		RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount',ran0_87);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount01',ran0_88);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount03',ran0_89);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount06',ran0_90);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount12',ran0_91);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount24',ran0_92);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'bankruptcycount60',ran0_93);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount',ran0_94);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount01',ran0_95);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount03',ran0_96);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount06',ran0_97);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount12',ran0_98);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount24',ran0_99);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'evictioncount60',ran0_100);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount01',ran0_101);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount03',ran0_102);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount06',ran0_103);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount12',ran0_104);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount24',ran0_105);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'nonderogcount60',ran0_106);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount',ran0_107);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount01',ran0_108);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount03',ran0_109);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount06',ran0_110);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount12',ran0_111);
				  RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount24',ran0_112);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'profliccount60',ran0_113);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount',ran0_114);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount01',ran0_115);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount03',ran0_116);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount06',ran0_117);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount12',ran0_118);
			    RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount24',ran0_119);
					RiskView_Attributes_Reports.Range_Function_0(DS2,'subprimeofferrequestcount60',ran0_120);
								 
							ran_0:=   ran0_1 + ran0_2  + ran0_3  + ran0_4  + ran0_5  + ran0_6  + ran0_7  + ran0_8  + ran0_9  + ran0_10 +
				               ran0_11 + ran0_12 + ran0_13 + ran0_14 + ran0_15 + ran0_16 + ran0_17 + ran0_18 + ran0_19 + ran0_20 +
						           ran0_21 + ran0_22 + ran0_23 + ran0_24 + ran0_25 + ran0_26 + ran0_27 + ran0_28 + ran0_29 + ran0_30 +
				               ran0_31 + ran0_32 + ran0_33 + ran0_34 + ran0_35 + ran0_36 + ran0_37 + ran0_38 + ran0_39 + ran0_40 +
				               ran0_41 + ran0_42 + ran0_43 + ran0_44 + ran0_45 + ran0_46 + ran0_47 + ran0_48  +
                       ran0_51 + ran0_52 + ran0_53 + ran0_54 + ran0_55 + ran0_56 + ran0_57 + ran0_58 + ran0_59 + ran0_60 +
                       ran0_61 + ran0_62 + ran0_63 + ran0_64 + ran0_65 + ran0_66 + ran0_67 + ran0_68 + ran0_69 + ran0_70 + 
                       ran0_71 + ran0_72 + ran0_73 + ran0_74 + ran0_75 + ran0_76 + ran0_77 + ran0_78 + ran0_79 + ran0_80 + 
                       ran0_81 + ran0_82 + ran0_83 + ran0_84 + ran0_85 + ran0_86 + ran0_87 + ran0_88 + ran0_89 + ran0_90 + 
					             ran0_91 + ran0_92 + ran0_93 + ran0_94 + ran0_95 + ran0_96 + ran0_97 + ran0_98 + ran0_99 + ran0_100 + 
				               ran0_101 + ran0_102 + ran0_103 + ran0_104 + ran0_105 + ran0_106 + ran0_107 + ran0_108 + ran0_109 + ran0_110 + 
											 ran0_111 + ran0_112 + ran0_113 + ran0_114 + ran0_115 + ran0_116 + ran0_117 + ran0_118 + ran0_119 + ran0_120;
								
						  	RiskView_Attributes_Reports.Range_Function_1(DS2,'inputaddrcountyindex',ran1_1);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'inputaddrtractindex',ran1_2);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'inputaddrblockindex',ran1_3);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'curraddrcountyindex',ran1_4);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'curraddrtractindex',ran1_5);
							  RiskView_Attributes_Reports.Range_Function_1(DS2,'curraddrblockindex',ran1_6);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'prevaddrcountyindex',ran1_7);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'prevaddrtractindex',ran1_8);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'prevaddrblockindex',ran1_9);
								RiskView_Attributes_Reports.Range_Function_1(DS2,'propnewestsalepurchaseindex',ran1_10);
											
							
											 
											 ran_1:=ran1_1  + ran1_2  + ran1_3  + ran1_4  + ran1_5  + ran1_6  + ran1_7  + ran1_8  + ran1_9  + ran1_10;
								
								 RiskView_Attributes_Reports.Range_Function_2(DS2,'srcsconfirmidaddrcount',ran2_1);
								 
								 ran_2:=ran2_1;
								 
								 	RiskView_Attributes_Reports.Range_Function_3(DS2,'felonyage',ran3_1);
								  RiskView_Attributes_Reports.Range_Function_3(DS2,'lienfiledage',ran3_2);
									RiskView_Attributes_Reports.Range_Function_3(DS2,'lienreleasedage',ran3_3);
								  RiskView_Attributes_Reports.Range_Function_3(DS2,'evictionage',ran3_4);
								 
								 ran_3:=ran3_1+ ran3_2  + ran3_3  + ran3_4;
								 
								 RiskView_Attributes_Reports.Range_Function_4(DS2,'derogage',ran4_1);
								 RiskView_Attributes_Reports.Range_Function_4(DS2,'bankruptcyage',ran4_2);
								 
								 ran_4:=ran4_1+ ran4_2;
				
				          RiskView_Attributes_Reports.Range_Function_7(DS2,'derogcount',ran7_1);
								  RiskView_Attributes_Reports.Range_Function_7(DS2,'derogrecentcount',ran7_2);
									
								 
								 ran_7:=ran7_1+ ran7_2;
								 
					RiskView_Attributes_Reports.Distinct_function(DS2,'recentupdate',dis1);
					RiskView_Attributes_Reports.Distinct_function(DS2,'invaliddl',dis2);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verificationfailure',dis3);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnnotfound',dis4);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedname',dis5);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedssn',dis6);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedphone',dis7);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifiedaddress',dis8);
					RiskView_Attributes_Reports.Distinct_function(DS2,'verifieddob',dis9);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'aircraftowner',dis10);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'invaliddl',dis11);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'verificationfailure',dis12);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnrecent',dis13);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnissuestate',dis14);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnnonus',dis15);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssn3years',dis16);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnafter5',dis17);
					RiskView_Attributes_Reports.Distinct_function(DS2,'ssnproblems',dis18);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrhistoricalmatch',dis19);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrdwelltype',dis20);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrdelivery',dis21);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrapplicantowned',dis22);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrfamilyowned',dis23);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddroccupantowned',dis24);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrmortgagetype',dis25);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrnotprimaryres',dis26);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddractivephonelist',dis27);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrtaxyr',dis28);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrdwelltype',dis29);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrapplicantowned',dis30);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrfamilyowned',dis31);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddroccupantowned',dis32);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrmortgagetype',dis33);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddractivephonelist',dis34);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrtaxyr',dis35);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrdwelltype',dis36);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrapplicantowned',dis37);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrfamilyowned',dis38);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddroccupantowned',dis39);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrtaxyr',dis40);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrmostrecentstatediff',dis41);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrrecentecontrajectory',dis42);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrrecentecontrajectoryindex',dis43);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationattendedcollege',dis44);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationprogram2yr',dis45);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationprogram4yr',dis46);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationprogramgraduate',dis47);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationinstitutionprivate',dis48);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationfieldofstudytype',dis49);
					RiskView_Attributes_Reports.Distinct_function(DS2,'educationinstitutionrating',dis50);
					RiskView_Attributes_Reports.Distinct_function(DS2,'statusmostrecent',dis51);
					RiskView_Attributes_Reports.Distinct_function(DS2,'statusprevious',dis52);
					RiskView_Attributes_Reports.Distinct_function(DS2,'statusnextprevious',dis53);
					RiskView_Attributes_Reports.Distinct_function(DS2,'propertyowner',dis54);
					RiskView_Attributes_Reports.Distinct_function(DS2,'assetowner',dis55);
					RiskView_Attributes_Reports.Distinct_function(DS2,'watercraftowner',dis56);
					RiskView_Attributes_Reports.Distinct_function(DS2,'wealthindex',dis57);
					RiskView_Attributes_Reports.Distinct_function(DS2,'businessactiveassociation',dis58);
					RiskView_Attributes_Reports.Distinct_function(DS2,'businessinactiveassociation',dis59);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'businesstitle',dis60);
					RiskView_Attributes_Reports.Distinct_function(DS2,'derogseverityindex',dis61);
					RiskView_Attributes_Reports.Distinct_function(DS2,'bankruptcytype',dis62);
					RiskView_Attributes_Reports.Distinct_function(DS2,'bankruptcystatus',dis63);
					RiskView_Attributes_Reports.Distinct_function(DS2,'recentactivityindex',dis64);
					RiskView_Attributes_Reports.Distinct_function(DS2,'voterregistrationrecord',dis65);
					RiskView_Attributes_Reports.Distinct_function(DS2,'proflictype',dis66);
					RiskView_Attributes_Reports.Distinct_function(DS2,'proflictypecategory',dis67);
					RiskView_Attributes_Reports.Distinct_function(DS2,'proflicexpired',dis68);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inquirycollectionsrecent',dis69);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inquirypersonalfinancerecent',dis70);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inquiryotherrecent',dis71);
					RiskView_Attributes_Reports.Distinct_function(DS2,'highriskcreditactivity',dis72);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputphonemobile',dis73);	
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputphonehighrisk',dis74);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputphoneproblems',dis75);
					RiskView_Attributes_Reports.Distinct_function(DS2,'emailaddress',dis76);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrhighrisk',dis77);
					RiskView_Attributes_Reports.Distinct_function(DS2,'curraddrcorrectional',dis78);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prevaddrcorrectional',dis79);
				  RiskView_Attributes_Reports.Distinct_function(DS2,'historicaladdrcorrectional',dis80);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrproblems',dis81);
					RiskView_Attributes_Reports.Distinct_function(DS2,'securityfreeze',dis82);
					RiskView_Attributes_Reports.Distinct_function(DS2,'securityalert',dis83);	
					RiskView_Attributes_Reports.Distinct_function(DS2,'idtheftflag',dis84);
					RiskView_Attributes_Reports.Distinct_function(DS2,'consumerstatement',dis85);
					RiskView_Attributes_Reports.Distinct_function(DS2,'prescreenoptout',dis86);
					RiskView_Attributes_Reports.Distinct_function(DS2,'history_date',dis87);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'fnamepop',dis88);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'lnamepop',dis89);
				  // RiskView_Attributes_Reports.Distinct_function(DS2,'addrpop',dis90);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'ssnlength',dis91);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'dobpop',dis92);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'emailpop',dis93);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'ipaddrpop',dis94);
					// RiskView_Attributes_Reports.Distinct_function(DS2,'hphnpop',dis95);
					RiskView_Attributes_Reports.Distinct_function(DS2,'errorcode',dis96);
				
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				         dis13 + dis14 + dis15 + dis16 + dis17 + dis18 + dis19 + dis20 +
						    dis21 + dis22 + dis23 + dis24 + dis25 + dis26 + dis27 + dis28 + dis29 + dis30 +
				        dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37 + dis38 + dis39 + dis40 +
				        dis41 + dis42 + dis43 + dis44 + dis45 + dis46 + dis47 + dis48 + dis49 + dis50 +
						    dis51 + dis52 + dis53 + dis54 + dis55 + dis56 + dis57 + dis58 + dis59 + dis60 +
                dis61 + dis62 + dis63 + dis64 + dis65 + dis66 + dis67 + dis68 + dis69 + dis70 + 
                dis71 + dis72 + dis73 + dis74 + dis75 + dis76 + dis77 + dis78 + dis79 + dis80 + 
                dis81 + dis82 + dis83 + dis84 + dis85 + dis86 + dis87  + dis96 ;

							 RiskView_Attributes_Reports.Length_Function(DS2,'did',len1);
							
      len:=len1;
			result2_stats:= ran + dis + ran_0 + ran_1 +ran_2 + ran_3 + ran_4 + ran_7 +len;
   				
         	// result2_stats;
			/////////////////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////
					
				RiskView_Attributes_Reports.Average_func(DS1,'ageoldestrecord',av1);
      	RiskView_Attributes_Reports.Average_func(DS1,'agenewestrecord',av2);
      	RiskView_Attributes_Reports.Average_func(DS1,'ssnagedeceased',av3);
				RiskView_Attributes_Reports.Average_func(DS1,'ssnlowissueage',av4);
      	RiskView_Attributes_Reports.Average_func(DS1,'ssnhighissueage',av5);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrageoldestrecord',av6);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddragenewestrecord',av7);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddrlenofres',av8);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddragelastsale',av9);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrlastsalesprice',av10);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrtaxvalue',av11);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddrtaxmarketvalue',av12);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmvalue',av13);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmvalue12',av14);
      	RiskView_Attributes_Reports.Average_func(DS1,'inputaddravmvalue60',av15);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrageoldestrecord',av16);
      	RiskView_Attributes_Reports.Average_func(DS1,'curraddragenewestrecord',av17);
      	RiskView_Attributes_Reports.Average_func(DS1,'curraddrlenofres',av18);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddragelastsale',av19);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrlastsalesprice',av20);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddrtaxvalue',av21);
      	RiskView_Attributes_Reports.Average_func(DS1,'curraddrtaxmarketvalue',av22);
      	RiskView_Attributes_Reports.Average_func(DS1,'curraddravmvalue',av23);
				RiskView_Attributes_Reports.Average_func(DS1,'curraddravmvalue12',av24);
      	RiskView_Attributes_Reports.Average_func(DS1,'curraddravmvalue60',av25);
				RiskView_Attributes_Reports.Average_func(DS1,'businessassociationage',av26);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienfiledtotal',av27);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienfederaltaxfiledtotal',av28);
				RiskView_Attributes_Reports.Average_func(DS1,'lientaxotherfiledtotal',av29);
				RiskView_Attributes_Reports.Average_func(DS1,'lienforeclosurefiledtotal',av30);
				RiskView_Attributes_Reports.Average_func(DS1,'lienlandlordtenantfiledtotal',av31);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienjudgmentfiledtotal',av32);
      	RiskView_Attributes_Reports.Average_func(DS1,'liensmallclaimsfiledtotal',av33);
				RiskView_Attributes_Reports.Average_func(DS1,'lienotherfiledtotal',av34);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedtotal',av35);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrageoldestrecord',av36);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddragenewestrecord',av37);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddrlenofres',av38);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddragelastsale',av39);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrlastsalesprice',av40);
				RiskView_Attributes_Reports.Average_func(DS1,'prevaddrtaxvalue',av41);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddrtaxmarketvalue',av42);
      	RiskView_Attributes_Reports.Average_func(DS1,'prevaddravmvalue',av43);
				RiskView_Attributes_Reports.Average_func(DS1,'addrmostrecentdistance',av44);
				RiskView_Attributes_Reports.Average_func(DS1,'addrmostrecentmoveage',av45);
				RiskView_Attributes_Reports.Average_func(DS1,'propownedtaxtotal',av46);
				RiskView_Attributes_Reports.Average_func(DS1,'propnewestsaleprice',av47);
				RiskView_Attributes_Reports.Average_func(DS1,'propageoldestpurchase',av48);
				RiskView_Attributes_Reports.Average_func(DS1,'propagenewestpurchase',av49);
				RiskView_Attributes_Reports.Average_func(DS1,'propagenewestsale',av50);
				RiskView_Attributes_Reports.Average_func(DS1,'lientaxotherreleasedtotal',av51);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienforeclosurereleasedtotal',av52);
      	RiskView_Attributes_Reports.Average_func(DS1,'lienlandlordtenantreleasedtotal',av53);
				RiskView_Attributes_Reports.Average_func(DS1,'lienjudgmentreleasedtotal',av54);
      	RiskView_Attributes_Reports.Average_func(DS1,'liensmallclaimsreleasedtotal',av55);
				RiskView_Attributes_Reports.Average_func(DS1,'lienotherreleasedtotal',av56);
				RiskView_Attributes_Reports.Average_func(DS1,'proflicage',av57);
				RiskView_Attributes_Reports.Average_func(DS1,'phoneedaageoldestrecord',av58);
				RiskView_Attributes_Reports.Average_func(DS1,'phoneedaagenewestrecord',av59);
      	RiskView_Attributes_Reports.Average_func(DS1,'phoneotherageoldestrecord',av60);
				RiskView_Attributes_Reports.Average_func(DS1,'phoneotheragenewestrecord',av61);
				RiskView_Attributes_Reports.Average_func(DS1,'lienfederaltaxreleasedtotal',av62);				
				RiskView_Attributes_Reports.Average_func(DS1,'derogcount',av63);
				RiskView_Attributes_Reports.Average_func(DS1,'derogrecentcount',av64);
			  RiskView_Attributes_Reports.Average_func(DS1,'derogage',av65);
				
				 
				  RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount',av66);
		  		RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount01',av67);
			  	RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount03',av68);
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount06',av69);
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount12',av70);
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount24',av71);
					RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedcount60',av72);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfederaltaxfiledcount',av73);
					RiskView_Attributes_Reports.Average_func(DS1,'lientaxotherfiledcount',av74);
					RiskView_Attributes_Reports.Average_func(DS1,'lienforeclosurefiledcount',av75);
					RiskView_Attributes_Reports.Average_func(DS1,'lienlandlordtenantfiledcount',av76);
					RiskView_Attributes_Reports.Average_func(DS1,'lienjudgmentfiledcount',av77);
				  RiskView_Attributes_Reports.Average_func(DS1,'liensmallclaimsfiledcount',av78);
					RiskView_Attributes_Reports.Average_func(DS1,'lienotherfiledcount',av79);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfederaltaxreleasedcount',av80);
					RiskView_Attributes_Reports.Average_func(DS1,'lientaxotherreleasedcount',av81);
				  RiskView_Attributes_Reports.Average_func(DS1,'lienforeclosurereleasedcount',av82);
					RiskView_Attributes_Reports.Average_func(DS1,'lienlandlordtenantreleasedcount',av83);
					RiskView_Attributes_Reports.Average_func(DS1,'lienjudgmentreleasedcount',av84);
					RiskView_Attributes_Reports.Average_func(DS1,'liensmallclaimsreleasedcount',av85);
				  RiskView_Attributes_Reports.Average_func(DS1,'lienotherreleasedcount',av86);
		  		RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount',av87);
			    RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount01',av88);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount03',av89);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount06',av90);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount12',av91);
				  RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount24',av92);
					RiskView_Attributes_Reports.Average_func(DS1,'bankruptcycount60',av93);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount',av94);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount01',av95);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount03',av96);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount06',av97);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount12',av98);
			    RiskView_Attributes_Reports.Average_func(DS1,'evictioncount24',av99);
					RiskView_Attributes_Reports.Average_func(DS1,'evictioncount60',av100);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount01',av101);
				  RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount03',av102);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount06',av103);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount12',av104);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount24',av105);
					RiskView_Attributes_Reports.Average_func(DS1,'nonderogcount60',av106);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount',av107);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount01',av108);
			    RiskView_Attributes_Reports.Average_func(DS1,'profliccount03',av109);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount06',av110);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount12',av111);
				  RiskView_Attributes_Reports.Average_func(DS1,'profliccount24',av112);
					RiskView_Attributes_Reports.Average_func(DS1,'profliccount60',av113);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount',av114);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount01',av115);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount03',av116);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount06',av117);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount12',av118);
			    RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount24',av119);
					RiskView_Attributes_Reports.Average_func(DS1,'subprimeofferrequestcount60',av120);					
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount',av121);
				  RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount01',av122);
					RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount03',av123);
					RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount06',av124);
					RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount12',av125);
					RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount24',av126);
					RiskView_Attributes_Reports.Average_func(DS1,'addrchangecount60',av127);
					RiskView_Attributes_Reports.Average_func(DS1,'propownedcount',av128);
			    RiskView_Attributes_Reports.Average_func(DS1,'propownedhistoricalcount',av129);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount01',av130);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount03',av131);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount06',av132);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount12',av133);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount24',av134);
					RiskView_Attributes_Reports.Average_func(DS1,'proppurchasedcount60',av135);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount01',av136);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount03',av137);
				  RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount06',av138);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount12',av139);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount24',av140);
					RiskView_Attributes_Reports.Average_func(DS1,'propsoldcount60',av141);
				  RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount',av142);
					RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount01',av143);
					RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount03',av144);
					RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount06',av145);
				  RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount12',av146);
		  		RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount24',av147);
			  	RiskView_Attributes_Reports.Average_func(DS1,'watercraftcount60',av148);					
				RiskView_Attributes_Reports.Average_func(DS1,'subjectssncount',av149);
				RiskView_Attributes_Reports.Average_func(DS1,'subjectaddrcount',av150);
      	RiskView_Attributes_Reports.Average_func(DS1,'subjectphonecount',av151);
      	RiskView_Attributes_Reports.Average_func(DS1,'subjectssnrecentcount',av152);
				RiskView_Attributes_Reports.Average_func(DS1,'subjectaddrrecentcount',av153);
      	RiskView_Attributes_Reports.Average_func(DS1,'subjectphonerecentcount',av154);
      	RiskView_Attributes_Reports.Average_func(DS1,'ssnidentitiescount',av155);
				RiskView_Attributes_Reports.Average_func(DS1,'ssnaddrcount',av156);
      	RiskView_Attributes_Reports.Average_func(DS1,'ssnidentitiesrecentcount',av157);
      	RiskView_Attributes_Reports.Average_func(DS1,'ssnaddrrecentcount',av158);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrphonecount',av159);
				RiskView_Attributes_Reports.Average_func(DS1,'inputaddrphonerecentcount',av160);
      	RiskView_Attributes_Reports.Average_func(DS1,'phoneidentitiescount',av161);
      	RiskView_Attributes_Reports.Average_func(DS1,'phoneidentitiesrecentcount',av162);
				  RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount01',av163);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount03',av164);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount06',av165);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount12',av166);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount24',av167);
					RiskView_Attributes_Reports.Average_func(DS1,'aircraftcount60',av168);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount',av169);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount01',av170);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount03',av171);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount06',av172);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount12',av173);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount24',av174);
					RiskView_Attributes_Reports.Average_func(DS1,'felonycount60',av175);
				  RiskView_Attributes_Reports.Average_func(DS1,'liencount',av176);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount',av177);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount01',av178);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount03',av179);
				  RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount06',av180);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount12',av181);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount24',av182);
					RiskView_Attributes_Reports.Average_func(DS1,'lienfiledcount60',av183);
					
					       RiskView_Attributes_Reports.Average_func(DS1,'srcsconfirmidaddrcount',av184);
									RiskView_Attributes_Reports.Average_func(DS1,'felonyage',av185);
								  RiskView_Attributes_Reports.Average_func(DS1,'lienfiledage',av186);
									RiskView_Attributes_Reports.Average_func(DS1,'lienreleasedage',av187);
								  RiskView_Attributes_Reports.Average_func(DS1,'evictionage',av188);
								  RiskView_Attributes_Reports.Average_func(DS1,'bankruptcyage',av189);
      	
      	   av:= av1  + av2  + av3  + av4  + av5  + av6  + av7  + av8  + av9  + av10 +
				        av11 + av12 + av13 + av14 + av15 + av16 + av17 + av18 + av19 + av20 +
						    av21 + av22 + av23 + av24 + av25 + av26 + av27 + av28 + av29 + av30 +
				        av31 + av32 + av33 + av34 + av35 + av36 + av37 + av38 + av39 + av40 +
				        av41 + av42 + av43 + av44 + av45 + av46 + av47 + av48 + av49 + av50 +
								av51 + av52 + av53 + av54 + av55 + av56 + av57 + av58 + av59 + av60 +
                av61 + av62 + av63 + av64 + av65 + av66 + av67 + av68 + av69 + av70 + 
                   av71 + av72 + av73 + av74 + av75 + av76 + av77 + av78 + av79 + av80 + 
                   av81 + av82 + av83 + av84 + av85 + av86 + av87 + av88 + av89 + av90 + 
					         av91 + av92 + av93 + av94 + av95 + av96 + av97 + av98 + av99 + av100 + 
				           av101 + av102 + av103 + av104 + av105 + av106 + av107 + av108 + av109 + av110 + 
									 av111 + av112 + av113 + av114 + av115 + av116 + av117 + av118 + av119 + av120 +
									 av121 + av122 + av123 + av124 + av125 + av126 + av127 + av128 + av129 + av130 +
				           av131 + av132 + av133 + av134 + av135 + av136 + av137 + av138 + av139 + av140 +
				           av141 + av142 + av143 + av144 + av145 + av146 + av147 + av148 + av149 + av150 +
                   av151 + av152 + av153 + av154 + av155 + av156 + av157 + av158 + av159 + av160 +
                   av161 + av162 + av163 + av164 + av165 + av166 + av167 + av168 + av169 + av170 + 
                   av171 + av172 + av173 + av174 + av175 + av176 + av177 + av178 + av179 + av180 + 
									 av181 + av182 + av183 + av184 + av185 + av186 + av187 + av188 + av189;
					
				RiskView_Attributes_Reports.Average_func(DS2,'ageoldestrecord',ave1);
      	RiskView_Attributes_Reports.Average_func(DS2,'agenewestrecord',ave2);
      	RiskView_Attributes_Reports.Average_func(DS2,'ssnagedeceased',ave3);
				RiskView_Attributes_Reports.Average_func(DS2,'ssnlowissueage',ave4);
      	RiskView_Attributes_Reports.Average_func(DS2,'ssnhighissueage',ave5);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrageoldestrecord',ave6);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddragenewestrecord',ave7);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddrlenofres',ave8);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddragelastsale',ave9);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddrlastsalesprice',ave10);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrtaxvalue',ave11);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddrtaxmarketvalue',ave12);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmvalue',ave13);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmvalue12',ave14);
      	RiskView_Attributes_Reports.Average_func(DS2,'inputaddravmvalue60',ave15);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrageoldestrecord',ave16);
      	RiskView_Attributes_Reports.Average_func(DS2,'curraddragenewestrecord',ave17);
      	RiskView_Attributes_Reports.Average_func(DS2,'curraddrlenofres',ave18);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddragelastsale',ave19);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrlastsalesprice',ave20);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddrtaxvalue',ave21);
      	RiskView_Attributes_Reports.Average_func(DS2,'curraddrtaxmarketvalue',ave22);
      	RiskView_Attributes_Reports.Average_func(DS2,'curraddravmvalue',ave23);
				RiskView_Attributes_Reports.Average_func(DS2,'curraddravmvalue12',ave24);
      	RiskView_Attributes_Reports.Average_func(DS2,'curraddravmvalue60',ave25);
				RiskView_Attributes_Reports.Average_func(DS2,'lienfiledtotal',ave26);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienfederaltaxfiledtotal',ave27);
      	RiskView_Attributes_Reports.Average_func(DS2,'lientaxotherfiledtotal',ave28);
				RiskView_Attributes_Reports.Average_func(DS2,'lienforeclosurefiledtotal',ave29);
				RiskView_Attributes_Reports.Average_func(DS2,'lienlandlordtenantfiledtotal',ave30);
				RiskView_Attributes_Reports.Average_func(DS2,'lienjudgmentfiledtotal',ave31);
      	RiskView_Attributes_Reports.Average_func(DS2,'liensmallclaimsfiledtotal',ave32);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienotherfiledtotal',ave33);
				RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedtotal',ave34);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienfederaltaxreleasedtotal',ave35);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrageoldestrecord',ave36);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddragenewestrecord',ave37);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddrlenofres',ave38);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddragelastsale',ave39);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrlastsalesprice',ave40);
				RiskView_Attributes_Reports.Average_func(DS2,'prevaddrtaxvalue',ave41);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddrtaxmarketvalue',ave42);
      	RiskView_Attributes_Reports.Average_func(DS2,'prevaddravmvalue',ave43);
				RiskView_Attributes_Reports.Average_func(DS2,'addrmostrecentdistance',ave44);
				RiskView_Attributes_Reports.Average_func(DS2,'addrmostrecentmoveage',ave45);
				RiskView_Attributes_Reports.Average_func(DS2,'propownedtaxtotal',ave46);
				RiskView_Attributes_Reports.Average_func(DS2,'propnewestsaleprice',ave47);
				RiskView_Attributes_Reports.Average_func(DS2,'propageoldestpurchase',ave48);
				RiskView_Attributes_Reports.Average_func(DS2,'propagenewestpurchase',ave49);
				RiskView_Attributes_Reports.Average_func(DS2,'propagenewestsale',ave50);
				RiskView_Attributes_Reports.Average_func(DS2,'lientaxotherreleasedtotal',ave51);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienforeclosurereleasedtotal',ave52);
      	RiskView_Attributes_Reports.Average_func(DS2,'lienlandlordtenantreleasedtotal',ave53);
				RiskView_Attributes_Reports.Average_func(DS2,'lienjudgmentreleasedtotal',ave54);
      	RiskView_Attributes_Reports.Average_func(DS2,'liensmallclaimsreleasedtotal',ave55);
				RiskView_Attributes_Reports.Average_func(DS2,'lienotherreleasedtotal',ave56);
				RiskView_Attributes_Reports.Average_func(DS2,'proflicage',ave57);
				RiskView_Attributes_Reports.Average_func(DS2,'phoneedaageoldestrecord',ave58);
				RiskView_Attributes_Reports.Average_func(DS2,'phoneedaagenewestrecord',ave59);
      	RiskView_Attributes_Reports.Average_func(DS2,'phoneotherageoldestrecord',ave60);
				RiskView_Attributes_Reports.Average_func(DS2,'phoneotheragenewestrecord',ave61);
			  RiskView_Attributes_Reports.Average_func(DS2,'businessassociationage',ave62);
				
				RiskView_Attributes_Reports.Average_func(DS2,'derogcount',ave63);
				RiskView_Attributes_Reports.Average_func(DS2,'derogrecentcount',ave64);
			  RiskView_Attributes_Reports.Average_func(DS2,'derogage',ave65);
				
				 RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount',ave66);
		  		RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount01',ave67);
			  	RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount03',ave68);
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount06',ave69);
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount12',ave70);
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount24',ave71);
					RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedcount60',ave72);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfederaltaxfiledcount',ave73);
					RiskView_Attributes_Reports.Average_func(DS2,'lientaxotherfiledcount',ave74);
					RiskView_Attributes_Reports.Average_func(DS2,'lienforeclosurefiledcount',ave75);
					RiskView_Attributes_Reports.Average_func(DS2,'lienlandlordtenantfiledcount',ave76);
					RiskView_Attributes_Reports.Average_func(DS2,'lienjudgmentfiledcount',ave77);
				  RiskView_Attributes_Reports.Average_func(DS2,'liensmallclaimsfiledcount',ave78);
					RiskView_Attributes_Reports.Average_func(DS2,'lienotherfiledcount',ave79);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfederaltaxreleasedcount',ave80);
					RiskView_Attributes_Reports.Average_func(DS2,'lientaxotherreleasedcount',ave81);
				  RiskView_Attributes_Reports.Average_func(DS2,'lienforeclosurereleasedcount',ave82);
					RiskView_Attributes_Reports.Average_func(DS2,'lienlandlordtenantreleasedcount',ave83);
					RiskView_Attributes_Reports.Average_func(DS2,'lienjudgmentreleasedcount',ave84);
					RiskView_Attributes_Reports.Average_func(DS2,'liensmallclaimsreleasedcount',ave85);
				  RiskView_Attributes_Reports.Average_func(DS2,'lienotherreleasedcount',ave86);
		  		RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount',ave87);
			    RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount01',ave88);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount03',ave89);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount06',ave90);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount12',ave91);
				  RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount24',ave92);
					RiskView_Attributes_Reports.Average_func(DS2,'bankruptcycount60',ave93);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount',ave94);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount01',ave95);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount03',ave96);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount06',ave97);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount12',ave98);
			    RiskView_Attributes_Reports.Average_func(DS2,'evictioncount24',ave99);
					RiskView_Attributes_Reports.Average_func(DS2,'evictioncount60',ave100);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount01',ave101);
				  RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount03',ave102);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount06',ave103);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount12',ave104);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount24',ave105);
					RiskView_Attributes_Reports.Average_func(DS2,'nonderogcount60',ave106);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount',ave107);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount01',ave108);
			    RiskView_Attributes_Reports.Average_func(DS2,'profliccount03',ave109);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount06',ave110);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount12',ave111);
				  RiskView_Attributes_Reports.Average_func(DS2,'profliccount24',ave112);
					RiskView_Attributes_Reports.Average_func(DS2,'profliccount60',ave113);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount',ave114);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount01',ave115);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount03',ave116);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount06',ave117);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount12',ave118);
			    RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount24',ave119);
					RiskView_Attributes_Reports.Average_func(DS2,'subprimeofferrequestcount60',ave120);					
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount',ave121);
				  RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount01',ave122);
					RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount03',ave123);
					RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount06',ave124);
					RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount12',ave125);
					RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount24',ave126);
					RiskView_Attributes_Reports.Average_func(DS2,'addrchangecount60',ave127);
					RiskView_Attributes_Reports.Average_func(DS2,'propownedcount',ave128);
			    RiskView_Attributes_Reports.Average_func(DS2,'propownedhistoricalcount',ave129);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount01',ave130);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount03',ave131);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount06',ave132);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount12',ave133);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount24',ave134);
					RiskView_Attributes_Reports.Average_func(DS2,'proppurchasedcount60',ave135);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount01',ave136);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount03',ave137);
				  RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount06',ave138);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount12',ave139);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount24',ave140);
					RiskView_Attributes_Reports.Average_func(DS2,'propsoldcount60',ave141);
				  RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount',ave142);
					RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount01',ave143);
					RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount03',ave144);
					RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount06',ave145);
				  RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount12',ave146);
		  		RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount24',ave147);
			  	RiskView_Attributes_Reports.Average_func(DS2,'watercraftcount60',ave148);					
				RiskView_Attributes_Reports.Average_func(DS2,'subjectssncount',ave149);
				RiskView_Attributes_Reports.Average_func(DS2,'subjectaddrcount',ave150);
      	RiskView_Attributes_Reports.Average_func(DS2,'subjectphonecount',ave151);
      	RiskView_Attributes_Reports.Average_func(DS2,'subjectssnrecentcount',ave152);
				RiskView_Attributes_Reports.Average_func(DS2,'subjectaddrrecentcount',ave153);
      	RiskView_Attributes_Reports.Average_func(DS2,'subjectphonerecentcount',ave154);
      	RiskView_Attributes_Reports.Average_func(DS2,'ssnidentitiescount',ave155);
				RiskView_Attributes_Reports.Average_func(DS2,'ssnaddrcount',ave156);
      	RiskView_Attributes_Reports.Average_func(DS2,'ssnidentitiesrecentcount',ave157);
      	RiskView_Attributes_Reports.Average_func(DS2,'ssnaddrrecentcount',ave158);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrphonecount',ave159);
				RiskView_Attributes_Reports.Average_func(DS2,'inputaddrphonerecentcount',ave160);
      	RiskView_Attributes_Reports.Average_func(DS2,'phoneidentitiescount',ave161);
      	RiskView_Attributes_Reports.Average_func(DS2,'phoneidentitiesrecentcount',ave162);
				  RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount01',ave163);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount03',ave164);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount06',ave165);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount12',ave166);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount24',ave167);
					RiskView_Attributes_Reports.Average_func(DS2,'aircraftcount60',ave168);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount',ave169);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount01',ave170);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount03',ave171);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount06',ave172);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount12',ave173);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount24',ave174);
					RiskView_Attributes_Reports.Average_func(DS2,'felonycount60',ave175);
				  RiskView_Attributes_Reports.Average_func(DS2,'liencount',ave176);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount',ave177);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount01',ave178);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount03',ave179);
				  RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount06',ave180);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount12',ave181);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount24',ave182);
					RiskView_Attributes_Reports.Average_func(DS2,'lienfiledcount60',ave183);
					
						      RiskView_Attributes_Reports.Average_func(DS2,'srcsconfirmidaddrcount',ave184);
									RiskView_Attributes_Reports.Average_func(DS2,'felonyage',ave185);
								  RiskView_Attributes_Reports.Average_func(DS2,'lienfiledage',ave186);
									RiskView_Attributes_Reports.Average_func(DS2,'lienreleasedage',ave187);
								  RiskView_Attributes_Reports.Average_func(DS2,'evictionage',ave188);
								  RiskView_Attributes_Reports.Average_func(DS2,'bankruptcyage',ave189);
				
      	avearage:= ave1  + ave2  + ave3  + ave4  + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				           ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						       ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27 + ave28 + ave29 + ave30 +
				           ave31 + ave32 + ave33 + ave34 + ave35 + ave36 + ave37 + ave38 + ave39 + ave40 +
				           ave41 + ave42 + ave43 + ave44 + ave45 + ave46 + ave47 + ave48 + ave49 + ave50 +
									 ave51 + ave52 + ave53 + ave54 + ave55 + ave56 + ave57 + ave58 + ave59 + ave60 +
                   ave61 + ave62 + ave63 + ave64 + ave65 + ave66 + ave67 + ave68 + ave69 + ave70 + 
                   ave71 + ave72 + ave73 + ave74 + ave75 + ave76 + ave77 + ave78 + ave79 + ave80 + 
                   ave81 + ave82 + ave83 + ave84 + ave85 + ave86 + ave87 + ave88 + ave89 + ave90 + 
					         ave91 + ave92 + ave93 + ave94 + ave95 + ave96 + ave97 + ave98 + ave99 + ave100 + 
				           ave101 + ave102 + ave103 + ave104 + ave105 + ave106 + ave107 + ave108 + ave109 + ave110 + 
									 ave111 + ave112 + ave113 + ave114 + ave115 + ave116 + ave117 + ave118 + ave119 + ave120 +
									 ave121 + ave122 + ave123 + ave124 + ave125 + ave126 + ave127 + ave128 + ave129 + ave130 +
				           ave131 + ave132 + ave133 + ave134 + ave135 + ave136 + ave137 + ave138 + ave139 + ave140 +
				           ave141 + ave142 + ave143 + ave144 + ave145 + ave146 + ave147 + ave148 + ave149 + ave150 +
                   ave151 + ave152 + ave153 + ave154 + ave155 + ave156 + ave157 + ave158 + ave159 + ave160 +
                   ave161 + ave162 + ave163 + ave164 + ave165 + ave166 + ave167 + ave168 + ave169 + ave170 + 
                   ave171 + ave172 + ave173 + ave174 + ave175 + ave176 + ave177 + ave178 + ave179 + ave180 + 
									 ave181 + ave182 + ave183 + ave184 + ave185 + ave186 + ave187 + ave188 + ave189 ;
					
								 RiskView_Attributes_Reports.Range_Average_Function_0(DS1,'addrmostrecenttaxdiff',ranav0_1);
											 
											 ranav0:=ranav0_1;	
											 
									RiskView_Attributes_Reports.Range_Average_Function_0(DS2,'addrmostrecenttaxdiff',ranave0_1);
											 
											 ranave0:=ranave0_1;				 
	
	
	 result3_stats:=av + ranav0;
   result4_stats:=avearage + ranave0;
	 
	 //////////////////////////////////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////////////////////////////////
	 //////////////////////////////////////////////////////////////////////////////////
	 
    compare_layout := RECORD
		  string file_version;
			string mode;
      string field_name;
      string distribution_type;
			decimal20_4 p_file_count;
      decimal20_4 c_file_count;
      decimal20_4 file_count_diff;
      STRING50 attribute_value; 
      decimal20_4 p_frequency;
      decimal20_4 c_frequency;
      decimal20_4 frequency_diff;
			decimal20_4 perc_frequency_diff;
   	  decimal20_4 p_proportion;
      decimal20_4 c_proportion;
      decimal20_4 proportion_diff;
			decimal20_4 abs_proportion_diff;
			decimal20_4 perc_proportion_diff;
	
								
            END;				
     	 compare_result1:= join(result2_stats,result1_stats,
				                                        // left.file_version = right.file_version and
      	                                        left.field_name = right.field_name and
         									                      left.distribution_type = right.distribution_type and
         																	      left.attribute_value = right.attribute_value //and
         									                      // left.Count1 = right.Count1
   																							,transform(	compare_layout, self.file_version:='fcra_rvattributes_v4',
																								                            self.mode:='batch',
																								                            self.field_name:=if(left.field_name='',right.field_name,left.field_name),
                  			 			                                              self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
																																						self.p_file_count:=count(file1),
																																						self.c_file_count:=count(file2),
																																						self.file_count_diff:=count(file2)-count(file1) ,
               																														  self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
      																																		  self.p_frequency:=right.Count1,
                  			 			                                              self.c_frequency:=left.Count1,
               																														  self.frequency_diff:=left.Count1-right.Count1,
																																						self.perc_frequency_diff:=if(right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)/left.Count1),
   																																					self.p_proportion:=right.Count1/count(DS1),
                  			 			                                              self.c_proportion:=left.Count1/count(DS2),
               																														  self.proportion_diff:=(left.Count1/count(DS2))-(right.Count1/count(DS1)),
																																						self.abs_proportion_diff:=abs((left.Count1/count(DS2))-(right.Count1/count(DS1))),
																																						self.perc_proportion_diff:=if(right.Count1!= 0 and left.Count1=0,1,((left.Count1/count(DS2))-(right.Count1/count(DS1)))/(left.Count1/count(DS2)))
																																				
																																						
      																						                        ),full outer
      																																											 );

compare_result2:= join(result4_stats,result3_stats,
				                                        // left.file_version = right.file_version and
      	                                        left.field_name = right.field_name and
         									                      left.distribution_type = right.distribution_type and
         																	      left.attribute_value = right.attribute_value //and
         									                      // left.Count1 = right.Count1
   																							,transform(	compare_layout, self.file_version:='fcra_rvattributes_v4',
																								                            self.mode:='batch',
																								                            self.field_name:=if(left.field_name='',right.field_name,left.field_name),
                  			 			                                              self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
               																														  self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
																																						self.p_file_count:=count(file1),
																																						self.c_file_count:=count(file2),
																																						self.file_count_diff:=count(file2)-count(file1) ,
      																																		  self.p_frequency:=count(ds1),
                  			 			                                              self.c_frequency:=count(ds2),
               																														  self.frequency_diff:=count(ds2)-count(ds1),
																																						self.perc_frequency_diff:=(count(ds2)-count(ds1))/count(ds1),
   																																					self.p_proportion:=right.Count1,
                  			 			                                              self.c_proportion:=left.Count1,
               																														  self.proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)/left.Count1),
																																						self.abs_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,abs((left.Count1-right.Count1)/left.Count1)),
																																						self.perc_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,((left.Count1-right.Count1)/left.Count1)/left.Count1)
																																						
      																						                        ),full outer
      																																											 );
         										compare_result:=compare_result1 + compare_result2;																														 
				// compare_result_filter1:=compare_result(abs_proportion_diff>=0.01);										
			  // compare_result_filter2:=sort(compare_result_filter1,-abs_proportion_diff);										

return choosen(compare_result,all);


endmacro;