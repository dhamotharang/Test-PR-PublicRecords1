import ut,STD, lib_fileservices;

//Run on regular thor, not hthor
export name_rec := record
	  string	first_name		{xpath('firstname')};
		string	middle_initial{xpath('middleinitial')};
		string	last_name			{xpath('lastname')};
		string	full_name			{xpath('fullname')};
		string	company_name	{xpath('companyname')};
end;


export add_rec := record
	string	address_line1	{xpath('addressline1')};
		string	address_line2	{xpath('addressline2')};
		string	city					{xpath('city')};
		string	state					{xpath('state')};
		string	zip						{xpath('postalcode')};
		string	country				{xpath('countrycode')};
end;

export phone_rec := record
	string	phone					{xpath('phone10')};
end;

export	Main_new	:=
	record
		string	file_date			{xpath('file_date')};
		string	record_id			{xpath('record_id')};
		string	record_type		{xpath('record_type')};
		dataset(name_rec) names {xpath('name')};
		dataset(add_rec) addresses {xpath('address')};
		//dataset(add_rec) phone {xpath('phone_rec')};
		{ string phone{xpath('phone10')} } phone{xpath('phone')};
	end;
	
string					vCorrectionsCSVSeparator				:=	',';
string					vCorrectionsCSVQuote						:=	'"';
string					vCorrectionsCSVTerminator				:=	'\n';
string					vCorrectionsLogicalFileName			:=	FedEx.constants.cluster	+	'in::fedex::nohit::'+	ut.GetDate;
string					vCorrectionsSuperFileName				:=	'~thor_200::in::fedex::nohit';		 
set	of	string	sCorrectionsCSVTerminator				:=	['\r\n','\n'];
	 
 
    MainD			:=	dataset('~thor_200::in::fedex::nohit',
																			Main_new,
																		xml('addressupdate/records/record'),
																		__COMPRESSED__
																	);
   
	 MainDist := distribute(MainD);
   output(MainDist,,'~thor400_20::in::consolidated::fedex::nohit_' + ut.GetDate,xml('record',heading('<addressupdate>\n<records>\n','</records>\n</addressupdate>\n')),CLUSTER('thor400_20'),all,compressed,overwrite);
   
                                                            
																														
      sequential(
       nothor(FileServices.StartSuperFileTransaction())
      ,nothor(FileServices.clearSuperFile('~thor_200::in::fedex::nohit'))
      ,nothor(FileServices.AddSuperFile('~thor_200::in::fedex::nohit','~thor400_20::in::consolidated::fedex::nohit_' +ut.GetDate+''))
      ,nothor(FileServices.FinishSuperFileTransaction()
      ));
