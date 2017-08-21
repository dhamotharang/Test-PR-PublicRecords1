export Process_xADL2_Layouts := MODULE
import SALT20;
shared h := File_PersonHeader;//The input file
export Key := index(h,{DID},{h},'~key::PersonLinkingADL2V2_PersonHeader'); // Base key for header file
export InputLayout := record,maxlength(4096)
  unsigned4 UniqueId; // This had better be unique or it will all break horribly
  h.NAME_SUFFIX;
  h.FNAME;
  h.MNAME;
  h.LNAME;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.CITY;
  h.STATE;
  h.ZIP;
  h.ZIP4;
  h.COUNTY;
  h.SSN5;
  h.SSN4;
  h.DOB;
  h.PHONE;
  string MAINNAME;//Wordbag field for concept
  string FULLNAME;//Wordbag field for concept
  string NAMESSN;//Wordbag field for concept
  string ADDR1;//Wordbag field for concept
  string LOCALE;//Wordbag field for concept
  string ADDRS;//Wordbag field for concept
// Below only used in header search (data returning) case
  boolean MatchRecords := false; // Only show records which match
  boolean FullMatch := false; // Only show DID if it has a record which fully matches
  SALT20.UIDType Entered_DID := 0; // Allow user to enter 4648096 to pull data
end;
export HardKeyMatch(InputLayout le) :=(le.FNAME <> (typeof(le.FNAME))'' AND le.LNAME <> (typeof(le.LNAME))'' AND le.CITY <> (typeof(le.CITY))'' AND le.STATE <> (typeof(le.STATE))'') OR (le.LNAME <> (typeof(le.LNAME))'' AND le.FNAME <> (typeof(le.FNAME))'' AND le.ZIP <> (typeof(le.ZIP))'') OR (le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'' AND le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.ZIP <> (typeof(le.ZIP))'' AND le.FNAME <> (typeof(le.FNAME))'') OR (le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'' AND le.ZIP <> (typeof(le.ZIP))'' AND le.LNAME <> (typeof(le.LNAME))'') OR (le.SSN5 <> (typeof(le.SSN5))'' AND le.SSN4 <> (typeof(le.SSN4))'') OR (le.FNAME <> (typeof(le.FNAME))'' AND le.SSN5 <> (typeof(le.SSN5))'') OR (le.SSN4 <> (typeof(le.SSN4))'' AND le.FNAME <> (typeof(le.FNAME))'') OR (le.DOB <> (typeof(le.DOB))'' AND le.LNAME <> (typeof(le.LNAME))'') OR (le.PHONE <> (typeof(le.PHONE))'' AND le.LNAME <> (typeof(le.LNAME))'' AND le.FNAME <> (typeof(le.FNAME))'') OR (le.ZIP <> (typeof(le.ZIP))'' AND le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'') OR (le.ZIP <> (typeof(le.ZIP))'' AND le.PRIM_NAME <> (typeof(le.PRIM_NAME))'') OR false;
export LayoutScoredFetch := record,maxlength(32000) // Nulls required for linkpaths that do not have field
  h.DID;
  unsigned2 Weight;
  SALT20.UIDType Reference := 0;//Presently for batch
  typeof(h.NAME_SUFFIX) NAME_SUFFIX := (typeof(h.NAME_SUFFIX))'';
  unsigned2 NAME_SUFFIXWeight := 0;
  typeof(h.FNAME) FNAME := (typeof(h.FNAME))'';
  unsigned2 FNAMEWeight := 0;
  typeof(h.MNAME) MNAME := (typeof(h.MNAME))'';
  unsigned2 MNAMEWeight := 0;
  typeof(h.LNAME) LNAME := (typeof(h.LNAME))'';
  unsigned2 LNAMEWeight := 0;
  typeof(h.PRIM_RANGE) PRIM_RANGE := (typeof(h.PRIM_RANGE))'';
  unsigned2 PRIM_RANGEWeight := 0;
  typeof(h.PRIM_NAME) PRIM_NAME := (typeof(h.PRIM_NAME))'';
  unsigned2 PRIM_NAMEWeight := 0;
  typeof(h.SEC_RANGE) SEC_RANGE := (typeof(h.SEC_RANGE))'';
  unsigned2 SEC_RANGEWeight := 0;
  typeof(h.CITY) CITY := (typeof(h.CITY))'';
  unsigned2 CITYWeight := 0;
  typeof(h.STATE) STATE := (typeof(h.STATE))'';
  unsigned2 STATEWeight := 0;
  typeof(h.ZIP) ZIP := (typeof(h.ZIP))'';
  unsigned2 ZIPWeight := 0;
  typeof(h.ZIP4) ZIP4 := (typeof(h.ZIP4))'';
  unsigned2 ZIP4Weight := 0;
  typeof(h.COUNTY) COUNTY := (typeof(h.COUNTY))'';
  unsigned2 COUNTYWeight := 0;
  typeof(h.SSN5) SSN5 := (typeof(h.SSN5))'';
  unsigned2 SSN5Weight := 0;
  typeof(h.SSN4) SSN4 := (typeof(h.SSN4))'';
  unsigned2 SSN4Weight := 0;
  unsigned2 DOB_year := 0;
  unsigned1 DOB_month := 0;
  unsigned1 DOB_day := 0;
  unsigned2 DOBWeight_year := 0;
  unsigned2 DOBWeight_month := 0;
  unsigned2 DOBWeight_day := 0;
  typeof(h.PHONE) PHONE := (typeof(h.PHONE))'';
  unsigned2 PHONEWeight := 0;
  string MAINNAME := ''; // Concepts always a wordbag
  unsigned2 MAINNAMEWeight := 0;
  string FULLNAME := ''; // Concepts always a wordbag
  unsigned2 FULLNAMEWeight := 0;
  string NAMESSN := ''; // Concepts always a wordbag
  unsigned2 NAMESSNWeight := 0;
  string ADDR1 := ''; // Concepts always a wordbag
  unsigned2 ADDR1Weight := 0;
  string LOCALE := ''; // Concepts always a wordbag
  unsigned2 LOCALEWeight := 0;
  string ADDRS := ''; // Concepts always a wordbag
  unsigned2 ADDRSWeight := 0;
  unsigned4 keys_used; // A bitmap of the keys used
