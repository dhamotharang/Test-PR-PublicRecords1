IMPORT SALT311,STD;
EXPORT charge_arrests_hygiene(dataset(charge_arrests_layout_crim) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.vendor))'', MAX(GROUP,h.vendor));
    NumberOfRecords := COUNT(GROUP);
    populated_recordid_cnt := COUNT(GROUP,h.recordid <> (TYPEOF(h.recordid))'');
    populated_recordid_pcnt := AVE(GROUP,IF(h.recordid = (TYPEOF(h.recordid))'',0,100));
    maxlength_recordid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordid)));
    avelength_recordid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordid)),h.recordid<>(typeof(h.recordid))'');
    populated_statecode_cnt := COUNT(GROUP,h.statecode <> (TYPEOF(h.statecode))'');
    populated_statecode_pcnt := AVE(GROUP,IF(h.statecode = (TYPEOF(h.statecode))'',0,100));
    maxlength_statecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statecode)));
    avelength_statecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statecode)),h.statecode<>(typeof(h.statecode))'');
    populated_caseid_cnt := COUNT(GROUP,h.caseid <> (TYPEOF(h.caseid))'');
    populated_caseid_pcnt := AVE(GROUP,IF(h.caseid = (TYPEOF(h.caseid))'',0,100));
    maxlength_caseid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseid)));
    avelength_caseid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.caseid)),h.caseid<>(typeof(h.caseid))'');
    populated_warrantnumber_cnt := COUNT(GROUP,h.warrantnumber <> (TYPEOF(h.warrantnumber))'');
    populated_warrantnumber_pcnt := AVE(GROUP,IF(h.warrantnumber = (TYPEOF(h.warrantnumber))'',0,100));
    maxlength_warrantnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantnumber)));
    avelength_warrantnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantnumber)),h.warrantnumber<>(typeof(h.warrantnumber))'');
    populated_warrantdate_cnt := COUNT(GROUP,h.warrantdate <> (TYPEOF(h.warrantdate))'');
    populated_warrantdate_pcnt := AVE(GROUP,IF(h.warrantdate = (TYPEOF(h.warrantdate))'',0,100));
    maxlength_warrantdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantdate)));
    avelength_warrantdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantdate)),h.warrantdate<>(typeof(h.warrantdate))'');
    populated_warrantdesc_cnt := COUNT(GROUP,h.warrantdesc <> (TYPEOF(h.warrantdesc))'');
    populated_warrantdesc_pcnt := AVE(GROUP,IF(h.warrantdesc = (TYPEOF(h.warrantdesc))'',0,100));
    maxlength_warrantdesc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantdesc)));
    avelength_warrantdesc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantdesc)),h.warrantdesc<>(typeof(h.warrantdesc))'');
    populated_warrantissuedate_cnt := COUNT(GROUP,h.warrantissuedate <> (TYPEOF(h.warrantissuedate))'');
    populated_warrantissuedate_pcnt := AVE(GROUP,IF(h.warrantissuedate = (TYPEOF(h.warrantissuedate))'',0,100));
    maxlength_warrantissuedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantissuedate)));
    avelength_warrantissuedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantissuedate)),h.warrantissuedate<>(typeof(h.warrantissuedate))'');
    populated_warrantissuingagency_cnt := COUNT(GROUP,h.warrantissuingagency <> (TYPEOF(h.warrantissuingagency))'');
    populated_warrantissuingagency_pcnt := AVE(GROUP,IF(h.warrantissuingagency = (TYPEOF(h.warrantissuingagency))'',0,100));
    maxlength_warrantissuingagency := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantissuingagency)));
    avelength_warrantissuingagency := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantissuingagency)),h.warrantissuingagency<>(typeof(h.warrantissuingagency))'');
    populated_warrantstatus_cnt := COUNT(GROUP,h.warrantstatus <> (TYPEOF(h.warrantstatus))'');
    populated_warrantstatus_pcnt := AVE(GROUP,IF(h.warrantstatus = (TYPEOF(h.warrantstatus))'',0,100));
    maxlength_warrantstatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantstatus)));
    avelength_warrantstatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.warrantstatus)),h.warrantstatus<>(typeof(h.warrantstatus))'');
    populated_citationnumber_cnt := COUNT(GROUP,h.citationnumber <> (TYPEOF(h.citationnumber))'');
    populated_citationnumber_pcnt := AVE(GROUP,IF(h.citationnumber = (TYPEOF(h.citationnumber))'',0,100));
    maxlength_citationnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.citationnumber)));
    avelength_citationnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.citationnumber)),h.citationnumber<>(typeof(h.citationnumber))'');
    populated_bookingnumber_cnt := COUNT(GROUP,h.bookingnumber <> (TYPEOF(h.bookingnumber))'');
    populated_bookingnumber_pcnt := AVE(GROUP,IF(h.bookingnumber = (TYPEOF(h.bookingnumber))'',0,100));
    maxlength_bookingnumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bookingnumber)));
    avelength_bookingnumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bookingnumber)),h.bookingnumber<>(typeof(h.bookingnumber))'');
    populated_arrestdate_cnt := COUNT(GROUP,h.arrestdate <> (TYPEOF(h.arrestdate))'');
    populated_arrestdate_pcnt := AVE(GROUP,IF(h.arrestdate = (TYPEOF(h.arrestdate))'',0,100));
    maxlength_arrestdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arrestdate)));
    avelength_arrestdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arrestdate)),h.arrestdate<>(typeof(h.arrestdate))'');
    populated_arrestingagency_cnt := COUNT(GROUP,h.arrestingagency <> (TYPEOF(h.arrestingagency))'');
    populated_arrestingagency_pcnt := AVE(GROUP,IF(h.arrestingagency = (TYPEOF(h.arrestingagency))'',0,100));
    maxlength_arrestingagency := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.arrestingagency)));
    avelength_arrestingagency := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.arrestingagency)),h.arrestingagency<>(typeof(h.arrestingagency))'');
    populated_bookingdate_cnt := COUNT(GROUP,h.bookingdate <> (TYPEOF(h.bookingdate))'');
    populated_bookingdate_pcnt := AVE(GROUP,IF(h.bookingdate = (TYPEOF(h.bookingdate))'',0,100));
    maxlength_bookingdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bookingdate)));
    avelength_bookingdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bookingdate)),h.bookingdate<>(typeof(h.bookingdate))'');
    populated_custodydate_cnt := COUNT(GROUP,h.custodydate <> (TYPEOF(h.custodydate))'');
    populated_custodydate_pcnt := AVE(GROUP,IF(h.custodydate = (TYPEOF(h.custodydate))'',0,100));
    maxlength_custodydate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.custodydate)));
    avelength_custodydate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.custodydate)),h.custodydate<>(typeof(h.custodydate))'');
    populated_custodylocation_cnt := COUNT(GROUP,h.custodylocation <> (TYPEOF(h.custodylocation))'');
    populated_custodylocation_pcnt := AVE(GROUP,IF(h.custodylocation = (TYPEOF(h.custodylocation))'',0,100));
    maxlength_custodylocation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.custodylocation)));
    avelength_custodylocation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.custodylocation)),h.custodylocation<>(typeof(h.custodylocation))'');
    populated_initialcharge_cnt := COUNT(GROUP,h.initialcharge <> (TYPEOF(h.initialcharge))'');
    populated_initialcharge_pcnt := AVE(GROUP,IF(h.initialcharge = (TYPEOF(h.initialcharge))'',0,100));
    maxlength_initialcharge := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialcharge)));
    avelength_initialcharge := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialcharge)),h.initialcharge<>(typeof(h.initialcharge))'');
    populated_initialchargedate_cnt := COUNT(GROUP,h.initialchargedate <> (TYPEOF(h.initialchargedate))'');
    populated_initialchargedate_pcnt := AVE(GROUP,IF(h.initialchargedate = (TYPEOF(h.initialchargedate))'',0,100));
    maxlength_initialchargedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialchargedate)));
    avelength_initialchargedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialchargedate)),h.initialchargedate<>(typeof(h.initialchargedate))'');
    populated_initialchargecancelleddate_cnt := COUNT(GROUP,h.initialchargecancelleddate <> (TYPEOF(h.initialchargecancelleddate))'');
    populated_initialchargecancelleddate_pcnt := AVE(GROUP,IF(h.initialchargecancelleddate = (TYPEOF(h.initialchargecancelleddate))'',0,100));
    maxlength_initialchargecancelleddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialchargecancelleddate)));
    avelength_initialchargecancelleddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.initialchargecancelleddate)),h.initialchargecancelleddate<>(typeof(h.initialchargecancelleddate))'');
    populated_chargedisposed_cnt := COUNT(GROUP,h.chargedisposed <> (TYPEOF(h.chargedisposed))'');
    populated_chargedisposed_pcnt := AVE(GROUP,IF(h.chargedisposed = (TYPEOF(h.chargedisposed))'',0,100));
    maxlength_chargedisposed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chargedisposed)));
    avelength_chargedisposed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chargedisposed)),h.chargedisposed<>(typeof(h.chargedisposed))'');
    populated_chargedisposeddate_cnt := COUNT(GROUP,h.chargedisposeddate <> (TYPEOF(h.chargedisposeddate))'');
    populated_chargedisposeddate_pcnt := AVE(GROUP,IF(h.chargedisposeddate = (TYPEOF(h.chargedisposeddate))'',0,100));
    maxlength_chargedisposeddate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chargedisposeddate)));
    avelength_chargedisposeddate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chargedisposeddate)),h.chargedisposeddate<>(typeof(h.chargedisposeddate))'');
    populated_chargeseverity_cnt := COUNT(GROUP,h.chargeseverity <> (TYPEOF(h.chargeseverity))'');
    populated_chargeseverity_pcnt := AVE(GROUP,IF(h.chargeseverity = (TYPEOF(h.chargeseverity))'',0,100));
    maxlength_chargeseverity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chargeseverity)));
    avelength_chargeseverity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chargeseverity)),h.chargeseverity<>(typeof(h.chargeseverity))'');
    populated_chargedisposition_cnt := COUNT(GROUP,h.chargedisposition <> (TYPEOF(h.chargedisposition))'');
    populated_chargedisposition_pcnt := AVE(GROUP,IF(h.chargedisposition = (TYPEOF(h.chargedisposition))'',0,100));
    maxlength_chargedisposition := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chargedisposition)));
    avelength_chargedisposition := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chargedisposition)),h.chargedisposition<>(typeof(h.chargedisposition))'');
    populated_amendedcharge_cnt := COUNT(GROUP,h.amendedcharge <> (TYPEOF(h.amendedcharge))'');
    populated_amendedcharge_pcnt := AVE(GROUP,IF(h.amendedcharge = (TYPEOF(h.amendedcharge))'',0,100));
    maxlength_amendedcharge := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amendedcharge)));
    avelength_amendedcharge := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amendedcharge)),h.amendedcharge<>(typeof(h.amendedcharge))'');
    populated_amendedchargedate_cnt := COUNT(GROUP,h.amendedchargedate <> (TYPEOF(h.amendedchargedate))'');
    populated_amendedchargedate_pcnt := AVE(GROUP,IF(h.amendedchargedate = (TYPEOF(h.amendedchargedate))'',0,100));
    maxlength_amendedchargedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amendedchargedate)));
    avelength_amendedchargedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amendedchargedate)),h.amendedchargedate<>(typeof(h.amendedchargedate))'');
    populated_bondsman_cnt := COUNT(GROUP,h.bondsman <> (TYPEOF(h.bondsman))'');
    populated_bondsman_pcnt := AVE(GROUP,IF(h.bondsman = (TYPEOF(h.bondsman))'',0,100));
    maxlength_bondsman := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bondsman)));
    avelength_bondsman := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bondsman)),h.bondsman<>(typeof(h.bondsman))'');
    populated_bondamount_cnt := COUNT(GROUP,h.bondamount <> (TYPEOF(h.bondamount))'');
    populated_bondamount_pcnt := AVE(GROUP,IF(h.bondamount = (TYPEOF(h.bondamount))'',0,100));
    maxlength_bondamount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bondamount)));
    avelength_bondamount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bondamount)),h.bondamount<>(typeof(h.bondamount))'');
    populated_bondtype_cnt := COUNT(GROUP,h.bondtype <> (TYPEOF(h.bondtype))'');
    populated_bondtype_pcnt := AVE(GROUP,IF(h.bondtype = (TYPEOF(h.bondtype))'',0,100));
    maxlength_bondtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bondtype)));
    avelength_bondtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bondtype)),h.bondtype<>(typeof(h.bondtype))'');
    populated_sourcename_cnt := COUNT(GROUP,h.sourcename <> (TYPEOF(h.sourcename))'');
    populated_sourcename_pcnt := AVE(GROUP,IF(h.sourcename = (TYPEOF(h.sourcename))'',0,100));
    maxlength_sourcename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcename)));
    avelength_sourcename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcename)),h.sourcename<>(typeof(h.sourcename))'');
    populated_sourceid_cnt := COUNT(GROUP,h.sourceid <> (TYPEOF(h.sourceid))'');
    populated_sourceid_pcnt := AVE(GROUP,IF(h.sourceid = (TYPEOF(h.sourceid))'',0,100));
    maxlength_sourceid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourceid)));
    avelength_sourceid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourceid)),h.sourceid<>(typeof(h.sourceid))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recordid_pcnt *   0.00 / 100 + T.Populated_statecode_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_warrantnumber_pcnt *   0.00 / 100 + T.Populated_warrantdate_pcnt *   0.00 / 100 + T.Populated_warrantdesc_pcnt *   0.00 / 100 + T.Populated_warrantissuedate_pcnt *   0.00 / 100 + T.Populated_warrantissuingagency_pcnt *   0.00 / 100 + T.Populated_warrantstatus_pcnt *   0.00 / 100 + T.Populated_citationnumber_pcnt *   0.00 / 100 + T.Populated_bookingnumber_pcnt *   0.00 / 100 + T.Populated_arrestdate_pcnt *   0.00 / 100 + T.Populated_arrestingagency_pcnt *   0.00 / 100 + T.Populated_bookingdate_pcnt *   0.00 / 100 + T.Populated_custodydate_pcnt *   0.00 / 100 + T.Populated_custodylocation_pcnt *   0.00 / 100 + T.Populated_initialcharge_pcnt *   0.00 / 100 + T.Populated_initialchargedate_pcnt *   0.00 / 100 + T.Populated_initialchargecancelleddate_pcnt *   0.00 / 100 + T.Populated_chargedisposed_pcnt *   0.00 / 100 + T.Populated_chargedisposeddate_pcnt *   0.00 / 100 + T.Populated_chargeseverity_pcnt *   0.00 / 100 + T.Populated_chargedisposition_pcnt *   0.00 / 100 + T.Populated_amendedcharge_pcnt *   0.00 / 100 + T.Populated_amendedchargedate_pcnt *   0.00 / 100 + T.Populated_bondsman_pcnt *   0.00 / 100 + T.Populated_bondamount_pcnt *   0.00 / 100 + T.Populated_bondtype_pcnt *   0.00 / 100 + T.Populated_sourcename_pcnt *   0.00 / 100 + T.Populated_sourceid_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING vendor1;
    STRING vendor2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.vendor1 := le.Source;
    SELF.vendor2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_recordid_pcnt*ri.Populated_recordid_pcnt *   0.00 / 10000 + le.Populated_statecode_pcnt*ri.Populated_statecode_pcnt *   0.00 / 10000 + le.Populated_caseid_pcnt*ri.Populated_caseid_pcnt *   0.00 / 10000 + le.Populated_warrantnumber_pcnt*ri.Populated_warrantnumber_pcnt *   0.00 / 10000 + le.Populated_warrantdate_pcnt*ri.Populated_warrantdate_pcnt *   0.00 / 10000 + le.Populated_warrantdesc_pcnt*ri.Populated_warrantdesc_pcnt *   0.00 / 10000 + le.Populated_warrantissuedate_pcnt*ri.Populated_warrantissuedate_pcnt *   0.00 / 10000 + le.Populated_warrantissuingagency_pcnt*ri.Populated_warrantissuingagency_pcnt *   0.00 / 10000 + le.Populated_warrantstatus_pcnt*ri.Populated_warrantstatus_pcnt *   0.00 / 10000 + le.Populated_citationnumber_pcnt*ri.Populated_citationnumber_pcnt *   0.00 / 10000 + le.Populated_bookingnumber_pcnt*ri.Populated_bookingnumber_pcnt *   0.00 / 10000 + le.Populated_arrestdate_pcnt*ri.Populated_arrestdate_pcnt *   0.00 / 10000 + le.Populated_arrestingagency_pcnt*ri.Populated_arrestingagency_pcnt *   0.00 / 10000 + le.Populated_bookingdate_pcnt*ri.Populated_bookingdate_pcnt *   0.00 / 10000 + le.Populated_custodydate_pcnt*ri.Populated_custodydate_pcnt *   0.00 / 10000 + le.Populated_custodylocation_pcnt*ri.Populated_custodylocation_pcnt *   0.00 / 10000 + le.Populated_initialcharge_pcnt*ri.Populated_initialcharge_pcnt *   0.00 / 10000 + le.Populated_initialchargedate_pcnt*ri.Populated_initialchargedate_pcnt *   0.00 / 10000 + le.Populated_initialchargecancelleddate_pcnt*ri.Populated_initialchargecancelleddate_pcnt *   0.00 / 10000 + le.Populated_chargedisposed_pcnt*ri.Populated_chargedisposed_pcnt *   0.00 / 10000 + le.Populated_chargedisposeddate_pcnt*ri.Populated_chargedisposeddate_pcnt *   0.00 / 10000 + le.Populated_chargeseverity_pcnt*ri.Populated_chargeseverity_pcnt *   0.00 / 10000 + le.Populated_chargedisposition_pcnt*ri.Populated_chargedisposition_pcnt *   0.00 / 10000 + le.Populated_amendedcharge_pcnt*ri.Populated_amendedcharge_pcnt *   0.00 / 10000 + le.Populated_amendedchargedate_pcnt*ri.Populated_amendedchargedate_pcnt *   0.00 / 10000 + le.Populated_bondsman_pcnt*ri.Populated_bondsman_pcnt *   0.00 / 10000 + le.Populated_bondamount_pcnt*ri.Populated_bondamount_pcnt *   0.00 / 10000 + le.Populated_bondtype_pcnt*ri.Populated_bondtype_pcnt *   0.00 / 10000 + le.Populated_sourcename_pcnt*ri.Populated_sourcename_pcnt *   0.00 / 10000 + le.Populated_sourceid_pcnt*ri.Populated_sourceid_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'recordid','statecode','caseid','warrantnumber','warrantdate','warrantdesc','warrantissuedate','warrantissuingagency','warrantstatus','citationnumber','bookingnumber','arrestdate','arrestingagency','bookingdate','custodydate','custodylocation','initialcharge','initialchargedate','initialchargecancelleddate','chargedisposed','chargedisposeddate','chargeseverity','chargedisposition','amendedcharge','amendedchargedate','bondsman','bondamount','bondtype','sourcename','sourceid','vendor');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recordid_pcnt,le.populated_statecode_pcnt,le.populated_caseid_pcnt,le.populated_warrantnumber_pcnt,le.populated_warrantdate_pcnt,le.populated_warrantdesc_pcnt,le.populated_warrantissuedate_pcnt,le.populated_warrantissuingagency_pcnt,le.populated_warrantstatus_pcnt,le.populated_citationnumber_pcnt,le.populated_bookingnumber_pcnt,le.populated_arrestdate_pcnt,le.populated_arrestingagency_pcnt,le.populated_bookingdate_pcnt,le.populated_custodydate_pcnt,le.populated_custodylocation_pcnt,le.populated_initialcharge_pcnt,le.populated_initialchargedate_pcnt,le.populated_initialchargecancelleddate_pcnt,le.populated_chargedisposed_pcnt,le.populated_chargedisposeddate_pcnt,le.populated_chargeseverity_pcnt,le.populated_chargedisposition_pcnt,le.populated_amendedcharge_pcnt,le.populated_amendedchargedate_pcnt,le.populated_bondsman_pcnt,le.populated_bondamount_pcnt,le.populated_bondtype_pcnt,le.populated_sourcename_pcnt,le.populated_sourceid_pcnt,le.populated_vendor_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recordid,le.maxlength_statecode,le.maxlength_caseid,le.maxlength_warrantnumber,le.maxlength_warrantdate,le.maxlength_warrantdesc,le.maxlength_warrantissuedate,le.maxlength_warrantissuingagency,le.maxlength_warrantstatus,le.maxlength_citationnumber,le.maxlength_bookingnumber,le.maxlength_arrestdate,le.maxlength_arrestingagency,le.maxlength_bookingdate,le.maxlength_custodydate,le.maxlength_custodylocation,le.maxlength_initialcharge,le.maxlength_initialchargedate,le.maxlength_initialchargecancelleddate,le.maxlength_chargedisposed,le.maxlength_chargedisposeddate,le.maxlength_chargeseverity,le.maxlength_chargedisposition,le.maxlength_amendedcharge,le.maxlength_amendedchargedate,le.maxlength_bondsman,le.maxlength_bondamount,le.maxlength_bondtype,le.maxlength_sourcename,le.maxlength_sourceid,le.maxlength_vendor);
  SELF.avelength := CHOOSE(C,le.avelength_recordid,le.avelength_statecode,le.avelength_caseid,le.avelength_warrantnumber,le.avelength_warrantdate,le.avelength_warrantdesc,le.avelength_warrantissuedate,le.avelength_warrantissuingagency,le.avelength_warrantstatus,le.avelength_citationnumber,le.avelength_bookingnumber,le.avelength_arrestdate,le.avelength_arrestingagency,le.avelength_bookingdate,le.avelength_custodydate,le.avelength_custodylocation,le.avelength_initialcharge,le.avelength_initialchargedate,le.avelength_initialchargecancelleddate,le.avelength_chargedisposed,le.avelength_chargedisposeddate,le.avelength_chargeseverity,le.avelength_chargedisposition,le.avelength_amendedcharge,le.avelength_amendedchargedate,le.avelength_bondsman,le.avelength_bondamount,le.avelength_bondtype,le.avelength_sourcename,le.avelength_sourceid,le.avelength_vendor);
