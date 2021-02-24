﻿EXPORT z_layouts_Input := RECORD
    string subjectrecordtimeoldest{xpath('subjectrecordtimeoldest')};
      string subjectdeceased{xpath('subjectdeceased')};
      string confirmationsubjectfound{xpath('confirmationsubjectfound')};
      string sourcenonderogcount{xpath('sourcenonderogcount')};
      string sourcenonderogcount06month{xpath('sourcenonderogcount06month')};
      string ssndeceased{xpath('ssndeceased')};
      string assetpropcurrentcount{xpath('assetpropcurrentcount')};
      string assetpropeversoldcount{xpath('assetpropeversoldcount')};
      string evictioncount{xpath('evictioncount')};
      string lienjudgmentcount{xpath('lienjudgmentcount')};
      string lienjudgmentsmallclaimscount{xpath('lienjudgmentsmallclaimscount')};
      string bankruptcystatus{xpath('bankruptcystatus')};
      string shorttermloanrequest{xpath('shorttermloanrequest')};
      string inquiryauto12month{xpath('inquiryauto12month')};
      string inquirybanking12month{xpath('inquirybanking12month')};
      string inquiryshortterm12month{xpath('inquiryshortterm12month')};
      string inquirycollections12month{xpath('inquirycollections12month')};
      string addronfilecount{xpath('addronfilecount')};
      string addrcurrentownershipindex{xpath('addrcurrentownershipindex')};
      string addrprevioustimeoldest{xpath('addrprevioustimeoldest')};
      string addrchangecount60month{xpath('addrchangecount60month')};
      string alertregulatorycondition{xpath('alertregulatorycondition')};
      string transactionid{xpath('TransactionID')};
      real8 rawscore{xpath('rawscore')};
      real8 predscr{xpath('predscr')};
      real8 finalscore{xpath('finalscore')};
      string reasoncode1{xpath('ReasonCode1')};
      string reasoncode2{xpath('ReasonCode2')};
      string reasoncode3{xpath('ReasonCode3')};
      string reasoncode4{xpath('ReasonCode4')};
      string reasoncode5{xpath('ReasonCode5')};
      real8 l_ca_creditseeking_pts{xpath('L_ca_creditseeking_pts')};
      real8 l_ca_derogseverityindex_pts{xpath('L_ca_derogseverityindex_pts')};
      real8 assetpropcurrentcount_pts{xpath('assetpropcurrentcount_pts')};
      real8 assetpropeversoldcount_pts{xpath('assetpropeversoldcount_pts')};
      real8 addrcurrentownershipindex_pts{xpath('addrcurrentownershipindex_pts')};
      real8 l_ca_nonderogindex_pts{xpath('L_ca_nonderogindex_pts')};
      real8 addrprevioustimeoldest_pts{xpath('addrprevioustimeoldest_pts')};
      real8 l_ca_addrchangeindex_pts{xpath('L_ca_addrchangeindex_pts')};
      real8 l_ca_creditseeking_cont{xpath('L_ca_creditseeking_cont')};
      real8 l_ca_derogseverityindex_cont{xpath('L_ca_derogseverityindex_cont')};
      real8 assetpropcurrentcount_cont{xpath('assetpropcurrentcount_cont')};
      real8 assetpropeversoldcount_cont{xpath('assetpropeversoldcount_cont')};
      real8 addrcurrentownershipindex_cont{xpath('addrcurrentownershipindex_cont')};
      real8 l_ca_nonderogindex_cont{xpath('L_ca_nonderogindex_cont')};
      real8 addrprevioustimeoldest_cont{xpath('addrprevioustimeoldest_cont')};
      real8 l_ca_addrchangeindex_cont{xpath('L_ca_addrchangeindex_cont')};
END;
