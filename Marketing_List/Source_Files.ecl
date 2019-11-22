import BIPV2,bipv2_best,BIPV2_Build,dcav2,Equifax_Business_Data,OSHAIR,Cortera,Infutor_NARB,BusReg,DataBridge,tools,BIPV2_Crosswalk;

EXPORT Source_Files(

   string   pversionBIP           = 'built'                     // use built superfiles for BIP files because this will run in the BIP build before the BIP files are promoted to the qa supers
  ,string   pversionSourceFiles   = 'qa'                        // use QA superfiles for source files.  Cortera is the exception.
  ,boolean  pUseOtherEnviron      = tools._Constants.IsDataland // if dataland, pull from prod, if on prod pull from prod by default
  
) :=
module

  export bip_base           := bipv2.CommonBase                       .clean_common_base(pversionBIP,pUseOtherEnviron)     .logical  ;   // use clean base file
  export bip_best           := bipv2_best                             .Files            (pversionBIP,pUseOtherEnviron).base.logical  ;   // best file
  export crosswalk          := BIPV2_Crosswalk.Key_BipToConsumer.kFetch_thor(,,true ,   ,pversionBIP,pUseOtherEnviron);

  export dca          := dcav2                .files(pversionSourceFiles,pUseOtherEnviron).base.companies  .logical ;
  export oshair       := OSHAIR               .Files(pversionSourceFiles,pUseOtherEnviron).base.Inspection .logical ;
  export accutrend    := BusReg               .files(pversionSourceFiles,pUseOtherEnviron).base.aid        .logical ;
  export infutor      := Infutor_NARB         .files(pversionSourceFiles,pUseOtherEnviron).base            .logical ;
  export eq_biz       := Equifax_Business_Data.files(pversionSourceFiles,pUseOtherEnviron).base            .logical ;
  export DataBridge   := DataBridge           .files(pversionSourceFiles,pUseOtherEnviron).base            .logical ;        
  export cortera      := Cortera              .Files.Hdr_Out                                                        ; // will pull the prod file on dataland automatically
  
end;