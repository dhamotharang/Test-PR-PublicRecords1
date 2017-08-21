Import UtilFile, Scrubs_UtilDid, Scrubs, ut, std, tools;
#option('multiplePersistInstances',FALSE);
Export UtilDid_Scrubs(String Filedate, string emailList='') := Function
//F := Scrubs_UtilDid.In_UtilDid(filedate); //logical file of UtilFile.Daily_with_did attribute
return Scrubs.ScrubsPlus_PassFile(Scrubs_UtilDid.In_UtilDid(filedate),'UtilDid','Scrubs_UtilDid','Scrubs_UtilDid','',Filedate,emailList,false);
End;	