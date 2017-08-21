Import corp2;

EXPORT files := module

EXPORT corp2_ar_IN := DATASET(constants.In_Prefix + 'ar', Layouts.AR_Base_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT corp2_ar_Base := DATASET(constants.Base_Prefix + 'ar', Layouts.AR_Base_Layout, FLAT );

EXPORT corp2_event_IN := DATASET(constants.In_Prefix + 'event', Layouts.Event_Base_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT corp2_event_Base := DATASET(constants.Base_Prefix + 'event', Layouts.Event_Base_Layout, FLAT );

EXPORT corp2_stock_IN := DATASET(constants.In_Prefix + 'stock', Layouts.Stock_Base_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT corp2_stock_Base := DATASET(constants.Base_Prefix + 'stock', Layouts.Stock_Base_Layout, FLAT );

EXPORT corp2_cont_IN := DATASET(constants.In_Prefix + 'cont', Layouts.cont_Base_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT corp2_cont_Base := DATASET(constants.Base_Prefix + 'cont', Layouts.cont_Base_Layout, FLAT );

EXPORT corp2_corp_IN := DATASET(constants.In_Prefix + 'corp', Layouts.corp_Base_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT corp2_corp_Base := DATASET(constants.Base_Prefix + 'corp', Layouts.corp_Base_Layout, FLAT );

Export DS_AR_key := project(corp2_ar_Base,
Transform(Layouts.AR_Out_Layout,
SELF:=Left;
));

Export DS_Event_key := project(corp2_event_Base,
Transform(Layouts.Event_Out_Layout,
SELF:=Left;
));

Export DS_Stock_key := project(corp2_stock_Base,
Transform(Layouts.Stock_Out_Layout,
SELF:=Left;
));

Export DS_corp_record_key:=project(corp2_corp_Base,
Transform(Layouts.corp_record_key_layout,
Self:=Left;
self := []; 
));

Export DS_corp_charter_key:=project(corp2_corp_Base,Layouts.corp_charter_layout);

Export DS_corp_Direct:=project(corp2_corp_Base,Layouts.Layout_Corporate_Direct_Corp_Base);

Export DS_cont_Direct:=project(corp2_cont_Base,Layouts.Layout_Corporate_Direct_Cont_Base);

Export DS_cont_corp_key_record_type:=project(corp2_cont_Base,
Transform(Layouts.cont_corp_key_record_type,
Self:=Left;
self := []; 
));

Export DS_cont_did_key := project(dedup(sort(distribute(DS_cont_corp_key_record_type,hash(did)),did,corp_key,-dt_last_seen,if(cont_type_desc=corp2.constants.Ra_desc,1,0), local),did,corp_key,local),transform({DS_cont_corp_key_record_type.did,DS_cont_corp_key_record_type.corp_key,DS_cont_corp_key_record_type.cont_type_desc},self:=left));

Export DS_corp_bdid_key			:= project(dedup(sort(distribute(DS_corp_record_key,hash(bdid)),bdid,corp_key,-dt_last_seen,local),bdid,corp_key,local),Layouts.corp_bdid_layout);

Export DS_corp2_contbdid_key		 := project(dedup(sort(distribute(DS_cont_corp_key_record_type,hash(bdid)),bdid,corp_key,-dt_last_seen,local),bdid,corp_key,local),Layouts.Cont_bdid_Layout);

Export DS_corp_pl_key			:= project(dedup(sort(distribute(DS_corp_record_key,hash(bdid)),bdid,corp_key,-dt_last_seen,local),bdid,corp_key,local),Layouts.Layout_Corporate_Direct_Corp_Base);

END;