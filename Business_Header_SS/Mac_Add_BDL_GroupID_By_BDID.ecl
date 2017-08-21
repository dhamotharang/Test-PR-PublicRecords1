//**** Macro that adds the BDL and Group_Ids to a given file that has the BDID.
import Business_Header;

export Mac_Add_BDL_GroupID_By_BDID(
	 
	 infile
	,BDID_field
	,BDL_field
	,GroupID_field
	,outfile
	,pFileVersion						= '\'prod\''														// default to using the "prod" version of the bdl superfile
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.

) := macro

#uniquename(dbdl2)
%dbdl2% := Business_Header.files(pFileVersion,pUseOtherEnvironment).base.bdl2.logical;

#uniquename(should_join)
%should_join% := infile.bdid_field > 0; // and (integer)infile.bdl_field = 0;

#uniquename(infile_attempt)
#uniquename(infile_skip)
%infile_attempt% := infile(%should_join%);
%infile_skip%    := infile(~%should_join%);

#uniquename(dbdl)
%dbdl% := dedup(sort(distribute(%dbdl2%(bdl <> 0), (unsigned6)bdid),bdid,local),bdid,local);

#uniquename(dtbdl)
%dtbdl% := table(%dbdl%, {%dbdl%.bdid, %dbdl%.bdl, %dbdl%.group_id});

#uniquename(infile_dist)
%infile_dist% := distribute(%infile_attempt%, (unsigned6)bdid_field);

#uniquename(add_BDL)
typeof(infile) %add_bdl%(%infile_dist% l, %dtbdl% r) := transform
	self.bdl_field			:= r.bdl;
	self.GroupID_field	:= r.group_id;
	self :=l;
end;

#uniquename(bdl_added)
%bdl_added% := join(%infile_dist%,%dtbdl%,
										(unsigned6)left.bdid_field = (unsigned6)right.bdid,
										%add_bdl%(left, right),
										left outer,
										local);

//****** Add back those that skipped over
outfile := %bdl_added% + %infile_skip%;

endmacro;