end;
export LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri) := transform
  self.NAME_SUFFIXWeight := IF ( le.NAME_SUFFIXWeight>ri.NAME_SUFFIXWeight, le.NAME_SUFFIXWeight, ri.NAME_SUFFIXWeight );
  self.NAME_SUFFIX := IF ( le.NAME_SUFFIXWeight>ri.NAME_SUFFIXWeight, le.NAME_SUFFIX, ri.NAME_SUFFIX );
  self.FNAMEWeight := IF ( le.FNAMEWeight>ri.FNAMEWeight, le.FNAMEWeight, ri.FNAMEWeight );
  self.FNAME := IF ( le.FNAMEWeight>ri.FNAMEWeight, le.FNAME, ri.FNAME );
  self.MNAMEWeight := IF ( le.MNAMEWeight>ri.MNAMEWeight, le.MNAMEWeight, ri.MNAMEWeight );
  self.MNAME := IF ( le.MNAMEWeight>ri.MNAMEWeight, le.MNAME, ri.MNAME );
  self.LNAMEWeight := IF ( le.LNAMEWeight>ri.LNAMEWeight, le.LNAMEWeight, ri.LNAMEWeight );
  self.LNAME := IF ( le.LNAMEWeight>ri.LNAMEWeight, le.LNAME, ri.LNAME );
  self.PRIM_RANGEWeight := IF ( le.PRIM_RANGEWeight>ri.PRIM_RANGEWeight, le.PRIM_RANGEWeight, ri.PRIM_RANGEWeight );
  self.PRIM_RANGE := IF ( le.PRIM_RANGEWeight>ri.PRIM_RANGEWeight, le.PRIM_RANGE, ri.PRIM_RANGE );
  self.PRIM_NAMEWeight := IF ( le.PRIM_NAMEWeight>ri.PRIM_NAMEWeight, le.PRIM_NAMEWeight, ri.PRIM_NAMEWeight );
  self.PRIM_NAME := IF ( le.PRIM_NAMEWeight>ri.PRIM_NAMEWeight, le.PRIM_NAME, ri.PRIM_NAME );
  self.SEC_RANGEWeight := IF ( le.SEC_RANGEWeight>ri.SEC_RANGEWeight, le.SEC_RANGEWeight, ri.SEC_RANGEWeight );
  self.SEC_RANGE := IF ( le.SEC_RANGEWeight>ri.SEC_RANGEWeight, le.SEC_RANGE, ri.SEC_RANGE );
  self.CITYWeight := IF ( le.CITYWeight>ri.CITYWeight, le.CITYWeight, ri.CITYWeight );
  self.CITY := IF ( le.CITYWeight>ri.CITYWeight, le.CITY, ri.CITY );
  self.STATEWeight := IF ( le.STATEWeight>ri.STATEWeight, le.STATEWeight, ri.STATEWeight );
  self.STATE := IF ( le.STATEWeight>ri.STATEWeight, le.STATE, ri.STATE );
  self.ZIPWeight := IF ( le.ZIPWeight>ri.ZIPWeight, le.ZIPWeight, ri.ZIPWeight );
  self.ZIP := IF ( le.ZIPWeight>ri.ZIPWeight, le.ZIP, ri.ZIP );
  self.ZIP4Weight := IF ( le.ZIP4Weight>ri.ZIP4Weight, le.ZIP4Weight, ri.ZIP4Weight );
  self.ZIP4 := IF ( le.ZIP4Weight>ri.ZIP4Weight, le.ZIP4, ri.ZIP4 );
  self.COUNTYWeight := IF ( le.COUNTYWeight>ri.COUNTYWeight, le.COUNTYWeight, ri.COUNTYWeight );
  self.COUNTY := IF ( le.COUNTYWeight>ri.COUNTYWeight, le.COUNTY, ri.COUNTY );
  self.SSN5Weight := IF ( le.SSN5Weight>ri.SSN5Weight, le.SSN5Weight, ri.SSN5Weight );
  self.SSN5 := IF ( le.SSN5Weight>ri.SSN5Weight, le.SSN5, ri.SSN5 );
  self.SSN4Weight := IF ( le.SSN4Weight>ri.SSN4Weight, le.SSN4Weight, ri.SSN4Weight );
  self.SSN4 := IF ( le.SSN4Weight>ri.SSN4Weight, le.SSN4, ri.SSN4 );
  self.DOBWeight_year := IF ( le.DOBWeight_year>ri.DOBWeight_year, le.DOBWeight_year, ri.DOBWeight_year );
  self.DOB_year := IF ( le.DOBWeight_year>ri.DOBWeight_year, le.DOB_year, ri.DOB_year );
  self.DOBWeight_month := IF ( le.DOBWeight_month>ri.DOBWeight_month, le.DOBWeight_month, ri.DOBWeight_month );
  self.DOB_month := IF ( le.DOBWeight_month>ri.DOBWeight_month, le.DOB_month, ri.DOB_month );
  self.DOBWeight_day := IF ( le.DOBWeight_day>ri.DOBWeight_day, le.DOBWeight_day, ri.DOBWeight_day );
  self.DOB_day := IF ( le.DOBWeight_day>ri.DOBWeight_day, le.DOB_day, ri.DOB_day );
  self.PHONEWeight := IF ( le.PHONEWeight>ri.PHONEWeight, le.PHONEWeight, ri.PHONEWeight );
  self.PHONE := IF ( le.PHONEWeight>ri.PHONEWeight, le.PHONE, ri.PHONE );
  self.MAINNAMEWeight := IF ( le.MAINNAMEWeight>ri.MAINNAMEWeight, le.MAINNAMEWeight, ri.MAINNAMEWeight );
  self.MAINNAME := IF ( le.MAINNAMEWeight>ri.MAINNAMEWeight, le.MAINNAME, ri.MAINNAME );
  self.FULLNAMEWeight := IF ( le.FULLNAMEWeight>ri.FULLNAMEWeight, le.FULLNAMEWeight, ri.FULLNAMEWeight );
  self.FULLNAME := IF ( le.FULLNAMEWeight>ri.FULLNAMEWeight, le.FULLNAME, ri.FULLNAME );
  self.NAMESSNWeight := IF ( le.NAMESSNWeight>ri.NAMESSNWeight, le.NAMESSNWeight, ri.NAMESSNWeight );
  self.NAMESSN := IF ( le.NAMESSNWeight>ri.NAMESSNWeight, le.NAMESSN, ri.NAMESSN );
  self.ADDR1Weight := IF ( le.ADDR1Weight>ri.ADDR1Weight, le.ADDR1Weight, ri.ADDR1Weight );
  self.ADDR1 := IF ( le.ADDR1Weight>ri.ADDR1Weight, le.ADDR1, ri.ADDR1 );
  self.LOCALEWeight := IF ( le.LOCALEWeight>ri.LOCALEWeight, le.LOCALEWeight, ri.LOCALEWeight );
  self.LOCALE := IF ( le.LOCALEWeight>ri.LOCALEWeight, le.LOCALE, ri.LOCALE );
  self.ADDRSWeight := IF ( le.ADDRSWeight>ri.ADDRSWeight, le.ADDRSWeight, ri.ADDRSWeight );
  self.ADDRS := IF ( le.ADDRSWeight>ri.ADDRSWeight, le.ADDRS, ri.ADDRS );
  self.keys_used := le.keys_used | ri.keys_used;
  self.Weight :=  self.NAME_SUFFIXWeight +  self.FNAMEWeight +  self.MNAMEWeight +  self.LNAMEWeight +  self.PRIM_RANGEWeight +  self.PRIM_NAMEWeight +  self.SEC_RANGEWeight +  self.CITYWeight +  self.STATEWeight +  self.ZIPWeight +  self.ZIP4Weight +  self.COUNTYWeight +  self.SSN5Weight +  self.SSN4Weight +  self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day +  self.PHONEWeight +  self.MAINNAMEWeight +  self.FULLNAMEWeight +  self.NAMESSNWeight +  self.ADDR1Weight +  self.LOCALEWeight +  self.ADDRSWeight;
  self := le;
