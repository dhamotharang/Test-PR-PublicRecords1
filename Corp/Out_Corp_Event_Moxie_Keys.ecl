import Lib_KeyLib, Lib_ZipLib, Lib_StringLib;

lBaseKeyName 	:= 'key::moxie.corp_event.';
lMoxieFileName	:= '~thor_data400::out::corp_event_' + Corp.Corp_Build_Date;

rMoxieFileLayout
 :=
  record
	Corp.Layout_Corp_Event_Out;
    unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

dMoxieFile := dataset(lMoxieFileName,rMoxieFileLayout,flat);

// Begin "Normal" keys, built upon existing fields without normalization vvvvvvvvvvvvvvvvvvvvv
rNormalKeysLayout
 :=
  record
	typeof(dMoxieFile.Corp_SOS_Charter_Nbr) sos_charter_nbr := trim(dMoxieFile.Corp_SOS_Charter_Nbr,left);
	typeof(dMoxieFile.Corp_State_Origin) 	st_orig			:= dMoxieFile.Corp_State_Origin;								// Just to rename to match keyname
	dMoxieFile.BDID;
	typeof(dMoxieFile.corp_key)				corpkey		:= Lib_StringLib.StringLib.StringToUpperCase(dMoxieFile.corp_key);
	dMoxieFile.Event_Filing_Date;
	big_endian unsigned8 					filepos 		:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;
	
dNormalKeysTable	:= table(dMoxieFile,rNormalKeysLayout);

kBDID				:= buildindex(dNormalKeysTable(bdid<>''),{bdid,filepos},
									lBaseKeyName + 'bdid.key',moxie,overwrite);
kCorpKey			:= buildindex(dNormalKeysTable(corpkey<>''),{corpkey,filepos},
									lBaseKeyName + 'corp_key.key',moxie,overwrite);
kCharterNo			:= buildindex(dNormalKeysTable(sos_charter_nbr<>''),{sos_charter_nbr,filepos},
									lBaseKeyName + 'sos_charter_nbr.key',moxie,overwrite);
kStOrigCharterNo	:= buildindex(dNormalKeysTable(st_orig<>''),{st_orig,sos_charter_nbr,filepos},
									lBaseKeyName + 'st_orig.sos_charter_nbr.key',moxie,overwrite);
kCorpKeyFilingDt	:= buildindex(dNormalKeysTable(corpkey<>''),{corpkey,event_filing_date,filepos},
									lBaseKeyName + 'corp_key.event_filing_date.key',moxie,overwrite);
// End "Normal" keys ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


export Out_Corp_Event_Moxie_Keys
 :=
  parallel(
			 kBDID
			,kCorpKey
			,kCharterNo
			,kStOrigCharterNo
			,kCorpKeyFilingDt
		   )
 ;