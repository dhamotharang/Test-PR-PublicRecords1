layout_pubrec_in := record
   unsigned4 per_id;
   unsigned integer1 pubtype; // The record type, e.g. 0x18,0x1E,0x1A
   data2 presflag;            //Presence flags ...some types have only one byte
   unsigned integer1 dfile_m; //Date Filed month
   unsigned integer1 dfile_y; //Date Filed year
   unsigned integer1 drptd_m; //Date Reported month/year
   unsigned integer1 drptd_y;
   unsigned integer1 dasgn_m; //Date Assigned month/year
   unsigned integer1 dasgn_y;
   unsigned integer1 dstat_m; //Date Status month/year
   unsigned integer1 dstat_y;
   unsigned integer1 dbaln_m; //Date Balance month/year
   unsigned integer1 dbaln_y;
   unsigned integer1 dpurg_m; //Date Purged month/year
   unsigned integer1 dpurg_y;
   unsigned integer1 dchck_m; //Date Checked month/year
   unsigned integer1 dchck_y;
   unsigned integer1 dsatd_m; //Date Satisfied month/year
   unsigned integer1 dsatd_y;
   unsigned integer1 drels_m; //Date Released month/year
   unsigned integer1 drels_y;
   unsigned integer1 dsetl_m; //Date Settled month/year
   unsigned integer1 dsetl_y;
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
   ebcdic string2 indust_cd;  //Industry Code from member number
   unsigned decimal8 member;  //Numeric portion of member number
   ebcdic string2 acb_cd;     //ACB Industry Code
   ebcdic string1 ecoa;       //ECOA code
   ebcdic string1 typ;       //Type
   ebcdic string1 filer;      //Filer
   ebcdic string1 action;     //Action
   ebcdic string1 intent;     //Intent
   ebcdic string1 statcd;     //Status Code
   ebcdic string42 casenum;   //Case Number
   ebcdic string12 client;    //Client ID
   ebcdic string40 defend;    //Defendant
   ebcdic string40 plaint;    //Plaintiff
   ebcdic string40 memname;   //Member Name
   ebcdic string40 spouse;    //Spouse
   ebcdic string20 actno;     //Account Nunber
   ebcdic string2 fill;
  end;

layout_pubrec into(layout_pubrec_in le,unsigned1 slice) := transform
  self.date_filed := into_date(le.dfile_m,le.dfile_y);
  self.date_reported:= into_date(le.drptd_m,le.drptd_y);
  self.date_assigned:= into_date(le.dasgn_m,le.dasgn_y);
  self.date_status:= into_date(le.dstat_m,le.dstat_y);
  self.date_balance:= into_date(le.dbaln_m,le.dbaln_y);
  self.date_purged:= into_date(le.dpurg_m,le.dpurg_y);
  self.date_checked:= into_date(le.dchck_m,le.dchck_y);
  self.date_satisfied:= into_date(le.dsatd_m,le.dsatd_y);
  self.date_released:= into_date(le.drels_m,le.drels_y);
  self.date_settled:= into_date(le.dsetl_m,le.dsetl_y);
  self.per_id := Change_Id(slice,le.per_id);
  self := le;
  end;

d := distributed(project(dataset('dev_in::pubrec_per',layout_pubrec_in,flat),into(left,1)),per_id);

export File_Pubrec := d;