import _control;

/* DFUInfoRequest XML
<DFUInfoRequest>
	<Name>thor_data50::in::worldcheck_piped</Name>
	<Cluster></Cluster>
	<UpdateDescription>0</UpdateDescription>
	<FileName></FileName>
	<FileDesc></FileDesc>
</DFUInfoRequest>
DFUInfoRequest XML */

/* DFUInfoResponse XML
<DFUInfoResponse>
	<Exceptions>
		<Exception>
			<Code>String</Code> 
			<Audience>String</Audience> 
			<Source>String</Source> 
			<Message>String</Message> 
		</Exception>
		<Exception>
			<Code>String</Code> 
			<Audience>String</Audience> 
			<Source>String</Source> 
			<Message>String</Message> 
		</Exception>
  </Exceptions>
	<FileDetail>
		<Name>String</Name> 
		<Filename>String</Filename> 
		<Description>String</Description> 
		<Dir>String</Dir> 
		<PathMask>String</PathMask> 
		<Filesize>String</Filesize> 
		<ActualSize>String</ActualSize> 
		<RecordSize>String</RecordSize> 
		<RecordCount>String</RecordCount> 
		<Wuid>String</Wuid> 
		<Owner>String</Owner> 
		<Cluster>String</Cluster> 
		<JobName>String</JobName> 
		<Persistent>String</Persistent> 
		<Format>String</Format> 
		<MaxRecordSize>String</MaxRecordSize> 
		<CsvSeparate>String</CsvSeparate> 
		<CsvQuote>String</CsvQuote> 
		<CsvTerminate>String</CsvTerminate> 
		<Modified>String</Modified> 
		<Ecl>String</Ecl> 
		<ZipFile>false</ZipFile> 
		<Stat>
			<MinSkew>String</MinSkew> 
			<MaxSkew>String</MaxSkew> 
		</Stat>
		<DFUFileParts>
			<DFUPart>
				<Id>0</Id> 
				<Copy>0</Copy> 
				<ActualSize>String</ActualSize> 
				<Ip>String</Ip> 
				<Partsize>String</Partsize> 
			</DFUPart>
			<DFUPart>
				<Id>0</Id> 
				<Copy>0</Copy> 
				<ActualSize>String</ActualSize> 
				<Ip>String</Ip> 
				<Partsize>String</Partsize> 
			</DFUPart>
		</DFUFileParts>
		<isSuperfile>false</isSuperfile> 
		<ShowFileContent>true</ShowFileContent> 
		<subfiles>
			<Item>String</Item> 
			<Item>String</Item> 
		</subfiles>
		<Superfiles>
			<DFULogicalFile>
				<Prefix>String</Prefix> 
				<ClusterName>String</ClusterName> 
				<Directory>String</Directory> 
				<Description>String</Description> 
				<Parts>String</Parts> 
				<Name>String</Name> 
				<Owner>String</Owner> 
				<Totalsize>String</Totalsize> 
				<RecordCount>String</RecordCount> 
				<Modified>String</Modified> 
				<LongSize>String</LongSize> 
				<LongRecordCount>String</LongRecordCount> 
				<isSuperfile>false</isSuperfile> 
				<isZipfile>false</isZipfile> 
				<isDirectory>false</isDirectory> 
				<Replicate>false</Replicate> 
				<IntSize>2147483647</IntSize> 
				<IntRecordCount>2147483647</IntRecordCount> 
				<FromRoxieCluster>false</FromRoxieCluster> 
				<BrowseData>false</BrowseData> 
			</DFULogicalFile>
			<DFULogicalFile>
				<Prefix>String</Prefix> 
				<ClusterName>String</ClusterName> 
				<Directory>String</Directory> 
				<Description>String</Description> 
				<Parts>String</Parts> 
				<Name>String</Name> 
				<Owner>String</Owner> 
				<Totalsize>String</Totalsize> 
				<RecordCount>String</RecordCount> 
				<Modified>String</Modified> 
				<LongSize>String</LongSize> 
				<LongRecordCount>String</LongRecordCount> 
				<isSuperfile>false</isSuperfile> 
				<isZipfile>false</isZipfile> 
				<isDirectory>false</isDirectory> 
				<Replicate>false</Replicate> 
				<IntSize>2147483647</IntSize> 
				<IntRecordCount>2147483647</IntRecordCount> 
				<FromRoxieCluster>false</FromRoxieCluster> 
				<BrowseData>false</BrowseData> 
			</DFULogicalFile>
		</Superfiles>
	</FileDetail>
  </DFUInfoResponse>
DFUInfoResponse XML */

