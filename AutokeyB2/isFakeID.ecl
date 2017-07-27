import autokey;
export isFakeID(unsigned8 ID, STRING10 typ = 'AK'):= ID > autokey.did_adder(typ);