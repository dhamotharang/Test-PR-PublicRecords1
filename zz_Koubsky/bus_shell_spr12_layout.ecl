﻿EXPORT bus_shell_spr12_layout := module

input := RECORD
   unsigned4 seq;
   string30 acctno;
   unsigned3 historydate;
   unsigned6 powid;
   unsigned6 proxid;
   unsigned6 seleid;
   unsigned6 orgid;
   unsigned6 ultid;
   string120 companyname;
   string120 altcompanyname;
   string120 streetaddress1;
   string120 streetaddress2;
   string25 city;
   string2 state;
   string9 zip;
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string5 zip5;
   string4 zip4;
   string10 lat;
   string11 long;
   string1 addr_type;
   string4 addr_status;
   string3 county;
   string7 geo_block;
   string9 fein;
   string10 phone10;
   string16 ipaddr;
   string120 companyurl;
   string120 rep_fullname;
   string5 rep_nametitle;
   string20 rep_firstname;
   string20 rep_middlename;
   string20 rep_lastname;
   string5 rep_namesuffix;
   string20 rep_formerlastname;
   string120 rep_streetaddress1;
   string120 rep_streetaddress2;
   string25 rep_city;
   string2 rep_state;
   string9 rep_zip;
   string10 rep_prim_range;
   string2 rep_predir;
   string28 rep_prim_name;
   string4 rep_addr_suffix;
   string2 rep_postdir;
   string10 rep_unit_desig;
   string8 rep_sec_range;
   string5 rep_zip5;
   string4 rep_zip4;
   string10 rep_lat;
   string11 rep_long;
   string1 rep_addr_type;
   string4 rep_addr_status;
   string3 rep_county;
   string7 rep_geo_block;
   string9 rep_ssn;
   string8 rep_dateofbirth;
   string10 rep_phone10;
   string3 rep_age;
   string25 rep_dlnumber;
   string2 rep_dlstate;
   string100 rep_email;
   unsigned6 rep_lexid;
   unsigned1 rep_lexidscore;
  END;

layoutverification := RECORD
   string1 inputbusnamecheck;
   string1 inputaltbusnamecheck;
   string1 inputbusaddrline1check;
   string1 inputbusaddrcitycheck;
   string1 inputbusaddrstatecheck;
   string1 inputbusaddrzipcheck;
   string1 inputbusfeincheck;
   string1 inputbusphonecheck;
   string1 inputauthrepfirstnamecheck;
   string1 inputauthreplastnamecheck;
   string1 inputauthrepmiddlenamecheck;
   string1 inputauthrepaddrline1check;
   string1 inputauthrepaddrcitycheck;
   string1 inputauthrepaddrstatecheck;
   string1 inputauthrepaddrzipcheck;
   string1 inputauthrepssncheck;
   string1 inputauthrepphonecheck;
   string1 inputauthrepagecheck;
   string1 inputauthrepdobyearcheck;
   string1 inputauthrepdobmonthcheck;
   string1 inputauthrepdobdaycheck;
   string1 inputauthrepdrvrsliscnumcheck;
   string1 inputauthrepdrvrsliscstatecheck;
   string1 inputauthrepformerlastnamecheck;
   string6 datefirstseen;
   string6 datelastseen;
   string195 sourcelist;
   string455 sourcedatefirstseenlist;
   string455 sourcedatelastseenlist;
   string2 sourcecount;
   string1 sourcefbn;
   string1 sourcebureau;
   string1 sourceucc;
   string1 sourcebbbmember;
   string1 sourcebbbnonmember;
   string1 sourceirsnonprofit;
   string1 sourceosha;
   string1 sourcebankruptcy;
   string1 sourceproperty;
   string1 namematch;
   string195 namematchsourcelist;
   string2 namematchsourcecount;
   string1 namemiskey;
   string1 addrmiskey;
   string2 addrinputresidential;
   string2 addrbestresidential;
   string3 addrconsumercount;
   string1 addrcitymatch;
   string195 addrcitymatchsourcelist;
   string1 addrstatematch;
   string195 addrstatematchsourcelist;
   string1 addrzipcodematch;
   string195 addrzipcodematchsourcelist;
   string1 addrcityzipmatch;
   string2 addrverification;
   string1 addrisbest;
   string195 addrverificationsourcelist;
   string2 addrverificationsourcecount;
   string3 addrcurrentlyreported;
   string3 addreverreported;
   string1 phonematch;
   string195 phonematchsourcelist;
   string2 phonematchsourcecount;
   string1 phonemiskey;
   string2 phoneaddrmismatch;
   string2 phonedisconnected;
   string195 feinmatchsourcelist;
   string2 feinmatchsourcecount;
   string2 feinverification;
   string1 feinmiskeyflag;
   string6 busfeinonfilecount;
   string4 busfeinlinkedtopersonaddr;
   string2 busfeinlinkedtopersonphone;
   string2 busaddrconsumerfirstname;
   string2 busaddrconsumerlastname;
   string2 busaddrconsumerfullname;
   string2 bnap;
   string2 bnat;
   string2 bnas;
   string2 bviindicator;
   string15 inputidmatchpowid;
   string15 inputidmatchproxid;
   string15 inputidmatchseleid;
   string15 inputidmatchorgid;
   string15 inputidmatchultid;
   string3 ultidorgidtreecount;
   string3 ultidseleidtreecount;
   string3 ultidproxidtreecount;
   string3 ultidpowidtreecount;
   string3 orgidseleidtreecount;
   string3 orgidproxidtreecount;
   string3 orgidpowidtreecount;
   string3 seleidproxidtreecount;
   string3 seleidpowidtreecount;
   string3 proxidpowidtreecount;
  END;

