dasbc := DCAV2.As_Business_Contact(false,false);
dasbh := DCAV2.As_Business_Header	(false,false);

countdasbc  := count(dasbc );
countdasbh  := count(dasbh );

output(countdasbc				,named('countdasbc'	));
output(countdasbh				,named('countdasbh'	));
output(enth(dasbc,300)	,named('dasbc'			));
output(enth(dasbh,300)	,named('dasbh'			));