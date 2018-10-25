EXPORT Typ := MODULE
  // This definition must match the one in Kel.Null.  The definition must
  // be duplicated in order to avoid circular references between Kel.Typ
  // and Kel.Null.
  SHARED __NotNullFlag := 1;
  SHARED __NullFlag := 0;

  // Flag indicating single-valued property had multiple values on intake
  EXPORT MultipleValuesDetected := 2;

  EXPORT int := INTEGER;
  EXPORT uid := UNSIGNED8;
  EXPORT biguid := DATA16;
  EXPORT str := STRING;
  EXPORT bool := BOOLEAN;
  EXPORT kdate := UNSIGNED4;            // equivalent to STD.Date.Date_t
  EXPORT float := REAL8;
  EXPORT unk := STRING;
  EXPORT flags := UNSIGNED1;
  EXPORT epoch := UNSIGNED2;

  // Construct a nullable type
  EXPORT ntyp(BaseType) := FUNCTIONMACRO
    LOCAL __rec := {BaseType v};
    RETURN { BaseType v := ROW([],__rec).v, Kel.typ.flags f := __NullFlag };
  ENDMACRO;
  SHARED ntyp_local(BaseType, Default) := FUNCTIONMACRO
    RETURN { BaseType v := Default, flags f := __NullFlag };
  ENDMACRO;

  // Construct a nullable child dataset type
  EXPORT ndataset(BaseType) := FUNCTIONMACRO
    RETURN { DATASET(BaseType) v := DATASET([], BaseType), Kel.typ.flags f := __NullFlag };
  ENDMACRO;

  // Construct a nullable child dataset type -- old version -- revert with codegen=noembeddedchildsets
  EXPORT ondataset(BaseType) := FUNCTIONMACRO
    RETURN { DATASET(BaseType) v := DATASET([], BaseType), Kel.typ.flags f := __NullFlag };
  ENDMACRO;

  EXPORT nint := ntyp_local(int, 0);
  EXPORT nuid := ntyp_local(uid, 0);
  EXPORT nbiguid := ntyp_local(biguid, x'00');
  EXPORT nstr := ntyp_local(str, '');
  EXPORT nbool := ntyp_local(bool, FALSE);
  EXPORT nkdate := ntyp_local(kdate, 0);
  EXPORT nfloat := ntyp_local(float, 0);
  EXPORT nunk := ntyp_local(unk, '');

  // Numeric type ranges
  EXPORT MAXINT := 9223372036854775807;
  EXPORT MININT := -9223372036854775808;
  EXPORT MAXFLOAT := 1.797693e+308;
  EXPORT MINFLOAT := -1.797693e+308;
  EXPORT MAXEPOCH := 65535;
  EXPORT MINEPOCH := 0;

  // Flag handling macros
  EXPORT SetFlag(__in, __flag) := FUNCTIONMACRO
    LOCAL __v := __in;
    RETURN ROW({ __v.v, (__v.f | __flag) }, RECORDOF(__v));
  ENDMACRO;
  EXPORT TestFlag(__in, __flag) := FUNCTIONMACRO
    LOCAL __v := __in;
    RETURN (__v.f & __flag) != 0;
  ENDMACRO;
END;

