

EXPORT U_PropInfo_Clash_Files := MODULE
	EXPORT SAVE_XREF_NAME	:= '~prct::BASE::ct::propertyinfo::Clash_Alpharetta_XREF';
	EXPORT SAVE_XREF_DS := DATASET(SAVE_XREF_NAME,Layouts.ClashLayout,THOR);
	EXPORT SAVE_RECS_NAME	:= '~prct::BASE::ct::propertyinfo::Clash_Alpharetta_base';
	EXPORT SAVE_RECS_DS := DATASET(SAVE_RECS_NAME,Layouts.PropertyExpandedRec,THOR);
END;
