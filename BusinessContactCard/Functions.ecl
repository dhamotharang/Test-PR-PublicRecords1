
IMPORT Address;

EXPORT Functions := MODULE
  
  EXPORT get_addr1(BusinessContactCard.Layouts.rec_company_best co) :=
    FUNCTION
      RETURN Address.Addr1FromComponents( co.prim_range, co.predir, co.prim_name, co.addr_suffix, co.postdir, co.unit_desig, co.sec_range);
    END;

  EXPORT get_addr2(BusinessContactCard.Layouts.rec_company_best co) :=
    FUNCTION
      RETURN Address.Addr2FromComponents( co.city, co.state, co.zip + IF( TRIM(co.zip4) != '', '-' + TRIM(co.zip4), '' ) );
    END;
      
      
END;
