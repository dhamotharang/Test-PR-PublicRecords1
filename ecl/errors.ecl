// Modified on 09 Jan 2018 21:09:42 GMT by HIPIE (version 1.8.0) on machine ORLBROWNJ003-WXL
  EXPORT Errors := MODULE
 
EXPORT LevelEnum := ENUM(UNSIGNED1,Warning0,Warning1,Error0,Error1,Fatal0,Info0);
EXPORT Layout := RECORD
	UNSIGNED Cnt;
	LevelEnum Level;
	STRING ErrorCode;
	STRING Description;
	STRING InstanceDescription;
	STRING Plugin;
	INTEGER linenum;
	INTEGER colnum;
  END;
 
EXPORT CreateIF(BOOLEAN err,LevelEnum Level,STRING errcode,STRING Description,STRING InstanceDescription,STRING plugin,UNSIGNED linenum=0,UNSIGNED colnum=0,UNSIGNED C=1) := 
  IF ( err AND C > 0, 
       DATASET( [{ C, Level, errcode, Description, InstanceDescription, plugin,linenum,colnum }], Layout ),
			 DATASET([], Layout)
			 );
 
EXPORT CreateIFErr0(BOOLEAN b,STRING ErrCode,STRING Description,STRING InstanceDescription,STRING Plugin,UNSIGNED linenum=0,UNSIGNED colnum=0,UNSIGNED C=1) := CreateIF(b,LevelEnum.Error0,ErrCode,Description,InstanceDescription,Plugin,linenum,colnum,C);
EXPORT CreateIFWarn0(BOOLEAN b,STRING ErrCode,STRING Description,STRING InstanceDescription,STRING Plugin,UNSIGNED linenum=0,UNSIGNED colnum=0,UNSIGNED C=1) := CreateIF(b,LevelEnum.Warning0,ErrCode,Description,InstanceDescription,Plugin,linenum,colnum,C);
EXPORT CreateIFFatal0(BOOLEAN b,STRING ErrCode,STRING Description,STRING InstanceDescription,STRING Plugin,UNSIGNED linenum=0,UNSIGNED colnum=0,UNSIGNED C=1) := CreateIF(b,LevelEnum.Fatal0,ErrCode,Description,InstanceDescription,Plugin,linenum,colnum,C);
 
EXPORT CreateErr0(STRING ErrCode,STRING Description,STRING InstanceDescription,STRING Plugin,UNSIGNED linenum=0,UNSIGNED colnum=0,UNSIGNED C=1) := CreateIF(TRUE,LevelEnum.Error0,ErrCode,Description,InstanceDescription,Plugin,linenum,colnum,C);
EXPORT CreateWarn0(STRING ErrCode,STRING Description,STRING InstanceDescription,STRING Plugin,UNSIGNED linenum=0,UNSIGNED colnum=0,UNSIGNED C=1) := CreateIF(TRUE,LevelEnum.Warning0,ErrCode,Description,InstanceDescription,Plugin,linenum,colnum,C);
EXPORT CreateFatal0(STRING ErrCode,STRING Description,STRING InstanceDescription,STRING Plugin,UNSIGNED linenum=0,UNSIGNED colnum=0,UNSIGNED C=1) := CreateIF(TRUE,LevelEnum.Fatal0,ErrCode,Description,InstanceDescription,Plugin,linenum,colnum,C);
EXPORT CreateInfo(STRING Description,STRING InstanceDescription,STRING Plugin) := CreateIF(TRUE,LevelEnum.Info0,'INFO',Description,InstanceDescription,Plugin,0,0,1);
 
 
 EXPORT PluginErrorIf(BOOLEAN ifclause, STRING Description,STRING ciname,STRING errorOutput) := FUNCTION 
     dsErrors:=CreateIfErr0(
           ifclause,
           'RUNTIME_PLUGIN_ERROR',
           Description,
           'CONTRACTINSTANCE',
           ciname,
           0,0);
    return OUTPUT(dsErrors,NAMED(ciname + '_' + errorOutput + '_errors'),EXTEND);
 END;
 
END;
