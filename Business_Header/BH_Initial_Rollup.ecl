IMPORT Business_Header, ut;

EXPORT BH_Initial_Rollup(

	 dataset(Layout_Business_Header_Base)	pBusiness_Headers	= Files().Base.Business_Headers.QA

) :=
function

Layout_BH_Slim := RECORD
  unsigned6 rcid;
  unsigned6 bdid;
  string2   source;
  qstring34 source_group;
  string3   pflag;
  qstring120 company_name;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring8  sec_range;
  string2   state;
  unsigned3 zip;
  unsigned6 phone;
  unsigned4 fein;
END;

file_bh_previous := pBusiness_Headers;

//****** Slim down the business header to match fields
Layout_BH_Slim SlimBH(file_bh_previous L) := TRANSFORM
SELF.source_group := if(L.source_group = '' and L.source in Business_Header.Set_Source_Vendor_Id_Unique, L.vendor_id, L.source_group);
SELF.fein := if(ValidFEIN(l.fein), l.fein, 0);  // Zero the FEIN if prefix is invalid
SELF := L;
END;

BH_Slim := PROJECT(file_bh_previous(zip > 0 and prim_name <> ''), SlimBH(LEFT)); 

//-- Transform that assigns the right record id as old_rid and the left record id as new_rid
//	 Sets flag to RU1 (rule 1)
Business_Header.Layout_PairMatch Assign_RID(Layout_BH_Slim L, Layout_BH_Slim R) := TRANSFORM
  self.old_rid := R.rcid;
  self.new_rid := L.rcid;
  self.pflag := 1;
END;

//****** Join the business header file to itself
//	     Keep the lower record id as the new_rid
BH_Match := join(BH_Slim,
                 BH_Slim,
			       left.zip = right.zip and
			       left.prim_name = right.prim_name and
			       left.prim_range = right.prim_range and
                   left.source = right.source and
                   left.source_group = right.source_group and
			       left.company_name = right.company_name and
                   left.rcid < right.rcid and
			       ut.NNEQ(left.sec_range,right.sec_range) and
                   (left.phone = 0 OR right.phone = 0 OR left.phone = right.phone) and
			       (left.fein = 0 OR right.fein = 0 OR left.fein = right.fein),
               Assign_RID(left,right));
                
BH_Match_Sort := SORT(DISTRIBUTE(BH_Match, old_rid), old_rid, new_rid, LOCAL);

BH_Rollup := DEDUP(BH_Match_Sort, old_rid, LOCAL);

return BH_Rollup;

end;