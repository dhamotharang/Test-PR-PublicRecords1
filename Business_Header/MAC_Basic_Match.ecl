import business_header;

EXPORT MAC_Basic_Match(

	 infile
	,outfile
	,matchsourcegroup
	,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.

) := MACRO

#uniquename(pBHFile)
%pBHFile%	:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.Business_headers.logical;

#uniquename(match_to)
%match_to% := %pBHFile%;

//-- slimmer record format for business header file (match_to)
#uniquename(slimrec)
%slimrec% := record
  unsigned6 rcid;
  unsigned6 bdid;
  string2   source;
  qstring34 source_group;
  string3   pflag;
  qstring120 company_name;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring8  sec_range;
  unsigned3 zip;
  unsigned6 phone;
  unsigned4 fein;
end;

//-- transform used by join to add rid and did
#uniquename(add_rid)
typeof(infile) %add_rid%(infile L, %slimrec% R) := transform
	  self.rcid := R.rcid;
	  self.bdid := R.bdid;
	  self := L;
end;

#uniquename(slimbh)
//-- transform used to push header into slimmer record format
%slimrec% %slimbh%(%match_to% L) := transform
      self.source_group := if(matchsourcegroup, L.source_group, '');
	  self := L;
end;

//****** project business headers into slimmer record format
#uniquename(bhinit)
#uniquename(bhdist)
#uniquename(bhdup)
#uniquename(ifdist)
%bhinit% := project(%match_to%(company_name<>''), %slimbh%(left));
%bhdist% := distribute(%bhinit%, hash(trim(company_name), trim(source), trim(source_group), trim(prim_name), zip));
%bhdup% := dedup(%bhdist%,zip,prim_name,prim_range,source,company_name,
					source_group,sec_range,phone,fein,all,local);

%ifdist% := distribute(infile, hash(trim(company_name), trim(source), trim(source_group), trim(prim_name), zip));

//****** join to find matches between infile and business header file
#uniquename(bmatch) 
%bmatch% := join(%ifdist%,
                 %bhdup%,
			     left.zip = right.zip and
			       left.prim_name = right.prim_name and
			       left.prim_range = right.prim_range and
                   left.source = right.source and
			       left.company_name = right.company_name and
                   (not matchsourcegroup or
                    left.source_group = right.source_group) and
			       ut.NNEQ(left.sec_range,right.sec_range) and
                   (left.phone = 0 OR right.phone = 0 OR left.phone = right.phone) and
			       (left.fein = 0 OR right.fein = 0 OR left.fein = right.fein),
			     %add_rid%(left,right),
                 left outer,
				 keep(1),
                 local);

outfile := %bmatch%;

endmacro;