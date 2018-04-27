IMPORT BIPV2, BIPV2_Files,BIPV2_PostProcess,wk_ut,tools,std,BIPV2_Tools;
l_base          := BIPV2.CommonBase.Layout;
in_default      := PROJECT(BIPV2_Files.files_empid().DS_BASE, l_base);
// f_default        := BIPV2_Files.files_CommonBase.filePrefix   + '::' + BIPV2.KeySuffix;  //so superfile and logical files have the same naming convention
// f_hist_default := BIPV2_Files.files_CommonBase.FILE_HISTORY + '::' + BIPV2.KeySuffix;
EXPORT Build_CommonBase(
   string           pversion  = bipv2.KeySuffix
  ,DATASET(l_base)  input     = in_default
  ,STRING           f_out     = BIPV2_Files.files_CommonBase.filePrefix  + pversion //default uses version you pass in 
  ,STRING           f_hist    = BIPV2_Files.files_CommonBase.FILE_HISTORY + '::' + pversion //default uses version you pass in
) := 
MODULE
  
  // Output Files (logical)
  // EXPORT f_out := outfile;
  
  SHARED l_thin := RECORD
    l_base.lgid3;
    l_base.powid;
    l_base.empid;
    l_base.proxid;
    l_base.dotid;
    l_base.rcid;
    l_base.cnt_prox_per_lgid3;
    l_base.cnt_prox_per_powid;
    l_base.cnt_dot_per_empid;
    l_base.cnt_dot_per_proxid; 
    l_base.cnt_rcid_per_dotid;
  END;
  
  // Descendant Counts
  SHARED cnt_X_per_Y(ds,X,Y,fld) := FUNCTIONMACRO
    LOCAL ds_dist := DISTRIBUTE(ds,HASH32(Y));
    LOCAL tab_cnt := TABLE(TABLE(ds_dist, {Y, X}, Y, X, LOCAL), {Y, UNSIGNED fld:=count(GROUP)}, Y, LOCAL);
    LOCAL ds_cnt  := JOIN(ds_dist, tab_cnt, LEFT.Y=RIGHT.Y, TRANSFORM(RECORDOF(ds), SELF:=RIGHT, SELF:=LEFT), KEEP(1), LOCAL);
    RETURN ds_cnt;
  ENDMACRO;
  SHARED lgid3_counts(DATASET(l_thin) ds_in)  := cnt_X_per_Y(ds_in,proxid,lgid3,cnt_prox_per_lgid3);
  SHARED powid_counts(DATASET(l_thin) ds_in)  := cnt_X_per_Y(ds_in,proxid,powid,cnt_prox_per_powid);
  SHARED empid_counts(DATASET(l_thin) ds_in)  := cnt_X_per_Y(ds_in,dotid,empid,cnt_dot_per_empid);
  SHARED proxid_counts(DATASET(l_thin) ds_in) := cnt_X_per_Y(ds_in,dotid,proxid,cnt_dot_per_proxid);
  SHARED dotid_counts(DATASET(l_thin) ds_in)  := cnt_X_per_Y(ds_in,rcid,dotid,cnt_rcid_per_dotid);
  EXPORT descendant_counts(DATASET(l_base) ds_in) := FUNCTION
    ds_in_thin := PROJECT(ds_in, l_thin);
    ds_out_thin := dotid_counts(proxid_counts(empid_counts(powid_counts(lgid3_counts(ds_in_thin)))));
    RETURN JOIN(ds_in,ds_out_thin,LEFT.rcid=RIGHT.rcid,TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT),KEEP(1),HASH);
  END;
  
  // Take action
  ds1 := descendant_counts(input);
  shared ds        := BIPV2_PostProcess.proc_segmentation(pversion ,ds1    ,pPopulateStatus := true ).patched; //put in seg stats into file itself.  do this for now.  the output of the stats will come later
  shared ds_test   := BIPV2_PostProcess.proc_segmentation(pversion ,input  ,pPopulateStatus := true ,pGoldOutputModifier := 'test_buildcommonbase').patched_test; //put in seg stats into file itself.  do this for now.  the output of the stats will come later
  ds_filter := table(ds,{seleid,st,v_city_name,prim_range,prim_name,cnp_name,fname,lname,company_fein})( 
  (    seleid = 22731126692 
  or (
            st          = 'UT'
        and v_city_name = 'BOUNTIFUL' 
        and prim_range  = '990'
        and regexfind('JENNIFER VAZIRI',cnp_name,nocase)
     )
  )
  or (
    seleid = 32067721272
    or (
              st          = 'NV'
          and v_city_name = 'RENO' 
          and prim_range  = '4936'
          and prim_name   = 'COCOA'
          and regexfind('QUAMIS',cnp_name,nocase)
       )
  
  )
  or (
    seleid = 127313100
    or (
              st          = 'FL'
          and v_city_name = 'ORLANDO' 
          and prim_name   = 'PO BOX 555096'
          and regexfind('SAMARITAN',cnp_name,nocase)
       )  
  )
  or (
    seleid IN [25504220,25649250]
    or (
              TRIM(cnp_name)='CAMELBACK GROUP'
          and fname='PETER'
          and lname='KIRN'
       )  
  ) // Added 2016-03-05 per user demand
  or ( // LNK-511
        prim_range = '8275'
    and st = 'NV'
    and v_city_name = 'LAS VEGAS'
    and ((
            fname = 'PASTORA'
        and lname = 'ROLDAN'
      ) or regexfind('PASTORA ROLDAN', cnp_name)
    )
  )
  or ( // LNK-823
    company_fein = '320153283'
    and regexfind('CARRIAGE HOUSE PROPERTIES PARTNERS', cnp_name)

  )
  );  //hack filter for Bug: 166172 - Privacy Office Directing Record Removal from BIP Header.  Will make this better later
  shared set_filt_seleids := set(table(ds_filter,{seleid},seleid,few),seleid);
  
  shared set_rcid :=[2957294316,2994521116,64211053595]; //ticket 188309, rcid to be excluded: the set_rcid
      
