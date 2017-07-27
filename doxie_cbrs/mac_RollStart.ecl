
//doxie_cbrs.mac_Selection_Declare()
export mac_RollStart
	(infile, outfile, keyfile, numneeded, boolInclude = 'true',
	 bdid_field = 'bdid',  addlJoinCriteria = 'true', sort1 = 'bdid', sort2 = 'bdid', sort3 = 'bdid', useslim = 'false', slimrec = '')
 := macro

#uniquename(ulv)
#uniquename(useSupergroup)
%ulv% := business_header.stored_use_Levels_val;
%useSupergroup% := business_header.stored_useSupergroup;

#uniquename(fatten)
doxie_cbrs.layout_supergroup %fatten%(infile l) := transform
	self.bdid := l.bdid;
	self := [];
end;

#uniquename(bdids)
%bdids% := if(%ulv% and %useSupergroup%, 
				    doxie_Cbrs.ds_SupergroupLevels(infile), 
						project(infile, %fatten%(left)))
					(boolInclude)	;

#uniquename(outrec)
%outrec% := {unsigned1 level, 
#if(useslim)
	slimrec
#else
	keyfile
#end
};

#uniquename(FetchBaseRecords)
%outrec% %FetchBaseRecords%(keyfile r, unsigned1 l) := TRANSFORM
  SELF.level := l;
  SELF := r;
  SELF := [];
END;
#uniquename(j0)
#uniquename(j1)
#uniquename(j2)
#uniquename(jrest)
%j0% := join(%bdids%(level = 0,boolInclude), 
							  keyfile,
								keyed(left.bdid = right.bdid_field) and addlJoinCriteria,
								%FetchBaseRecords%(right,0), limit(10000, skip));
			 
%j1% := join(%bdids%(level = 1,boolInclude), 
								keyfile,
								keyed(left.bdid = right.bdid_field) and addlJoinCriteria,
								%FetchBaseRecords%(right,1), limit(10000, skip));
			 
%j2% := join(%bdids%(level = 2,boolInclude), 
								keyfile,
								keyed(left.bdid = right.bdid_field) and addlJoinCriteria,
								%FetchBaseRecords%(right,2), limit(10000, skip));
								
%jrest% := join(%bdids%(level > 2,boolInclude), 
								keyfile,
								keyed(left.bdid = right.bdid_field) and addlJoinCriteria,
								%FetchBaseRecords%(right,10), limit(10000, skip));
								

//****** more deterministic sort
			 
//for rolling up
#uniquename(Countlev0)
#uniquename(Countlev1)
#uniquename(Countlev2)
%Countlev0% := count(choosen(%j0%,numneeded));
%Countlev1% := %Countlev0% + count(choosen(%j1%,numneeded));
%Countlev2% := %Countlev1% + count(choosen(%j2%,numneeded));
		 
//** get however many we need	
#uniquename(outlev)	 
%outlev% := 
	choosen(sort(%j0%, sort1,sort2,sort3) &
					IF(%Countlev0% < numneeded, sort(%j1%, sort1,sort2,sort3,record)) & 
				  IF(%Countlev1% < numneeded, sort(%j2%, sort1,sort2,sort3,record)) &
					IF(%Countlev2% < numneeded, sort(%jrest%, sort1,sort2,sort3,record))
					, numneeded);
					
outfile := if(%ulv%, %outlev%, %j0%);
endmacro;