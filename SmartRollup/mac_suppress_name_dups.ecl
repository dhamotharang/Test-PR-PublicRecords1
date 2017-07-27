//REMOVE ROWS WHERE LAST AND FIRST ARE THE SAME AND THE MNAME IS BLANK.
export MAC_suppress_name_dups(inMacRecs, outrecs, lname='lname', fname ='fname', mname = 'mname') := MACRO
#uniquename(orderedLayout)
#uniquename(recsOrig)
#uniquename(recs1)
#uniquename(srecs1)
#uniquename(recs2Middle)
#uniquename(recs2NoMiddle)
#uniquename(soutRecs)
#uniquename(origIt)
#uniquename(bothSets)
#uniquename(bothNoDups)

   %orderedLayout% := record(recordof(inMacRecs))
	   integer origOrder;
	 end;
	
	%orderedLayout% %origIt%(inMacRecs l, integer c) := transform
	   self.origOrder := c;
		 self := l;
	 end;
	 %recsOrig% := project(inMacRecs, %origIt%(LEFT, COUNTER));
	 
   %recs1% := JOIN(%recsOrig%, %recsOrig%(mname <> ''), 
	                 LEFT.mname = '' and LEFT.lname = RIGHT.lname and LEFT.fname = RIGHT.fname ,
									 TRANSFORM(%orderedLayout%,SELF := LEFT), 
									 LEFT ONLY);
   %srecs1% := SORT(%recs1%,lname, fname, mname);									 
	 
	 %orderedLayout% rollitup(%srecs1% l, %srecs1% r) := transform
	   self.origOrder := if (l.origOrder < r.origOrder, l.origOrder, r.origOrder);
	   self := r;
	 end;
	 %recs2Middle% := rollup(%srecs1%, 
	                       LEFT.lname = RIGHT.lname and 
												 LEFT.fname =RIGHT.fname and 
												 RIGHT.mname[1..length(trim(LEFT.mname))] = LEFT.mname ,
	                       rollitup(LEFT,RIGHT));
	 
	 %recs2NoMiddle% := %recs1%(mname = '');
	  //rollup entire record duplicates
		//keeping hypenated last name over non-hypenated (SMITH-MORE, SMITH MORE, and SMITHMORE)
	 %bothSets% := sort(%recs2Middle% + %recs2NoMiddle%, trim(stringlib.stringFilterOut(lname,'-'),ALL), fname, mname);
	
	 %orderedLayout% rollupNameDups(%bothSets% l, %bothSets% r) := transform
	   self.origOrder := if (l.origOrder < r.origOrder, l.origOrder, r.origOrder);
		 self.lname := if (length(trim(stringlib.stringcleanspaces(l.lname))) > length(trim(stringlib.stringcleanspaces(r.lname))), l.lname, r.lname);
	   self := l;
	 end;									 
	 %bothNoDups% := rollup(%bothSets%, 
	                        trim(stringlib.stringFilterOut(LEFT.lname,'-'),ALL) = trim(stringlib.stringFilterOut(RIGHT.lname,'-'),ALL) and 
												  LEFT.fname =RIGHT.fname and 
												  LEFT.mname = RIGHT.mname ,
	                        rollupNameDups(LEFT,RIGHT));
	 
	 %soutRecs%:= sort(%bothNoDups%, origOrder);
	 outrecs := project(%soutRecs%, recordof(inMacRecs));
ENDMACRO;
