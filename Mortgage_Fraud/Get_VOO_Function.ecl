
import   Risk_Indicators, ut,  VerificationOfOccupancy, Mortgage_Fraud, Std;

EXPORT Get_VOO_Function(DATASET(Mortgage_Fraud.layouts.Layout_BocaShell_Out) Boca_In, 
																						string50 DataRestrictionMask, 
																						integer glba,  
																						integer dppa,
																						string50 DataPermissionMask,
																						BOOLEAN   DISPLAYOutput = false
																						) := FUNCTION

Risk_Indicators.Layout_Boca_Shell norm(Boca_in L, integer C) := transform
	self.seq := L.Borrower1_Boca_out.seq + C - 1;
	self := if (C = 1, L.Borrower1_Boca_out, L.Borrower2_Boca_out);
end;

Boca_norm := normalize(Boca_in, 2, norm(LEFT,COUNTER));



  VerificationOfOccupancy.Layouts.Layout_VOOIn intoVOOlayout(Boca_norm l) := TRANSFORM
		self.LexID 								:= l.shell_input.did;
		self.seq 									:= l.shell_input.seq;
		self.AsOf 								:= (string)l.historydate;
		self.Name_First           := l.shell_input.fname;
		self.Name_Middle          := l.shell_input.mname;
		self.Name_Last            := l.shell_input.lname;
		self.ssn                  := l.shell_input.ssn;
		self.dob                  := l.shell_input.dob;
		self.phone10              := l.shell_input.phone10;
		
		self.street_addr        := l.shell_input.in_streetAddress;
		self.streetnumber       := l.shell_input.prim_range;
		self.streetpredirection :=  l.shell_input.predir;
		self.streetname         := l.shell_input.prim_name;
		self.streetsuffix       := l.shell_input.addr_suffix;
		self.streetpostdirection := l.shell_input.postdir;
		self.unitdesignation    := l.shell_input.unit_desig;  
		self.unitnumber         := l.shell_input.sec_range;
		 
		self.City_name          := l.shell_input.p_city_name;
		self.st                 := l.shell_input.st;
		self.z5                 := l.shell_input.z5;
		self.country            := l.shell_input.country;
		self											:= [];
	END;
	
	VOO_Input := PROJECT(Boca_norm, intoVOOlayout(left));	
	
	
	// Check a certain input param so the appropriate boolean value isUtility can be passed in below
	IndustryClassIn   := 'UTILI';
  BOOLEAN isUtility := STD.STR.ToUpperCase(IndustryClassIn) = 'UTILI';

	ds_VOO_recs := VerificationOfOccupancy.Search_Function(
	                                                        VOO_Input, 
																													DataRestrictionMask, 
																													glba, 
																													dppa, 
																													isUtility,
																													'VOOATTRV1',  //AttributesVersion
										                                       TRUE,        //IncludeModel 
																													DataPermissionMask, 
																													FALSE,
									                                        FALSE
									                                        ).VOOReport;																										
																																																																				
		
	Mortgage_Fraud.revised_layouts.Layout_Mortgage_Shell_VOO add_VOO_attributes(Boca_norm le, ds_VOO_recs ri) := TRANSFORM
	     self.VOO_attributes.version1.AddressReportingSourceIndex  := ri.attributes.version1.AddressReportingSourceIndex;
	     self.VOO_attributes.version1.AddressReportingHistoryIndex := ri.attributes.version1.AddressReportingHistoryIndex;
			 self.VOO_attributes.version1.AddressSearchHistoryIndex    := ri.attributes.version1.AddressSearchHistoryIndex;
			 SELF.voo_attributes.version1.addressutilityhistoryindex   := ri.attributes.version1.addressutilityhistoryindex;
			 SELF.voo_attributes.version1.addressownershiphistoryindex := ri.attributes.version1.addressownershiphistoryindex;
			 SELF.voo_attributes.version1.addresspropertytypeindex     := ri.attributes.version1.addresspropertytypeindex; 
			 SELF.voo_attributes.version1.addressvalidityindex         := ri.attributes.version1.addressvalidityindex;
			 SELF.voo_attributes.version1.relativesconfirmingaddressindex  := ri.attributes.version1.relativesconfirmingaddressindex;
			 SELF.voo_attributes.version1.AddressOwnerMailingAddressIndex  := ri.attributes.version1.AddressOwnerMailingAddressIndex;
			 SELF.voo_attributes.version1.PriorAddressMoveIndex            := ri.attributes.version1.PriorAddressMoveIndex;
			 SELF.voo_attributes.version1.PriorResidentMoveIndex           := ri.attributes.version1.PriorResidentMoveIndex;
			 SELF.voo_attributes.version1.AddressDateFirstSeen             := ri.attributes.version1.AddressDateFirstSeen;
			 SELF.voo_attributes.version1.AddressDateLastSeen              := ri.attributes.version1.AddressDateLastSeen;
			 SELF.voo_attributes.version1.OccupancyOverride                := ri.attributes.version1.OccupancyOverride;
			 SELF.voo_attributes.version1.InferredOwnershipTypeIndex       := ri.attributes.version1.InferredOwnershipTypeIndex;
			 SELF.voo_attributes.version1.OtherOwnedPropertyProximity      := ri.attributes.version1.OtherOwnedPropertyProximity;
			 SELF.voo_attributes.version1.VerificationOfOccupancyScore     := ri.attributes.version1.VerificationOfOccupancyScore;
			 self := le;
			 
  END;
  
	outf := join(Boca_norm, ds_VOO_recs, left.shell_input.seq = right.seq, add_VOO_attributes(LEFT,RIGHT), LEFT OUTER);
	
   outseq := record
	   unsigned4	seq;
	   Mortgage_Fraud.revised_layouts.Layout_Mortgage_Shell;
   end;

   outseq into_out1(outf L) := transform
	   self.seq := If (L.seq % 2 = 0, L.seq, skip);
	   self.MRR_Borrower1 := L;
	   self := [];
   end;

   outf2 := project(outf, into_out1(LEFT));

   Mortgage_Fraud.revised_layouts.Layout_Mortgage_Shell into_out2(outf2 L, outf R) := transform
	   self.MRR_Borrower2 := R;
	   self := L;
   end;

  finalwV := join(outf2, outf, left.seq = right.seq - 1, into_out2(LEFT,RIGHT), left outer);	
	
	IF(DISPLAYOutput,   output(finalwV,        named('finalwV'),     overwrite));
	IF(DISPLAYOutput,   output(ds_VOO_recs,    named('ds_VOO_recs'), overwrite));
	IF(DISPLAYOutput,   output(voo_input,      named('VOO_Input'),   overwrite));
	
		
	RETURN finalwV;  
END; 																											