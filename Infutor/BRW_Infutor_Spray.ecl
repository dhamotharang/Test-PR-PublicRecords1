import infutor,_Control;

EXPORT BRW_Infutor_Spray(STRING9 filedate) := FUNCTION

#Workunit('name','Yogurt:Trackerplus'+filedate);
#Workunit('priority','high');
#Workunit('priority',10);
#Workunit('protect',TRUE);
#option('multiplePersistInstances',FALSE);

                                                      
 return SEQUENTIAL(
                                             
infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_AK.txt','~thor_dell400::in::infutor::' + filedate + '::AK') 
,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_AL.txt','~thor_dell400::in::infutor::' + filedate + '::AL') 
,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_AR.txt','~thor_dell400::in::infutor::' + filedate + '::AR') 
,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_AZ.txt','~thor_dell400::in::infutor::' + filedate + '::AZ') 
,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_CA.txt','~thor_dell400::in::infutor::' + filedate + '::CA')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_CO.txt','~thor_dell400::in::infutor::' + filedate + '::CO')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_CT.txt','~thor_dell400::in::infutor::' + filedate + '::CT')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_DC.txt','~thor_dell400::in::infutor::' + filedate + '::DC')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_DE.txt','~thor_dell400::in::infutor::' + filedate + '::DE')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_FL.txt','~thor_dell400::in::infutor::' + filedate + '::FL')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_GA.txt','~thor_dell400::in::infutor::' + filedate + '::GA')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_HI.txt','~thor_dell400::in::infutor::' + filedate + '::HI')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_IA.txt','~thor_dell400::in::infutor::' + filedate + '::IA')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_ID.txt','~thor_dell400::in::infutor::' + filedate + '::ID')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_IL.txt','~thor_dell400::in::infutor::' + filedate + '::IL')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_IN.txt','~thor_dell400::in::infutor::' + filedate + '::IN')
, infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_KS.txt','~thor_dell400::in::infutor::' + filedate + '::KS')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_KY.txt','~thor_dell400::in::infutor::' + filedate + '::KY')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_LA.txt','~thor_dell400::in::infutor::' + filedate + '::LA')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_MA.txt','~thor_dell400::in::infutor::' + filedate + '::MA')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_MD.txt','~thor_dell400::in::infutor::' + filedate + '::MD')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_ME.txt','~thor_dell400::in::infutor::' + filedate + '::ME')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_MI.txt','~thor_dell400::in::infutor::' + filedate + '::MI')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_MN.txt','~thor_dell400::in::infutor::' + filedate + '::MN')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_MO.txt','~thor_dell400::in::infutor::' + filedate + '::MO')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_MS.txt','~thor_dell400::in::infutor::' + filedate + '::MS')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_MT.txt','~thor_dell400::in::infutor::' + filedate + '::MT')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_NC.txt','~thor_dell400::in::infutor::' + filedate + '::NC')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_ND.txt','~thor_dell400::in::infutor::' + filedate + '::ND')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_NE.txt','~thor_dell400::in::infutor::' + filedate + '::NE')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_NH.txt','~thor_dell400::in::infutor::' + filedate + '::NH')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_NJ.txt','~thor_dell400::in::infutor::' + filedate + '::NJ')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_NM.txt','~thor_dell400::in::infutor::' + filedate + '::NM')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_NV.txt','~thor_dell400::in::infutor::' + filedate + '::NV')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_NY.txt','~thor_dell400::in::infutor::' + filedate + '::NY')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_OH.txt','~thor_dell400::in::infutor::' + filedate + '::OH')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_OK.txt','~thor_dell400::in::infutor::' + filedate + '::OK')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_OR.txt','~thor_dell400::in::infutor::' + filedate + '::OR')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_PR.txt','~thor_dell400::in::infutor::' + filedate + '::PR')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_PA.txt','~thor_dell400::in::infutor::' + filedate + '::PA')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_RI.txt','~thor_dell400::in::infutor::' + filedate + '::RI')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_SC.txt','~thor_dell400::in::infutor::' + filedate + '::SC')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_SD.txt','~thor_dell400::in::infutor::' + filedate + '::SD')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_TN.txt','~thor_dell400::in::infutor::' + filedate + '::TN')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_TX.txt','~thor_dell400::in::infutor::' + filedate + '::TX') 
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_UT.txt','~thor_dell400::in::infutor::' + filedate + '::UT')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_VA.txt','~thor_dell400::in::infutor::' + filedate + '::VA')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_VT.txt','~thor_dell400::in::infutor::' + filedate + '::VT')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_WA.txt','~thor_dell400::in::infutor::' + filedate + '::WA')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_WI.txt','~thor_dell400::in::infutor::' + filedate + '::WI')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_WV.txt','~thor_dell400::in::infutor::' + filedate + '::WV')
 ,infutor.fSprayInputFiles(_Control.IPAddress.bctlpedata11,'/data/data_lib_2_hus2/infutor/in/CRD_WY.txt','~thor_dell400::in::infutor::' + filedate + '::WY')
);
  
END;