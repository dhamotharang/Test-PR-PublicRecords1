IMPORT Cortera;
EXPORT proc_link_bip(DATASET($.Layout_Tradeline_base) tradelines = $.Files.Base) := FUNCTION

	key := DISTRIBUTE(PULL(Cortera.Key_Header_Link_Id(current=true)), link_id);
	b := DISTRIBUTE(tradelines, Link_id);
	
	j := JOIN(b, key, left.link_id=right.link_id, TRANSFORM($.Layout_Tradeline_base,
			self.bdid := right.bdid;
			self.bdid_score := right.bdid_score;
			
			self.DotID			:= right.DotID;
			self.DotScore	:= right.DotScore;
			self.DotWeight	:= right.DotWeight;
   
			self.EmpID			:= right.EmpID;
			self.EmpScore	:= right.EmpScore;
			self.EmpWeight	:= right.EmpWeight;
	
			self.POWID			:= right.POWID;
			self.POWScore	:= right.POWScore;
			self.POWWeight	:= right.POWWeight;
	
			self.ProxID		:= right.ProxID;
			self.ProxScore	:= right.ProxScore;
			self.ProxWeight:= right.ProxWeight;
	
			self.SELEID		:= right.SELEID;
			self.SELEScore	:= right.SELEScore;
			self.SELEWeight:= right.SELEWeight;	
	
			self.OrgID			:= right.OrgID;
			self.OrgScore	:= right.OrgScore;
			self.OrgWeight	:= right.OrgWeight;
	
			self.UltID			:= right.UltID;
			self.UltScore	:= right.UltScore;
			self.UltWeight	:= right.UltWeight;	
			
			self := LEFT;),
			LEFT OUTER, KEEP(1), LOCAL);
			
		return j;
END;