import doxie;
export Keys := module

	EXPORT Key_BBB_Member_BDID 		 := INDEX(Files.Key_BBB_BDID,{bdid},					 {Files.Key_BBB_BDID},					 Constants.Key_BBB_Member_BDID_Name);
	EXPORT Key_BBB_Non_Member_BDID := INDEX(Files.Key_BBB_Non_Member_BDID,{bdid},{Files.Key_BBB_Non_Member_BDID},Constants.Key_BBB_Non_Member_BDID_Name);
	
	EXPORT Key_BBB_Member_LinkIds 		:= INDEX(Files.Key_BBB_LinkIds,						{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},{Files.Key_BBB_LinkIds},					 Constants.Key_BBB_Member_LinkIds_Name);
	EXPORT Key_BBB_Non_Member_LinkIds := INDEX(Files.Key_BBB_Non_Member_LinkIds,{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},{Files.Key_BBB_Non_Member_LinkIds},Constants.Key_BBB_Non_Member_LinkIds_Name);
	
end;