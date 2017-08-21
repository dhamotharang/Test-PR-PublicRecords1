export Keys :=
module

	export Moxie :=
	module
		shared unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
		  if (filepos<headersize, rawsize+filepos, filepos);

		////////////////////////////////////////////////////////////////////////////////////
		// -- Company keys
		////////////////////////////////////////////////////////////////////////////////////
		export Companies :=
		module
			export Bdid := index(	 Files.keybuild.companies(bdid != '')
									,{bdid,(big_endian unsigned8 )__filepos}
									,keynames.moxie.companies.bdid);

			/////////////////////////////////////////////////			
			// Company FPOS DATA KEY
			/////////////////////////////////////////////////			
			shared rawsize_company		:= sizeof(BusReg.Layout_BusReg_Company_Out) * count(Files.keybuild.companies) : global;
			shared headersize_company	:= sizeof(BusReg.Layout_BusReg_Company_Out) : global;

			export Fpos := INDEX(	 Files.keybuild.companies
									,{f:= moxietransform(__filepos,rawsize_company,headersize_company)}
									,{Files.keybuild.companies}
									,keynames.moxie.companies.fpos);
		end;
		
		////////////////////////////////////////////////////////////////////////////////////
		// -- Contacts keys
		////////////////////////////////////////////////////////////////////////////////////
		export Contacts :=
		module
			export Bdid := index(	 Files.keybuild.contacts(bdid != '')
									,{bdid,(big_endian unsigned8 )__filepos}
									,keynames.moxie.contacts.bdid);

			shared rawsize_contacts	:= sizeof(BusReg.Layout_BusReg_contact_Out) * count(Files.keybuild.contacts) : global;
			shared headersize_contacts	:= sizeof(BusReg.Layout_BusReg_contact_Out) : global;

			export Fpos := INDEX(	 Files.keybuild.contacts
									,{f:= moxietransform(__filepos, rawsize_contacts, headersize_contacts)}
									,{Files.keybuild.contacts}
									,keynames.moxie.contacts.fpos);
		end;
		
	end;

end;