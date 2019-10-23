#workunit('name','Customer Test xLink Keybuild V1');
#OPTION('multiplePersistInstances',FALSE);
#stored ('CustomerTestEnv','Y');
String fileVersion:= thorlib.wuid()[2..9];
InsuranceHeader_xLink.CustTest_Proc_GoExternal(fileVersion);