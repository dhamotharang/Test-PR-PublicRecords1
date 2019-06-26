#OPTION('multiplePersistInstances',FALSE);
IMPORT Corp2;
IMPORT BIPV2_Files;
IMPORT BIPV2;
IMPORT BIPv2_HRCHY;
IMPORT BIPV2_Company_Names;
IMPORT ut;
IMPORT MDR;
IMPORT lib_date;
IMPORT Cortera;
IMPORT BIPV2_Ingest;

Export proc_Build_Ext_Data_Basefile(STRING version, BOOLEAN isFullBuild) := FUNCTION
  ds_sos := choosen(Corp2.fCorp2_As_Business_Linking(),ALL);
  //ds_sbfe := choosen(Business_Credit.Business_Credit_As_Business_Linking,ALL); //Removed SBFE data ZRS 4/1/2019
  ds_cortera := Cortera.Files.Bus_linking;
    
  pAs_Linking_Mappers   := ds_sos + ds_cortera;
  pSet_Test_Sources     := [mdr.sourcetools.src_Cortera,
                             mdr.sourcetools.src_AK_Corporations,
                             mdr.sourcetools.src_AL_Corporations,
                             mdr.sourcetools.src_AR_Corporations,
                             mdr.sourcetools.src_AZ_Corporations,
                             mdr.sourcetools.src_CA_Corporations,
                             mdr.sourcetools.src_CO_Corporations,
                             mdr.sourcetools.src_CT_Corporations,
                             mdr.sourcetools.src_DC_Corporations,
                             mdr.sourcetools.src_FL_Corporations,
                             mdr.sourcetools.src_GA_Corporations,
                             mdr.sourcetools.src_HI_Corporations,
                             mdr.sourcetools.src_IA_Corporations,
                             mdr.sourcetools.src_ID_Corporations,
                             mdr.sourcetools.src_IL_Corporations,
                             mdr.sourcetools.src_IN_Corporations,
                             mdr.sourcetools.src_KS_Corporations,
                             mdr.sourcetools.src_KY_Corporations,
                             mdr.sourcetools.src_LA_Corporations,
                             mdr.sourcetools.src_MA_Corporations,
                             mdr.sourcetools.src_MD_Corporations,
                             mdr.sourcetools.src_ME_Corporations,
                             mdr.sourcetools.src_MI_Corporations,
                             mdr.sourcetools.src_MN_Corporations,
                             mdr.sourcetools.src_MO_Corporations,
                             mdr.sourcetools.src_MS_Corporations,
                             mdr.sourcetools.src_MT_Corporations,
                             mdr.sourcetools.src_NC_Corporations,
                             mdr.sourcetools.src_ND_Corporations,
                             mdr.sourcetools.src_NE_Corporations,
                             mdr.sourcetools.src_NH_Corporations,
                             mdr.sourcetools.src_NJ_Corporations,
                             mdr.sourcetools.src_NM_Corporations,
                             mdr.sourcetools.src_NV_Corporations,
                             mdr.sourcetools.src_NY_Corporations,
                             mdr.sourcetools.src_OH_Corporations,
                             mdr.sourcetools.src_OK_Corporations,
                             mdr.sourcetools.src_OR_Corporations,
                             mdr.sourcetools.src_PA_Corporations,
                             mdr.sourcetools.src_RI_Corporations,
                             mdr.sourcetools.src_SC_Corporations,
                             mdr.sourcetools.src_SD_Corporations,
                             mdr.sourcetools.src_TN_Corporations,
                             mdr.sourcetools.src_TX_Corporations,
                             mdr.sourcetools.src_UT_Corporations,
                             mdr.sourcetools.src_VA_Corporations,
                             mdr.sourcetools.src_VT_Corporations,
                             mdr.sourcetools.src_WA_Corporations,
                             mdr.sourcetools.src_WI_Corporations,
                             mdr.sourcetools.src_WV_Corporations,
                             mdr.sourcetools.src_WV_Hist_Corporations,
                             mdr.sourcetools.src_WY_Corporations
                             //mdr.sourcetools.src_Business_Credit,//Removed SBFE data ZRS 4/1/2019
                           ];
  pBase_File                := IF(isFullBuild,bipv2.commonbase.ds_built,bipv2.commonbase.ds_base); //Use ds_base for independent ext data build process. For full build use ds_built
                                               
  ds_base_Filtered          := pBase_File(count(pSet_Test_Sources) = 0 or source in pSet_Test_Sources) : persist('~persist::BIPV2_Ingest._ExternalFile_Ingest::ds_base_Filtered');

  ds_as_linking             := pAs_Linking_Mappers      ;  
  ds_as_linking_filtered    := ds_as_linking(count(pSet_Test_Sources) = 0 or source in pSet_Test_Sources);
  ds_as_linking_prep_ingest := if(count(pAs_Linking_Mappers) != 0
                                  ,BIPV2_Files.tools_dotid(BIPV2.BL_Init(ds_as_linking_filtered)).base_NoDebug
                                  ,dataset([],RECORDOF(BIPV2_Ingest.In_INGEST))
                               );
  do_ingest                 := BIPV2_Ingest.Ingest(false,,ds_base_Filtered,ds_as_linking_prep_ingest,'~persist::BIPV2_Ingest._ExternalFile_Ingest::do_ingest');

  dBase:=PROJECT(do_ingest.newRecords, TRANSFORM({ BIPV2.CommonBase.Layout,unsigned8 rid}, SELF.rid := COUNTER, SELF.rcid := COUNTER, SELF.ingest_status:=BIPV2_Ingest.Ingest().RTToText(LEFT.__Tpe), SELF:=LEFT, SELF:=[]));

  //Removed lines 13-39 from File_Bizhead
  // Distributing the HRCHY file and "pre-cleaning" targeted fields
  BIPV2_Company_Names.functions.mac_go(dBase,dCnpName,rid,company_name,,FALSE);
  // Re-joining the cleaned company name information to the HRCHY file.  At the
  // same time, addingi
  lFileBizHead:=RECORD
    RECORDOF(dCnpName) AND NOT [rid,cnp_nameid];
    STRING5 company_name_prefix;
    STRING25 city;
    STRING25 city_clean;
    STRING3 company_phone_3;
    STRING3 company_phone_3_ex;
    STRING7 company_phone_7;
    STRING20 fname_preferred;
    UNSIGNED1 fallback_value;
  END;
  dWithCnpName:=PROJECT(dCnpName,TRANSFORM(lFileBizHead,
    phone_cleaned:=REGEXREPLACE('[^0-9]',LEFT.company_phone,'');
    SELF.company_name_prefix:=BizLinkFull.fn_company_name_prefix(LEFT.cnp_name);//[..5];
    SELF.city:=IF(LEFT.p_city_name='',LEFT.v_city_name,LEFT.p_city_name);
    SELF.city_clean:=IF(LEFT.err_stat[1]='S',SELF.city,'');
    SELF.company_phone_3:=IF(LENGTH(phone_cleaned)=10,phone_cleaned[..3],'');
    SELF.company_phone_3_ex:=IF(LENGTH(phone_cleaned)=10,phone_cleaned[..3],'');
    SELF.company_phone_7:=IF(LENGTH(phone_cleaned)=10,phone_cleaned[4..],'');
    SELF.fname_preferred:=fn_PreferredName(LEFT.fname);
    SELF.fallback_value:=0;
    SELF:=LEFT;
  ))(cnp_name!='');
  // Adding in rows where there is a different v_city_name
  dAdditionalCity:=PROJECT(dWithCnpName(v_city_name<>'' AND v_city_name<>city),TRANSFORM(RECORDOF(LEFT),
    SELF.city:=LEFT.v_city_name;
    SELF:=LEFT;
  ));
  dBaseFile_1:=dWithCnpName+dAdditionalCity:PERSIST('~BizLinkFull::persist::file_ext_data',EXPIRE(60));
  dBaseFile := PROJECT(dBaseFile_1,TRANSFORM(RECORDOF(File_BizHead),SELF:=LEFT,SELF:=[]));


  RETURN SEQUENTIAL(
       OUTPUT(dBaseFile, ,Filenames_Ext_Data.BaseLF(version).new,COMPRESSED),
       Filenames_Ext_Data.updateSuperfiles(Filenames_Ext_Data.BaseLF(version).new)
       );
END;
