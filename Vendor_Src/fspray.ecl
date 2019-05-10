IMPORT VersionControl,STD,lib_fileservices,Tools,workman,promotesupers;

FS:=fileservices;

EXPORT fspray(STRING pversion, STRING LogicalName,STRING SourceIP, STRING Directory) := FUNCTION

ThorList:=NOTHOR(FS.LogicalFileList(LogicalName,TRUE,FALSE)):INDEPENDENT;
LZList_:=NOTHOR(FS.RemoteDirectory(SourceIP,Directory + pversion ,'*',TRUE)):INDEPENDENT;
lzlist:=TABLE(lzlist_,{name,size,modified});

r:=RECORD
STRING20 input_file_id;
STRING thDate;
STRING lzDate;
TYPEOF(ThorList) TH;
STRING lz_name;
VersionControl.Layout_Sprays.Info;
END;

pth:=PROJECT(ThorList, TRANSFORM(r,SELF.input_file_id:=MAP(
     REGEXFIND('bank',LEFT.name,NOCASE) => 'bankruptcy',
     REGEXFIND('lien',LEFT.name,NOCASE)  => 'lien',
     REGEXFIND('colle',LEFT.name,NOCASE) => 'collegelocator',
     REGEXFIND('court',LEFT.name,NOCASE) => 'courtlocator',
     REGEXFIND('maste',LEFT.name,NOCASE) => 'masterlist',
   ''
   );
	
	 SELF.thdate:=REGEXFIND('(.*)([0-9]{8})(.*)',LEFT.name,2),
   SELF.th:=LEFT,
   SELF:=[]
))(input_file_id<>'');

pthsort:= SORT(pth,input_file_id,-thdate);
pthdedup := DEDUP(pthsort,LEFT.input_file_id = RIGHT.input_file_id);


plz:=PROJECT(LZList,TRANSFORM(r, SELF.input_file_id:=MAP(
     REGEXFIND('bank',LEFT.name,NOCASE) => 'bankruptcy',
     REGEXFIND('lien',LEFT.name,NOCASE)  => 'lien',
     REGEXFIND('colle',LEFT.name,NOCASE) => 'collegelocator',
     REGEXFIND('court',LEFT.name,NOCASE) => 'courtlocator',
     REGEXFIND('maste',LEFT.name,NOCASE) => 'masterlist',
   ''
   );
	 SELF.lzdate:=REGEXFIND('(.*)([0-9]{8})(.*)',LEFT.name,2),
   SELF.lz_name:=LEFT.name,
   SELF:=[]
))(input_file_id<>'');


plzsort:= SORT(plz,input_file_id,lzdate);
plzdedup := DEDUP(plzsort,LEFT.input_file_id = RIGHT.input_file_id);




j:=JOIN(pthdedup,plzdedup,
   LEFT.input_file_id=RIGHT.input_file_id,
   TRANSFORM(r,
   SELF.input_file_id:=IF(LEFT.input_file_id<>'',LEFT.input_file_id,RIGHT.input_file_id);
   SELF.th:=LEFT.th,
   SELF.lz_name:=IF(LEFT.lz_name<>'',LEFT.lz_name,RIGHT.lz_name);  
   SELF.SourceIP:=SourceIP;
   SELF.Thor_filename_template:='~thor_data400::in::vendor_src::'+ TRIM(SELF.input_file_id) + '_'+ RIGHT.lzdate;    
   SELF.SourceDirectory:=Directory + pversion;                         
   SELF.Directory_Filter:= RIGHT.LZ_NAME;                                                                        
   SELF.Record_Size :=0;                                                                                             
   SELF.dSuperfilenames:=ROW({'~thor_data400::in::vendor_src::'+ TRIM(SELF.input_file_id)},FsLogicalFileNameRecord);  
   SELF.Fun_Groupname:='thor400_36';                                                                               
   SELF.FileDate:=pversion;
   SELF.Date_Regex:='[0-9]{8}';                                                                                      
   SELF.File_Type:='VARIABLE';                                                                                       
   SELF.SourceRowTagXML := '';
   SELF.SourceMaxRecordSize := 8192;
   SELF.SourceCsvSeparate := ',';                                                                                  
   SELF.SourceCsvTerminate :='\n';                                                                                 
   SELF.SourceCsvQuote :='"';
   SELF.lzdate:=RIGHT.lzdate;
   SELF.thdate:=LEFT.thdate;
	 SELF:=LEFT;
	 SELF:=RIGHT;
	),FULL OUTER);


OUTPUT(ThorList,NAMED ('ThorList'));
OUTPUT(pthdedup,NAMED ('pthdedup'));
OUTPUT(plzdedup,NAMED ('plzdedup'));
OUTPUT(j,NAMED ('Join_Table'));
toSpray:=PROJECT(j(lzdate>thdate),VersionControl.Layout_Sprays.Info);
OUTPUT(toSpray,NAMED('ToSpray'));
t:=TABLE(toSpray,{sf:=dsuperfilenames[1].name}):GLOBAL(few); 
OUTPUT(t,NAMED('SuperTable'));

spray := VersionControl.fSprayInputFiles(toSpray,pOverwrite:=true,pIsTesting:=FALSE,pEmailSubjectDataset:='VendorSourceInfo_' + pVersion,pOutputName:='Vendor Source Info Spray Report',pShouldClearSuperfileFirst:= true);


   prepSuper := SEQUENTIAL(
   FS.StartSuperFileTransaction();
   NOTHOR(apply(t,SEQUENTIAL(
									 FS.ClearSuperfile('~'+TRIM(sf)+'_father',TRUE)
									,FS.addsuperfile('~'+TRIM(sf)+'_father','~'+TRIM(sf),,TRUE)
									,FS.ClearSuperfile('~'+TRIM(sf))
									
   												)
   												));
   FS.FinishSuperFileTransaction();
   );

   Go:= SEQUENTIAL(PrepSuper,spray);

  RETURN Go;
END;
