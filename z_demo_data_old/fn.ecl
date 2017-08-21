import Address;

export fn := MODULE
export varstring cleanAddress(string street, string citystatezip) := FUNCTION
return if(street <> '',Address.CleanAddress182(street,citystatezip),'');
END;
// 
export varstring cleanName(String fml):=FUNCTION
return IF(fml != '',Address.CleanPersonFML73(trim(regexreplace('^O ',fml,'O'))),'');
END;



END;