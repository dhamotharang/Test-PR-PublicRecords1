//MATCHSET should be set of char1's indicating matchfields
/*	'A' = Address
	'F' = FEIN
	'P'	= phone
		* company name will always be part of the match if any of
		  the above flags are set.
	'N' = Allow match on company name only.
*/

import business_header;

EXPORT Business_Header_SS_MAC_Match_Flex
(
	 infile
	,matchset
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
	,BDID_Score_field				//these should default to zero in definition
	,outfile
	,bool_outrec_has_bestfein	= 'false'
	,bestfein_field					
	,keep_count							= '1'
	,score_threshold				= '75'
	,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.

) :=
MACRO
#uniquename(pBHFile						)
#uniquename(pBHBFile					)
#uniquename(pCnameAddressBase	)
#uniquename(pCnameFeinBase		)
#uniquename(pCnamePhoneBase		)
#uniquename(pCnameBase				)
// All files used by this macro + the files used by the macros that it calls
%pBHFile%								:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.Business_headers.logical			;
%pBHBFile%							:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.Business_Header_Best.logical	;
%pCnameAddressBase%			:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameAddress.logical		;
%pCnameFeinBase%				:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameFein.logical			;
%pCnamePhoneBase%				:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNamePhone.logical			;
%pCnameBase%						:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.CompanyName.logical					;

#uniquename(id_layout)
#uniquename(bdid_score)
#uniquename(name_similar_score)
%id_layout% := RECORD
	UNSIGNED6 temp_id := 0;
	UNSIGNED2 %bdid_score% := 0;
	UNSIGNED2 %name_similar_score% := 0;
	outrec;
END;

#uniquename(make_id_layout)
%id_layout% %make_id_layout%(infile l) := TRANSFORM
	SELF := l;
END;

#uniquename(infile_id_layout)
%infile_id_layout% := PROJECT(infile, %make_id_layout%(LEFT));

#uniquename(infile_seq)
ut.MAC_Sequence_Records(%infile_id_layout%, temp_id, %infile_seq%)

			
//*********************
//****** 		ROXIE route
//*********************

#uniquename(roxprep)
business_header_ss.Layout_BDID_InBatch %roxprep%(%infile_seq% l) := transform
	#if('F' in matchset)
		self.fein := (qSTRING9)l.fein_field;
	#else
		self.fein := '';
	#end
	#if('A' in matchset)
		self.prim_range := (qSTRING10)l.prange_field;
		self.prim_name := (qSTRING28)l.pname_field;
		self.sec_range := (qSTRING8)l.srange_field; 
		self.z5 := (qSTRING5)l.zip_field;
		self.st := (qSTRING2)l.state_field;
	#else
		self.prim_range := '';
		self.prim_name := '';
		self.sec_range := '';
		self.z5 := '';
		self.st := '';
	#end
	#if('P' in matchset)
		self.phone10 := (qstring10)l.phone_field;
	#else
		self.phone10 := '';
	#end
	self.seq := l.temp_id;
	self.company_name := (qstring120)l.company_name_field;
end;

#uniquename(roxin)
%roxin% := distribute(project(%infile_seq%, %roxprep%(left)),hash(random()));

#uniquename(roxout)
Business_Header_Mac_BDID_Roxie(%roxin%, %roxout%, , , ,'10') //** thread use upped to 40 for 10 node logs/logs fcra thor

//** Reappend the full rec
#uniquename(postrox)
typeof(%infile_seq%) %postrox%(%infile_seq% l, %roxout% r) := transform
	self.bdid_field := r.bdid;
	self.%bdid_score% := r.score;

	#if(bool_outrec_has_bestfein)
	//** Append best FEIN here
	self.bestfein_field := r.best_fein;
	#end
	
	self := l;
end;


#uniquename(roxplus)
%roxplus% := join(%infile_seq%, %roxout%,
				left.temp_id = right.seq,
				%postrox%(left, right), 
				hash);

#uniquename(strip_id_roxie)
outrec %strip_id_roxie%(%roxplus% L) := transform
	self.bdid_field := if(L.%bdid_score% >= score_threshold, L.bdid_field, 0);
	self.bestfein_field := if(self.bdid_field > 0, L.bestfein_field, '');
	#if(bool_outrec_has_score)
		SELF.BDID_score_field := if(L.%bdid_score% >= score_threshold, l.%bdid_score%, 0);
	#end
	self := L;
end;

#uniquename(outrox)
%outrox% := project(%roxplus%,%strip_id_roxie%(LEFT));

//****** Pick which route to go
#uniquename(force)
string4 %force% := '' : stored('did_add_force');

#uniquename(preclean)

outfile := %outrox%;


ENDMACRO;