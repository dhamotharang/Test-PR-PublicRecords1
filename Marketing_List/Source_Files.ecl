import BIPV2,bipv2_best,BIPV2_Build,dcav2,Equifax_Business_Data,OSHAIR,Cortera,Infutor_NARB,BusReg,DataBridge,tools,BIPV2_Crosswalk;

EXPORT Source_Files(

   string   pversion          = 'qa'                        // use QA superfiles.  Cortera is the exception.
  ,boolean  pUseOtherEnviron  = tools._Constants.IsDataland //if dataland, pull from prod, if on prod pull from prod by default
  
) :=
module

  export bip_base           := bipv2.CommonBase                       .clean_common_base(pversion,pUseOtherEnviron)     .logical  ;   // use clean base file
  export bip_best           := bipv2_best                             .Files            (pversion,pUseOtherEnviron).base.logical  ;   // may not need this
  export contacts_key       := BIPV2_Build.key_contact_linkids        .keyvs            (pversion,pUseOtherEnviron)     .logical  ;   // pull email and contacts info from this key  
  export contact_Titles_key := BIPV2_Build.key_contact_title_linkids().keyvs            (pversion,pUseOtherEnviron)     .logical  ;   // pull email and contacts info from this key  
  export crosswalk          := BIPV2_Crosswalk.Key_BipToConsumer.kFetch_thor();


  export dca          := dcav2                .files(pversion,pUseOtherEnviron).base.companies  .logical ;
  export oshair       := OSHAIR               .Files(pversion,pUseOtherEnviron).base.Inspection .logical ;
  export accutrend    := BusReg               .files(pversion,pUseOtherEnviron).base.aid        .logical ;
  export infutor      := Infutor_NARB         .files(pversion,pUseOtherEnviron).base            .logical ;
  export eq_biz       := Equifax_Business_Data.files(pversion,pUseOtherEnviron).base            .logical ;
  export DataBridge   := DataBridge           .files(pversion,pUseOtherEnviron).base            .logical ;        
  export cortera      := Cortera              .Files.Hdr_Out                                             ; // will pull the prod file on dataland automatically
  
end;