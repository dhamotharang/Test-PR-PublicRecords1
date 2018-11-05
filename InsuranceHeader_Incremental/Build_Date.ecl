IMPORT did_add, STD,Data_Services,InsuranceHeader_Ingest,dops,InsuranceHeader_xLink; 

EXPORT Build_Date := MODULE

  Alphalogical       := NOTHOR(STD.File.GetSuperFileSubName(Data_Services.foreign_prod + 'thor_data400::key::insuranceheader_xlink::qa::header',1));
EXPORT AlphaKeyFull  := Alphalogical[STD.Str.Find(Alphalogical,'_xlink',1) + 8..STD.Str.Find(Alphalogical,'idl',1)-3];

  Bocalogical        := NOTHOR(STD.File.GetSuperFileSubName(Data_Services.foreign_prod + 'thor_data400::key::insuranceheader_xlink::qa::did::refs::name',1));
EXPORT BocaKeyFull   := Bocalogical[STD.Str.Find(Bocalogical,'_xlink',1) + 8..STD.Str.Find(Bocalogical,'::did',1)-1];

//EXPORT AlphaDops   := (UNSIGNED)did_add.get_EnvVariable('iheader_build_version','http://Iroxievip.sc.seisint.com:9876');
EXPORT AlphaDops     := (UNSIGNED) SORT(dops.GetReleaseHistory('A','N','IHeaderLABKeys')(updateflag = 'F' and prodversion <> 'NA'),-prodversion)[1].prodversion;
       
			 IngestFilename := NOTHOR(STD.File.GetSuperFileSubName(InsuranceHeader_Ingest.FileNames.AsHeaderAll_SF.current,1));
EXPORT IngestDateFull := IngestFilename[STD.Str.Find(IngestFilename,'_all',1) + 6..STD.Str.Find(IngestFilename,'_w',1)-1];

       IngestIncFilename := NOTHOR(STD.File.GetSuperFileSubName(InsuranceHeader_Incremental.Filenames.AsHeader_SF.current,1));
EXPORT IngestIncDate  := IngestIncFilename[STD.Str.Find(IngestIncFilename,'_w',1) + 2..STD.Str.Find(IngestIncFilename,'-',1)-1];

       BaseFilename := NOTHOR(STD.File.GetSuperFileSubName('~thor_data400::base::insuranceheader::idl_policy_header',1));
EXPORT BaseDate     := BaseFilename[STD.Str.Find(BaseFilename,'_w',1) + 2..STD.Str.Find(BaseFilename,'-',1)-1];

        BocaFilename  := NOTHOR(STD.File.GetSuperFileSubName(Data_Services.foreign_prod + 'thor_data400::base::header_raw',1));
EXPORT	BocaRaw       := BocaFilename[STD.Str.Find(BocaFilename,'raw_',1) + 4..];

EXPORT  BocaDopsOrig  := (UNSIGNED)did_add.get_EnvVariable('header_build_version','http://roxiebatch.br.seisint.com:9856');
EXPORT  BocaDops      := Files.BuildDate_Current_DS(BocaRawDate = BocaDopsOrig)[1].AlphaRawDate; 

  childFiles := NOTHOR(STD.File.SuperFileContents(InsuranceHeader_xLink.KeyNames().header_super, TRUE));
  Layout_modifyDate := RECORD
    RECORDOF(childFiles);
    STRING modifyDate;
  END;
  Layout_modifyDate xModified(childFiles L) := TRANSFORM
     SELF.modifyDate   := L.name[STD.Str.Find(L.name,'_xlink',1) + 8..IF(STD.Str.Find(L.name,'did',1)> 0 , STD.Str.Find(L.name,'did',1), STD.Str.Find(L.name,'idl',1)) -3]; 
		SELF := L;
  END;
  Incrementallogical := NOTHOR(PROJECT(childFiles, xModified(LEFT)))(STD.Str.Find(modifyDate,'i',1)>1);
EXPORT deltaversion := (UNSIGNED) Incrementallogical[1].modifyDate[1..8]+1 ;
	
END; 	