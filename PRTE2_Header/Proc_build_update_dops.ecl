IMPORT PRTE,_control;

notifyList := _control.MyInfo.EmailAddressNormal;

EXPORT Proc_build_update_dops(string fileVersion) :=
sequential (    
                 PRTE.UpdateVersion('PersonHeaderKeys'      ,fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N')
                ,PRTE.UpdateVersion('FCRA_PersonHeaderKeys' ,fileVersion, notifyList, l_inloc:='B', l_inenvment:='F', l_includeboolean:= 'N')
                ,PRTE.UpdateVersion('PersonLABKeys'         ,fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N')
								
                ,PRTE.UpdateVersion('RelativeV3Keys'        ,fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N')
                ,PRTE.UpdateVersion('WatchdogKeys'          ,fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N')
                ,PRTE.UpdateVersion('FCRA_WatchdogKeys'     ,fileVersion, notifyList, l_inloc:='B', l_inenvment:='F', l_includeboolean:= 'N')
                ,PRTE.UpdateVersion('MarketingHeaderKeys '  ,fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N')
                ,PRTE.UpdateVersion('InfutorKeys'           ,fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N')
								,PRTE.UpdateVersion('PersonSlimSortKeys'	  ,fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N')
								,PRTE.UpdateVersion('PersonHeaderWeeklyKeys',fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N')
								,PRTE.UpdateVersion('AddressRawAIDKeys'			,fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N') 			
								,PRTE.UpdateVersion('PersonAncillaryKeys'		,fileVersion, notifyList, l_inloc:='B', l_inenvment:='N', l_includeboolean:= 'N') 			
);

// 1   B = Boca, A = Alpharetta
// 2   N = Non-FCRA, F = FCRA
// 3   N = Do not also include boolean, Y = Include boolean, too
