/**
suppress address if:
1) it does not clean correctly
2) It hais an invalid prim name
3) The address category is not blank
**/ 
$.Layout_Base2 addrXform($.Layout_Base2 b) := TRANSFORM
	valid := b.err_stat[1]='S'
						AND $.fn_IsValidAddress(b.prepped_addr1)
						AND CASE(b.addressType,
							'M' => b.Mailing_AddressCategory = '',
							'P' => b.Physical_AddressCategory = '',
							b.Mailing_AddressCategory = '' AND b.Physical_AddressCategory = '');
	self.prim_name := IF(valid, b.prim_name, '');					// A matches
	self.v_city_name := IF(valid, b.v_city_name, '');			// C matches
	self.st := IF(valid, b.st, '');												// C matches
	self.zip := IF(valid, b.zip, '');											// Z matches
	self := b;
END;

EXPORT fn_suppress_addr(dataset(Layout_Base2) Base) := project(Base, addrXform(left));
