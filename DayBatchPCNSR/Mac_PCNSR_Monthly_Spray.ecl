import _control;

export Mac_PCNSR_Monthly_Spray(file_date,build_date,sourceIP,group_name,outname) := Macro

#uniquename(spray_LEXAK)    
#uniquename(spray_LEXAL)    
#uniquename(spray_LEXAR)    
#uniquename(spray_LEXAZ)    
#uniquename(spray_LEXCA)    
#uniquename(spray_LEXCO)    
#uniquename(spray_LEXCT)    
#uniquename(spray_LEXDC)    
#uniquename(spray_LEXDE)    
#uniquename(spray_LEXFL)    
#uniquename(spray_LEXGA)    
#uniquename(spray_LEXHI)    
#uniquename(spray_LEXIA)    
#uniquename(spray_LEXID)    
#uniquename(spray_LEXIL)    
#uniquename(spray_LEXIN)    
#uniquename(spray_LEXKS)    
#uniquename(spray_LEXKY)    
#uniquename(spray_LEXLA)    
#uniquename(spray_LEXMA)    
#uniquename(spray_LEXMD)    
#uniquename(spray_LEXME)    
#uniquename(spray_LEXMI)    
#uniquename(spray_LEXMN)    
#uniquename(spray_LEXMO)    
#uniquename(spray_LEXMS)    
#uniquename(spray_LEXMT)    
#uniquename(spray_LEXNC)    
#uniquename(spray_LEXND)    
#uniquename(spray_LEXNE)    
#uniquename(spray_LEXNH)    
#uniquename(spray_LEXNJ)    
#uniquename(spray_LEXNM)    
#uniquename(spray_LEXNV)    
#uniquename(spray_LEXNY)    
#uniquename(spray_LEXOH)    
#uniquename(spray_LEXOK)    
#uniquename(spray_LEXOR)    
#uniquename(spray_LEXPA)    
#uniquename(spray_LEXRI)    
#uniquename(spray_LEXSC)    
#uniquename(spray_LEXSD)    
#uniquename(spray_LEXTN)    
#uniquename(spray_LEXTX)    
#uniquename(spray_LEXUT)    
#uniquename(spray_LEXVA)    
#uniquename(spray_LEXVT)    
#uniquename(spray_LEXWA)    
#uniquename(spray_LEXWI)    
#uniquename(spray_LEXWV)    
#uniquename(spray_LEXWY)
#uniquename(recordsize)
#uniquename(clear_superfile)    
#uniquename(super_pcnsr)    

%recordsize% :=850;

%spray_LEXAK% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXAK.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_AK_'+build_date ,-1,,,true,true);      
%spray_LEXAL% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXAL.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_AL_'+build_date ,-1,,,true,true);      
%spray_LEXAR% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXAR.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_AR_'+build_date ,-1,,,true,true);      
%spray_LEXAZ% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXAZ.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_AZ_'+build_date ,-1,,,true,true);      
%spray_LEXCA% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXCA.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_CA_'+build_date ,-1,,,true,true);      
%spray_LEXCO% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXCO.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_CO_'+build_date ,-1,,,true,true);      
%spray_LEXCT% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXCT.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_CT_'+build_date ,-1,,,true,true);      
%spray_LEXDC% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXDC.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_DC_'+build_date ,-1,,,true,true);      
%spray_LEXDE% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXDE.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_DE_'+build_date ,-1,,,true,true);      
%spray_LEXFL% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXFL.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_FL_'+build_date ,-1,,,true,true);      
%spray_LEXGA% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXGA.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_GA_'+build_date ,-1,,,true,true);      
%spray_LEXHI% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXHI.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_HI_'+build_date ,-1,,,true,true);      
%spray_LEXIA% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXIA.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_IA_'+build_date ,-1,,,true,true);      
%spray_LEXID% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXID.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_ID_'+build_date ,-1,,,true,true);      
%spray_LEXIL% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXIL.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_IL_'+build_date ,-1,,,true,true);      
%spray_LEXIN% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXIN.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_IN_'+build_date ,-1,,,true,true);      
%spray_LEXKS% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXKS.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_KS_'+build_date ,-1,,,true,true);      
%spray_LEXKY% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXKY.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_KY_'+build_date ,-1,,,true,true);      
%spray_LEXLA% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXLA.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_LA_'+build_date ,-1,,,true,true);      
%spray_LEXMA% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXMA.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_MA_'+build_date ,-1,,,true,true);      
%spray_LEXMD% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXMD.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_MD_'+build_date ,-1,,,true,true);      
%spray_LEXME% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXME.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_ME_'+build_date ,-1,,,true,true);      
%spray_LEXMI% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXMI.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_MI_'+build_date ,-1,,,true,true);      
%spray_LEXMN% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXMN.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_MN_'+build_date ,-1,,,true,true);      
%spray_LEXMO% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXMO.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_MO_'+build_date ,-1,,,true,true);      
%spray_LEXMS% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXMS.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_MS_'+build_date ,-1,,,true,true);      
%spray_LEXMT% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXMT.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_MT_'+build_date ,-1,,,true,true);      
%spray_LEXNC% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXNC.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_NC_'+build_date ,-1,,,true,true);      
%spray_LEXND% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXND.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_ND_'+build_date ,-1,,,true,true);      
%spray_LEXNE% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXNE.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_NE_'+build_date ,-1,,,true,true);      
%spray_LEXNH% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXNH.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_NH_'+build_date ,-1,,,true,true);      
%spray_LEXNJ% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXNJ.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_NJ_'+build_date ,-1,,,true,true);      
%spray_LEXNM% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXNM.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_NM_'+build_date ,-1,,,true,true);      
%spray_LEXNV% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXNV.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_NV_'+build_date ,-1,,,true,true);      
%spray_LEXNY% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXNY.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_NY_'+build_date ,-1,,,true,true);      
%spray_LEXOH% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXOH.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_OH_'+build_date ,-1,,,true,true);      
%spray_LEXOK% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXOK.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_OK_'+build_date ,-1,,,true,true);      
%spray_LEXOR% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXOR.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_OR_'+build_date ,-1,,,true,true);      
%spray_LEXPA% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXPA.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_PA_'+build_date ,-1,,,true,true);      
%spray_LEXRI% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXRI.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_RI_'+build_date ,-1,,,true,true);      
%spray_LEXSC% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXSC.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_SC_'+build_date ,-1,,,true,true);      
%spray_LEXSD% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXSD.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_SD_'+build_date ,-1,,,true,true);      
%spray_LEXTN% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXTN.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_TN_'+build_date ,-1,,,true,true);      
%spray_LEXTX% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXTX.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_TX_'+build_date ,-1,,,true,true);      
%spray_LEXUT% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXUT.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_UT_'+build_date ,-1,,,true,true);      
%spray_LEXVA% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXVA.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_VA_'+build_date ,-1,,,true,true);      
%spray_LEXVT% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXVT.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_VT_'+build_date ,-1,,,true,true);      
%spray_LEXWA% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXWA.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_WA_'+build_date ,-1,,,true,true);      
%spray_LEXWI% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXWI.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_WI_'+build_date ,-1,,,true,true);      
%spray_LEXWV% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXWV.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_WV_'+build_date ,-1,,,true,true);      
%spray_LEXWY% := FileServices.Sprayfixed(sourceIP,'/hds_1/infousa_pcnsr/in/' + file_date + '/LEXWY.txt', %recordsize%, group_name,        '~thor_data400::in::infousa_p_cnsr_WY_'+build_date ,-1,,,true,true);      

