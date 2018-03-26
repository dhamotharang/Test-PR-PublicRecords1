
import	PRTE2_Hunting_Fishing,PRTE_CSV;

	finalMasterLayout := RECORD
			PRTE2_Hunting_Fishing.Layouts.AlphaBaseOUT;
	END;

	DSK1	:= 	PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__rid;
	DSK2	:= 	PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__payload;
	
	DS1	:= 	DATASET('~prct::base::ct::huntfish::20141205a::boca_huntfish',finalMasterLayout,THOR);
	DS2	:= 	DATASET('~prct::in::ct::huntfish::20141205a::boca_huntfish',finalMasterLayout,THOR);
	DSF := JOIN(DS1,DS2, LEFT.did_out = RIGHT.did_out and LEFT.file_acquired_date = RIGHT.file_acquired_date , left outer	);

	OUTPUT(SORT(DSK1,did_out));
	OUTPUT(SORT(DSK2,did));
	OUTPUT(SORT(DSK2,rid));
	OUTPUT(DSF,, 'prct::in::ct::huntfish::20141205::boca_huntfishJoin', OVERWRITE);