end;
shared OutputLayout_Base := record,maxlength(32000)
  boolean Verified := false; // has found possible results
  boolean Ambiguous := false; // has >= 20 dids within an order of magnitude of best
  boolean ShortList := false; // has < 20 dids within an order of magnitude of best
  boolean Handful := false; // has <6 IDs within two orders of magnitude of best
  boolean Resolved := false; // certain with 3 nines of accuracy
  dataset(LayoutScoredFetch) Results;
end;
export OutputLayout := record(OutputLayout_Base),maxlength(32000)
  InputLayout;
end;
export OutputLayout_Batch := record(OutputLayout_Base),maxlength(32006)
  SALT20.UIDType Reference;
end;
export MAC_Add_ResolutionFlags() := macro
  self.Verified := exists(self.results);
  self.Ambiguous := COUNT(self.results(Weight>=MAX(self.results,Weight)-1)) >= 20;
  self.ShortList := COUNT(self.results(Weight>=MAX(self.results,Weight)-1)) < 20 and self.verified;
  self.Handful := COUNT(self.results(Weight>=MAX(self.results,Weight)-3)) < 6 and self.verified;
  self.Resolved := COUNT(self.results(Weight>=MAX(self.results,Weight)-5)) = 1;
endmacro;

export SubInputLayout := record, maxlength(4096)
		unsigned4 UniqueId; // This had better be unique or it will all break horribly
		h.NAME_SUFFIX;
		h.FNAME;
		h.MNAME;
		h.LNAME;
		h.PRIM_RANGE;
		h.PRIM_NAME;
		h.SEC_RANGE;
		h.CITY;
		h.STATE;
		h.ZIP;
		h.ZIP4;
		h.COUNTY;
		h.SSN5;
		h.SSN4;
		h.DOB;
		h.PHONE;
