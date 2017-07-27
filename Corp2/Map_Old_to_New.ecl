import corp;

states_to_exclude := ['CA','FL','HI','NC'];

dCorp  := corp.File_Corp_Base(corp_state_origin not in states_to_exclude);
dCont  := corp.File_Corp_Cont_Base(corp_state_origin not in states_to_exclude);
dEvent := corp.File_Corp_Event_Base(corp_state_origin not in states_to_exclude);

Corp2.Layout_Corp_Base Corp_Old2New(dCorp l) := transform
 self := l;
 self := [];
end;

Corp2.Layout_Corp_Cont_Base Cont_Old2New(dCont l) := transform
 self := l;
 self := [];
end;

Corp2.Layout_Corp_Event_Base Event_Old2New(dEvent l) := transform
 self := l;
 self := [];
end;

dCorp_InNewLayout  := project(dCorp,Corp_Old2New(left));
dCont_InNewLayout  := project(dCont,Cont_Old2New(left));
dEvent_InNewLayout := project(dEvent,Event_Old2New(left));

output(dCorp_InNewLayout,,'in::corp2::99999999::corp::xx',__compressed__);
output(dCont_InNewLayout,,'in::corp2::99999999::cont::xx',__compressed__);
output(dEvent_InNewLayout,,'in::corp2::99999999::event::xx',__compressed__);


