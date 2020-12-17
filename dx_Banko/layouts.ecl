import dx_common;

EXPORT layouts := MODULE

EXPORT i_Layout_Key_Banko_CourtCode_CaseNumber := RECORD
  string5 court_code;
  string7 casekey;
  string10 caseid;
  string5 drcategoryeventid;
  string100 docketentryid;
  string10 courtid;
  string40 district;
  string5 boca_court;
  string2 casetype;
  string24 bkcasenumber;
  string200 bkcasenumberurl;
  string24 proceedingscasenumber;
  string200 proceedingscasenumberurl;
  string10 pacercaseid;
  string200 attachmenturl;
  string10 entrynumber;
  string24 entereddate;
  string24 pacer_entereddate;
  string24 fileddate;
  string5 score;
  string5000 dockettext;
  string200 catevent_description;
  string200 catevent_category;
//New Fields DF-27858 will be used for Azure Delta updates
  dx_common.layout_metadata;
  // unsigned8 recpos; //Not needed as per query
END;

Export i_Layout_Key_Banko_CourtCode_FullCaseNumber	:=	RECORD
	i_Layout_Key_Banko_CourtCode_CaseNumber.CaseKey;
	i_Layout_Key_Banko_CourtCode_CaseNumber.BKCaseNumber;
	i_Layout_Key_Banko_CourtCode_CaseNumber.CaseID;
	i_Layout_Key_Banko_CourtCode_CaseNumber.court_code;
END;


END;
