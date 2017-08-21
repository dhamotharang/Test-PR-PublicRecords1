IMPORT SALTTOOLS30, Repository ; 

EXPORT fMigrate (STRING pModule , STRING pAtt , STRING pESP , STRING pRemoteESP , STRING desc) := FUNCTION 

 GetAttribute_text := SALTTOOLS30.mod_Soapcalls.fGetAttributes(pModule,pAtt,pESP)(COUNT(results)>0)[1].results[1].Text;

 RETURN   SEQUENTIAL(OUTPUT(SALTTOOLS30.mod_Soapcalls.fSaveAttribute(pModule,pAtt,GetAttribute_text,pRemoteESP)),
                     OUTPUT(Repository.Checkout_Attribute(pModule,pAtt, pRemoteESP)) ,
                     OUTPUT(Repository.Checkin_Attribute(pModule,pAtt, desc, pRemoteESP))
                    );

END;