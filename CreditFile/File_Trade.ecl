layout_trade_in := record //Trade
   unsigned4 per_id;
   data5 presflag;
   unsigned integer1 drpt_m;
   unsigned integer1 drpt_y;
   ebcdic string2 indust_cd;
   unsigned decimal8 member;
   unsigned integer1 dopn_m;
   unsigned integer1 dopn_y;
   ebcdic string1 typ;
   ebcdic string1 rate;
   data2 optind;
   decimal3 mos_rvwd;
   unsigned integer1 narr1;
   unsigned integer1 narr2;
   decimal7 hc;
   decimal7 bal;
   decimal7 terms;
   decimal7 pda;
   unsigned integer1 dact_m;
   unsigned integer1 dact_y;
   decimal3 cnt30;
   decimal3 cnt60;
   decimal3 cnt90;
   ebcdic string1 term;
   ebcdic string1 fbcd;
   ebcdic string20 actno;
   ebcdic string3 fill;
  end;

layout_trade into(layout_trade_in le,unsigned1 slice) := transform
  self.date_reported := into_date(le.drpt_m,le.drpt_y);
  self.date_opened := into_date(le.dopn_m,le.dopn_y);
  self.date_activity := into_date(le.dact_m,le.dact_y);
  self.per_id := Change_Id(slice,le.per_id);
  self := le;
  end;

d := distributed(project(dataset('dev_in::trad_per',layout_trade_in,flat),into(left,1)),per_id);

d_slim := record
  d.per_id;
  d.actno;
  d.member;
  unsigned4 val := IF(d.hc=0,d.bal,d.hc);
  end;

dsmall := table(d,d_slim);

d_sum := record
  dsmall.per_id;
  unsigned4 val := sum(group,dsmall.val);
  end;

dtots := table(dsmall,d_sum,per_id,local);

d_slim modify_dsmall(dsmall le, d_sum ri) := transform
  self.val := ri.val;
  self := le;
  end;

d_res := join(dsmall,dtots,left.per_id=right.per_id,modify_dsmall(left,right),local);

t := distribute(d_res,hash(actno,member));

st := dedup(sort(t,actno,member,-val,local),actno,member,local);

dst := distribute(st,per_id);

layout_trade flag_master(layout_trade le,dst ri) := transform
  self.master := ri.per_id<>0;
  self := le;
  end;

jres := join(d,dst,left.per_id=right.per_id and
                   left.actno=right.actno and
                   left.member=right.member,
                   flag_master(left,right),local,left outer);

export File_Trade := jres;