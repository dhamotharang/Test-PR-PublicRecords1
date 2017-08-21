import roxiekeybuild,_control;
export Email_Notification_Lists := 
module

	export Spray 	:= if(IsTesting, 'lbentley@seisint.com', _control.MyInfo.EmailAddressNotify +';lbentley@seisint.com; ehamel@seisint.com; jfreibaum@seisint.com; melanie.jackson@lexisnexis.com');
	export Stats	:= if(IsTesting, 'skasavajjala@seisint.com','lbentley@seisint.com; tmiddleton@seisint.com; jvilaplana@seisint.com; qualityassurance@seisint.com; jfreibaum@seisint.com; melanie.jackson@lexisnexis.com' );
	export Roxie	:= if(IsTesting, 'lbentley@seisint.com', roxiekeybuild.Email_Notification_List + ';lbentley@seisint.com; vniemela@seisint.com; melanie.jackson@lexisnexis.com; skasavajjala@seisint.com; jfreibaum@seisint.com');
	
end;	