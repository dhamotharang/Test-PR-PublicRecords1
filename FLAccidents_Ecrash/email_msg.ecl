import _control,STD;
EXPORT email_msg := MODULE

EXPORT NOC_MSG 

		
	:=
	'** ALERT **** ECRASH BUILD FAILURE **\n\n'

	+'http://'+_control.IPAddress.prod_thor_esp+':8010/?Wuid='+STD.System.Job.WUID()+'&Widget=WUDetailsWidget#/stub/Summary\n\n'

	+'Please view below contacts:\n'
	+'Sudhir Kasavajjala(Primary Contact) Ph # 561-789-8594 Email : Sudhir.Kasavajjala@lexisnexisrisk.com\n'
  +'Chris Brodeur( Secondary Contact) Email : Christopher.Brodeur@lexisnexisrisk.com\n\n'

	
	;

END;