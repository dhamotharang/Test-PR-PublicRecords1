import NID;

Layout_PL := RECORD
 Layouts_DL_Uber.Layout_Base;
END;

mod_PL := PROJECT(DriversV2.Key_DL_AutoKey_Payload
						,TRANSFORM(Layout_PL
						,SELF.pfname := NID.PreferredFirstVersionedStr(LEFT.fname, NID.version)
						,SELF.dph_lname := metaphonelib.DMetaPhone1(LEFT.lname)[1..6]
						,SELF := LEFT));

export File_Uber_auto_base := DISTRIBUTE(mod_PL ,HASH32(fakeid)):persist('~Thor_data400::base::DL2::PAYLOAD');
