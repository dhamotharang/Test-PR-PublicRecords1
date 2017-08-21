
SearchBy := iesp.rightaddress.t_RightAddressSearchBy;

inLayout := RECORD
	STRING120 fullname;
	STRING20  fname;
	STRING20  mname;
	STRING120 lastnameorcompany;
	STRING12  entitytype;
END;

inRecs := DATASET( [ { '', 'JEFFERY', 'C', 'WOODS', 'Individual' },
										 { 'JEFFERY C WOODS', '', '', '', 'Individual' },
                     { '', 'JEFFERY C WOODS', '', '', 'Individual' },
                     { '', '', 'JEFFERY C WOODS', '', 'Individual' },
                     { '', '', '', 'JEFFERY C WOODS CORP', 'Individual' },

                     { '', 'JEFFERY', 'C', 'WOODS', 'Business' },
										 { 'JEFFERY C WOODS', '', '', '', 'Business' },
                     { '', 'JEFFERY C WOODS', '', '', 'Business' },
                     { '', '', 'JEFFERY C WOODS', '', 'Business' },
                     { '', '', '', 'JEFFERY C WOODS CORP', 'Business' },
										 
                     { 'JEFF WOODS C/O: LEXISNEXIS', '', '', '', 'Individual' },
                     { '', 'JEFF WOODS C/O: LEXISNEXIS', '', '', 'Individual' },
                     { '', '', 'JEFF WOODS C/O: LEXISNEXIS', '', 'Individual' },
                     { '', '', '', 'JEFF WOODS C/O: LEXISNEXIS', 'Individual' },

                     { 'JEFF WOODS C/O: LEXISNEXIS', '', '', '', 'Business' },
                     { '', 'JEFF WOODS C/O: LEXISNEXIS', '', '', 'Business' },
                     { '', '', 'JEFF WOODS C/O: LEXISNEXIS', '', 'Business' },
                     { '', '', '', 'JEFF WOODS C/O: LEXISNEXIS', 'Business' },

                     { 'LEXISNEXIS ATTN: JEFF WOODS', '', '', '', 'Individual' },
                     { '', 'LEXISNEXIS ATTN: JEFF WOODS', '', '', 'Individual' },
                     { '', '', 'LEXISNEXIS ATTN: JEFF WOODS', '', 'Individual' },
                     { '', '', '', 'LEXISNEXIS ATTN: JEFF WOODS', 'Individual' },

                     { 'LEXISNEXIS ATTN: JEFF WOODS', '', '', '', 'Business' },
                     { '', 'LEXISNEXIS ATTN: JEFF WOODS', '', '', 'Business' },
                     { '', '', 'LEXISNEXIS ATTN: JEFF WOODS', '', 'Business' },
                     { '', '', '', 'LEXISNEXIS ATTN: JEFF WOODS', 'Business' } 
										 
										 ], inLayout);

										 
										 
output(inRecs);

SearchBy toSearchBy(inLayout L) := TRANSFORM
	SELF.Name.Full := L.fullname;
	SELF.Name.First := L.fname;
	SELF.Name.Middle := L.mname;
	SELF.LastNameOrCompany := L.lastnameorcompany;
	SELF.EntityType := L.entitytype;

	SELF := [];
END;

searchby_recs := PROJECT(inRecs, toSearchBy(LEFT));
output(searchby_recs);

iesp.share.t_NameAndCompany CleanSearchBy(SearchBy L) := TRANSFORM
	SELF := UPS_Services.mod_Names(L).bestParser();
END;

outRecs := PROJECT(searchby_recs, CleanSearchBy(LEFT));
output(outRecs);