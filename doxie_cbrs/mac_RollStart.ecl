
//doxie_cbrs.mac_Selection_Declare()
EXPORT mac_RollStart
  (infile, outfile, keyfile, numneeded, boolInclude = 'TRUE',
   bdid_field = 'bdid', addlJoinCriteria = 'TRUE', sort1 = 'bdid', sort2 = 'bdid', sort3 = 'bdid', useslim = 'FALSE', slimrec = '')
 := MACRO

IMPORT business_header, doxie_cbrs;

#uniquename(ulv)
#uniquename(useSupergroup)
%ulv% := business_header.stored_use_Levels_val;
%useSupergroup% := business_header.stored_useSupergroup;

#uniquename(fatten)
doxie_cbrs.layout_supergroup %fatten%(infile l) := TRANSFORM
  SELF.bdid := l.bdid;
  SELF := [];
END;

#uniquename(bdids)
%bdids% := IF(%ulv% AND %useSupergroup%,
            doxie_Cbrs.ds_SupergroupLevels(infile),
            PROJECT(infile, %fatten%(LEFT)))
          (boolInclude) ;

#uniquename(outrec)
%outrec% := {UNSIGNED1 level,
#IF(useslim)
  slimrec
#else
  keyfile
#END
};

#uniquename(FetchBaseRecords)
%outrec% %FetchBaseRecords%(keyfile r, UNSIGNED1 l) := TRANSFORM
  SELF.level := l;
  SELF := r;
  SELF := [];
END;
#uniquename(j0)
#uniquename(j1)
#uniquename(j2)
#uniquename(jrest)
%j0% := JOIN(%bdids%(level = 0,boolInclude),
  keyfile,
  KEYED(LEFT.bdid = RIGHT.bdid_field) AND addlJoinCriteria,
  %FetchBaseRecords%(RIGHT,0), LIMIT(10000, SKIP));

%j1% := JOIN(%bdids%(level = 1,boolInclude),
  keyfile,
  KEYED(LEFT.bdid = RIGHT.bdid_field) AND addlJoinCriteria,
  %FetchBaseRecords%(RIGHT,1), LIMIT(10000, SKIP));

%j2% := JOIN(%bdids%(level = 2,boolInclude),
  keyfile,
  KEYED(LEFT.bdid = RIGHT.bdid_field) AND addlJoinCriteria,
  %FetchBaseRecords%(RIGHT,2), LIMIT(10000, SKIP));

%jrest% := JOIN(%bdids%(level > 2,boolInclude),
  keyfile,
  KEYED(LEFT.bdid = RIGHT.bdid_field) AND addlJoinCriteria,
  %FetchBaseRecords%(RIGHT,10), LIMIT(10000, SKIP));


//****** more deterministic sort

//for rolling up
#uniquename(Countlev0)
#uniquename(Countlev1)
#uniquename(Countlev2)
%Countlev0% := COUNT(CHOOSEN(%j0%,numneeded));
%Countlev1% := %Countlev0% + COUNT(CHOOSEN(%j1%,numneeded));
%Countlev2% := %Countlev1% + COUNT(CHOOSEN(%j2%,numneeded));

//** get however many we need
#uniquename(outlev)
%outlev% :=
  CHOOSEN(SORT(%j0%, sort1,sort2,sort3) &
          IF(%Countlev0% < numneeded, SORT(%j1%, sort1,sort2,sort3,RECORD)) &
          IF(%Countlev1% < numneeded, SORT(%j2%, sort1,sort2,sort3,RECORD)) &
          IF(%Countlev2% < numneeded, SORT(%jrest%, sort1,sort2,sort3,RECORD))
          , numneeded);

outfile := IF(%ulv%, %outlev%, %j0%);
ENDMACRO;
