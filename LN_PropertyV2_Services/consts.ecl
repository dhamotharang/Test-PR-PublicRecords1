export consts := module
  export max_raw			:= 4500;
  export max_parties	:= 20;		// per fid
  export max_entities	:= 10;		// per party
  export max_names		:= 25;		// per party
  export max_deeds		:= 1;			// per fid
  export max_assess		:= 1;			// per fid
  export max_details	:= 1;			// per fid
  export max_deepDIDs	:= 100;

  export MAX_TRIM_BY_SORTBY := 1000; // max ever to take during a trim by sortby date for biz report

  export assess_codefile	:= 'FARES_2580';
  export deeds_codefile		:= 'FARES_1080';

  export VENDOR_FARES 		:= 'A';
  export SET OF STRING VENDOR_FIDELITY 		:= ['B','D'];

  export TYPE_DEED 		    := 'DEED';
  export TYPE_ASSESSMENT 	:= 'ASSESSMENT';
  export TYPE_ASSESSED 		:= 'ASSESSED';
  export TYPE_MORTGAGE 		:= 'MORTGAGE';

  //bug 59088
  export WARRANTY_DEED := 'WARRANTY DEED';
  export GRANT_DEED    := 'GRANT DEED';
  export FID_TYPE_DEED := 'D';

  export unsigned1 found  :=1;
  export unsigned1 missing:=0;

  // USLM -- Property Search Enhancement to allow for address type searching
  // Enhancement/Bug: 64514
  /*
  Source Code   Description
  BB            Borrower Mailing Address
  BO            Buyer Mailing Address
  BP            Buyer/Borrower Property Address
  CO            Care of Name and Mailing Address
  CP            Care of Name and Property Address
  CS            Care of Name and Seller Address
  OO            Owner/Buyer Mailing Address
  OP            Owner/Buyer Property Address
  SP            Seller Property Address
  SS            Seller Mailing Address
  */

  // Per Rob Holp 20101008 the following is the break down for the Address types
  EXPORT set_BuyerAddressCodes    := ['BB','BO','BP'];
  EXPORT set_MailingAddressCodes  := ['BB','BO','CO','OO','SS'];
  EXPORT set_OwnerAddressCodes    := ['OO','OP'];
  EXPORT set_PropertyAddressCodes := ['BP','CP','OP','SP'];
  EXPORT set_SellerAddressCodes   := ['CS','SP','SS'];

  EXPORT	LOOKUP_TYPE	:=
   MODULE
   EXPORT STRING EVERYTHING            := '';
   EXPORT	STRING	ASSESSMENT           := 'A';
   EXPORT	STRING	DEED                 := 'D';
   EXPORT	STRING	ASSIGNMENTANDRELEASE := 'R';
   EXPORT	STRING  DEEDSPLUSAR          := 'S';
   EXPORT getFIDtype(string lookupVal) := if(lookupVal IN [ASSIGNMENTANDRELEASE, DEEDSPLUSAR],DEED,lookupVal);
   EXPORT IsIncludeAllDeedTypes(STRING lookupVal) := lookupVal IN [EVERYTHING, DEEDSPLUSAR];
  END;

end;
