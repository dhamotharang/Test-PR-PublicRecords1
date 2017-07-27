EXPORT IDmacros := MODULE
	
	export mac_JoinAllLinkids := MACRO
		left.UltID  = right.UltID  and  
     left.OrgID  = right.OrgID  and 
     left.SELEID = right.SELEID  and 
     left.ProxID = right.ProxID and
		 left.PowID  = right.PowID  and
		 left.EmpID  = right.EmpID  and
		 left.DotID  = right.DotID
	ENDMACRO;

	export mac_IespTransferLinkids(UseIdValue=true) := MACRO
		self.BusinessIds.DotID 		:= L.DotID;
		self.BusinessIds.EmpID 		:= L.EmpID;
		self.BusinessIds.POWID 		:= L.POWID;
		self.BusinessIds.ProxID 	:= L.ProxID;
		self.BusinessIds.SELEID 	:= L.SELEID;  
		self.BusinessIds.OrgID 		:= L.OrgID;
		self.BusinessIds.UltID 		:= L.UltID;
		#IF(UseIdValue=true) 
				self.IdValue	:= L.IdValue;
		#END
	ENDMACRO;
END;