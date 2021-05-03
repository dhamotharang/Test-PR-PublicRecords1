import std,bipv2,bipv2_files;
l_common  := BIPV2.CommonBase.Layout;
l_base    := BIPV2_Files.files_lgid3.Layout_LGID3;

EXPORT _getInitialChanges(
   string             pversion  = bipv2.KeySuffix  
  ,DATASET(l_common)  dsb
  ,DATASET(l_base  )  dsa
) := 
Function

  lgid3Prox:=project(dsa,transform({string20 version, unsigned6 proxid,unsigned6 lgid3}, 
     self.version:=pversion; self.proxid:=left.proxid; self.lgid3:=left.lgid3));
  lgid3Prox_ded:=dedup(sort(lgid3Prox, lgid3,proxid,skew(1.0)),lgid3,proxid);
  
  superInit:='~thor_data400::BIPV2_LGID3::init_super::lgid3prox' + pversion;
  
  b0:=if(STD.File.SuperFileExists(superInit)=false,
         STD.File.CreateSuperFile(superInit));
  Lgid3ProxPath:='~thor_data400::BIPV2_LGID3::lgid3prox::init'+pversion;
  f_lgid3Prox_ded:=output(lgid3Prox_ded,,Lgid3ProxPath,COMPRESSED,OVERWRITE);
  act5:=STD.File.AddSuperFile(superInit,Lgid3ProxPath);
  
/* 			todo:=SEQUENTIAL(
                     STD.File.StartSuperFileTransaction(),
                     STD.File.ClearSuperFile('~thor_data400::BIPV2_LGID3::lgid3_changes',true),
                     STD.File.FinishSuperFileTransaction()
                    );
*/
  superChange:='~thor_data400::BIPV2_LGID3::lgid3_changes::super' + pversion;
  AA:=STD.File.SuperFileExists(superChange);
  b1:=if(AA=false, STD.File.CreateSuperFile(superChange));
  
/* 			todo2:=SEQUENTIAL(
                     STD.File.StartSuperFileTransaction(),
                     STD.File.ClearSuperFile('~thor_data400::BIPV2_LGID3::lgid3_match_sample_debug',true),
                     STD.File.FinishSuperFileTransaction()
                    );
*/
  superMatch:='~thor_data400::BIPV2_LGID3::lgid3_match_sample_debug::super' + pversion;
  AA2:=STD.File.SuperFileExists(superMatch);
  //b2:=if(AA2=true,todo2, STD.File.CreateSuperFile('~thor_data400::BIPV2_LGID3::lgid3_match_sample_debug'));
  b2:=if(AA2<>true,STD.File.CreateSuperFile(superMatch));
  
  Change_rec:=RECORD
    string20 version;
    string20 iterNumber;
    unsigned6 lgid3_before;
    unsigned6 lgid3_after;
    unsigned6 seleid_before;
    unsigned6 seleid_after;
  end;		
  ds_c:=join(dsb,dsa,left.rcid=right.rcid, transform(Change_rec,
                                                      self.version :=pversion;
                                                      self.lgid3_before :=left.lgid3;
                                                      self.lgid3_after  :=right.lgid3;
                                                      self.seleid_before:=left.seleid;
                                                      self.seleid_after :=right.seleid;
                                                      self.iterNumber   :='I'+pversion));
  ds_r:= ds_c(lgid3_before <> lgid3_after or seleid_before <> seleid_after);
  ds_r1:=dedup(ds_r,version,iterNumber,lgid3_before,lgid3_after,seleid_before,seleid_after,all);
  
  qqPath:='~thor_data400::BIPV2_LGID3::lgid3_changes::I'+pversion;
  act_init:=output(ds_r1,,qqPath,COMPRESSED,OVERWRITE);
  act4:=STD.File.AddSuperFile(superChange,qqPath);
  
  return sequential(b1,b2,act_init,act4,b0,f_lgid3Prox_ded,act5);
  
end;
