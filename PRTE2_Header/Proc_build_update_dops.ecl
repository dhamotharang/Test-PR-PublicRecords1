IMPORT PRTE,_control;

notifyList := _control.MyInfo.EmailAddressNormal;

EXPORT Proc_build_update_dops(string fileVersion) :=
sequential (    
                 PRTE.UpdateVersion('PersonHeaderKeys'      ,fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   )
                // ,PRTE.UpdateVersion('FCRA_PersonHeaderKeys' ,fileVersion, notifyList,'B' /*1*/   ,'F' /*2*/  ,'N'/*3*/   )
                ,PRTE.UpdateVersion('PersonLABKeys'         ,fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   )
                // ,PRTE.UpdateVersion('RelativeV3Keys'        ,fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   )
                // ,PRTE.UpdateVersion('WatchdogKeys'          ,fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   )
                ,PRTE.UpdateVersion('FCRA_WatchdogKeys'     ,fileVersion, notifyList,'B' /*1*/   ,'F' /*2*/  ,'N'/*3*/   )
                ,PRTE.UpdateVersion('MarketingHeaderKeys '  ,fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   )
                ,PRTE.UpdateVersion('InfutorKeys'           ,fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   )
								,PRTE.UpdateVersion('PersonSlimSortKeys'	  ,fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   )
								,PRTE.UpdateVersion('PersonHeaderWeeklyKeys',fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   )
								,PRTE.UpdateVersion('AddressRawAIDKeys'			,fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   ) 			
								,PRTE.UpdateVersion('PersonAncillaryKeys'		,fileVersion, notifyList,'B' /*1*/   ,'N' /*2*/  ,'N'/*3*/   ) 			
);

// 1   B = Boca, A = Alpharetta
// 2   N = Non-FCRA, F = FCRA
// 3   N = Do not also include boolean, Y = Include boolean, too