export DFUInfo(string pFileName)
 :=
  module
	shared	lSoapVersion	:=	'ver_=1.04';

	shared	rDFUInfo_Input
	 :=
	  record,maxlength(1024)
		string		Name{xpath('Name')}								:=	pFileName;		//	<Name>String</Name>
		string		Cluster{xpath('Cluster')}						:=	'';				//	<Cluster>String</Cluster> 
		string		UpdateDescription{xpath('UpdateDescription')}	:=	'0';			//	<UpdateDescription>false</UpdateDescription> 
		string		FileName{xpath('FileName')}						:=	'';				//	<FileName>String</FileName>
		string		FileDesc{xpath('FileDesc')}						:=	'';				//	<FileDesc>String</FileDesc> 
	  end
	 ;

	shared	rExceptions
	 :=
	  record,maxlength(1024)
		string		Code{xpath('Code')};							//	<Code>String</Code> 
		string		Audience{xpath('Audience')};					//	<Audience>String</Audience> 
		string		Source{xpath('Source')};						//	<Source>String</Source> 
		string		Message{xpath('Message')};						//	<Message>String</Message> 
	  end
	 ;

	shared	rDFUInfo_FileDetail_Stat
	 :=
	  record,maxlength(256)
		string		MinSkew{xpath('MinSkew')};
		string		MaxSkew{xpath('MaxSkew')};
	  end
	 ;

	export	rFileParts
	 :=
	  record,maxlength(512)
		unsigned2		ID{xpath('Id')};
		unsigned2		Copy{xpath('Copy')};
		string			ActualSize{xpath('ActualSize')};
		string			IP{xpath('Ip')};
		string			Partsize{xpath('Partsize')};
	  end
	 ;

	shared	rDFUInfo_FileDetail_SubFiles
	 :=
	  record,maxlength(512)
		string			Item{xpath('')};
	  end
	 ;

	shared	rDFUInfo_FileDetail_SuperFiles
	 :=
	  record,maxlength(4096)
		string			Prefix{xpath('Prefix')};
		string			ClusterName{xpath('ClusterName')};
		string			Directory{xpath('Directory')};
		string			Description{xpath('Description')};
		string			Parts{xpath('Parts')};
		string			Name{xpath('Name')};
 		string			Owner{xpath('Owner')};
   		string			Totalsize{xpath('Totalsize')};
   		string			RecordCount{xpath('RecordCount')};
   		string			Modified{xpath('Modified')};
   		string			LongSize{xpath('LongSize')};
   		string			LongRecordCount{xpath('LongRecordCount')};
   		boolean			IsSuperFile{xpath('isSuperfile')};
   		boolean			IsZipFile{xpath('isZipfile')};
   		boolean			IsDirectory{xpath('isDirectory')};
   		boolean			Replicate{xpath('Replicate')};
   		string			IntSize{xpath('IntSize')};
   		string			IntRecordCount{xpath('IntRecordCount')};
   		boolean			FromRoxieCluster{xpath('FromRoxieCluster')};
   		boolean			BrowseDate{xpath('BrowseData')};
	  end
	 ;

	export	rFileDetail
	 :=
	  record,maxlength(32768)
		string		Name{xpath('Name')};
		string		Filename{xpath('Filename')};
		string		Description{xpath('Description')};
		string		Dir{xpath('Dir')};
		string		PathMask{xpath('PathMask')};
		string		Filesize{xpath('Filesize')};
		string		ActualSize{xpath('ActualSize')};
		string		RecordSize{xpath('RecordSize')};
		string		RecordCount{xpath('RecordCount')};
		string		Wuid{xpath('Wuid')};
		string		Owner{xpath('Owner')};
		string		Cluster{xpath('Cluster')};
		string		JobName{xpath('JobName')};
		boolean		Persistent{xpath('Persistent')};
		string		Format{xpath('Format')};
		string		MaxRecordSize{xpath('MaxRecordSize')};
		string		CsvSeparate{xpath('CsvSeparate')};
		string		CsvQuote{xpath('CsvQuote')};
		string		CsvTerminate{xpath('CsvTerminate')};
		string		Modified{xpath('Modified')};
		string		Ecl{xpath('Ecl')};
		boolean		ZipFile{xpath('ZipFile')};						//	<ZipFile>false</ZipFile>
		boolean		IsSuperFile{xpath('isSuperfile')};				//	<isSuperfile>false</isSuperfile>
		boolean		ShowFileContent{xpath('ShowFileContent')};		//	<ShowFileContent>true</ShowFileContent>
		string		MinSkew{xpath('Stat/MinSkew')};					//	In lieu of rDFUInfo_FileDetail_Stat	Stat{xpath('Stat')};
		string		MaxSkew{xpath('Stat/MaxSkew')};					//	In lieu of rDFUInfo_FileDetail_Stat	Stat{xpath('Stat')};
		/* NOTE:  Commented record segment may be collapsed here
		dataset(rDFUInfo_FileDetail_FileParts)		FileParts{xpath('DFUFileParts/DFUPart')};
		dataset(rDFUInfo_FileDetail_SubFiles)		SubFiles{xpath('subfiles')};
		dataset(rDFUInfo_FileDetail_SuperFiles)		SuperFiles{xpath('Superfiles/DFULogicalFile')};
		*/
	  end
	 ;

	shared	rDFUInfo_Response
	 :=
	  record,maxlength(32768)
		dataset(rExceptions)						Exceptions{xpath('Exceptions/Exception')};
		rFileDetail									FileDetail{xpath('FileDetail')};
	  end
	 ;

	export	rFileDetail	dFileDetail
			 :=
			  soapcall('http://' + _control.ThisEnvironment.ESP_IPAddress + ':8010/WsDFU?' + lSOAPVersion,
					   'DFUInfo',
					   rDFUInfo_Input,
					   rFileDetail,
					   xpath('DFUInfoResponse/FileDetail')
					  );

	export	string	GetCreationWUID
	 :=
	  function
		return	dFileDetail.WUID;
	  end
	 ;

	export	string	GetCreationJobName
	 :=
	  function
		return	dFileDetail.JobName;
	  end
	 ;

	export	string	GetOwner
	 :=
	  function
		return	dFileDetail.Owner;
	  end
	 ;

	export	string	GetCluster
	 :=
	  function
		return	dFileDetail.Cluster;
	  end
	 ;

	export	string	GetRecordCount
	 :=
	  function
		return	dFileDetail.RecordCount;
	  end
	 ;

	export	boolean	IsCompressed
	 :=
	  function
		return	dFileDetail.ZipFile or dFileDetail.Persistent;
	  end
	 ;

	export	boolean	IsSuper
	 :=
	  function
		return	dFileDetail.IsSuperFile;
	  end
	 ;

	export	dataset(rFileParts)	dFileParts
			 :=
			  soapcall('http://' + _control.ThisEnvironment.ESP_IPAddress + ':8010/WsDFU?' + lSOAPVersion,
					   'DFUInfo',
					   rDFUInfo_Input,
					   dataset(rFileParts),
					   xpath('DFUInfoResponse/FileDetail/DFUFileParts/DFUPart')
					  );

	export	boolean	IsIndex
	 :=
	  function
		boolean		lNameContainsKey	:=	regexfind('::key::',pFileName);
		unsigned2	lFileParts			:=	max(dFileParts,(unsigned2)ID);
		return	(lNameContainsKey and (lFileParts % 10 = 1)) or (lFileParts in [1, 51, 101, 201, 401]);
	  end
	 ;

  end
 ;

