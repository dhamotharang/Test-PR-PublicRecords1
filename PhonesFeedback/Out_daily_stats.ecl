import ut,lib_stringlib; 

export Out_daily_stats(string rawfilename,string cleanfilename,string srctype) := module

//Rozlin files  
	export	string		FilesIP				:=	'edata12-bld.br.seisint.com';
	export	string		FilesLZDir		:=	'::hds_2::phones_feedback::sources::customer::'+srctype+'::';
	export	string		FilesLZName	:=	'~file::' + FilesIP + FilesLZDir  ;
	export  string    LZCleanFile := FilesLZName + 'clean::' + cleanfilename;
 

export	string Rawfileparse := map(regexfind('FMA',rawfilename) = true => regexreplace('FMAA',rawfilename,'^F^M^A^A'),
	                      regexfind('Monarch',rawfilename) = true => regexreplace('Monarch',rawfilename,'^Monarch'),
												regexfind('RFGI',rawfilename) = true => regexreplace('RFGI_PhoneDispositions',rawfilename,'^R^F^G^I_^Phone^Dispositions'),
												regexfind('Zenith',rawfilename) = true =>regexreplace('Zenith',rawfilename,'^Zenith'), rawfilename);



export string FullRawfpath := 	FilesLZName  + 'raw::' + ut.GetDate + '::' + Rawfileparse;

layout_payload := record
string payload;
end;

export InRawFName := dataset(FullRawfpath ,layout_payload,csv(terminator('\n'), separator('')));
					


export InCleanFName := dataset(LZCleanFile ,PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in,thor);

export string run_date := ut.getDate[5..6] + '/' + ut.getDate[7..8] + '/' + ut.getDate[1..4] + '     ' + ut.getTime()[1..2]+':'+ ut.getTime()[3..4] + ':' + ut.getTime()[5..6];
export string customerid := InCleanFName[1].customerid;
export string cust_name := map(regexfind('assetaccep',cleanfilename) = true => 'Asset Acceptance' ,
                                                         regexfind('ffam',cleanfilename) = true => 'First Financial Asset Management' ,
												                                 regexfind('Monarch',cleanfilename) = true => 'Monarch Recovery Management, Inc' ,
																												 regexfind('accutrac',cleanfilename) = true => 'Accutrac Developers',
												                                 regexfind('plaza',cleanfilename) = true =>  'Plaza Associates' ,
																												 regexfind('FMA',cleanfilename) = true =>  'FMAAlliance',
																												 regexfind('rozlin',cleanfilename) = true => 'Rozlin',
																												 regexfind('zenith',cleanfilename) = true => 'Zenith',
																												 '');	
																												 
																												 
export string25 JobName := map(regexfind('assetaccep',cleanfilename) = true => 'Asset Acceptance PhoneFeedback' ,
                                                         regexfind('ffam',cleanfilename) = true => 'First Financial Asset Management PhoneFeedback' ,
												                                 regexfind('Monarch',cleanfilename) = true => 'Monarch Recovery Management, Inc PhoneFeedback' ,
																												 regexfind('accutrac',cleanfilename) = true => 'Accutrac PhoneFeedback',
												                                 regexfind('plaza',cleanfilename) = true =>  'Plaza PhoneFeedback' ,
																												 regexfind('FMA',cleanfilename) = true =>  'FMAAlliance',
																												 regexfind('rozlin',cleanfilename) = true => 'Rozlin PhoneFeedback',
																												 regexfind('zenith',cleanfilename) = true => 'Zenith PhoneFeedback',
																												 '');
																												 
export string RawInputfilename := rawfilename;
export string CleanInputfilename := cleanfilename;


export  unsigned integer reccount := count(InRawFName);

shared unsigned integer reccount_new := count(InCleanFName);


export unsigned integer custcount := count(InCleanFName);




Valid_rec := record
InCleanFName.phone_contact_type;
integer count_ := count(group);
end;

export Valid_stat := sort(table(InCleanFName,Valid_rec,phone_contact_type,few),phone_contact_type);

Cust_rec := record
InCleanFName.customerid;
integer count_id := count(group);
end;

export CustID_stat := sort(table(InCleanFName,Cust_rec,customerid,few),customerid);
export unsigned integer countdiff := reccount - reccount_new;


end;



