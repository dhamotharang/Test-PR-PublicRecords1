export Parse_Input :=
module
	/////////////////////////////////////////////////////////////////////////
	// -- Modify XML to work on thor
	/////////////////////////////////////////////////////////////////////////
	export PreProcess(
		
		dataset(layouts.Input.Sprayed) pInputFile	= Files().input.using
	
	) :=
	function
		
		layouts.Input.Sprayed tPreProcess(layouts.Input.Sprayed l) :=
		transform

			self.line := '<DOCUMENT>' + regexreplace('<[?]xml version="1.0" standalone="no"[?]>|<DOCUMENT .*?>|<!DOCTYPE DOCUMENT .*?]>|&[^ ;]*?;', l.line, ' ')  + '</DOCUMENT>';

		end;

		dPreProcess := project(pInputFile, tPreProcess(left));
		
		return dPreProcess;

	end;

	export Organizations(dataset(layouts.Input.Sprayed) pInputFile) :=
	function

		org_records := pInputFile(regexfind('<ORG>', line));

		layouts.Input.Parsed.Organizations tParseOrg :=
		transform
				self.CONTACT                                                        := xmltext('CONTACT');
				self.CONTACT_BLDG                                                   := xmltext('CONTACT/BLDG');
				self.CONTACT_CITY                                                   := xmltext('CONTACT/CITY');
				self.CONTACT_COUNTRY                                                := xmltext('CONTACT/COUNTRY');
				self.CONTACT_COUNTY_COUNTY_NAME                                     := xmltext('CONTACT/COUNTY/COUNTY.NAME'[1]);
				self.CONTACT_COUNTY_PHRASE                                          := xmltext('CONTACT/COUNTY/PHRASE');
				self.CONTACT_EMAILS_EMAIL                                           := xmltext('CONTACT/EMAILS/EMAIL');
				self.CONTACT_EMAILS_EMAIL_ADDR                                      := xmltext('CONTACT/EMAILS/EMAIL/ADDR');
				self.CONTACT_FAXS_FAX                                               := xmltext('CONTACT/FAXS/FAX');
				self.CONTACT_FAXS_FAX_NUMBER                                        := xmltext('CONTACT/FAXS/FAX/NUMBER');
				self.CONTACT_PHONES_PHONE                                           := xmltext('CONTACT/PHONES/PHONE');
				self.CONTACT_PHONES_PHONE_NUMBER                                    := xmltext('CONTACT/PHONES/PHONE/NUMBER');
				self.CONTACT_POBOX                                                  := xmltext('CONTACT/POBOX');
				self.CONTACT_STATE                                                  := xmltext('CONTACT/STATE');
				self.CONTACT_STREET                                                 := xmltext('CONTACT/STREET');
				self.CONTACT_URLS_URL_ADDR                                          := xmltext('CONTACT/URLS/URL/ADDR');
				self.CONTACT_URLS_URL_HOTLINK                                       := xmltext('CONTACT/URLS/URL/HOTLINK');
				self.CONTACT_XREFTEXT                                               := xmltext('CONTACT/XREFTEXT');
				self.CONTACT_ZIP                                                    := xmltext('CONTACT/ZIP');
				self.ESTABLISH                                                      := xmltext('ESTABLISH');
				self.FORMERLY                                                       := xmltext('FORMERLY');
				self.HEADER_AFF_INDIV							                      						:= xmlproject('HEADER/AFF.INDIV',transform(Layouts.Input.Parsed.Affiliated_Individuals
					,
					self.HEADER_AFF_INDIV_ARMEDFORCES                                   := xmltext('ARMEDFORCES');
					self.HEADER_AFF_INDIV_CORPTITLE                                     := xmltext('CORPTITLE');
					self.HEADER_AFF_INDIV_DECEASED                                      := xmltext('DECEASED');
					self.HEADER_AFF_INDIV_DEVOTES                                       := xmltext('DEVOTES');
					self.HEADER_AFF_INDIV_GOVTTITLE                                     := xmltext('GOVTTITLE');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_ATTYNO                            := xmltext('INDIV.AUDIT/ATTYNO');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_ATTYSEQ                           := xmltext('INDIV.AUDIT/ATTYSEQ');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_INDIV_ID                          := xmltext('INDIV.AUDIT/INDIV.ID');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN                              := xmltext('INDIV.AUDIT/ISLN');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_LISTING_ID                        := xmltext('INDIV.AUDIT/LISTING.ID');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_LISTING_TYPE                      := xmltext('INDIV.AUDIT/LISTING.TYPE');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_ORG_LID                           := xmltext('INDIV.AUDIT/ORG.LID');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_ORG_VID                           := xmltext('INDIV.AUDIT/ORG.VID');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_SOLO                              := xmltext('INDIV.AUDIT/SOLO');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_SORTKEY                           := xmltext('INDIV.AUDIT/SORTKEY');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_SUB_TYPE                          := xmltext('INDIV.AUDIT/SUB.TYPE');
					self.HEADER_AFF_INDIV_INDIV_AUDIT_VERSION_ID                        := xmltext('INDIV.AUDIT/VERSION.ID');
					self.HEADER_AFF_INDIV_INDIV_BIOG_SECTION                            := xmltext('INDIV.BIOG/SECTION');
					self.HEADER_AFF_INDIV_INDIV_BIOG_SKETCH                             := xmltext('INDIV.BIOG/SKETCH');
					self.HEADER_AFF_INDIV_INDIV_CELL_PHONE_NUMBER                       := xmltext('INDIV.CELL/PHONE/NUMBER'[1]);
					self.HEADER_AFF_INDIV_INDIV_EMAIL_EMAIL_ADDR                        := xmltext('INDIV.EMAIL/EMAIL/ADDR');
					self.HEADER_AFF_INDIV_INDIV_FAX_FAX_NUMBER                          := xmltext('INDIV.FAX/FAX/NUMBER'[1]);
					self.HEADER_AFF_INDIV_INDIV_PHONE_PHONE_NUMBER                      := xmltext('INDIV.PHONE/PHONE/NUMBER'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_ADMIT_STATE                          := xmltext('INDIV.PP/ADMIT/STATE');
					self.HEADER_AFF_INDIV_INDIV_PP_ADMIT_TEXT                           := xmltext('INDIV.PP/ADMIT/TEXT');
					self.HEADER_AFF_INDIV_INDIV_PP_ADMIT_YEAR                           := xmltext('INDIV.PP/ADMIT/YEAR');
					self.HEADER_AFF_INDIV_INDIV_PP_AGENCIES                             := xmltext('INDIV.PP/AGENCIES');
					self.HEADER_AFF_INDIV_INDIV_PP_ALSO_TEXT                            := xmltext('INDIV.PP/ALSO.TEXT');
					self.HEADER_AFF_INDIV_INDIV_PP_BIOG_TEXT                            := xmltext('INDIV.PP/BIOG.TEXT');
					self.HEADER_AFF_INDIV_INDIV_PP_BORN_TEXT                            := xmltext('INDIV.PP/BORN/TEXT');
					self.HEADER_AFF_INDIV_INDIV_PP_BORN_YEAR                            := xmltext('INDIV.PP/BORN/YEAR');
					self.HEADER_AFF_INDIV_INDIV_PP_EDUC_EDUCATION                       := xmltext('INDIV.PP/EDUC/EDUCATION');
					self.HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_DEGREE                  := xmltext('INDIV.PP/EDUC/FLDEDUC/DEGREE'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_GRADYEAR                := xmltext('INDIV.PP/EDUC/FLDEDUC/GRADYEAR'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_HONORS                  := xmltext('INDIV.PP/EDUC/FLDEDUC/HONORS'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_NAME                    := xmltext('INDIV.PP/EDUC/FLDEDUC/NAME'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_TYPE                    := xmltext('INDIV.PP/EDUC/FLDEDUC/TYPE'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_LANGUAGES                            := xmltext('INDIV.PP/LANGUAGES');
					self.HEADER_AFF_INDIV_INDIV_PP_LEG_SUPPORT_TITLE                    := xmltext('INDIV.PP/LEG.SUPPORT.TITLE');
					self.HEADER_AFF_INDIV_INDIV_PP_MEMBER_ABA                           := xmltext('INDIV.PP/MEMBER/ABA');
					self.HEADER_AFF_INDIV_INDIV_PP_MEMBER_CBA                           := xmltext('INDIV.PP/MEMBER/CBA');
					self.HEADER_AFF_INDIV_INDIV_PP_MEMBER_IBA                           := xmltext('INDIV.PP/MEMBER/IBA');
					self.HEADER_AFF_INDIV_INDIV_PP_MEMBER_PARSETEXT                     := xmltext('INDIV.PP/MEMBER/PARSETEXT');
					self.HEADER_AFF_INDIV_INDIV_PP_NOTADMIT                             := xmltext('INDIV.PP/NOTADMIT');
					self.HEADER_AFF_INDIV_INDIV_PP_PRACTICEAREA_PRACTAREA               := xmltext('INDIV.PP/PRACTICEAREA/PRACTAREA'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_PRACTICEAREA_PRACTAREA_AREA          := xmltext('INDIV.PP/PRACTICEAREA/PRACTAREA/AREA'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_PRACTICEAREA_PRACTAREA_PCTOFTIME     := xmltext('INDIV.PP/PRACTICEAREA/PRACTAREA/PCTOFTIME'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_RATING                               := xmltext('INDIV.PP/RATING');
					self.HEADER_AFF_INDIV_INDIV_PP_REPCASES                             := xmltext('INDIV.PP/REPCASES');
					self.HEADER_AFF_INDIV_INDIV_PP_RESPONSIBILITY_RESPONSIB_AREA        := xmltext('INDIV.PP/RESPONSIBILITY/RESPONSIB/AREA'[1]);
					self.HEADER_AFF_INDIV_INDIV_PP_SECTION                              := xmltext('INDIV.PP/SECTION');
					self.HEADER_AFF_INDIV_INDIV_URL_URL_ADDR                            := xmltext('INDIV.URL/URL/ADDR'[1]);
					self.HEADER_AFF_INDIV_INDIV_URL_URL_HOTLINK                         := xmltext('INDIV.URL/URL/HOTLINK'[1]);
					self.HEADER_AFF_INDIV_MULTIOFFICE                                   := xmltext('MULTIOFFICE');
					self.HEADER_AFF_INDIV_NAME_DISPLAY_NAME                             := xmltext('NAME/DISPLAY.NAME');
					self.HEADER_AFF_INDIV_NAME_FIRSTNAME                                := xmltext('NAME/FIRSTNAME');
					self.HEADER_AFF_INDIV_NAME_LASTNAME                                 := xmltext('NAME/LASTNAME');
					self.HEADER_AFF_INDIV_NAME_ORG_NAME                                 := xmltext('NAME/ORG.NAME');
					self.HEADER_AFF_INDIV_NAME_PREFIX                                   := xmltext('NAME/PREFIX');
					self.HEADER_AFF_INDIV_NAME_SUFFIX                                   := xmltext('NAME/SUFFIX');
					self.HEADER_AFF_INDIV_POSITION                                      := xmltext('POSITION');
					self.HEADER_AFF_INDIV_ROSTERINFO_ROSTER_MEMBER_SINCE                := xmltext('ROSTERINFO/ROSTER/MEMBER.SINCE'[1]);
					self.HEADER_AFF_INDIV_ROSTERINFO_ROSTER_MEMBERSHIP                  := xmltext('ROSTERINFO/ROSTER/MEMBERSHIP'[1]);
					self.HEADER_AFF_INDIV_ROSTERINFO_ROSTER_ROSTER_NAME                 := xmltext('ROSTERINFO/ROSTER/ROSTER.NAME'[1]);
					self.HEADER_AFF_INDIV_ROSTERINFO_ROSTER_ROSTERAUDIT_DATE            := xmltext('ROSTERINFO/ROSTER/ROSTERAUDIT.DATE'[1]);
					self.HEADER_AFF_INDIV_ROSTERINFO_ROSTER_SOURCE_ID                   := xmltext('ROSTERINFO/ROSTER/SOURCE.ID'[1]);
					self.HEADER_AFF_INDIV_ROSTERINFO_ROSTER_STATUS                      := xmltext('ROSTERINFO/ROSTER/STATUS'[1]);
					)
				);
				self.HEADER_CD_HEADING                                              := xmltext('HEADER/CD.HEADING'[1]);
				self.HEADER_HEADING                                                 := xmltext('HEADER/HEADING'[1]);
				self.INFO_COUNTRY                                                   := xmltext('INFO/COUNTRY');
				self.INFO_SORTCITY                                                  := xmltext('INFO/SORTCITY');
				self.INFO_SORTCOUNTRY                                               := xmltext('INFO/SORTCOUNTRY');
				self.INFO_STATE                                                     := xmltext('INFO/STATE');
				self.LANGUAGES                                                      := xmltext('LANGUAGES');
				self.LFAINFO_LFA                                                    := xmltext('LFAINFO/LFA'[1]);
				self.MAILADDR_MCITY                                                 := xmltext('MAILADDR/MCITY');
				self.MAILADDR_MPOBOX                                                := xmltext('MAILADDR/MPOBOX');
				self.MAILADDR_MSTATE                                                := xmltext('MAILADDR/MSTATE');
				self.MAILADDR_MSTREET                                               := xmltext('MAILADDR/MSTREET');
				self.MAILADDR_MZIP                                                  := xmltext('MAILADDR/MZIP');
				self.MULTIOFFICE                                                    := xmltext('MULTIOFFICE');
				self.NAME_CORP_BIOG_NAME                                            := xmltext('NAME/CORP.BIOG.NAME');
				self.NAME_DISPLAY_NAME                                              := xmltext('NAME/DISPLAY.NAME');
				self.NAME_FIRSTNAME                                                 := xmltext('NAME/FIRSTNAME');
				self.NAME_LASTNAME                                                  := xmltext('NAME/LASTNAME');
				self.NAME_ORG_NAME                                                  := xmltext('NAME/ORG.NAME');
				self.NAME_PREFIX                                                    := xmltext('NAME/PREFIX');
				self.NAME_SUFFIX                                                    := xmltext('NAME/SUFFIX');
				self.ORG_AUDIT_BARREG                                               := xmltext('ORG.AUDIT/BARREG');
				self.ORG_AUDIT_FIRMNO                                               := xmltext('ORG.AUDIT/FIRMNO');
				self.ORG_AUDIT_FIRMSEQNO                                            := xmltext('ORG.AUDIT/FIRMSEQNO');
				self.ORG_AUDIT_LISTING_ID                                           := xmltext('ORG.AUDIT/LISTING.ID');
				self.ORG_AUDIT_LISTING_TYPE                                         := xmltext('ORG.AUDIT/LISTING.TYPE');
				self.ORG_AUDIT_LOCATION_SIZE                                        := xmltext('ORG.AUDIT/LOCATION.SIZE');
				self.ORG_AUDIT_MAINPOINT                                            := xmltext('ORG.AUDIT/MAINPOINT');
				self.ORG_AUDIT_ORG_TYPE                                             := xmltext('ORG.AUDIT/ORG.TYPE');
				self.ORG_AUDIT_ORGID                                                := xmltext('ORG.AUDIT/ORGID');
				self.ORG_AUDIT_PREF_TYPE                                            := xmltext('ORG.AUDIT/PREF.TYPE');
				self.ORG_AUDIT_SIZE                                                 := xmltext('ORG.AUDIT/SIZE');
				self.ORG_AUDIT_SOLO                                                 := xmltext('ORG.AUDIT/SOLO');
				self.ORG_AUDIT_SORTKEY                                              := xmltext('ORG.AUDIT/SORTKEY');
				self.ORG_AUDIT_SUB_TYPE                                             := xmltext('ORG.AUDIT/SUB.TYPE');
				self.ORG_AUDIT_VERSION_ID                                           := xmltext('ORG.AUDIT/VERSION.ID');
				self.ORG_AUDIT_XREF_LID                                             := xmltext('ORG.AUDIT/XREF.LID');
				self.ORG_AUDIT_XREF_VID                                             := xmltext('ORG.AUDIT/XREF.VID');
				self.ORG_BIOG_ADDLSEE                                               := xmltext('ORG.BIOG/ADDLSEE');
				self.ORG_BIOG_BIOG_CLIENTS                                          := xmltext('ORG.BIOG/BIOG.CLIENTS');
				self.ORG_BIOG_POSTINDIVTEXT                                         := xmltext('ORG.BIOG/POSTINDIVTEXT');
				self.ORG_BIOG_PREINDIVTEXT                                          := xmltext('ORG.BIOG/PREINDIVTEXT');
				self.ORG_BIOG_REVISER                                               := xmltext('ORG.BIOG/REVISER');
				self.ORG_BIOG_SECTION                                               := xmltext('ORG.BIOG/SECTION');
				self.ORG_PP_PATENT_PATENT                                           := xmltext('ORG.PP/PATENT/PATENT');
				self.ORG_PP_PATENT_PATENT_SOP                                       := xmltext('ORG.PP/PATENT/PATENT.SOP');
				self.ORG_PP_PATENT_PERSONNEL                                        := xmltext('ORG.PP/PATENT/PERSONNEL');
				self.ORG_PP_PERSONNEL                                               := xmltext('ORG.PP/PERSONNEL');
				self.ORG_PP_PP_CLIENTS                                              := xmltext('ORG.PP/PP.CLIENTS');
				self.ORG_PP_RATING                                                  := xmltext('ORG.PP/RATING');
				self.ORG_PP_SECTION                                                 := xmltext('ORG.PP/SECTION');
				self.OTHEROFF                                                       := xmltext('OTHEROFF');
				self.PARTNER                                                        := xmltext('PARTNER');
				self.PROFILE                                                        := xmltext('PROFILE');
				self.SOP                                                            := xmltext('SOP');
		end;
		
		org_parsed	:= parse(org_records, line, tParseOrg, xml('DOCUMENT/ORG'))
//			: persist(persistnames().ParseInput.Organizations);
;
		return org_parsed;
	
	end;

	export Affiliated_Individuals(dataset(layouts.Input.Parsed.Organizations) pInputFile) :=
	function
		
		Layouts.Input.Parsed.Affiliated_Individuals_plus	tNormIt(layouts.Input.Parsed.Organizations l, layouts.Input.Parsed.Affiliated_Individuals r) :=
		transform
		
			self	:= l;
			self	:= r;

		end;

		person_parsed	:= normalize(pInputFile, Left.HEADER_AFF_INDIV	,tNormIt(left,right))
			: persist(persistnames().ParseInput.AffiliatedIndividuals);

		return person_parsed;
	
	end;

	export Unaffiliated_Individuals(dataset(layouts.Input.Sprayed) pInputFile) :=
	function

		person_records := pInputFile(regexfind('<UNAFF.INDIV>', line));

		person_parsed	:= parse(person_records, line, layouts.Input.Parsed.Unaffiliated_Individuals, xml('DOCUMENT/UNAFF.INDIV'))
//			: persist(persistnames().ParseInput.UnaffiliatedIndividuals)
			;

		return person_parsed;
	
	end;
	
	

end;