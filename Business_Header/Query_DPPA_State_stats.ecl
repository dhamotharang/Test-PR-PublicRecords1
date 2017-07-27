IMPORT Business_Header, ut;
#workunit ('name', 'Get dppa examples for qa');

//////////////////////////////////////////////////////////////////////////////////////
// Business Contacts DPPA State Stats
//////////////////////////////////////////////////////////////////////////////////////
bcdppa := Business_Header.File_Business_Contacts_Out(DPPA_State != '');

mylay := record
bcdppa.DPPA_State;
end;


bc_slim := table(bcdppa,mylay);


cnt_lay := record
bc_slim.DPPA_State;
cnt := count(group);
end;

bc_cnt := table(bc_slim,cnt_lay,DPPA_State);

do1 := output(topn(bc_cnt,1000,-cnt),all) : success(output('Business Contacts DPPA State Stats'));


//////////////////////////////////////////////////////////////////////////////////////
// Business Header Best DPPA State stats
//////////////////////////////////////////////////////////////////////////////////////
bhbdppa := Business_Header.File_Business_Header_Best_Out(DPPA_State != '');

bhblay := record
bhbdppa.DPPA_State;
end;


bhb_slim := table(bhbdppa,bhblay);


cnt_bhb_lay := record
bhb_slim.DPPA_State;
cnt := count(group);
end;

bhb_cnt := table(bhb_slim,cnt_bhb_lay,DPPA_State);

do2 := output(topn(bhb_cnt,1000,-cnt),all) : success(output('Business Header Best DPPA State stats'));

//////////////////////////////////////////////////////////////////////////////////////
// Business Header DPPA State stats
//////////////////////////////////////////////////////////////////////////////////////
bhdppa := Business_Header.File_Business_Header_Out(DPPA_State != '');

bhlay := record
bhdppa.DPPA_State;
end;


bh_slim := table(bhdppa,bhlay);


cnt_bh_lay := record
bh_slim.DPPA_State;
cnt := count(group);
end;

bh_cnt := table(bh_slim,cnt_bh_lay,DPPA_State);

do3 := output(topn(bh_cnt,1000,-cnt),all) : success(output('Business Header DPPA State stats'));

//////////////////////////////////////////////////////////////////////////////////////
// PAW DPPA State stats
//////////////////////////////////////////////////////////////////////////////////////
pawdppa := Business_Header.File_Employment_Out(DPPA_State != '');

pawlay := record
pawdppa.DPPA_State;
end;


paw_slim := table(pawdppa,pawlay);


cnt_paw_lay := record
paw_slim.DPPA_State;
cnt := count(group);
end;

paw_cnt := table(paw_slim,cnt_paw_lay,DPPA_State);

do4 := output(topn(paw_cnt,1000,-cnt),all) : success(output('PAW DPPA State stats'));

export Query_DPPA_State_stats := sequential(do1,do2,do3,do4);