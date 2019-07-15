/*

BIP Business header WAF (We Also Found) Key build:

	Overview: BIP WAF Key is built using the below 5 sources
						1) BIP Business Contacts
						2) Corporation (Corp2)
						3) Property (LN_PropertyV2)
						4) UCC (UCCV2)
						5) Moter Vehicles (VehicleV2)

	The Build:
		
		Quick documentation to run the build:

			Thor Module		: BIPV2_WAF
			Orbit Build		: BIPV2_WAF_Build
			Frequency			: Weekly
		
			1.  Open BIPV2_WAF.BWR_Build_WAF in a builder window.  Change the pversion to today's date.
			2.  Execute it.
			3.	In Orbit, create a build instance for "BIPV2_WAF_Build" key build.  Add the source file(s) used in the build.
					When the build finishes and goes up into roxie dev, update the Platform Build status (Non FCRA) to "On Development" and 
					Status to "Build Available for Use"
			4.	The build will send you an email when it finishes successfully, or a fail email if it fails.

	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.  

*/