layoutar2bi := RECORD
   string abr2bi;
   string2 ar2bbusnameauthrepfirst;
   string2 ar2bbusnameauthreppreffirst;
   string2 ar2bbusnameauthrepfirstfile;
   string2 ar2bbusnameauthreppreffirstfile;
   string2 ar2bbusnameauthreplast;
   string2 ar2bbusnameauthreplastfile;
   string2 ar2bbusnameauthrepfull;
   string2 ar2bbusnameauthrepfullfile;
   string5 ar2bpropertyoverlapcount;
   string5 ar2bbusaddrauthrepowned;
   string2 ar2butilityoverlapcount;
   string2 ar2bpublishedassociation;
   string5 ar2bsharedinquirycount;
   string2 ar2bsameaddr;
   string2 ar2bsameaddrfile;
   string2 ar2bsamephone;
   string2 ar2bsamephonefile;
  END;

layoutpublicrecord := RECORD
   string3 bankruptever;
   string3 bankrupt07year;
   string3 bankrupt02year;
   string3 bankrupt01year;
   string2 bankruptrecenttype;
   string8 bankruptrecentdate;
   string1800 lienfilingdatelist;
   string900 lienreleasedatelist;
   string1500 lientypelist;
   string900 lienfilingstatuslist;
   string600 lienfilingstatelist;
   string1400 lienamountlist;
   string9 lientotalamount;
   string4 liencount;
   string4 lien01years;
   string3 judgmentcount;
   string3 judgment01years;
   string500 judgmentreleaseddate;
   string1800 judgmentfilingdatelist;
   string1500 judgmenttypelist;
   string900 judgmentfilingstatuslist;
   string1400 judgmentamountlist;
   string9 judgmenttotalamount;
   string3 ucccount;
   string1800 uccdatelist;
   string400 ucctypeslist;
   string400 uccfilingstatus;
   string uccfilingamount;
   string ucccollateralcount;
   string uccpropertycount;
   string govdebarred;
   string govdebarreddate;
  END;

