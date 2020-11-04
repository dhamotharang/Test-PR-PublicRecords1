import business_header, bipv2,_control;
EXPORT MAC_Match_Flex_V2
(
   infile
  ,matchset             //defined in Business_Header_SS.MAC_Add_BDID_FLEX
  ,company_name_field
  ,prange_field
  ,pname_field
  ,zip_field
  ,srange_field
  ,state_field
  ,phone_field
  ,fein_field
  ,BDID_field
  ,outrec
  ,bool_outrec_has_score
  ,BDID_Score_field       //these should default to zero in definition
  ,outfile2
  ,keep_count             = '1'
  ,score_threshold        = '75'
  
  //not quite sure if i need these next two
  ,pFileVersion           = '\'prod\''                            // default to use prod version of superfiles
  ,pUseOtherEnvironment   = business_header._Dataset().IsDataland // default is to hit prod on dataland, and on prod hit prod.
  ,pSetLinkingVersions    = BIPV2.IDconstants.xlink_versions_default  //
  ,pURL                   = ''
  ,pEmail                 = ''
  ,pCity                  = ''
  ,pContact_fname         = ''
  ,pContact_mname         = ''
  ,pContact_lname         = ''
  ,pContact_ssn            = ''
  ,pSource                 = ''
  ,pSource_record_id       = ''
  ,src_matching_is_priority = FALSE
) :=
MACRO

import BIPV2;

#uniquename(rec_id);

#uniquename(infileWithRequestId);
// add request_id to infile so it can be used to join later
%infileWithRequestId% := project(infile, transform({recordof(left), unsigned %rec_id%}, self.%rec_id% := counter, self := left));

#uniquename(appendInput);
// project to append input layout
%appendInput% :=
	project(%infileWithRequestId%,
		transform(BIPV2.IdAppendLayouts.AppendInput,
			self.request_id := left.%rec_id%;
			self.company_name := left.company_name_field;
			#if('A' in matchset)
				self.prim_range := left.prange_field;
				self.prim_name := left.pname_field;
				self.sec_range := left.srange_field;
				self.state := left.state_field;
				self.zip5 := left.zip_field;
				#if(#text(pCity) != '')
					self.city := left.pCity;
				#else
					self.city := '';
				#end
			#else
				self.prim_range := '';
				self.prim_name := '';
				self.sec_range := '';
				self.city := '';
				self.state := '';
				self.zip5 := '';
			#end
			#if('P' in matchset and #text(phone_field) != '')
				self.phone10 := (typeof(self.phone10)) left.phone_field;
			#else
				self.phone10 := '';
			#end
			#if('F' in matchset and #text(fein_field) != '')
				self.fein := (typeof(self.fein)) left.fein_field;
			#else
				self.fein := '';
			#end;
			#if(#text(pUrl) != '')
				self.url := left.pUrl;
			#else
				self.url := '';
			#end
			#if(#text(pEmail) != '')
				self.email := left.pEmail;
			#else
				self.email := '';
			#end
			#if(#text(pContact_fname) != '')
				self.contact_fname := left.pContact_fname;
			#else
				self.contact_fname := '';
			#end
			#if(#text(pContact_mname) != '')
				self.contact_mname := left.pContact_mname;
			#else
				self.contact_mname := '';
			#end
			#if(#text(pContact_lname) != '')
				self.contact_lname := left.pContact_lname;
			#else
				self.contact_lname := '';
			#end
			#if(#text(pContact_ssn) != '')
				self.contact_ssn := (typeof(self.contact_ssn)) left.pContact_ssn;
			#else
				self.contact_ssn := '';
			#end
			#if(#text(pSource) != '')
				self.source := left.pSource;
			#else
				self.source := '';
			#end
			#if(#text(pSource_record_id) != '')
				self.source_record_id := (typeof(self.source_record_id)) left.pSource_record_id;
			#else
				self.source_record_id := 0;
			#end
			self := [];
	));

#uniquename(appendMod);
// run append
%appendMod% := BIPV2.IdAppendThor(%appendInput%,
                                  scoreThreshold := score_threshold 
                                  );
#uniquename(withAppend);
%withAppend% := %appendMod%.IdsOnly();

// join with infile by append request id
outfile2 :=
	join(%infileWithRequestId%, %withAppend%,
		left.%rec_id% = right.request_id,
		transform(outrec,
			self.proxid := right.proxid;
			self.proxweight := right.proxweight;
			self.proxscore := right.proxscore;

			self.seleID := right.SELEid;
			self.SELEweight := right.SELEweight, 
			self.SELEscore := right.SELEscore,       

			self.orgid := right.orgid;
			self.orgweight := right.orgweight,  
			self.orgscore := right.orgscore,

			self.ultid := right.ultid;
			self.ultweight := right.ultweight,  
			self.ultscore := right.ultscore,  

			self.powid := RIGHT.powid,
			self.powweight := RIGHT.powweight,
			self.powscore := RIGHT.powscore,   

			//*** Empty values
			self.dotid := 0;
			self.dotweight := 0;
			self.dotscore := 0;

			self.empid := 0,
			self.empweight := 0,
			self.empscore := 0, 

			self := left;
		), keep(keep_count), hash);


ENDMACRO;
