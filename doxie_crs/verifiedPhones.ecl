import doxie,address,ut;

export verifiedPhones(boolean Legacy_Verified_Value = false) :=
MODULE

//****** Pull the listed phone, which comes from gong, off of the verified records
shared csa := project(doxie.Comp_Subject_Addresses_wrap.raw, transform(doxie.Layout_Comp_Addresses, self.hri_address := [], self := left));


//****** export layout
export RecordLayout := record
		doxie_crs.layout_best_phones; // created during the FDN project so can be used in multiple places.
end;

export MaxRecords := 20;

standard := project(csa(Address.isVerified(tnt, phone, listed_phone)), transform(RecordLayout,self.timezone:='',self:=left));

//***** When legacy verified, we need an additional function call

falvv := Doxie.fn_addLVV(doxie.Comp_Subject_Addresses_wrap.addresses).records_wListedPhone;  

legacy := project(falvv(Address.isVerified(tnt, phone, phone)), transform(RecordLayout,self.timezone:='',self:=left));//i intentionally passed phone in twice so that listed_phone does not unverify me.  the legacy option of comp addresses actually returns a blank listed_phone to the ESP layer, which assigns verified

ut.getTimeZone(legacy,listed_phone,timezone,legacy_w_tzone)	
ut.getTimeZone(standard,listed_phone,timezone,standard_w_tzone)	


export records := choosen(dedup(if(Legacy_Verified_Value, legacy_w_tzone, standard_w_tzone)(listed_phone <> ''), all), MaxRecords);


END;