layoutassets := RECORD
   string4 propertycount;
   string propertystatelist;
   string propertylandusecode;
   string propertylotsizelist;
   string propertybuildingarealist;
   string propertyyearbuiltlist;
   string propertycountofbuildingslist;
   string propertycountofunitslist;
   string propertymortgageamountlist;
   string propertymortgagetypelist;
   string1000 propertyassesedvaluelist;
   string9 propertyassesedtotal;
   string aircraftcount;
   string aircraftownershiplist;
   string aircraftregisteredlist;
   string aircraftcertificatedatelist;
   string watercraftcount;
   string watercraftuselist;
   string watercraftregisteredlist;
  END;

layouttradeline := RECORD
   string8 tradecurrentaccountbalance;
   string8 trade06monthhighbalance;
   string8 trade06monthlowbalance;
   string8 tradehighextendedcredit;
   string8 trademedianextendedcredit;
   string8 trademedianhighextendedcredit;
   string8 tradenew12monthhighbalance;
   string8 tradereg12monthhighbalance;
   string8 tradecombo12monthhighbalance;
   string9 tradeactivetotalbalance;
   string3 tradepercentnewgoodstanding;
   string3 tradepercentreggoodstanding;
   string3 tradepercentcombogoodstanding;
   string6 tradenewcount;
   string6 traderegcount;
   string6 tradecombocount;
   string3 tradepercentnew1to30dpd;
   string3 tradepercentnew31to60dpd;
   string3 tradepercentnew61to90dpd;
   string3 tradepercentnew91ormoredpd;
   string3 tradepercentreg1to30dpd;
   string3 tradepercentreg31to60dpd;
   string3 tradepercentreg61to90dpd;
   string3 tradepercentreg91ormoredpd;
   string3 tradepercentcombo1to30dpd;
   string3 tradepercentcombo31to60dpd;
   string3 tradepercentcombo61to90dpd;
   string3 tradepercentcombo91ormoredpd;
   string bureauinqindustrycodelist;
   string bureauinqindustrydescriptionlist;
   string bureauinqmonthlist;
   string bureauinqyearlist;
   string bureauinqtotallist;
  END;

layoutfirmographic := RECORD
   string3 busobservedage;
   string3 busreportedage;
   string600 industrysourcenaicbestlist;
   string1400 industrynaicbestlist;
   string6 industrynaicprimary;
   string600 industrysourcenaiccompletelist;
   string1400 industrynaiccompletelist;
   string600 industrysicsourcebestlist;
   string1000 industrysicbestlist;
   string4 industrysicprimary;
   string900 industrysourcesiccompletelist;
   string1500 industrysiccompletelist;
   string21 employeecountsourcelist;
   string63 employeecountdatefirstseenlist;
   string63 employeecountdatelastseenlist;
   string49 employeecountlist;
   string6 employeecountsmallest;
   string6 employeecountlargest;
   string6 employeecountmostrecent;
   string6 employeecount;
   string buscontactcount;
   string bussquarefootage;
   string busownorrent;
   string industrygroup;
   string bushasdunsnumberlist;
   string9 financereportedsales;
   string9 financereportedearnings;
   string9 financereportedassets;
   string financereportedliabilities;
   string financeworthofbus;
   string bustypenameadvertized;
   string1 bustypeaddress;
   string busingoodstanding;
   string buswebsiteonfile;
   string buswebsiteext;
   string businactiveindicator;
   string businactiveever;
  END;

layoutdemographic := RECORD
   string busshellcompany;
   string associatecount;
   string associatecrimeindex;
   string associatefelonycount;
   string associatecountwithfelony;
   string associatebankyruptcount;
   string associatecountwithbankruptcy;
   string associatebankyrupt1yearcount;
   string associatebusinesscount;
   string associatecitycount;
   string addrmedianincome;
   string addrmedianvalue;
   string addrmurderindex;
   string addrcartheftindex;
   string addrburglaryindex;
   string addrcrimeindex;
   string addrmobilityindex;
   string addrvacantpropcount;
   string addrcountyfcindex;
  END;

