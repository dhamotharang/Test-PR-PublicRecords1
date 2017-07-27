IMPORT BIPV2, BIPV2_Files,BIPV2_PostProcess,wk_ut,tools,std,BIPV2_Tools;
l_base					:= BIPV2.CommonBase.Layout;
in_default			:= PROJECT(BIPV2_Files.files_empid().DS_BASE, l_base);
// f_default				:= BIPV2_Files.files_CommonBase.filePrefix   + '::' + BIPV2.KeySuffix;  //so superfile and logical files have the same naming convention
// f_hist_default	:= BIPV2_Files.files_CommonBase.FILE_HISTORY + '::' + BIPV2.KeySuffix;
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
		LOCAL ds_dist	:= DISTRIBUTE(ds,HASH32(Y));
		LOCAL tab_cnt	:= TABLE(TABLE(ds_dist, {Y, X}, Y, X, LOCAL), {Y, UNSIGNED fld:=count(GROUP)}, Y, LOCAL);
		LOCAL ds_cnt	:= JOIN(ds_dist, tab_cnt, LEFT.Y=RIGHT.Y, TRANSFORM(RECORDOF(ds), SELF:=RIGHT, SELF:=LEFT), KEEP(1), LOCAL);
		RETURN ds_cnt;
	ENDMACRO;
	SHARED lgid3_counts(DATASET(l_thin) ds_in)	:= cnt_X_per_Y(ds_in,proxid,lgid3,cnt_prox_per_lgid3);
	SHARED powid_counts(DATASET(l_thin) ds_in)	:= cnt_X_per_Y(ds_in,proxid,powid,cnt_prox_per_powid);
	SHARED empid_counts(DATASET(l_thin) ds_in)	:= cnt_X_per_Y(ds_in,dotid,empid,cnt_dot_per_empid);
	SHARED proxid_counts(DATASET(l_thin) ds_in)	:= cnt_X_per_Y(ds_in,dotid,proxid,cnt_dot_per_proxid);
	SHARED dotid_counts(DATASET(l_thin) ds_in)	:= cnt_X_per_Y(ds_in,rcid,dotid,cnt_rcid_per_dotid);
	EXPORT descendant_counts(DATASET(l_base) ds_in) := FUNCTION
		ds_in_thin := PROJECT(ds_in, l_thin);
		ds_out_thin := dotid_counts(proxid_counts(empid_counts(powid_counts(lgid3_counts(ds_in_thin)))));
		RETURN JOIN(ds_in,ds_out_thin,LEFT.rcid=RIGHT.rcid,TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT),KEEP(1),HASH);
	END;
	
	// Take action
	ds1 := descendant_counts(input);
  ds  := BIPV2_PostProcess.proc_segmentation(pversion,ds1,pPopulateStatus := true ).patched; //put in seg stats into file itself.  do this for now.  the output of the stats will come later
  ds_filter := table(ds,{seleid,st,v_city_name,prim_range,prim_name,cnp_name,fname,lname})( 
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
  );  //hack filter for Bug: 166172 - Privacy Office Directing Record Removal from BIP Header.  Will make this better later
  set_filt_seleids := set(table(ds_filter,{seleid},seleid,few),seleid);
	
	set_rcid :=[2957294316,2994521116,64211053595]; //ticket 188309, rcid to be excluded: the set_rcid
  ds_filt2 := ds(seleid not in set_filt_seleids and rcid not in set_rcid);
	
	SHARED ds_header     := BIPV2_Tools.Propagate_DID(ds_filt2);
  shared ds_header_out := dataset(f_out,bipv2.CommonBase.layout,thor);
  /* ---------------------- Strata Quick ID Check --------------------------------*/
  import BIPV2_Strata,strata;
  export strata_ID_Check_Pre (dataset(l_base) pDataset = input        ,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'CommonBase','Input' ,pversion,pIsTesting);
  export strata_ID_Check_Post(dataset(l_base) pDataset = ds_header_out,boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(pDataset,'CommonBase','Output',pversion,pIsTesting);
	out := OUTPUT(ds_header,,f_out,OVERWRITE,COMPRESSED);
	supr := SEQUENTIAL(BIPV2_Files.files_CommonBase.updateBuilding(f_out)
                    ,BIPV2_Build.Promote(pversion,,,false,BIPV2.Filenames(pversion).Common_Base.dall_filenames).new2built/*, BIPV2.CommonBase.updateSuperfiles(f_out)*/);
	EXPORT run_base := SEQUENTIAL(strata_ID_Check_Pre(),out,strata_ID_Check_Post(), supr);
	
	// Header History
	EXPORT run_hist := BIPV2_Files.files_CommonBase.BuildHistoryKey(ds_header_out,pversion);
	
  export copyempid2StorageThor := if(not wk_ut._constants.IsDev ,tools.Copy2_Storage_Thor(filename := '~' + nothor(std.file.superfilecontents(BIPV2_Files.files_empid().FILE_BASE)[1].name)  ,pDeleteSourceFile  := true));  //copy orig file to storage thor
	EXPORT run := SEQUENTIAL(run_base, run_hist,copyempid2StorageThor);
	
END;
