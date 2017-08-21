//********************************************************************************
//* This assume that the incoming layout has an appended BIPV@.IDLayouts fields.  
//* So the the outgoing layout can be project into the original layout to minimize
//* a project post function into the desired layout.
//*
//* The COMPANY_FIELD should be the field name of the company name being used to populate
//* the linkid(s) fields.  If dataset contains mutliple company names, normalization may be 
//* required.
//**********************************************************************************
import prte_bip, BIPV2, ut;
EXPORT fn_PopulateLinkIDs(inFile, company_field = 'company_name') := FUNCTIONMACRO

temp_layout := record
unsigned8 	unique_id;
recordof(inFile) - BIPV2.IDlayouts.l_xlink_ids;
end;

project_2_temp_layout	:= project(inFile, transform(temp_layout, self := left; self.unique_id := 0));

ut.MAC_Sequence_Records(project_2_temp_layout, unique_id, project_infile_2_temp_layout_seq );

project_2_fakeId_layout			:= project(project_infile_2_temp_layout_seq,transform(prte_bip.Layout_Append_FakeIDs.LinkIds
																																									  ,self.company_name 	:= left.company_field;
																																										,self 							:= left;
																																										,self 							:= [];
																																										)
																				 );

stamp_infile_with_linkids		:= prte_bip.fn_Append_Fake_LinkIDs(project_2_fakeId_layout);

new_layout := record
temp_layout - unique_id;
BIPV2.IDlayouts.l_xlink_ids;
end;

new_layout 			AssignIDs(temp_layout l, prte_bip.Layout_Append_FakeIDs.LinkIds r) := transform
		self.DotID			:= r.DotID;
		self.DotScore		:= r.DotScore;
		self.DotWeight	:= r.DotWeight;
		self.EmpID			:= r.EmpID;
		self.EmpScore		:= r.EmpScore;
		self.EmpWeight	:= r.EmpWeight;
		self.POWID			:= r.POWID;
		self.POWScore		:= r.POWScore;
		self.POWWeight	:= r.POWWeight;
		self.ProxID			:= r.ProxID;
		self.ProxScore	:= r.ProxScore;
		self.ProxWeight	:= r.ProxWeight;
		self.SELEID			:= r.SELEID;
		self.SELEScore	:= r.SELEScore;
		self.SELEWeight	:= r.SELEWeight;	
		self.OrgID			:= r.OrgID;
		self.OrgScore		:= r.OrgScore;
		self.OrgWeight	:= r.OrgWeight;
		self.UltID			:= r.UltID;
		self.UltScore		:= r.UltScore;
		self.UltWeight	:= r.UltWeight;
		self 						:= l;
		self						:= [];
	end;

	stamped_linkids										  := join(project_infile_2_temp_layout_seq,
																														stamp_infile_with_linkids,
																														left.unique_id = right.unique_id,
																														AssignIDs(left, right),
																														left outer
																														);

 
  outfile := project(stamped_linkids, transform(recordof(inFile),SELF := LEFT)); 
 	return outfile;

ENDMACRO;