end;
export OutputLayout_Batchfull := record(OutputLayout_Batch),maxlength(32006)
  subInputLayout;
end;

export Layout_xADL2_ScoreFetch := record(LayoutScoredFetch),maxlength(32000)
		unsigned2 Score :=100;
	end;

	export OutputLayout_BatchThin := record//,maxlength(32006)
		Layout_xADL2_ScoreFetch.DID;
		Layout_xADL2_ScoreFetch.score;
		SALT20.UIDType Reference;
	end;

	Export Layout_xADL2_Score := record, maxlength(100000)
		SALT20.UIDType Reference;
		//boolean linked := false;
		boolean Verified := false; // has found possible results
		boolean Ambiguous := false; // has >= 20 dids within an order of magnitude of best
		boolean ShortList := false; // has < 20 dids within an order of magnitude of best
		boolean Handful := false; // has <6 IDs within two orders of magnitude of best
		boolean Resolved := false; // certain with 3 nines of accuracy
		dataset(Layout_xADL2_ScoreFetch) results;
	end;

	Export OuputLayout_xADL2 := record, maxlength(100000)
		Layout_xADL2_Score;
		InputLayout;
	END;
	
	export CalculateADL2Score(dataset(OutputLayout_Batch) rsADL2, integer mthHold=75) := Function
		Score_layout :=record
				Layout_xADL2_ScoreFetch;
				//boolean linked := false;
				boolean resolved := false;		
				unsigned2 level:=0; // the distance betweet top candidate and the current one by weight
				real8 chance:=1.0; 
		end;
		layout_withWeight := record, maxlength(100000)
				SALT20.UIDType Reference := 0;
				boolean resolved := false;	
				unsigned2 Weight;
				real8 sumChance :=1.0;
				dataset(Score_layout) results;
		end;
		layout_withWeight transferNewLayout(rsADL2 L) := transform
				self.weight:=L.results[1].weight;
				self.results:= project(L.results, Score_layout);
				self :=L;
		end;
		//copy the first candidates in parent for calculating levels
		rsWithWeight := project(rsADL2,transferNewLayout(left));
		//output(rsWithWeight);
		Score_layout getInterMediateResult(rsWithWeight L, Score_layout R, integer c) :=transform, skip(c>20)
				self.reference := L.reference;
				self.score := 100;
				self.level := L.weight-R.weight;//if(R.weight>=30, L.weight-R.weight,L.weight-30);
				self.chance := 1.0/power(2,self.level);//if(self.level>20, 0, 1.0/power(2,self.level));
				self.resolved := L.resolved;
				//self.linked := L.resolved;
				self :=R;
		end;
		rsItermediateScore := normalize(rsWithWeight,left.results,getInterMediateResult(left, right, counter));
		//output(rsItermediateScore);
		layout_withWeight calculateSumChance(layout_withWeight L, dataset(Score_layout) R) := transform
					self.sumChance := sum(R, chance);
					self.Results := R;
					self := L;
			end;
			rsWithWeightScore := denormalize(rsWithWeight, rsItermediateScore, 
																			left.reference=right.reference, 
																			group,
																			calculateSumChance(left, rows(right)));
			//output(rsWithWeightScore);
			Score_layout getResult(rsWithWeightScore L, Score_layout R):=transform
							self.score := round(R.chance*100/L.sumChance);
							self.resolved := if(self.score>=mthHold, true, false);
							self :=R;
			end;
			rsFinalScore := normalize(rsWithWeightScore,left.results,getResult(left, right));
			
			//put back to batch layout with score and linked
			Layout_xADL2_Score updatedResolved(rsADL2 L, dataset(Score_layout) R) :=transform
					self.results := project(R, transform(Layout_xADL2_ScoreFetch, self:=left));
					self.resolved := R[1].resolved;
					self := L;
			end;
			
			rsWithxADL2Score := denormalize(rsADL2, rsFinalScore, 
																			left.reference=right.reference, 
																			group,
																			updatedResolved(left, rows(right)));
			 return rsWithxADL2Score;
