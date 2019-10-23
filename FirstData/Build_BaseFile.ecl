IMPORT FirstData, header, ut, PromoteSupers,VersionControl, address, STD;

EXPORT Build_BaseFile(STRING	pVersion	=	(STRING)STD.Date.Today()) := MODULE

	//FirstData input file 
	ds_firstdata_in := FirstData.Files().file_in;
	
  file_name	:=	FirstData.Filenames().Input.Raw.Using;
	file_date := IF(VersionControl.fGetFilenameVersion(file_name)>0,
															(STRING)VersionControl.fGetFilenameVersion(file_name)
														,pVersion
														);

	FirstData.layout.base xformToCommon(ds_firstdata_in l) := TRANSFORM
    SELF.PROCESS_DATE    := thorlib.wuid()[2..9];
		SELF.filedate    := (string10)file_date;
		TrimFirstDate := ut.CleanSpacesAndUpper(L.FIRST_SEEN_DATE_TRUE);
		SELF.FIRST_SEEN_DATE_TRUE := IF(length(TrimFirstDate) = 7,TrimFirstDate[4..7] + '0'+TrimFirstDate[1] + TrimFirstDate[2..3],
		                          IF(length(TrimFirstDate) = 8,TrimFirstDate[5..8] + TrimFirstDate[1..2] + TrimFirstDate[3..4], ''));
		TrimLastDate  := ut.CleanSpacesAndUpper(L.LAST_SEEN_DATE);
		SELF.LAST_SEEN_DATE := IF(length(TrimLastDate) = 7,TrimLastDate[4..7] + '0'+TrimLastDate[1] + TrimLastDate[2..3],
		                          IF(length(TrimLastDate) = 8,TrimLastDate[5..8] + TrimLastDate[1..2] + TrimLastDate[3..4],''));
		SELF := L;
		SELF := [];
	END;

	EXPORT dsClean				:=	project(ds_firstdata_in,xformToCommon(left));

	ds_firstdata_base_in := Firstdata.Files().file_base;
	ds_firstdata_base	   := ds_firstdata_base_in + dsClean;

  VersionControl.macBuildNewLogicalFile(Filenames(pVersion).base.firstdata.new, ds_firstdata_base, Build_FirstDataBase_File		,TRUE);

	EXPORT	full_build	:=
				SEQUENTIAL(
					Promote(pversion).inputfiles.Sprayed2Using
					,Build_FirstDataBase_File
					,Promote(pversion).Inputfiles.Using2Used
					,Promote(pversion, 'base').buildfiles.New2Built
					,Promote(pversion, 'base').buildfiles.Built2QA	
				);
				
	EXPORT	ALL	:=
	IF(VersionControl.IsValidVersion(pversion)
		, full_build
		,output('No Valid version parameter passed, skipping FirstData.Build_Basefiles().All attribute')
	);

END;