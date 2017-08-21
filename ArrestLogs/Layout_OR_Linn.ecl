export Layout_OR_Linn:= 
MODULE  
 EXPORT Old
 := 
	RECORD
	STRING Name;
	STRING Master_ID;
	STRING Age;
	STRING SID;
	STRING Date_Lodged;
	STRING Arresting_Agency;
	STRING Scheduled_Release_Date;
	STRING Charge;
	STRING Charge_Description;
	STRING Docket;
	STRING Charge_Release_Date;
	STRING court;
	STRING Security;
	STRING Status;
 END;

 EXPORT New:=
 RECORD 
    STRING ID; 
	STRING Name; 
	STRING Age; 
	STRING Date_Lodged; 
	STRING Arresting_Agency; 
	STRING Scheduled_Release_Date; 
	STRING Charge; 
	STRING Charge_Description; 
	STRING Docket; 
	STRING Charge_Release_Date; 
	STRING Court; 
	STRING Security; 
	STRING Status;
 END;
END;