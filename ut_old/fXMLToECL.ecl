//----------------------------------------------------------------------------
// Function takes a STRING that contains at least one record of XML text
// and constructs the ECL layout equivalent that can be used to load that
// XML data into a dataset.
//
// KNOWN ISSUES:
//   For more complex XML documents, some of the layouts may not be listed in
//   the correct order and will need to be re-arranged manually.
//   This program does NOT accommodate circular references (e.g. L1 refers to
//   L2, L2 refers to L3, and L3 refers to L1)
//   There may be an occasional missing layout due to quirks in the XML
//   definition.
//----------------------------------------------------------------------------
EXPORT fXMLToECL(
  STRING sXMLString,
  STRING sLayoutPrefix='LAYOUT_',            // Prefix for all layouts
  STRING sDatasetPrefix='DS_',               // Prefix for all dataset definitions
  STRING sStringPrefix='S_',                 // Prefix for all value definitions
  STRING sSpecialCharacterReplacement='_',   // to replace characters that can't be in a dataset member name (e.g. ":", "-")
  STRING sMemberIndent='  ',                 // Number of characters to indent dataset members
  STRING sStandardTextTag='txt',             // Name for the member that holds un-named text data
  UNSIGNED iMaxLength=100000,                // leave zero for no maxlength clause
  UNSIGNED iXpathDefinitionStartColumn=60    // used to align the xpath definitions for readability
):=FUNCTION
  //----------------------------------------------------------------------------
  // First pass: Creating a row for each tag (any body of characters enclosed
  // by a "<" and ">").  At this point also determining which part of the tag
  // is the tag name and which part consist of any additional attributes.  A 
  // placeholder "¶" is used to preserve lines without attributes in a later
  // step.
  //----------------------------------------------------------------------------
  PATTERN p_ws := PATTERN('[ \t\r\n]');
  PATTERN p_arb := pattern('[^<>/ ]+');
  PATTERN p_tagname := pattern('[^<>/ ]+') BEFORE (p_ws|'/'|'>');
  PATTERN p_attribute_section:=pattern('[^>/]+');
  PATTERN p_attribute_name:=pattern('[^=<>/ ]+');
  PATTERN p_term_01 := '/';
  PATTERN p_term_02 := '/';
  PATTERN p_tag := '<' OPT(p_term_01) p_tagname OPT(p_attribute_section) OPT(p_term_02) OPT(p_ws)'>';
  dXMLDoc:=DATASET([{sXMLString}],{,MAXLENGTH(1000000) STRING s;});
  lTagsParsed:=RECORD,MAXLENGTH(100000)
    STRING tag:=MATCHTEXT(p_tag);
    STRING tagname:=MATCHTEXT(p_tagname);
    STRING attributes:=IF(MATCHTEXT(p_attribute_section)='',IF(MATCHTEXT(p_term_02)='','¶=',''),IF(MATCHTEXT(p_term_02)='','¶= ','')+MATCHTEXT(p_attribute_section));
  END;
  dTagsParsed_01:=PARSE(dXMLDoc,s,p_tag,lTagsParsed,NOCASE,SCAN);

  //----------------------------------------------------------------------------
  // Quick iterate to identify those tag pairs that have two lines (distinct
  // begin and end tags) but no items between them except for the attributes
  // attached to the begin tag.  There will be text between these two tags, so
  // we add an extra filler character to the attribute section so that we may
  // have a line item for the text when we parse out the tags.
  //----------------------------------------------------------------------------
  dTagsParsed:=ITERATE(dTagsParsed_01,TRANSFORM(RECORDOF(dTagsParsed_01),SELF.attributes:=IF(LEFT.tagname=RIGHT.tagname AND RIGHT.tag[..2]='</','»= ','')+RIGHT.attributes;SELF:=RIGHT;));

  //----------------------------------------------------------------------------
  // Now break each attribute line into individual attributes, discarding the
  // values assigned to them.  The "¶" enables us to keep a line even if it
  // doesn't have an actual attribute (that placeholder is discarded in this
  // stage).  This stage will also replace the original tag with a simple row
  // type identifier indicating whether the row is a start tag, an end tag, or 
  // an attrribute or data tag.
  //----------------------------------------------------------------------------
  PATTERN p_attribute_names:=p_attribute_name BEFORE '=';
  lParseAttributes:=RECORD,MAXLENGTH(10000)
    DECIMAL10_5 order:=0;
    INTEGER depth:=0;
    STRING rowtype:=IF(MATCHTEXT(p_attribute_name)='¶',IF(dTagsParsed.tag[1..2]='</','E','B'),'A');
    STRING lineage:='';
    STRING parent:='';
    dTagsParsed.tagname;
    STRING attribute:=IF(MATCHTEXT(p_attribute_name)='¶','',MATCHTEXT(p_attribute_name));
    STRING tagname_sanitized:='';
    STRING indent:='';
  END;
  dParseAttributes:=PARSE(dTagsParsed,attributes,p_attribute_names,lParseAttributes,NOCASE,SCAN);

  //----------------------------------------------------------------------------
  // Run through the dataset, assigning an ordinal number to each row as well
  // as a "depth" indicator to keep track of the family tree of the structure.
  // This iterate also flags any lines related to the "p" tag, as this is just
  // formatting for free-text.  Those flagged lines are filtered out after the
  // the iterate call below.
  // Indentation is added here to enable a visual inspection of the dataset if
  // desired.
  //----------------------------------------------------------------------------
  lParseAttributes getdepth(lParseAttributes L,lParseAttributes R):=TRANSFORM
    SELF.order:=L.order+1;
    SELF.depth:=MAP(
      R.rowtype='B' => IF(L.rowtype IN ['A','E'],L.depth,L.depth+1),
      R.rowtype='A' => IF(L.rowtype='B',L.depth+1,L.depth),
      R.rowtype='E' => IF(L.rowtype='B',L.depth,L.depth-1),
      L.depth
    );
    SELF.indent:=IF(L.depth=SELF.depth,L.indent,IF(L.depth>SELF.depth,L.indent[3..],'  '+L.indent));
    // SELF.tagname:=SELF.indent+R.tagname;
    SELF.tagname:=IF(TRIM(L.tagname,RIGHT,LEFT)='¶',IF(TRIM(R.tagname,RIGHT,LEFT)='p' AND R.rowtype='E','¶¶','¶'),IF(TRIM(R.tagname,RIGHT,LEFT)='p','¶',SELF.indent+R.tagname));
    SELF.tagname_sanitized:=REGEXREPLACE('[^a-zA-Z0-9]',TRIM(R.tagname,LEFT,RIGHT),sSpecialCharacterReplacement);
    SELF:=R;
  END;
  dDepthAndOrder:=ITERATE(dParseAttributes,getdepth(LEFT,RIGHT))(tagname[1]!='¶');

  //----------------------------------------------------------------------------
  // A quick iterate to resolve the full lineage of a line item, as well as
  // its immediate parent.  
  //----------------------------------------------------------------------------
  lParseAttributes tGetParent(lParseAttributes L,lParseAttributes R):=TRANSFORM
    SELF.lineage:=IF(R.depth=L.depth,L.lineage,IF(R.depth>L.depth,L.lineage+'/'+TRIM(L.tagname,RIGHT,LEFT),REGEXREPLACE('/([^/]+)$',TRIM(L.lineage),'')));
    SELF.parent:=REGEXREPLACE('[^a-zA-Z0-9]',REGEXFIND('/([^/]+)$',TRIM(SELF.lineage),1),sSpecialCharacterReplacement);
    SELF:=R;
  END;
  dMap:=ITERATE(dDepthAndOrder,tGetParent(LEFT,RIGHT));

  //----------------------------------------------------------------------------
  // Produce a dataset containing a master list of all the unique layouts that
  // will be created.
  //----------------------------------------------------------------------------
  lLayoutNames:={STRING id:='';STRING layout_name:=dMap.tagname_sanitized;dMap.depth;};
  dLayoutNames:=ROLLUP(SORT(TABLE(dMap(rowtype='B'),lLayoutNames),RECORD),LEFT.layout_name=RIGHT.layout_name,TRANSFORM(lLayoutNames,SELF.depth:=IF(LEFT.depth<RIGHT.depth,RIGHT.depth,LEFT.depth);SELF:=RIGHT;));
  dLayoutsSequenced:=ITERATE(dLayoutNames,TRANSFORM(RECORDOF(dLayoutNames),strdepth:='0'+(STRING)RIGHT.depth;newid:='00'+(STRING)(((UNSIGNED)LEFT.id)+1);SELF.id:=strdepth[LENGTH(strdepth)-1..]+'_'+newid[LENGTH(newid)-2..];SELF:=RIGHT;));

  //----------------------------------------------------------------------------
  // Join the layout list generated above to the map dataset to fill in all of
  // the attributes and datasets, and assign a layout ID to each row.  At this
  // point we also determine the 3 major pieces of the layout definition for
  // each line: The type, the member name, and the xpath reference.
  //----------------------------------------------------------------------------
  lLayoutItems:=RECORD
    STRING layout_id;
    STRING layout_name;
    STRING tag_name;
    STRING member_name;
    STRING member_type;
    STRING member_xpath;
    STRING member;
  END;
  lLayoutItems tAddDatasets(dLayoutsSequenced L,dMap R):=TRANSFORM
    SELF.layout_id:=L.id;
    SELF.layout_name:=sLayoutPrefix+L.layout_name;
    SELF.tag_name:=TRIM(R.tagname,LEFT,RIGHT);
    SELF.member_name:=TRIM(IF(R.rowtype='B',R.tagname_sanitized,IF(R.attribute='»',sStandardTextTag,REGEXREPLACE('[^a-zA-Z0-9]',R.attribute,sSpecialCharacterReplacement))));
    SELF.member_type:=sMemberIndent+IF(R.rowtype='B','DATASET('+sLayoutPrefix+SELF.member_name+') '+sDatasetPrefix,'STRING '+sStringPrefix);
    SELF.member_xpath:=' {XPATH(\''+IF(R.rowtype='B' OR R.tagname_sanitized=R.parent,'',TRIM(R.tagname,LEFT,RIGHT)+'/')+IF(R.rowtype='A',IF(R.attribute='»','','@'+R.attribute),TRIM(R.tagname,LEFT,RIGHT))+'\')};¶';
    SELF.member:='';
  END;
  dAddMembers:=DEDUP(SORT(JOIN(dLayoutsSequenced,dMap(rowtype!='E'),LEFT.layout_name=RIGHT.parent,tAddDatasets(LEFT,RIGHT)),layout_name,member_type,member_name));

  //----------------------------------------------------------------------------
  // Iterate through this list to identify any duplicate field names (which
  // would only exist in instances where the xpath is different).  Any that are
  // are found are simply suffixed with a "_01".  This is the stage where we
  // construct the actual layout definition for the field line.
  //----------------------------------------------------------------------------
  RECORDOF(dAddMembers) tBuildLines(dAddMembers L,dAddMembers R):=TRANSFORM
    SELF.member_name:=R.member_name+IF(L.layout_id=R.layout_id AND L.member_name=R.member_name,'_01','');
    SELF.member:=(R.member_type+SELF.member_name+'                                                  ')[..(IF(LENGTH(R.member_type)+LENGTH(SELF.member_name)>iXpathDefinitionStartColumn,LENGTH(R.member_type)+LENGTH(SELF.member_name),iXpathDefinitionStartColumn))]+R.member_xpath;
    SELF:=R;
  END;
  dBuildLines:=ITERATE(dAddMembers,tBuildLines(LEFT,RIGHT));

  //----------------------------------------------------------------------------
  // Rolling up the previous dataset gives us one line for each layout
  // definition.
  //----------------------------------------------------------------------------
  dLayoutLines:=ROLLUP(dBuildLines,LEFT.layout_name=RIGHT.layout_name,TRANSFORM(RECORDOF(dBuildLines),SELF.member:=LEFT.member+RIGHT.member;SELF:=LEFT;));

  //----------------------------------------------------------------------------
  // Add in record wrappers for each line and then parse the resulting table
  // back out again to produce the final dataset, which is in the standard
  // layout listing format.
  //----------------------------------------------------------------------------
  dLayoutLinesPrepped:=PROJECT(SORT(dLayoutLines,-layout_id),TRANSFORM(RECORDOF(dLayoutLines),SELF.member:='¶'+LEFT.layout_name+':=RECORD'+IF(iMaxLength=0,'',',MAXLENGTH('+(STRING)iMaxLength+')')+'¶'+LEFT.member+'END;¶¶';SELF:=LEFT;));

  PATTERN p_layoutchars:=PATTERN('[^¶]+');
  PATTERN p_layoutline:=(p_layoutchars BEFORE '¶') AFTER '¶';
  lLayouts:={STRING layouts:=MATCHTEXT(p_layoutchars)};
  dLayouts:=PARSE(dLayoutLinesPrepped,member,p_layoutline,lLayouts,NOCASE,SCAN);

  output(choosen(dLayouts,10000),named('dLayouts'));

  RETURN 'View the dLayouts tab for the results';
END;