end;
export CombineAllScores(dataset(LayoutScoredFetch) in_data) := function
	OutputLayout_Batch into(in_data le) := transform
		self.Reference := le.Reference;
		self.Results := dataset([le],LayoutScoredFetch);
		MAC_Add_ResolutionFlags()
	end;
	OutputLayout_Batch Create_Output(OutputLayout_Batch le, OutputLayout_Batch ri) := transform
		self.Results := le.results+ri.results;
		self.Reference := le.Reference;
		MAC_Add_ResolutionFlags()
	end;
		r := rollup( sort( group( sort ( distribute(In_Data,hash(reference)),Reference, local ), Reference, Local),DID),left.DID=right.DID,Combine_Scores(left,right));
		r1 := rollup( project(topn(r,100,-Weight),into(left)),true, Create_Output(left,right) );
		return(CalculateADL2Score(group(r1)));
		//return group(r1);
end;

export KeysUsedToText(unsigned4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'FLCST,','') + IF(k&(1<<2)<>0,'LFZ,','') + IF(k&(1<<3)<>0,'ADDRESS1,','') + IF(k&(1<<4)<>0,'ADDRESS2,','') + IF(k&(1<<5)<>0,'S,','') + IF(k&(1<<6)<>0,'NAMESS,','') + IF(k&(1<<7)<>0,'SSN4,','') + IF(k&(1<<8)<>0,'DO,','') + IF(k&(1<<9)<>0,'PH,','') + IF(k&(1<<10)<>0,'ZPRF,','') + IF(k&(1<<11)<>0,'ZPNF,','');
  return list[1..length(trim(list))-1]; // Strim last ,