/*  dsa:=ds(seleid=4937701);
    dsb:=dsa(
        length(regexfind('WOMBLE', company_name,0))>0 OR
        length(regexfind('WCSR', company_name,0))>0 OR
        length(regexfind('WONBLE CARLYLE', company_name,0))>0 OR
        length(regexfind('WONBLE, CARLYLE', company_name,0))>0 OR
        length(regexfind('WOBMLE CARLYLE', company_name,0))>0 OR
        length(regexfind('WOBLE CARLYLE', company_name,0))>0 OR
        length(regexfind('WAMBLE CARLYLE', company_name,0))>0
    );
    set_womble:=set(table(dsb,{rcid},rcid),rcid);
*/ 
  shared set_prox :=[283437004];//BH-113
  shared ds_filt2      := ds(seleid not in set_filt_seleids and rcid not in set_rcid and proxid not in set_prox
/*                  and dotid not in [448534092,  //here temporarily for the BH-55 and will be removed in sprint44. 
                    1457098055,411933513,357925529,992837402,2239542081,186174785,334506045,225222253,
                    180910334,165395637,186638861,1212808209,213440582,1450796602,713523008,1626582526,
                    25600953615,1556755665,1055172695,1212499063,181071768,1626313260,164150620,187336784,
                    409518033,1261295412,282837188,40005758614,163995359,645880714,1442580334,917276555,
                    1055327735,409612289,1132223326,1457238550,1132176378,2239540481,578159883,187122063,
                    224495849,1443778491,1212396571,1582091769,357845651,334827969,2239540881,1294948923,
                    447753619,1581796195,965020314,1295471900,993747433,965386763,1558244285,755597129,
                    687771543,1393354796,40013166614,917091940,1262552690,712761988,1450976388,185945021,
                    412102697,1625078621,449289969,25607582015,1213316075,820170159,409466462,213161029,
                    754905354,187285598,165522301,1262713132,646266177,1392964116]
*/
                  //and rcid not in set_womble //here and following are all for womble case and may removed in sprint43
                  //and rcid not in [159574837,159576074,434979459,12250031665,35188158866,67058417687]
                  //and proxid not in [204310451,6783902870]
                  
                  //and proxid not in [//womble has been separated from seleid 4937701. But the following wombles appear in seleid 111865671 which also contains charitable trust so I hide these proxids
                  //113888004076,
                  //79021014276,
                  //113874755818,
                  //113874755018,
                  //533477445,
                  //201792877,
                  //113875657704,
                  //113877521343,
                  //113874818726,
                  //113874753418,
                  //113874754617,
                  //391991350
                  //]
                  //instead of the above for seleid 111865671, we can hide the charitable trust instead.
/*                  and rcid not in [114127504964,
                      95727409996,114296816164,114296816564,95727410396,44585985245,47460270260,92480943015,44561949245,
                      92488322214,47440165860,44829972045,56096229131,54331753316,75004114930,47490794659,89865690953,
                      44848389245,76993935331,101801178790,44658315245,93847296458,47437781860,58485833743,59240632101,
                      50609337678,92436717815,28852884816,35221397966,113933322622,42324345028,43069805752,47506325988,
                      40293418080,14888865266,14888864866,95970250796,29207846931,40225407280,19985341887,14814298701,
                      43067082552,19246081739,28912165804,12296756181,97008526087,95450873870,44564295442,111865671,
                      14815081901,43069806152,47431277460,97973396489,44564970445,54222141716,113898842623,42344102228,
                      35159116366,12757541996,89881995353]
*/

                  );
  shared ds_filt2_test := ds_test(seleid not in set_filt_seleids and rcid not in set_rcid and proxid not in set_prox
                  );
  
  
  SHARED ds_header      := BIPV2_Tools.Propagate_DID(ds_filt2);
  SHARED ds_header_test := ds_filt2_test;//BIPV2_Tools.Propagate_DID(ds_filt2);
  shared ds_header_out := dataset(f_out,bipv2.CommonBase.layout,thor);
  /* ---------------------- Strata Quick ID Check --------------------------------*/
  import BIPV2_Strata,strata;
  export strata_ID_Check_Pre (dataset(l_base) pDataset = input        ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'CommonBase','Input' ,pversion,pIsTesting);
  export strata_ID_Check_Post(dataset(l_base) pDataset = ds_header_out,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'CommonBase','Output',pversion,pIsTesting);
  export out := OUTPUT(ds_header,,f_out,OVERWRITE,COMPRESSED);
  export out_test := OUTPUT(ds_header_test,,f_out,OVERWRITE,COMPRESSED);
  supr := SEQUENTIAL(BIPV2_Files.files_CommonBase.updateBuilding(f_out)
                    ,BIPV2_Build.Promote(pversion,,,false,BIPV2.Filenames(pversion).Common_Base.dall_filenames).new2built/*, BIPV2.CommonBase.updateSuperfiles(f_out)*/);
  EXPORT run_base := SEQUENTIAL(strata_ID_Check_Pre(),out,strata_ID_Check_Post(), supr);
  EXPORT run_base_test := SEQUENTIAL(out_test);
  
  // Header History
  EXPORT run_hist := BIPV2_Files.files_CommonBase.BuildHistoryKey(ds_header_out,pversion);
  shared doCollectData:=if(tools._Constants.IsBocaProd,BIPV2_postProcess.DataCollector().addCandidates); 
  
  export kick_copy2_storage_thor  := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(BIPV2_Files.files_empid().FILE_BASE)[1].name) ,pversion ,'Build_CommonBase');
  export copyempid2StorageThor    := if(not wk_ut._constants.IsDev ,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')));  //copy orig file to storage thor

  EXPORT run := SEQUENTIAL(run_base, run_hist,copyempid2StorageThor,doCollectData);
  
END;