%clear_superfile% := fileservices.clearsuperfile('~thor_data400::in::p_cnsr',true);

%super_pcnsr% := parallel(
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_AK_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_AL_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_AR_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_AZ_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_CA_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_CO_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_CT_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_DC_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_DE_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_FL_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_GA_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_HI_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_IA_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_ID_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_IL_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_IN_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_KS_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_KY_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_LA_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_MA_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_MD_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_ME_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_MI_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_MN_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_MO_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_MS_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_MT_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_NC_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_ND_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_NE_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_NH_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_NJ_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_NM_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_NV_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_NY_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_OH_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_OK_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_OR_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_PA_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_RI_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_SC_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_SD_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_TN_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_TX_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_UT_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_VA_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_VT_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_WA_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_WI_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_WV_'+build_date),   
fileservices.addsuperfile('~thor_data400::in::p_cnsr'                  ,  '~thor_data400::in::infousa_p_cnsr_WY_'+build_date)); 
							
outname := 

sequential(
%spray_LEXAK%,
%spray_LEXAL%,
%spray_LEXAR%,
%spray_LEXAZ%,
%spray_LEXCA%,
%spray_LEXCO%,
%spray_LEXCT%,
%spray_LEXDC%,
%spray_LEXDE%,
%spray_LEXFL%,
%spray_LEXGA%,
%spray_LEXHI%,
%spray_LEXIA%,
%spray_LEXID%,
%spray_LEXIL%,
%spray_LEXIN%,
%spray_LEXKS%,
%spray_LEXKY%,
%spray_LEXLA%,
%spray_LEXMA%,
%spray_LEXMD%,
%spray_LEXME%,
%spray_LEXMI%,
%spray_LEXMN%,
%spray_LEXMO%,
%spray_LEXMS%,
%spray_LEXMT%,
%spray_LEXNC%,
%spray_LEXND%,
%spray_LEXNE%,
%spray_LEXNH%,
%spray_LEXNJ%,
%spray_LEXNM%,
%spray_LEXNV%,
%spray_LEXNY%,
%spray_LEXOH%,
%spray_LEXOK%,
%spray_LEXOR%,
%spray_LEXPA%,
%spray_LEXRI%,
%spray_LEXSC%,
%spray_LEXSD%,
%spray_LEXTN%,
%spray_LEXTX%,
%spray_LEXUT%,
%spray_LEXVA%,
%spray_LEXVT%,
%spray_LEXWA%,
%spray_LEXWI%,
%spray_LEXWV%,
%spray_LEXWY%,
%clear_superfile%,
%super_pcnsr%);
							
endmacro;