end;
export Layout_RolledEntity := record,maxlength(63000)
  SALT20.UIDType DID;
  dataset(SALT20.Layout_FieldValueList) DOB_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) PHONE_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) FULLNAME_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) NAMESSN_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) ADDRS_Values := dataset([],SALT20.Layout_FieldValueList);
end;
shared RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self.DID := le.DID;
  self.DOB_values := SALT20.fn_combine_fieldvaluelist(le.DOB_values,ri.DOB_values);
  self.PHONE_values := SALT20.fn_combine_fieldvaluelist(le.PHONE_values,ri.PHONE_values);
  self.FULLNAME_values := SALT20.fn_combine_fieldvaluelist(le.FULLNAME_values,ri.FULLNAME_values);
  self.NAMESSN_values := SALT20.fn_combine_fieldvaluelist(le.NAMESSN_values,ri.NAMESSN_values);
  self.ADDRS_values := SALT20.fn_combine_fieldvaluelist(le.ADDRS_values,ri.ADDRS_values);
end;
  return rollup( sort( distribute( infile, hash(DID) ), DID, local ), left.DID = right.DID, RollValues(left,right),local);
end;
export RolledEntities(dataset(recordof(Key)) in_data) := function
Layout_RolledEntity into(in_data le) := transform
  self.DID := le.DID;
  self.DOB_Values := IF ( (unsigned)le.DOB = 0,dataset([],SALT20.Layout_FieldValueList),dataset([{(string)le.DOB}],SALT20.Layout_FieldValueList));
  self.PHONE_Values := IF ( (string)le.PHONE = '',dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.PHONE)}],SALT20.Layout_FieldValueList));
  self.FULLNAME_Values := IF ( (string)le.FNAME = '' AND (string)le.MNAME = '' AND (string)le.LNAME = '' AND (string)le.NAME_SUFFIX = '',dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.FNAME) + ' ' + trim((string)le.MNAME) + ' ' + trim((string)le.LNAME) + ' ' + trim((string)le.NAME_SUFFIX)}],SALT20.Layout_FieldValueList));
  self.NAMESSN_Values := IF ( (string)le.FNAME = '' AND (string)le.MNAME = '' AND (string)le.LNAME = '' AND (string)le.SSN5 = '' AND (string)le.SSN4 = '',dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.FNAME) + ' ' + trim((string)le.MNAME) + ' ' + trim((string)le.LNAME) + ' ' + trim((string)le.SSN5) + ' ' + trim((string)le.SSN4)}],SALT20.Layout_FieldValueList));
  self.ADDRS_Values := IF ( (string)le.PRIM_RANGE = '' AND (string)le.PRIM_NAME = '' AND (string)le.SEC_RANGE = '' AND (string)le.ZIP4 = '' AND (string)le.COUNTY = '' AND (string)le.CITY = '' AND (string)le.STATE = '' AND (string)le.ZIP = '',dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.PRIM_RANGE) + ' ' + trim((string)le.PRIM_NAME) + ' ' + trim((string)le.SEC_RANGE) + ' ' + trim((string)le.ZIP4) + ' ' + trim((string)le.COUNTY) + ' ' + trim((string)le.CITY) + ' ' + trim((string)le.STATE) + ' ' + trim((string)le.ZIP)}],SALT20.Layout_FieldValueList));
end;
AsFieldValues := project(in_data,into(left));
  return RollEntities(AsFieldValues);
end;
end;
