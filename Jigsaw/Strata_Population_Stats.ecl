//Produces STRATA population statistics
import strata, tools;
export Strata_Population_Stats(string pversion) :=
module
	export Business_headers :=
	module
 
		Strata.createAsBusinessStats.Header(fAs_Business_Header_Jigsaw(files().base.qa),_Dataset().name,'Jigsaw',pversion,Email_Notification_Lists().stats,Jigsaw);
		
                              
		export all :=
		sequential( Jigsaw );

	end;

	export Business_Contacts :=
	module

		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_Jigsaw(files().base.qa),_Dataset().name,'Jigsaw',pversion,Email_Notification_Lists().stats,Jigsaw);
		

		export all :=
		sequential( Jigsaw );

	end;
	
	export all := if(tools.fun_IsValidVersion(pversion),
	sequential(
		 business_headers.all
		,business_contacts.all
	));

end;