END;
EXPORT invSummary := NORMALIZE(summary0, 31, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.warrantnumber),TRIM((SALT311.StrType)le.warrantdate),TRIM((SALT311.StrType)le.warrantdesc),TRIM((SALT311.StrType)le.warrantissuedate),TRIM((SALT311.StrType)le.warrantissuingagency),TRIM((SALT311.StrType)le.warrantstatus),TRIM((SALT311.StrType)le.citationnumber),TRIM((SALT311.StrType)le.bookingnumber),TRIM((SALT311.StrType)le.arrestdate),TRIM((SALT311.StrType)le.arrestingagency),TRIM((SALT311.StrType)le.bookingdate),TRIM((SALT311.StrType)le.custodydate),TRIM((SALT311.StrType)le.custodylocation),TRIM((SALT311.StrType)le.initialcharge),TRIM((SALT311.StrType)le.initialchargedate),TRIM((SALT311.StrType)le.initialchargecancelleddate),TRIM((SALT311.StrType)le.chargedisposed),TRIM((SALT311.StrType)le.chargedisposeddate),TRIM((SALT311.StrType)le.chargeseverity),TRIM((SALT311.StrType)le.chargedisposition),TRIM((SALT311.StrType)le.amendedcharge),TRIM((SALT311.StrType)le.amendedchargedate),TRIM((SALT311.StrType)le.bondsman),TRIM((SALT311.StrType)le.bondamount),TRIM((SALT311.StrType)le.bondtype),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.vendor)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,31,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 31);
  SELF.FldNo2 := 1 + (C % 31);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.warrantnumber),TRIM((SALT311.StrType)le.warrantdate),TRIM((SALT311.StrType)le.warrantdesc),TRIM((SALT311.StrType)le.warrantissuedate),TRIM((SALT311.StrType)le.warrantissuingagency),TRIM((SALT311.StrType)le.warrantstatus),TRIM((SALT311.StrType)le.citationnumber),TRIM((SALT311.StrType)le.bookingnumber),TRIM((SALT311.StrType)le.arrestdate),TRIM((SALT311.StrType)le.arrestingagency),TRIM((SALT311.StrType)le.bookingdate),TRIM((SALT311.StrType)le.custodydate),TRIM((SALT311.StrType)le.custodylocation),TRIM((SALT311.StrType)le.initialcharge),TRIM((SALT311.StrType)le.initialchargedate),TRIM((SALT311.StrType)le.initialchargecancelleddate),TRIM((SALT311.StrType)le.chargedisposed),TRIM((SALT311.StrType)le.chargedisposeddate),TRIM((SALT311.StrType)le.chargeseverity),TRIM((SALT311.StrType)le.chargedisposition),TRIM((SALT311.StrType)le.amendedcharge),TRIM((SALT311.StrType)le.amendedchargedate),TRIM((SALT311.StrType)le.bondsman),TRIM((SALT311.StrType)le.bondamount),TRIM((SALT311.StrType)le.bondtype),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.vendor)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.caseid),TRIM((SALT311.StrType)le.warrantnumber),TRIM((SALT311.StrType)le.warrantdate),TRIM((SALT311.StrType)le.warrantdesc),TRIM((SALT311.StrType)le.warrantissuedate),TRIM((SALT311.StrType)le.warrantissuingagency),TRIM((SALT311.StrType)le.warrantstatus),TRIM((SALT311.StrType)le.citationnumber),TRIM((SALT311.StrType)le.bookingnumber),TRIM((SALT311.StrType)le.arrestdate),TRIM((SALT311.StrType)le.arrestingagency),TRIM((SALT311.StrType)le.bookingdate),TRIM((SALT311.StrType)le.custodydate),TRIM((SALT311.StrType)le.custodylocation),TRIM((SALT311.StrType)le.initialcharge),TRIM((SALT311.StrType)le.initialchargedate),TRIM((SALT311.StrType)le.initialchargecancelleddate),TRIM((SALT311.StrType)le.chargedisposed),TRIM((SALT311.StrType)le.chargedisposeddate),TRIM((SALT311.StrType)le.chargeseverity),TRIM((SALT311.StrType)le.chargedisposition),TRIM((SALT311.StrType)le.amendedcharge),TRIM((SALT311.StrType)le.amendedchargedate),TRIM((SALT311.StrType)le.bondsman),TRIM((SALT311.StrType)le.bondamount),TRIM((SALT311.StrType)le.bondtype),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.vendor)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),31*31,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'recordid'}
      ,{2,'statecode'}
      ,{3,'caseid'}
      ,{4,'warrantnumber'}
      ,{5,'warrantdate'}
      ,{6,'warrantdesc'}
      ,{7,'warrantissuedate'}
      ,{8,'warrantissuingagency'}
      ,{9,'warrantstatus'}
      ,{10,'citationnumber'}
      ,{11,'bookingnumber'}
      ,{12,'arrestdate'}
      ,{13,'arrestingagency'}
      ,{14,'bookingdate'}
      ,{15,'custodydate'}
      ,{16,'custodylocation'}
      ,{17,'initialcharge'}
      ,{18,'initialchargedate'}
      ,{19,'initialchargecancelleddate'}
      ,{20,'chargedisposed'}
      ,{21,'chargedisposeddate'}
      ,{22,'chargeseverity'}
      ,{23,'chargedisposition'}
      ,{24,'amendedcharge'}
      ,{25,'amendedchargedate'}
      ,{26,'bondsman'}
      ,{27,'bondamount'}
      ,{28,'bondtype'}
      ,{29,'sourcename'}
      ,{30,'sourceid'}
      ,{31,'vendor'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor) vendor; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    charge_arrests_Fields.InValid_recordid((SALT311.StrType)le.recordid),
    charge_arrests_Fields.InValid_statecode((SALT311.StrType)le.statecode),
    charge_arrests_Fields.InValid_caseid((SALT311.StrType)le.caseid),
    charge_arrests_Fields.InValid_warrantnumber((SALT311.StrType)le.warrantnumber),
    charge_arrests_Fields.InValid_warrantdate((SALT311.StrType)le.warrantdate),
    charge_arrests_Fields.InValid_warrantdesc((SALT311.StrType)le.warrantdesc),
    charge_arrests_Fields.InValid_warrantissuedate((SALT311.StrType)le.warrantissuedate),
    charge_arrests_Fields.InValid_warrantissuingagency((SALT311.StrType)le.warrantissuingagency),
    charge_arrests_Fields.InValid_warrantstatus((SALT311.StrType)le.warrantstatus),
    charge_arrests_Fields.InValid_citationnumber((SALT311.StrType)le.citationnumber),
    charge_arrests_Fields.InValid_bookingnumber((SALT311.StrType)le.bookingnumber),
    charge_arrests_Fields.InValid_arrestdate((SALT311.StrType)le.arrestdate),
    charge_arrests_Fields.InValid_arrestingagency((SALT311.StrType)le.arrestingagency),
    charge_arrests_Fields.InValid_bookingdate((SALT311.StrType)le.bookingdate),
    charge_arrests_Fields.InValid_custodydate((SALT311.StrType)le.custodydate),
    charge_arrests_Fields.InValid_custodylocation((SALT311.StrType)le.custodylocation),
    charge_arrests_Fields.InValid_initialcharge((SALT311.StrType)le.initialcharge),
    charge_arrests_Fields.InValid_initialchargedate((SALT311.StrType)le.initialchargedate),
    charge_arrests_Fields.InValid_initialchargecancelleddate((SALT311.StrType)le.initialchargecancelleddate),
    charge_arrests_Fields.InValid_chargedisposed((SALT311.StrType)le.chargedisposed),
    charge_arrests_Fields.InValid_chargedisposeddate((SALT311.StrType)le.chargedisposeddate),
    charge_arrests_Fields.InValid_chargeseverity((SALT311.StrType)le.chargeseverity),
    charge_arrests_Fields.InValid_chargedisposition((SALT311.StrType)le.chargedisposition),
    charge_arrests_Fields.InValid_amendedcharge((SALT311.StrType)le.amendedcharge),
    charge_arrests_Fields.InValid_amendedchargedate((SALT311.StrType)le.amendedchargedate),
    charge_arrests_Fields.InValid_bondsman((SALT311.StrType)le.bondsman),
    charge_arrests_Fields.InValid_bondamount((SALT311.StrType)le.bondamount),
    charge_arrests_Fields.InValid_bondtype((SALT311.StrType)le.bondtype),
    charge_arrests_Fields.InValid_sourcename((SALT311.StrType)le.sourcename),
    charge_arrests_Fields.InValid_sourceid((SALT311.StrType)le.sourceid),
    charge_arrests_Fields.InValid_vendor((SALT311.StrType)le.vendor),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,31,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := charge_arrests_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Record_ID','Invalid_State','Invalid_Case_ID','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Invalid_Future_Date','Invalid_Current_Date','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Invalid_Future_Date','Unknown','Unknown','Unknown','Invalid_Current_Date','Unknown','Unknown','Unknown','Unknown','Invalid_Source_ID','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,charge_arrests_Fields.InValidMessage_recordid(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_statecode(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_caseid(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_warrantnumber(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_warrantdate(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_warrantdesc(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_warrantissuedate(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_warrantissuingagency(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_warrantstatus(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_citationnumber(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_bookingnumber(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_arrestdate(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_arrestingagency(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_bookingdate(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_custodydate(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_custodylocation(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_initialcharge(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_initialchargedate(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_initialchargecancelleddate(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_chargedisposed(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_chargedisposeddate(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_chargeseverity(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_chargedisposition(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_amendedcharge(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_amendedchargedate(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_bondsman(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_bondamount(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_bondtype(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_sourcename(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_sourceid(TotalErrors.ErrorNum),charge_arrests_Fields.InValidMessage_vendor(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Crim, charge_arrests_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
