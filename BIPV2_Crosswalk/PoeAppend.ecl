import poe,Business_Header_SS,Business_Header;

export PoeAppend(set of string ignoreSources) := function
     poeData := poe.files(,true).base.qa(subject_name.lname!='' and source not in ignoreSources);

     appendRec := record
	     poeData;
	     string email_address := '';
	     unsigned8 source_record_id := 0;
	     unsigned6 proxid := 0;
	     unsigned6 proxweight := 0;
	     unsigned6 proxscore := 0;
	     unsigned6 seleid := 0;
	     unsigned6 seleweight := 0;
	     unsigned6 selescore := 0;
	     unsigned6 lgid3 := 0;
	     unsigned6 lgid3weight := 0;
	     unsigned6 lgid3score := 0;
	     unsigned6 orgid := 0;
	     unsigned6 orgweight := 0;
	     unsigned6 orgscore := 0;
	     unsigned6 powid := 0;
	     unsigned6 powweight := 0;
	     unsigned6 powscore := 0;
	     unsigned6 empid := 0;
	     unsigned6 empweight := 0;
	     unsigned6 empscore := 0;
	     unsigned6 dotid := 0;
	     unsigned6 dotweight := 0;
	     unsigned6 dotscore := 0;
	     unsigned6 ultid := 0;
	     unsigned6 ultweight := 0;
	     unsigned6 ultscore := 0;
	     string company_phone_str;
		string company_fein_str;
		string contact_ssn_str;
     end;

     appendDs := project(poeData, transform(appendRec, 
	                                       self.company_phone_str := (string) left.company_phone, 
	                                       self.company_fein_str  := (string) left.company_fein, 
	                                       self.contact_ssn_str   := (string) left.subject_ssn, 
								    self := left, self := []));
  
     Business_Header_SS.MAC_Match_Flex_V2(
           appendDs  // infile
          ,['A','F','P'] // match set &apos;A&apos; = Address, &apos;F&apos; = FEIN, &apos;P&apos; = phone (company name will always be part of the match if any of the above flags are set), &apos;N&apos; = Allow match on company name only.
          ,company_name
          ,company_address.prim_range
          ,company_address.prim_name
          ,company_address.zip
          ,company_address.sec_range
          ,company_address.st
          ,company_phone_str
          ,company_fein_str
          ,bdid
          ,RECORDOF(appendDs) // out record layout
          ,FALSE // out record layout has score
          ,bdid_score // should default to zero in definition
          ,ds_output // outfile
          , // keep count = 1
          , // score threshold = 75
          , // file version = prod superfiles
          , // use other environment = hit prod on dataland
          ,[BIPV2.IDconstants.xlink_version_BIP] // linking versions
          , // URL
          ,email_address
          ,company_address.city_name
          ,subject_name.fname
          ,subject_name.mname
          ,subject_name.lname
          ,contact_ssn_str
          ,source
          ,source_record_id
     );
	
	return ds_output(seleid>0);
end;