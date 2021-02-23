Import Std, Python3;


EXPORT DecryptionFunctions := MODULE

   EXPORT string pythonDecryptAES(string key, string str_encrypted) := EMBED(Python3)
    import base64
    import zlib
    from Crypto.Cipher import AES

    #//assuming that base-64 is properly padded; if not, pad here
    key_decoded = base64.b64decode(key)
    str_decoded = base64.b64decode(str_encrypted)
    try:
      iv = str_decoded[:16]
      cipher = AES.new(key_decoded, AES.MODE_CBC, iv)
      base = str_decoded[16:]
      str_decrypted = cipher.decrypt(base)
      str_decomp = zlib.decompress(str_decrypted)
    except:
      str_decomp = 'failed'
    #//b3 = b2.decode("utf-8")

    return str_decomp
  ENDEMBED;

  //#PKCS1 version, deprecated
  string python_decrypt_pksc (string msg_encrypted, string original_key, string private_key) := EMBED(Python3)
    import base64
    from Crypto.Cipher import PKCS1_v1_5
    from Crypto.PublicKey import RSA

    msg = base64.b64decode(msg_encrypted)
    key = base64.b64decode(original_key)

    #Create PKCS1_v1_5 object
    key_import = RSA.import_key(private_key)
    pkc = PKCS1_v1_5.new(key_import)
    #decrypt
    msg_decrypted = pkc.decrypt(msg, key)
    return base64.b64encode(msg_decrypted)
  ENDEMBED;

  EXPORT PythonDecryptRsaPksc(string msg_encrypted, string original_key) :=
    python_decrypt_pksc (msg_encrypted, original_key, $.constants.key_private);


  //#OAEP version
  string python_decrypt_pksc_OAEP (string msg_encrypted, string private_key) := EMBED(Python3)
    import base64
    from Crypto.Cipher import PKCS1_OAEP
    from Crypto.PublicKey import RSA

    msg = base64.b64decode(msg_encrypted)

    #Create PKCS1_OAEP object
    pr_key = RSA.import_key(private_key)
    dec_oaep = PKCS1_OAEP.new(key=pr_key)
    #decrypt
    msg_decrypted = dec_oaep.decrypt(msg)
    return base64.b64encode(msg_decrypted)
  ENDEMBED;

  EXPORT PythonDecryptRsaPksc_OAEP(string msg_encrypted) :=
    python_decrypt_pksc_OAEP (msg_encrypted, $.constants.key_private);

END;