layoutother := RECORD
   string stockindicator;
   string stockchange;
   string buspublicorprivate;
   string oshainspectiondatelist;
   string oshatotalpenaltieslist;
   string oshaseriousviolationslist;
   string oshatotalviolationslist;
   string oshapenaltydollarslist;
   string irs5500pensionplan;
  END;

layoutsos := RECORD
   string900 sosdateofincorporationlist;
   string2 soseverdefunct;
   string200 sostypeoffilingtermlist;
   string300 sosstateofincorporationlist;
   string900 sosdateoffilinglist;
   string1500 soscodelist;
   string500 sosfilingcodelist;
   string300 sosforiegnstatelist;
   string3100 soscorporatestructurelist;
   string200 sosownershiptypelist;
   string1600 soslocationdescriptionlist;
   string2100 sosnatureofbusinesslist;
   string300 soscountofamendments;
   string200 sosregisteragentchange;
   string900 sosregisteragentchangedatelist;
  END;

layouttaxes := RECORD
   string corptaxesowed;
   string corpfranchisetaxes;
   string corptaxprogram;
  END;

layoutinquiryinfo := RECORD
   string3500 inquiryindustrydescriptionlist;
   string4500 inquirydatelist;
   string5 inquiry12months;
   string5 inquiry06months;
   string5 inquiry03months;
   string5 inquiryconsumeraddress;
   string5 inquiryconsumerphone;
   string5 inquiryconsumeraddressssn;
  END;

layoutindustrycomp := RECORD
   string compareavgnumemployeeindustry;
   string comparemednumemployeeindustry;
   string compareavgnumemployeestate;
   string comparemednumemployeestate;
   string compareavgnumemployeezip;
   string comparemednumemployeezip;
   string compareavgnumemployeeall;
   string comparemednumemployeeall;
   string compareavgnetworthindustry;
   string comparemednetworthindustry;
   string compareavgnetworthstate;
   string comparemednetworthstate;
   string compareavgnetworthzip;
   string comparemednetworthzip;
   string compareavgnetworthall;
   string comparemednetworthall;
   string comparegrowshrinkstagnant;
  END;

export layout := RECORD
  input input_echo;
  layoutverification verification;
  layoutar2bi ar2bi;
  layoutpublicrecord public_record;
  layoutassets assets;
  layouttradeline tradeline;
  layoutfirmographic firmographic;
  layoutdemographic demographic;
  layoutother other;
  layoutsos sos;
  layouttaxes taxes;
  layoutinquiryinfo inquiry_information;
  layoutindustrycomp industry_comparison;
  string200 errorcode;
  string50 file_ind;
 END;

export sources := set(
	dataset([
		{'BR'},
		{'C'},
		{'D'},
		{'DN'},
		{'ER'},
		{'FB'},
		{'L0'},
		{'L2'},
		{'DF'},
		{'U2'},
		{'AR'},
		{'BA'},
		{'BM/BN'},
		{'C#'},
		{'CU'},
		{'DA'},
		{'Q3'},
		{'EF'},
		{'FI'},
		{'I'},
		{'IN'},
		{'V2'},
		{'OS'},
		{'PL'},
		{'P'},
		{'SK'},
		{'SK'},
		{'TX'},
		{''},
		{'WA'},
		{'Y'},
		{'IC'},
		{'WB'},
		{'FK'},
		{'H7'},
		{'GB'},
		{'WX'},
		{'SB'},
		{'WK'},
		{'CF'},
		{'SJ'},
		{'F'},
		{'BY'},
		{'IP'},
		{'FT'},
		{'E'},
		{'EY'},
		{'FR'},
		{'GR'},
		{'IS'},
		{'IT'},
		{'MH'},
		{'MW'},
		{'NR'},
		{'J2'},
		{'NP'},
		{'ZO'},
		{'WC'},
		{'KC'},
		{'SA'},
		{'SA'},
		{'SG'},
		{'SP'},
		{'UT'},
		{'V'}
	]		
	, {string sourcecode})
	, sourcecode);

end;