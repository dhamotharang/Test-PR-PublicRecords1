IMPORT PRTE2_LNProperty, PRTE2_Common;

Files := PRTE2_LNProperty.Files;
Layouts := PRTE2_LNProperty.Layouts;

DataIn := Files.BOCA_BASE_SF_DS_PROD;
OUTPUT(COUNT(dataIn));
OUTPUT(PRTE2_Common.get_ds_of_Layout(Layouts_V2.LN_spreadsheet),ALL );

report0 := RECORD
	recTypeSrc	 := DataIn.fid_type+'-'+dataIn.lookups+'-'+dataIn.source_code;
	// recTypeSrc	 := DataIn.fid_type+dataIn.lookups;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,DataIn.fid_type+'-'+dataIn.lookups+'-'+dataIn.source_code);
// RepTable0 := TABLE(DataIn,report0,DataIn.fid_type+dataIn.lookups);
OUTPUT(SORT(RepTable0,recTypeSrc),ALL);

/*
// ==== another study that showed what the lookups values should be =================================================
// see notes I put into Transform_Data - I went with Boca PRCT data values 3,5 instead of 19,21 that this indicates
IMPORT ut;

ft1								:= 'A';
ft2								:= 'D';
pt1								:= 'P';
pt2								:= 'O';
lookups1			:= (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft1 )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt1 )));
lookups2			:= (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft1 )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt2 )));
lookups3			:= (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft2 )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt1 )));
lookups4			:= (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft2 )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt2 )));
OUTPUT(lookups1,NAMED('AP'));
OUTPUT(lookups2,NAMED('AO'));
OUTPUT(lookups3,NAMED('DP'));
OUTPUT(lookups4,NAMED('DO'));
// ==================================================================================================================
*/