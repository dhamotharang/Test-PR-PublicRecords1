import _control,std;
#option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_DFUInfo(string filename = '',string cluster,string pesp = _constants.LocalEsp) :=
module

	export DFUInfoRequest :=
	record, maxlength(100)
		string  Name              {xpath('Name'               )} := filename;
		string  Cluster           {xpath('Cluster'            )} := cluster;
		string  UpdateDescription {xpath('UpdateDescription'  )} := '0';
		string  FileName          {xpath('FileName'           )} := '';
		string  FileDesc          {xpath('FileDesc'           )} := '';
	end;
	
	export DFUInfoOutRecord :=
	record, maxlength(100000)
	
		string exception_code     {xpath('Exceptions/Exception/Code'   )};
		string exception_source   {xpath('Exceptions/Exception/Source' )};
		string exception_msg      {xpath('Exceptions/Exception/Message')};
		string Name               {xpath('FileDetail/Name'             )};
		string Filename           {xpath('FileDetail/Filename'         )};
		string Description        {xpath('FileDetail/Description'      )};
		string Dir                {xpath('FileDetail/Dir'              )};
		string PathMask           {xpath('FileDetail/PathMask'         )};
		string Filesize           {xpath('FileDetail/Filesize'         )};
		string ActualSize         {xpath('FileDetail/ActualSize'       )};
		string RecordSize         {xpath('FileDetail/RecordSize'       )};
		string RecordCount        {xpath('FileDetail/RecordCount'      )};
		string Wuid               {xpath('FileDetail/Wuid'             )};
		string Owner              {xpath('FileDetail/Owner'            )};
		string Cluster            {xpath('FileDetail/Cluster'          )};
		string JobName            {xpath('FileDetail/JobName'          )};
		string Persistent         {xpath('FileDetail/Persistent'       )};
		string Format             {xpath('FileDetail/Format'           )};
		string MaxRecordSize      {xpath('FileDetail/MaxRecordSize'    )};
		string CsvSeparate        {xpath('FileDetail/CsvSeparate'      )};
		string CsvQuote           {xpath('FileDetail/CsvQuote'         )};
		string CsvTerminate       {xpath('FileDetail/CsvTerminate'     )};
		string CsvEscape          {xpath('FileDetail/CsvEscape'        )};
		string Modified           {xpath('FileDetail/Modified'         )};
		string Ecl                {xpath('FileDetail/Ecl'              )};	
  
	end;

	export DFUInfo := 
	function
	
		esp				:= pesp + ':8010';	//oss is 242,infiniband is '10.241.3.242'

		results := SOAPCALL(
			'http://' + esp + '/WsDfu?ver_=1.48'
			,'DFUInfo'
			,DFUInfoRequest
			,dataset(DFUInfoOutRecord)
			,xpath('DFUInfoResponse')
		);
    
		return results;
		
	end;
  
  export layout := DFUInfo()[1].Ecl;

end;