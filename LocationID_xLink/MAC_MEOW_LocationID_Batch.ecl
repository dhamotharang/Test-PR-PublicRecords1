 
EXPORT MAC_MEOW_LocationID_Batch(infile,Ref = '',Input_LocId = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_v_city_name = '',Input_st = '',Input_zip5 = '',OutFile,AsIndex='true',UpdateIDs='false',Stats='') := MACRO
  #uniquename(ToProcess)
  IMPORT SALT37,LocationId_xLink;
  #uniquename(TPRec)
  %TPRec% := RECORD(LocationId_xLink.Process_LocationID_Layouts.InputLayout)
  END;
  #uniquename(InputT)
   %TPRec% %InputT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
  #IF ( #TEXT(Input_LocId) <> '' AND UpdateIDs=true)
    SELF.Entered_LocId := (TYPEOF(SELF.Entered_LocId))le.Input_LocId;
  #ELSE
    SELF.Entered_LocId := (TYPEOF(SELF.Entered_LocId))'';
  #END
  #IF ( #TEXT(Input_prim_range) <> '' )
    SELF.prim_range := (TYPEOF(SELF.prim_range))le.Input_prim_range;
  #ELSE
    SELF.prim_range := (TYPEOF(SELF.prim_range))'';
  #END
  #IF ( #TEXT(Input_predir) <> '' )
    SELF.predir := (TYPEOF(SELF.predir))le.Input_predir;
  #ELSE
    SELF.predir := (TYPEOF(SELF.predir))'';
  #END
  #IF ( #TEXT(Input_prim_name) <> '' )
    SELF.prim_name := (TYPEOF(SELF.prim_name))le.Input_prim_name;
  #ELSE
    SELF.prim_name := (TYPEOF(SELF.prim_name))'';
  #END
  #IF ( #TEXT(Input_addr_suffix) <> '' )
    SELF.addr_suffix := (TYPEOF(SELF.addr_suffix))le.Input_addr_suffix;
  #ELSE
    SELF.addr_suffix := (TYPEOF(SELF.addr_suffix))'';
  #END
  #IF ( #TEXT(Input_postdir) <> '' )
    SELF.postdir := (TYPEOF(SELF.postdir))le.Input_postdir;
  #ELSE
    SELF.postdir := (TYPEOF(SELF.postdir))'';
  #END
  #IF ( #TEXT(Input_unit_desig) <> '' )
    SELF.unit_desig := (TYPEOF(SELF.unit_desig))le.Input_unit_desig;
  #ELSE
    SELF.unit_desig := (TYPEOF(SELF.unit_desig))'';
  #END
  #IF ( #TEXT(Input_sec_range) <> '' )
    SELF.sec_range := (TYPEOF(SELF.sec_range))le.Input_sec_range;
  #ELSE
    SELF.sec_range := (TYPEOF(SELF.sec_range))'';
  #END
  #IF ( #TEXT(Input_v_city_name) <> '' )
    SELF.v_city_name := (TYPEOF(SELF.v_city_name))le.Input_v_city_name;
  #ELSE
    SELF.v_city_name := (TYPEOF(SELF.v_city_name))'';
  #END
  #IF ( #TEXT(Input_st) <> '' )
    SELF.st := (TYPEOF(SELF.st))le.Input_st;
  #ELSE
    SELF.st := (TYPEOF(SELF.st))'';
  #END
  #IF ( #TEXT(Input_zip5) <> '' )
    SELF.zip5 := (TYPEOF(SELF.zip5))le.Input_zip5;
  #ELSE
    SELF.zip5 := (TYPEOF(SELF.zip5))'';
  #END
  END;
  #uniquename(fats0)
  %fats0% := PROJECT(InFile,%InputT%(LEFT));
  #uniquename(CleanT) // Transform to clean input data identically to online transform
  %TPRec% %CleanT%(%fats0% le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.prim_range := (TYPEOF(SELF.prim_range))le.prim_range;
    SELF.predir := (TYPEOF(SELF.predir))le.predir;
    SELF.prim_name := (TYPEOF(SELF.prim_name))le.prim_name;
    SELF.addr_suffix := (TYPEOF(SELF.addr_suffix))le.addr_suffix;
    SELF.postdir := (TYPEOF(SELF.postdir))le.postdir;
    SELF.unit_desig := (TYPEOF(SELF.unit_desig))le.unit_desig;
    SELF.sec_range := (TYPEOF(SELF.sec_range))le.sec_range;
    SELF.v_city_name := (TYPEOF(SELF.v_city_name))le.v_city_name;
    SELF.st := (TYPEOF(SELF.st))le.st;
    SELF.zip5 := (TYPEOF(SELF.zip5))le.zip5;
    SELF := le;
  END;
  #uniquename(fats1)
  %fats1% := PROJECT(%fats0%,%CleanT%(LEFT));
  #uniquename(fats)
  #uniquename(dups)
 // In case multiple copies of the same indicative are in there - remove them
  SALT37.MAC_Dups_Note(%fats1%,%TPRec%,%fats%,%dups%,,LocationId_xLink._CFG.meow_dedup);
  %ToProcess% := %fats%(Entered_LocId = 0);
  #uniquename(OutputNewIDs)
#IF (#TEXT(Input_LocId) <> '')
  #uniquename(ToUpdate)
  %ToUpdate% := %fats%(~(Entered_LocId = 0));
  %OutputNewIDs% := LocationId_xLink.Process_LocationID_Layouts.UpdateIDs(%ToUpdate%);
#ELSE
  %OutputNewIDs% := DATASET([],LocationId_xLink.Process_LocationID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputSTATECITY)
#IF(#TEXT(Input_v_city_name)<>'' AND #TEXT(Input_st)<>'' AND #TEXT(Input_prim_range)<>'' AND #TEXT(Input_prim_name)<>'')
  #uniquename(HoldSTATECITY)
  %HoldSTATECITY% := %ToProcess%;
  LocationId_xLink.Key_LocationId_STATECITY.MAC_ScoredFetch_Batch(%HoldSTATECITY%,UniqueId,v_city_name,st,prim_range,prim_name,sec_range,unit_desig,postdir,addr_suffix,predir,%OutputSTATECITY%,AsIndex)
#ELSE
  %OutputSTATECITY% := DATASET([],LocationId_xLink.Process_LocationID_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputZIP)
#IF(#TEXT(Input_zip5)<>'' AND #TEXT(Input_prim_range)<>'' AND #TEXT(Input_prim_name)<>'')
  #uniquename(HoldZIP)
  %HoldZIP% := %ToProcess%;
  LocationId_xLink.Key_LocationId_ZIP.MAC_ScoredFetch_Batch(%HoldZIP%,UniqueId,zip5,prim_range,prim_name,sec_range,unit_desig,postdir,addr_suffix,predir,%OutputZIP%,AsIndex)
#ELSE
  %OutputZIP% := DATASET([],LocationId_xLink.Process_LocationID_Layouts.LayoutScoredFetch);
#END
  #uniquename(AllRes)
  %AllRes% := %OutputSTATECITY%+%OutputZIP%+%OutputNewIDs%;
  #uniquename(All)
  %All% := LocationId_xLink.Process_LocationID_Layouts.CombineAllScores(%AllRes%);
  #uniquename(OutFile0)
  SALT37.MAC_Dups_Restore(%All%,%dups%,%OutFile0%);
  #uniquename(RestoreChildReference)
  TYPEOF(%OutFile0%) %RestoreChildReference%(%OutFile0% le) := TRANSFORM
    SELF.Results := PROJECT(le.Results, TRANSFORM(LocationId_xLink.Process_LocationID_Layouts.LayoutScoredFetch,SELF.Reference := le.Reference, SELF := LEFT));
    SELF := le;
  END;
  OutFile := PROJECT(%OutFile0%,%RestoreChildReference%(LEFT));
  #IF (#TEXT(Stats)<>'')
    Stats := LocationId_xLink.Process_LocationID_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
