import address;

export MAC_BDID_Corp(infile, outfile) := macro

#uniquename(layout_seq)
%layout_seq% := record
unsigned6 rcid := 0;
infile;
end;

#uniquename(InitSeq)
%layout_seq% %InitSeq%(infile l) := transform
self := l;
end;

#uniquename(Corp_Init)
%Corp_Init% := project(infile, %InitSeq%(left));

#uniquename(Corp_Seq)
ut.MAC_Sequence_Records(%Corp_Init%, rcid, %Corp_Seq%)

#uniquename(layout_temp)
%layout_temp% := record
unsigned6 bdid := 0;
unsigned6 rcid;
string350 abbrev_legal_name;
string10  prim_range;
string2   predir;
string28  prim_name;
string4   addr_suffix;
string2   postdir;
string8   sec_range;
string25  p_city_name;
string2   state;
string5   zip5;
unsigned4 fein;
qstring34 vendor_id;
qstring34 source_group;
string1   suppress_ra_addr;
string11  ra_officer_also;
string350 reg_agent_name;
end;

#uniquename(SlimCorp)
%layout_temp% %SlimCorp%(%layout_seq% l) := transform
self.bdid := 0;  // clear out any existing bdid
self.fein := IF(l.fed_tax_id_9[3] <> '-', (unsigned4)l.fed_tax_id_9, (unsigned4)(l.fed_tax_id_9[1..2] + l.fed_tax_id_9[4..10]));
self.source_group := (qstring34)((string34)(l.state_origin+l.sos_ter_nbr));
self.vendor_id := (qstring34)((string34)(l.state_origin+l.sos_ter_nbr));
self := l;
end;

#uniquename(Corp_Slim)
%Corp_Slim% := project(%Corp_Seq%, %SlimCorp%(left));

#uniquename(BlankCorpAddress)
%layout_temp% %BlankCorpAddress%(%layout_temp% l) := transform
self.prim_range := '';
self.prim_name := '';
self.sec_range := '';
self.zip5 := '';
self := l;
end;

#uniquename(Corp4_RA_Addr)
%Corp4_RA_Addr% := %Corp_Slim%(not(
                              suppress_ra_addr<>'Y' OR
                              (suppress_ra_addr='Y' AND
                               ra_officer_also='Y' AND
                               (Datalib.CompanyClean(reg_agent_name))[41..120] = '' AND
                                (integer)((address.cleanPerson73(reg_agent_name))[71..73]) >= 85
                               )));

#uniquename(Corp4_Blank_Addr)
%Corp4_Blank_Addr% := project(%Corp4_RA_Addr%, %BlankCorpAddress%(left));

#uniquename(Corp4_Not_RA_Addr)
%Corp4_Not_RA_Addr% :=  %Corp_Slim%(stringlib.stringfind(abbrev_legal_name, '0000000000', 1) = 0,
                               suppress_ra_addr<>'Y' OR
                              (suppress_ra_addr='Y' AND
                               ra_officer_also='Y' AND
                               (Datalib.CompanyClean(reg_agent_name))[41..120] = '' AND
                                (integer)((address.cleanPerson73(reg_agent_name))[71..73]) >= 85
                               ));

#uniquename(Corp4_Clean)
%Corp4_Clean% := %Corp4_Not_RA_Addr% + %Corp4_Blank_Addr%;

#uniquename(Corp4_Base_BDID_Init)
// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(%Corp4_Clean%, %Corp4_Base_BDID_Init%,
                        FALSE, bdid,
                        FALSE, 'C',
                        TRUE, source_group,
                        abbrev_legal_name,
                        prim_range, prim_name, sec_range, zip5,
                        FALSE, phone_field,
                        TRUE, fein,
						TRUE, vendor_id)


// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
#uniquename(BDID_Matchset)
%BDID_Matchset% := ['A'];

#uniquename(Corp4_Base_BDID_Match)
%Corp4_Base_BDID_Match% := %Corp4_Base_BDID_Init%(bdid <> 0);

#uniquename(Corp4_Base_BDID_NoMatch)
%Corp4_Base_BDID_NoMatch% := %Corp4_Base_BDID_Init%(bdid = 0);

#uniquename(Corp4_Base_BDID_Rematch)

Business_Header_SS.MAC_Add_BDID_Flex(%Corp4_Base_BDID_NoMatch%,
                                  %BDID_Matchset%,
                                  abbrev_legal_name,
                                  prim_range, prim_name, zip5,
                                  sec_range, state,
                                  phone_field, fein,
                                  bdid, %layout_temp%,
                                  FALSE, BDID_score_field,
                                  %Corp4_Base_BDID_Rematch%)

#uniquename(Corp4_Base_BDID_All)
%Corp4_Base_BDID_All% := %Corp4_Base_BDID_Match% + %Corp4_Base_BDID_Rematch%;
								  

// Join to original file to set BDIDs
#uniquename(Corp_Seq_Dist)
%Corp_Seq_Dist% := distribute(%Corp_Seq%, hash(rcid));

#uniquename(Corp4_Base_BDID_Dist)
%Corp4_Base_BDID_Dist% := distribute(%Corp4_Base_BDID_All%, hash(rcid));

#uniquename(AssignBDID)
typeof(infile) %AssignBDID%(%layout_seq% l, %layout_temp% r) := transform
self.bdid := r.bdid;
self := l;
end;

#uniquename(Corp4_Base_Updated)
%Corp4_Base_Updated% := join(%Corp_Seq_Dist%,
                             %Corp4_Base_BDID_Dist%,
                             left.rcid = right.rcid,
                             %AssignBDID%(left, right),
                             left outer,
                             local);

outfile := %Corp4_Base_Updated%;
		 
							 
endmacro;