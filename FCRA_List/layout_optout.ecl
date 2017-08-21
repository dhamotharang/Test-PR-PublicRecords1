IMPORT watchdog, fcra_list;

EXPORT layout_optout := module

export base := record

integer4 optout_date;
boolean opt_out_hit := false;
watchdog.Layout_Best;

end;

export lexid := record

unsigned6 DID;

end;

end;

