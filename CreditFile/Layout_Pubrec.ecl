export layout_pubrec := record
   unsigned4 per_id;
   unsigned integer1 pubtype; // The record type, e.g. 0x18,0x1E,0x1A
   data2 presflag;            //Presence flags ...some types have only one byte
   unsigned3 date_filed;
   unsigned3 date_reported;
   unsigned3 date_assigned;
   unsigned3 date_status;
   unsigned3 date_balance;
   unsigned3 date_purged;
   unsigned3 date_checked;
   unsigned3 date_satisfied;
   unsigned3 date_released;
   unsigned3 date_settled;
   decimal7 collamt;          //Collection Amount
   decimal7 balamt;           //Balance Amount
   decimal7 lglamt;           //Legal Amount
   decimal7 amount;           //Amount
   unsigned integer1 fbcd;    //Foreign Bureau Code
   unsigned integer1 narr1;   //Narrative Code 1
   unsigned integer1 narr2;   //Narrative Code 2
   decimal7 liability;        //Liability (amount)
   decimal7 asset;            //Asset (amount)
   decimal7 exempt;           //Exempt (amount)
   string2 indust_cd;  //Industry Code from member number
   unsigned decimal8 member;  //Numeric portion of member number
   string2 acb_cd;     //ACB Industry Code
   string1 ecoa;       //ECOA code
   string1 typ;       //Type
   string1 action;     //Action
   string1 intent;     //Intent
   string1 statcd;     //Status Code
   qstring42 casenum;   //Case Number
   qstring12 client;    //Client ID
   qstring40 defend;    //Defendant
   qstring40 plaint;    //Plaintiff
   qstring40 memname;   //Member Name
   qstring40 spouse;    //Spouse
   qstring20 actno;     //Account Nunber
  end;