﻿EXPORT z_layouts_Input := RECORD
    string ssndeceased{xpath('ssndeceased')};
      string subjectdeceased{xpath('subjectdeceased')};
      string confirmationsubjectfound{xpath('confirmationsubjectfound')};
      string ssnsubjectcount{xpath('ssnsubjectcount')};
      string evictioncount{xpath('evictioncount')};
      string confirmationinputaddress{xpath('confirmationinputaddress')};
      string sourcecredheadertimeoldest{xpath('sourcecredheadertimeoldest')};
      string inquiryshortterm12month{xpath('inquiryshortterm12month')};
      string lienjudgmenttaxcount{xpath('lienjudgmenttaxcount')};
      string addrchangecount03month{xpath('addrchangecount03month')};
      string addrprevioustimeoldest{xpath('addrprevioustimeoldest')};
      string inquiryauto12month{xpath('inquiryauto12month')};
      string assetpropevercount{xpath('assetpropevercount')};
      string derogtimenewest{xpath('derogtimenewest')};
      string addrinputsubjectowned{xpath('addrinputsubjectowned')};
      string criminalfelonycount{xpath('criminalfelonycount')};
      string inquirybanking12month{xpath('inquirybanking12month')};
      string addrinputmatchindex{xpath('addrinputmatchindex')};
      string transactionid{xpath('TransactionID')};
      real8 rawscore{xpath('rawscore')};
      real8 predscr{xpath('predscr')};
      real8 finalscore{xpath('finalscore')};
      string reasoncode1{xpath('ReasonCode1')};
      string reasoncode2{xpath('ReasonCode2')};
      string reasoncode3{xpath('ReasonCode3')};
      string reasoncode4{xpath('ReasonCode4')};
      string reasoncode5{xpath('ReasonCode5')};
      real8 ssnsubjectcount_pts{xpath('ssnsubjectcount_pts')};
      real8 evictioncount_pts{xpath('evictioncount_pts')};
      real8 confirmationinputaddress_pts{xpath('confirmationinputaddress_pts')};
      real8 sourcecredheadertimeoldest_pts{xpath('sourcecredheadertimeoldest_pts')};
      real8 inquiryshortterm12month_pts{xpath('inquiryshortterm12month_pts')};
      real8 lienjudgmenttaxcount_pts{xpath('lienjudgmenttaxcount_pts')};
      real8 addrchangecount03month_pts{xpath('addrchangecount03month_pts')};
      real8 addrprevioustimeoldest_pts{xpath('addrprevioustimeoldest_pts')};
      real8 inquiryauto12month_pts{xpath('inquiryauto12month_pts')};
      real8 assetpropevercount_pts{xpath('assetpropevercount_pts')};
      real8 derogtimenewest_pts{xpath('derogtimenewest_pts')};
      real8 addrinputsubjectowned_pts{xpath('addrinputsubjectowned_pts')};
      real8 criminalfelonycount_pts{xpath('criminalfelonycount_pts')};
      real8 inquirybanking12month_pts{xpath('inquirybanking12month_pts')};
      real8 addrinputmatchindex_pts{xpath('addrinputmatchindex_pts')};
      real8 ssnsubjectcount_cont{xpath('ssnsubjectcount_cont')};
      real8 evictioncount_cont{xpath('evictioncount_cont')};
      real8 confirmationinputaddress_cont{xpath('confirmationinputaddress_cont')};
      real8 sourcecredheadertimeoldest_cont{xpath('sourcecredheadertimeoldest_cont')};
      real8 inquiryshortterm12month_cont{xpath('inquiryshortterm12month_cont')};
      real8 lienjudgmenttaxcount_cont{xpath('lienjudgmenttaxcount_cont')};
      real8 addrchangecount03month_cont{xpath('addrchangecount03month_cont')};
      real8 addrprevioustimeoldest_cont{xpath('addrprevioustimeoldest_cont')};
      real8 inquiryauto12month_cont{xpath('inquiryauto12month_cont')};
      real8 assetpropevercount_cont{xpath('assetpropevercount_cont')};
      real8 derogtimenewest_cont{xpath('derogtimenewest_cont')};
      real8 addrinputsubjectowned_cont{xpath('addrinputsubjectowned_cont')};
      real8 criminalfelonycount_cont{xpath('criminalfelonycount_cont')};
      real8 inquirybanking12month_cont{xpath('inquirybanking12month_cont')};
      real8 addrinputmatchindex_cont{xpath('addrinputmatchindex_cont')};
END;
