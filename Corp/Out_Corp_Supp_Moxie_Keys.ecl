import Lib_KeyLib, Lib_ZipLib, Lib_StringLib;

lBaseKeyName 	:= 'key::moxie.corp_supp.';
lMoxieFileName	:= '~thor_data400::out::corp_supp_' + Corp.Corp_Build_Date;

rMoxieFileLayout
 :=
  record
	Corp.Layout_Corp_Supp_Out;
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
	string50								corpname		:= dMoxieFile.Corp_Legal_Name;									// Shortened and renamed
	dMoxieFile.BDID;
	typeof(dMoxieFile.corp_key)				corpkey			:= Lib_StringLib.StringLib.StringToUpperCase(dMoxieFile.corp_key);
	dMoxieFile.Supp_Type_Desc;
	dMoxieFile.Supp_Filing_Date;
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
kCorpKeyTypeDate	:= buildindex(dNormalKeysTable(corpkey<>''),{corpkey,Supp_Type_Desc,Supp_Filing_Date,filepos},
									lBaseKeyName + 'corp_key.supp_type_desc.supp_filing_date.key',moxie,overwrite);
// End "Normal" keys ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


export Out_Corp_Supp_Moxie_Keys
 :=
  parallel(
			 kBDID
			,kCorpKey
			,kCharterNo
			,kStOrigCharterNo
			,kCorpKeyTypeDate
		   )
 ;